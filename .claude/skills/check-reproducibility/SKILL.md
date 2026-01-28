---
name: check-reproducibility
description: Analyze project for reproducibility issues
---

# Check Reproducibility

Audit project for reproducibility issues (read-only analysis).

## When to Use

- Before sharing code/data with others
- Reviewing a data science project
- Part of `/pr-ready` checklist for data pipelines

## See Also

- `/env-export` - if you want to CREATE a reproducible environment spec
- `/deps-check` - for security/version issues specifically
- `/visual-output` - to visualize dependency graphs or data pipelines

## Available Tools

- `Grep` - ripgrep-based search (use instead of `grep` or `rg` in bash)
- `Glob` - fast file pattern matching (use instead of `find`)
- `Read` - read file contents (use instead of `cat`)

Do NOT shell out for search/read operations - use the dedicated tools.

## Context Management

If file count exceeds 20, stop and ask before proceeding.

## Checks

### 1. Environment Specs

- environment.yml, requirements.txt, Project.toml present?
- Versions pinned? Lock file exists?

### 2. External Dependencies

- Database connections, API keys, S3 buckets referenced?
- Are credentials documented (without exposing secrets)?

### 3. README vs Reality

- Do README install instructions match actual dependency files?
- Any contradictions?

### 4. Random Seeds

- Search for random usage (use Grep, don't read every file)
- Are seeds set and documented?

### 5. Hardcoded Paths

- Absolute paths that won't work on other machines?

### 6. Hardware Requirements

- GPU/CUDA code? (`.cuda()`, `torch.device`, `CUDA.jl`)
- If GPU detected, check for version pinning:
  - CUDA toolkit version specified?
  - cuDNN version (if deep learning)?
  - GPU memory requirements documented?
- Check for `nvidia-smi` or similar in setup scripts
- Document if not already noted

## Output

Report as checklist with file:line references.

Do NOT make changes.
