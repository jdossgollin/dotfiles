# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Cross-platform dotfiles repository for scientific computing/data science workflows. Supports **macOS** and **Ubuntu Linux**. Manages shell configuration, package managers (Homebrew/apt, conda, npm, juliaup), system defaults, and development tools.

## Key Commands

### Main CLI (`bin/dotfiles`)

```bash
dotfiles help     # Show available commands
dotfiles clean    # Clean caches (brew/apt, conda, julia)
dotfiles edit     # Open dotfiles in VS Code
dotfiles themes   # Update oh-my-zsh, powerlevel10k, gitstatus
dotfiles update   # Update packages and package managers

# macOS only:
dotfiles dock     # Apply macOS Dock configuration
dotfiles macos    # Apply all macOS system defaults
```

### Installation

Installation is NOT automatic. Run `install.sh` line-by-line and watch for errors:

```bash
git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh  # Review and run line-by-line recommended
```

### Post-Install Manual Setup

1. **Git identity**: `cp secrets/.git_identity.template secrets/.git_identity` and edit
2. **API keys** (optional): `cp secrets/.api_keys.template secrets/.api_keys` and edit

### Testing

GitHub Actions workflow (`.github/workflows/test.yml`) runs on both:

- `macos-latest`
- `ubuntu-latest`

Tests verify: symlinks, `dotfiles help` command, platform-specific tools.

## Architecture

### Directory Structure

- **bin/** - Main `dotfiles` CLI dispatcher and utility scripts
- **install/** - Modular install scripts per package manager (brew, apt, conda, node, zsh, julia, fonts)
- **runcom/** - Runtime configs symlinked to home directory (.zshrc, .p10k.zsh, .latexmkrc)
- **system/** - Shell environment files sourced by .zshrc (.alias, .path, .env, .function)
- **apps/** - Application configs (git/.gitconfig, .vscode/settings.json)
- **macos/** - macOS system defaults scripts (macOS only)
- **conda/** - Conda environment YAML specifications
- **secrets/** - Git identity and API keys (gitignored, templates tracked)

### Platform Detection Functions

Located in `system/.function`:

```bash
is-macos()         # Returns true on macOS (Darwin)
is-linux()         # Returns true on Linux
is-ubuntu()        # Returns true on Ubuntu specifically
is-apt-available() # Returns true if apt-get is available
is-snap-available() # Returns true if snap is available
get-brew-prefix()  # Returns /opt/homebrew (Apple Silicon) or /usr/local (Intel)
```

Use these in install scripts for cross-platform logic:

```bash
if is-macos; then
    brew install package
elif is-apt-available; then
    sudo apt-get install -y package
fi
```

### Shell Configuration Loading Order

1. `.zshrc` loads oh-my-zsh and Powerlevel10k
2. Sources `system/.function`, `.alias`, `.env`, `.path`
3. Sources `secrets/.api_keys` if exists
4. Lazy-loads conda/mamba on first use (performance optimization)

### Shell Performance

Conda/mamba use lazy initialization to keep shell startup under 200ms. The first `conda` or `mamba` command triggers full initialization.

Benchmark with: `for i in {1..10}; do time zsh -i -c exit; done`

### Symlink Pattern

Install script creates these symlinks from home directory:
- `~/.zshrc` → `runcom/.zshrc`
- `~/.p10k.zsh` → `runcom/.p10k.zsh`
- `~/.latexmkrc` → `runcom/.latexmkrc`
- `~/.gitconfig` → `apps/git/.gitconfig`
- `~/.gitignore_global` → `apps/git/.gitignore_global`

### Adding New Install Scripts

1. Create `install/install-<tool>.sh`
2. Use platform detection: `if is-macos; then ... elif is-linux; then ... fi`
3. Add call to it in `install.sh` under appropriate platform section
4. Install scripts should be idempotent

### macOS Defaults

Scripts in `macos/` modify system preferences via `defaults write`. The `dock.sh` script organizes apps into categories using dockutil. These only run on macOS.

## Key Files

- **bin/dotfiles** - Main entry point, sources `.function` for platform detection
- **install.sh** - Master installation orchestrator with platform branching
- **install/install-apt.sh** - Linux apt package installation
- **system/.function** - Platform detection functions and helpers
- **system/.path** - PATH configuration with platform-specific paths
- **runcom/.zshrc** - Shell config with lazy conda initialization
- **secrets/.git_identity.template** - Template for git user config
- **secrets/.api_keys.template** - Template for API keys
