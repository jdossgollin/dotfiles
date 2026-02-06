# dotfiles

[![Test Install](https://github.com/jdossgollin/dotfiles/actions/workflows/test.yml/badge.svg)](https://github.com/jdossgollin/dotfiles/actions/workflows/test.yml)

Cross-platform dotfiles for macOS and Ubuntu Linux, optimized for scientific computing and data science workflows.

## Overview

These dotfiles support:

- **macOS** (10.15+) with Homebrew
- **Ubuntu Linux** (20.04+) with apt/snap

Key technologies:

- `zsh` shell with [Oh My Zsh](https://ohmyz.sh/) and [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Package managers: Homebrew (macOS), apt/snap (Linux)
- Conda/Mamba for Python environments
- Julia via juliaup
- Node.js for JavaScript tooling
- VSCodium as primary editor

## Quick Start

### macOS

```bash
# Install Xcode command line tools
xcode-select --install

# Clone and install
git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# Review install.sh and run line by line (recommended)
bash install.sh
```

### Ubuntu Linux

```bash
# Install prerequisites
sudo apt-get update && sudo apt-get install -y git curl

# Clone and install
git clone https://github.com/jdossgollin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# Review install.sh and run line by line (recommended)
bash install.sh
```

**Important:** Don't run install.sh with `source`. Open it in a text editor and run line by line to catch any errors.

## Post-Install Setup (Manual Steps)

After running `install.sh`, complete these manual configuration steps:

### 1. Git Identity (Required)

Create your git identity file:

```bash
cp ~/.dotfiles/secrets/.git_identity.template ~/.dotfiles/secrets/.git_identity
```

Edit `~/.dotfiles/secrets/.git_identity` with your details:

```bash
GIT_USER_NAME="Your Full Name"
GIT_USER_EMAIL="your.email@example.com"
GIT_GITHUB_USER="yourgithubusername"
```

Then re-run install.sh or configure manually:

```bash
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"
```

### 2. API Keys (Optional)

If you use API keys for tools like Claude, OpenAI, etc.:

```bash
cp ~/.dotfiles/secrets/.api_keys.template ~/.dotfiles/secrets/.api_keys
```

Edit with your keys. This file is gitignored.

### 3. macOS-Specific Setup

These commands only work on macOS:

```bash
dotfiles dock    # Configure Dock apps
dotfiles macos   # Apply system preferences
```

### 4. Linux-Specific Setup

Some apps must be installed manually on Linux:

- **Zoom**: Download from [zoom.us](https://zoom.us/download)
- **Zotero**: Download from [zotero.org](https://www.zotero.org/download/)

## The `dotfiles` Command

```bash
$ dotfiles help
Usage: dotfiles <command>

Commands:
   clean            Clean up caches (brew/apt, conda, julia)
   edit             Open dotfiles in IDE
   help             This help message
   themes           Update shell themes (oh-my-zsh, powerlevel10k)
   update           Update packages and package managers
   dock             Apply macOS Dock settings (macOS only)
   macos            Apply macOS system defaults (macOS only)
```

## What Gets Installed

### macOS (via Homebrew)

| Category | Tools |
|----------|-------|
| Shell | zsh, oh-my-zsh, powerlevel10k, z |
| Dev Tools | git, git-lfs, gcc, node, shellcheck |
| Apps | VSCodium, WezTerm, GitHub Desktop, Slack, Zoom (via cask) |
| Fonts | Meslo Nerd Font, JetBrains Mono, Cascadia Code, Iosevka, Monaspace |
| Python | Miniconda |
| Julia | juliaup |

### Ubuntu Linux (via apt/snap)

| Category | Tools |
|----------|-------|
| Shell | zsh, oh-my-zsh, powerlevel10k |
| Dev Tools | git, git-lfs, build-essential, node, shellcheck |
| Apps | VSCodium, WezTerm, GitHub Desktop, Slack, Spotify |
| Fonts | Meslo Nerd Font, JetBrains Mono, Cascadia Code |
| Python | Miniforge (includes mamba) |
| Julia | juliaup |

## Shell Performance

This configuration uses lazy loading to keep shell startup fast.

### Benchmark Your Shell

```bash
# Run 10 times and check average
for i in {1..10}; do time zsh -i -c exit; done

# Target: < 200ms
```

### Performance Optimizations

- **Lazy conda/mamba**: Initialized only on first use (saves 200-500ms)
- **Minimal P10k segments**: Only essential prompt elements
- **Native zsh deduplication**: Uses `typeset -U` instead of awk

## Directory Structure

```text
~/.dotfiles/
├── bin/              # CLI tools and dotfiles command
├── install/          # Modular install scripts per tool
├── runcom/           # Shell configs (.zshrc, .p10k.zsh)
├── system/           # Shell environment (.alias, .path, .function)
├── apps/             # App configs (git, vscode)
├── macos/            # macOS system defaults (macOS only)
├── conda/            # Conda environment YAML files
└── secrets/          # API keys, git identity (gitignored)
```

## Debugging

Common issues:

- Check shell initialization: `~/.zshenv` → `~/.zprofile` → `~/.zshrc`
- Verify Homebrew (macOS): `brew doctor`
- Check for conflicting dotfiles: `ls -la ~/.{zshrc,gitconfig}`
- Review install logs: `~/.dotfiles/logs/`
- PATH issues: `echo $PATH`
- Conda not loading: Run `conda` once to trigger lazy init

## Credits

Built on ideas from:

- <https://github.com/webpro/dotfiles/>
- <https://github.com/mathiasbynens/dotfiles>
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
