---
name: deps-check
description: Audit project dependencies for issues
---

# Dependency Check

Audit dependencies.

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for running audit tools

## Context Management

If more than 20 dependency files, stop and ask before proceeding.

## Checks

### 1. Security

- Python: `pip-audit` or `safety check`
- npm: `npm audit`

### 2. Outdated

- List packages with updates available
- Flag breaking changes in major versions

### 3. Potentially Unused (LOW CONFIDENCE)

- Imports not found in code
- Note: may be false positives (plugins, `__init__.py`, importlib)
- Flag for human verification, don't auto-remove

### 4. License Compliance (if relevant)

- Check for copyleft or non-commercial licenses
- Flag if enterprise/commercial use

### 5. Conflicts

- Version incompatibilities

## Output

Report with confidence levels.

Ask before changes.
