---
paths:
  - "**/src/**/*.py"
  - "**/lib/**/*.py"
  - "**/core/**/*.py"
---

# Python (Software/Library Code)

## Development Approach

- Test-driven development: write tests before or alongside implementation
- Incremental changes with tests passing at each step
- Refactor only with test coverage

## Code Quality

- Full type hints with mypy compliance
- Comprehensive docstrings for public APIs
- Clear module/package structure

## Formatting

- Use `mypy`, `black`, `isort` via CLI tools
- Do not manually format - run the tools

## Environment Management

- Separate environments or dependency groups for dev/test
- Use pyproject.toml with optional-dependencies: `[project.optional-dependencies]` for dev, test
- Or separate requirements-dev.txt, requirements-test.txt
