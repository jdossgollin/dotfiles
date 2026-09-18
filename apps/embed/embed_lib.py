"""Model-agnostic embedding library for local semantic search."""

from __future__ import annotations

import os
import sqlite3


_DEFAULT_MODEL = "Qwen/Qwen3-Embedding-0.6B"


def load_embedder(model_name: str | None = None):  # -> SentenceTransformer
    """Load a sentence-transformers model with MPS detection and stderr suppression."""
    model_name = model_name or os.environ.get("EMBED_MODEL", _DEFAULT_MODEL)
    os.environ.setdefault("HF_HUB_DISABLE_PROGRESS_BARS", "1")
    os.environ.setdefault("HF_HUB_DISABLE_TELEMETRY", "1")
    os.environ.setdefault("TRANSFORMERS_VERBOSITY", "error")
    os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")

    import contextlib
    import io

    with contextlib.redirect_stderr(io.StringIO()):
        import torch
        from sentence_transformers import SentenceTransformer

        device = "mps" if torch.backends.mps.is_available() else None
        model = SentenceTransformer(model_name, device=device)
        model.max_seq_length = min(model.max_seq_length, 512)
        return model


def get_query_prefix(embedder) -> str:
    """Return the model's query prompt (empty string if none)."""
    return getattr(embedder, "prompts", {}).get("query", "")


def embed_texts(embedder, texts: list[str], batch_size: int = 16):  # -> np.ndarray
    """Encode texts to normalized float32 vectors."""
    import numpy as np

    vecs = embedder.encode(
        texts, batch_size=batch_size, normalize_embeddings=True, show_progress_bar=False
    )
    return np.asarray(vecs, dtype="float32")


def _table_cols(conn: sqlite3.Connection) -> set[str]:
    return {r[1] for r in conn.execute("PRAGMA table_info(vec)")}


def _fetch_rows(conn: sqlite3.Connection):
    """Fetch vec rows, auto-detecting schema (rel_path vs item_key, note_type presence)."""
    cols = _table_cols(conn)
    key_col = "rel_path" if "rel_path" in cols else "item_key"
    has_note_type = "note_type" in cols
    # Build query from fixed column names (no user input)
    select_cols = [key_col, "title", "embedding"]
    if has_note_type:
        select_cols.append("note_type")
    query = "SELECT " + ", ".join(select_cols) + " FROM vec"
    rows = conn.execute(query).fetchall()
    return rows, key_col, has_note_type


def _rank(rows, query_vec, key_col: str, has_note_type: bool, limit: int, exclude: str | None):
    import numpy as np

    if not rows:
        return []
    dim = len(query_vec)
    matrix = np.frombuffer(
        b"".join(r["embedding"] for r in rows), dtype="float32"
    ).reshape(len(rows), dim)
    scores = matrix @ np.asarray(query_vec, dtype="float32")
    order = np.argsort(-scores)
    out: list[dict] = []
    for i in order:
        row = rows[int(i)]
        if exclude and row[key_col] == exclude:
            continue
        hit = {key_col: row[key_col], "title": row["title"], "score": round(float(scores[int(i)]), 4)}
        if has_note_type:
            hit["note_type"] = row["note_type"]
        out.append(hit)
        if len(out) >= limit:
            break
    return out


def search_index(db_path: str, query: str, embedder, limit: int = 10) -> list[dict]:
    """Encode a query and rank against all stored vectors."""
    prefix = get_query_prefix(embedder)
    vec = embed_texts(embedder, [prefix + query])[0]
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    try:
        rows, kc, hnt = _fetch_rows(conn)
    finally:
        conn.close()
    return _rank(rows, vec, kc, hnt, limit, None)


def similar_to(db_path: str, embedding, limit: int = 10, exclude: str | None = None) -> list[dict]:
    """Rank stored vectors against a pre-computed embedding (no query prefix)."""
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    try:
        rows, kc, hnt = _fetch_rows(conn)
    finally:
        conn.close()
    return _rank(rows, embedding, kc, hnt, limit, exclude)
