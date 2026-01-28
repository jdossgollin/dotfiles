---
name: env-export
description: Export environment to reproducible specification
---

# Environment Export

Export project environment.

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for running export commands

## Questions First

- Cross-platform or this machine only?
- Include dev dependencies?

## Process

### 1. Detect Environment Type

- Conda/Mamba
- pip/venv
- Julia
- npm

### 2. Export Appropriately

**Conda:**

- Prefer `conda env export --from-history` (cleaner, cross-platform)
- Warn if using full export with build strings (OS-specific)

**pip:**

- requirements.txt + python version
- Consider using `uv pip compile` for locked deps

**Julia:**

- Project.toml already tracks deps
- Ensure Manifest.toml is included

### 3. Verify Completeness

- All imports covered?
- Missing packages?

### 4. Provide Recreation Commands

Example:

```bash
conda env create -f environment.yml
```

or

```bash
uv venv && uv pip install -r requirements.txt
```
