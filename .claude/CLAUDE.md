# CLAUDE.md

## Repository Overview

Cross-platform dotfiles for macOS and Ubuntu Linux. Scientific computing/data science workflows. Manages shell config, package managers (Homebrew/apt, conda, npm, juliaup), system defaults, and dev tools.

## Architecture

```
bin/        → dotfiles CLI dispatcher
install/    → modular install scripts (brew, apt, conda, node, julia, fonts, ...)
runcom/     → shell configs symlinked to ~ (.zshrc, .p10k.zsh, .latexmkrc)
system/     → shell env sourced by .zshrc (.alias, .path, .env, .function)
apps/       → app configs (git, vscode, wezterm)
macos/      → macOS system defaults (macOS only)
docs/       → font specimens and documentation
secrets/    → git identity and API keys (gitignored, templates tracked)
```

**Shell startup:** `.zshrc` → oh-my-zsh → p10k → system/{.function, .alias, .env, .path} → secrets. Conda/mamba lazy-loaded. Target: <200ms.

**Platform detection:** `is-macos`, `is-linux`, `is-apt-available`, `is-snap-available`, `get-brew-prefix` in `system/.function`. Use in all install scripts.

**Adding a tool:** Create `install/install-<tool>.sh` with platform detection. Add call to `install.sh`. Must be idempotent. Comment every package with what it does.

**Symlinks:** Created by `install.sh` — `.zshrc`, `.p10k.zsh`, `.latexmkrc`, `.gitconfig`, `.gitignore_global`, `.wezterm.lua`, VSCodium settings.

## Key Commands

```bash
dotfiles help | clean | edit | themes | update
dotfiles dock    # macOS only
dotfiles macos   # macOS only
```

## Testing

GitHub Actions (`.github/workflows/test.yml`) runs on `macos-latest` and `ubuntu-latest`.

## Documentation Hierarchy

1. **README** — concise entry point, links to source files
2. **Install scripts** — authoritative package lists with inline comments
3. **docs/** — detailed docs (font specimens, etc.)
4. **Source files** — self-documenting (system/.function, runcom/.zshrc, etc.)

Don't duplicate info across levels. README should link, not restate.

## Maintenance Skills

- **`/suggest-improvements`** — Audit install methods against official docs (6-month interval via `.claude/MAINTENANCE.md`)
- **`/audit-sync`** — Verify macOS/Linux install parity
- **`/uninstall`** — Remove a package from all scripts, configs, and platforms
