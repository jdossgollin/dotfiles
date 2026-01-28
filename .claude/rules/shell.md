---
paths:
  - "**/*.sh"
  - "**/*.zsh"
  - "**/.*rc"
  - "**/.*profile"
  - "bin/*"
---

# Shell Scripts

## Safety

- Use `set -euo pipefail` at script start
- Quote all variables: `"$var"` not `$var`
- Use `[[ ]]` over `[ ]` in bash/zsh

## Style

- Use platform detection functions from system/.function
- Prefer long-form flags (`--verbose` over `-v`) for readability
- Scripts must be idempotent (safe to re-run)

## This Repository

- Follow existing patterns in install/ scripts
- Use `is-macos`, `is-linux`, `is-apt-available` for cross-platform logic
