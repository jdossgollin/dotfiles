# dotfiles

[![Test Install](https://github.com/jdossgollin/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/jdossgollin/dotfiles/actions/workflows/test.yml)

Cross-platform dotfiles for macOS and Ubuntu Linux, optimized for scientific computing and data science.

## Quick Start

```bash
# macOS: xcode-select --install first
# Linux: sudo apt-get install -y git curl first

git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh  # review and run line by line recommended
```

After install:

1. `cp secrets/.git_identity.template secrets/.git_identity` and edit with your name/email
2. `dcli devices register "My Device"` to authenticate Dashlane CLI, then `dotfiles sync-secrets`
3. macOS only: `dotfiles dock` and `dotfiles macos`
4. Linux only: install [Zoom](https://zoom.us/download) manually

## The `dotfiles` Command

```
clean          Clean up caches (brew/apt, conda, julia)
edit           Open dotfiles in IDE
help           This help message
sync-secrets   Pull secrets from Dashlane vault to local files
themes         Update oh-my-zsh and powerlevel10k
update         Update packages and package managers
dock           Apply macOS Dock settings (macOS only)
macos          Apply macOS system defaults (macOS only)
```

## What Gets Installed

See individual install scripts in [`install/`](install/) for the full, authoritative lists.

| Category | macOS | Linux |
|----------|-------|-------|
| Shell | zsh, oh-my-zsh, powerlevel10k | same |
| Dev Tools | git, gh, gcc, node, shellcheck, fd, jq, ... | same (via apt) |
| Apps | VSCodium, WezTerm, GitHub Desktop, Slack, Zoom, ... | same (via apt/snap) |
| Fonts | 40+ coding, scientific, and presentation fonts | same (via apt + download) |
| Python | Miniforge (conda/mamba), uv, nbdime | same |
| Julia | juliaup | same |

**Fonts:** Managed in [`install/install-fonts.sh`](install/install-fonts.sh). For visual specimens and pairing suggestions: `typst compile docs/font-specimens.typ`

## Architecture

```
~/.dotfiles/
├── bin/        dotfiles CLI dispatcher
├── install/    modular install scripts (brew, apt, conda, node, julia, fonts, ...)
├── runcom/     shell configs symlinked to ~ (.zshrc, .p10k.zsh, .latexmkrc)
├── system/     shell environment sourced by .zshrc (.alias, .path, .env, .function)
├── apps/       app configs (git, vscode, wezterm)
├── macos/      macOS system defaults (macOS only)
├── docs/       font specimens and other documentation
└── secrets/    git identity and API keys (gitignored, templates tracked)
```

**Shell startup:** `.zshrc` → oh-my-zsh → p10k → system/{.function, .alias, .env, .path} → secrets. Conda/mamba lazy-loaded on first use. Target: <200ms (`timezsh` to benchmark).

**Platform detection:** `is-macos`, `is-linux`, `is-apt-available`, etc. in [`system/.function`](system/.function). Use in install scripts for cross-platform logic.

**Adding a new tool:** Create `install/install-<tool>.sh`, use platform detection, add the call to `install.sh`. Scripts should be idempotent.

## Credits

Built on [webpro/dotfiles](https://github.com/webpro/dotfiles/), [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), and [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles).
