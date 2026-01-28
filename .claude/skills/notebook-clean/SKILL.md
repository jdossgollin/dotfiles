---
name: notebook-clean
description: Clean notebook for version control and reproducibility
---

# Notebook Clean

Clean Jupyter/Quarto notebook.

## Available Tools

- `Read` - read file contents
- `Grep` - search for patterns
- `Bash` - for running tools

## Checks

### 1. Execution Order

- Cells executed out of order?
- Variables used but not defined in visible cells? (hidden state)

### 2. Reproducibility Issues

- Hardcoded absolute paths
- Credentials or API keys in cells
- Large embedded data/images

### 3. Structure

- Does it run top-to-bottom?
- Imports at top?
- Clear narrative flow?

### 4. Version Pinning

Suggest adding version watermark cell:

```python
%pip freeze | grep -E "pandas|numpy|..."
```

## Actions (ask first)

- Clear outputs?
- Remove execution counts?
- Add version cell?

## Output

Report findings.

Ask before destructive changes.
