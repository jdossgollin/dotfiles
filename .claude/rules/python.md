---
paths:
  - "**/*.py"
  - "pyproject.toml"
  - "setup.py"
  - "setup.cfg"
---

# Python

## Code Quality

- Write clear, readable code with descriptive variable names
- Keep functions focused and reasonably sized
- Prefer composition over inheritance

## Type Safety

- Use type hints for all function signatures and class attributes
- Use mypy-compatible patterns (avoid Any when possible)
- Leverage typing module: Optional, Union, Literal, TypedDict, Protocol
- Run `mypy` to check types - do not manually "fix" type issues without running the checker

## Formatting

- Use `black` for formatting (88-char lines)
- Use `isort` for import sorting
- Run formatters via CLI tools, not manual LLM edits

## Documentation

- Use docstrings, but keep them concise - type hints convey most signature info
- Focus docstrings on *why* and *what*, not redundant parameter types
- Example: `"""Compute portfolio risk using Monte Carlo simulation."""`

## Style

- Prefer pathlib over os.path
- Use context managers for resources
- Prefer f-strings
- Use dataclasses or Pydantic for structured data

## Environment Management

- If project has existing setup (pyproject.toml, requirements.txt, conda env): use that
- If no environment defined: default to `uv` for speed
  - `uv venv`, `uv pip install`, `uv run`
- Ask before creating new environment infrastructure
