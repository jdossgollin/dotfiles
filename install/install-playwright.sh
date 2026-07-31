#!/usr/bin/env bash

# Playwright Chromium — headless browser used by the zotero skill's
# open-access extraction path (Copernicus journals: HESS, NHESS, ESD, GMD).
#
# Why this lives here rather than in the skill's setup.sh: the browser is a
# ~90MB machine-level binary, not skill config, so it should survive a
# claude-skills reinstall and be present on a fresh machine before any skill
# runs.
#
# Version coupling (important): each playwright release requires its own
# Chromium build. The zotero skill PINS playwright in the PEP-723 header of
# scripts/zotero.py; PLAYWRIGHT_VERSION below must match that pin. If they
# drift, extraction fails with "Executable doesn't exist" — which the skill now
# reports as a setup error rather than silently falling back.

PLAYWRIGHT_VERSION="1.61.0"

# Skip in CI (avoids a large network download in headless test runs)
if [[ -n "${CI:-}" ]]; then
    echo "Skipped: playwright chromium (CI environment)"
    return 2>/dev/null || exit 0
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "Warning: uv not found; skipping playwright chromium install"
    return 2>/dev/null || exit 0
fi

# `playwright install` is itself idempotent — it no-ops when the build is
# already present — so this is safe to re-run.
echo "Installing Playwright Chromium (playwright ${PLAYWRIGHT_VERSION})..."
uv run --with "playwright==${PLAYWRIGHT_VERSION}" python -m playwright install chromium \
    || echo "Warning: playwright chromium failed to install"
