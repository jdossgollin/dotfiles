# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

macOS-focused dotfiles repository for scientific computing/data science workflows. Manages shell configuration, package managers (Homebrew, conda, npm, juliaup), macOS system defaults, and development tools.

## Key Commands

### Main CLI (`bin/dotfiles`)

```bash
dotfiles help     # Show available commands
dotfiles clean    # Clean caches (brew, conda, julia)
dotfiles dock     # Apply macOS Dock configuration
dotfiles edit     # Open dotfiles in VS Code
dotfiles macos    # Apply all macOS system defaults
dotfiles update   # Update OS, brew, conda, npm, julia
```

### Installation

Installation is NOT automatic. Run `install.sh` line-by-line and watch for errors:
```bash
git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
# Then manually execute install.sh sections
```

### Testing

GitHub Actions workflow runs on macOS-latest (`.github/workflows/test.yml`):
- Verifies symlinks created correctly
- Tests `dotfiles help` command

## Architecture

### Directory Structure

- **bin/** - Main `dotfiles` CLI dispatcher and utility scripts
- **install/** - Modular install scripts per package manager (brew, conda, node, zsh, julia, fonts)
- **runcom/** - Runtime configs symlinked to home directory (.zshrc, .p10k.zsh, .latexmkrc)
- **system/** - Shell environment files sourced by .zshrc (.alias, .path, .env, .function)
- **apps/** - Application configs (git/.gitconfig, .vscode/settings.json)
- **macos/** - macOS system defaults scripts (general, finder, dock, safari, etc.)
- **conda/** - Conda environment YAML specifications

### Shell Configuration Loading Order

1. `.zshrc` loads oh-my-zsh and Powerlevel10k
2. Sources all files in `system/` directory: .alias, .path, .env, .function, .dockeralias
3. Loads any `.cache.sh` if present (gitignored)

### Symlink Pattern

Install script creates these symlinks from home directory:
- `~/.zshrc` → `runcom/.zshrc`
- `~/.p10k.zsh` → `runcom/.p10k.zsh`
- `~/.latexmkrc` → `runcom/.latexmkrc`
- `~/.gitconfig` → `apps/git/.gitconfig`
- `~/.gitignore_global` → `apps/git/.gitignore_global`

### Adding New Install Scripts

1. Create `install/install-<tool>.sh`
2. Add call to it in `install.sh`
3. Install scripts should be idempotent

### macOS Defaults

Scripts in `macos/` modify system preferences via `defaults write`. The `dock.sh` script organizes apps into categories (Web, Messaging, Time Management, Reading, Code, Folders) using dockutil.

## Key Files

- **bin/dotfiles** - Main entry point, bash case statement dispatching subcommands
- **install.sh** - Master installation orchestrator with logging
- **system/.function** - Helper functions (is_macos, prepend_path, cleanup_conda_envs, etc.)
- **system/.path** - PATH ordering: dotfiles/bin → homebrew → conda → julia → gems
