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
| Fonts | See [Fonts](#fonts) section below |
| Python | Miniconda |
| Julia | juliaup |

### Ubuntu Linux (via apt/snap)

| Category | Tools |
|----------|-------|
| Shell | zsh, oh-my-zsh, powerlevel10k |
| Dev Tools | git, git-lfs, build-essential, node, shellcheck |
| Apps | VSCodium, WezTerm, GitHub Desktop, Slack, Spotify |
| Fonts | See [Fonts](#fonts) section below |
| Python | Miniforge (includes mamba) |
| Julia | juliaup |

## Fonts

All fonts are installed on both macOS (via Homebrew cask) and Linux (via apt + direct download). Managed in `install/install-fonts.sh`.

### Terminal & Coding

| Font | Description |
|------|-------------|
| [**MesloLGS NF**](https://github.com/romkatv/powerlevel10k#fonts) | Required for Powerlevel10k prompt. Nerd Font with icons/powerline glyphs. |
| [**JetBrains Mono**](https://www.jetbrains.com/lp/mono/) | Default coding font. Tall x-height, excellent ligatures. |
| [**Cascadia Code**](https://github.com/microsoft/cascadia-code) | Microsoft's coding font with cursive italics variant. |
| [**Fira Code**](https://github.com/tonsky/FiraCode) | Pioneer of coding ligatures. Great for presentations about code. |
| [**Geist Mono**](https://vercel.com/font) | Vercel's modern monospace. Clean and minimal. |
| [**Commit Mono**](https://commitmono.com/) | Neutral monospace designed specifically for code readability. |
| [**Intel One Mono**](https://github.com/intel/intel-one-mono) | Optimized for legibility at small sizes and low-res displays. |
| [**Iosevka**](https://typeof.net/Iosevka/) | Narrow monospace — fits more columns on screen. Highly customizable. |
| [**Monaspace**](https://monaspace.githubnext.com/) | GitHub's texture healing monospace. Five variants (Neon, Argon, etc.). |
| [**Source Code Pro**](https://adobe-fonts.github.io/source-code-pro/) | Adobe's monospace. Clean and widely supported. |
| [**Fira Mono**](https://mozilla.github.io/Fira/) | Mozilla's monospace. Pairs well with Fira Sans. |
| [**JuliaMono**](https://juliamono.netlify.app/) | Designed for scientific computing. Full Unicode math symbol coverage. |

### Scientific Writing (LaTeX/Quarto)

| Font | Description |
|------|-------------|
| [**Libertinus**](https://github.com/alerque/libertinus) | Modern successor to Linux Libertine. Includes math font for LaTeX. |
| [**STIX Two**](https://www.stixfonts.org/) | Created by scientific publishers (AMS, AIP, IEEE). Full math coverage. |
| [**EB Garamond**](http://www.georgduffner.at/ebgaramond/) | Beautiful Garamond revival. Great for humanities papers. |
| [**Crimson Text**](https://github.com/skosch/Crimson) | Elegant old-style serif inspired by Minion. |
| [**Cormorant**](https://github.com/CatharsisFonts/Cormorant) | Display serif inspired by Garamond. Striking at large sizes. |
| [**Old Standard TT**](https://github.com/niclasr/ofontSmallCaps) | Reproduces early 20th century typefaces. Academic feel. |
| [**TeX Gyre Pagella**](http://www.gust.org.pl/projects/e-foundry/tex-gyre/pagella) | Free Palatino equivalent with math support. LaTeX standard. |
| [**Alegreya**](https://www.huertatipografica.com/en/fonts/alegreya-ht-pro) | Dynamic serif with small caps. Excellent for thesis/book work. |
| [**Cinzel**](https://github.com/niclasr) | Inspired by Roman inscriptions. Great for titles and headings. |
| [**GFS Didot**](https://www.greekfontsociety-gfs.gr/) | Classic Didone style. macOS only. |
| [**Merriweather**](https://ebensorkin.wordpress.com/) | Designed for comfortable on-screen reading. |

### Presentations & UI (Quarto/Slides)

| Font | Description |
|------|-------------|
| [**Inter**](https://rsms.me/inter/) | One of the most popular UI typefaces. Extremely legible at all sizes. |
| [**DM Sans**](https://github.com/googlefonts/dm-fonts) | Clean geometric sans-serif. Works great in slides. |
| [**Atkinson Hyperlegible**](https://brailleinstitute.org/freefont) | Braille Institute design for maximum readability. Surprisingly stylish. |
| [**Roboto**](https://fonts.google.com/specimen/Roboto) | Google's signature typeface. Versatile and neutral. |
| [**Open Sans**](https://fonts.google.com/specimen/Open+Sans) | Humanist sans-serif. Optimized for web and print. |
| [**Lato**](https://www.latofonts.com/) | Warm sans-serif. Looks professional without being cold. |
| [**Montserrat**](https://github.com/JulietaUla/Montserrat) | Geometric sans inspired by Buenos Aires signage. Great for headings. |
| [**Fira Sans**](https://mozilla.github.io/Fira/) | Mozilla's sans-serif. Pairs with Fira Code/Mono. |
| [**Oswald**](https://github.com/googlefonts/OswaldFont) | Condensed sans-serif. Bold and attention-grabbing for titles. |
| [**Bebas Neue**](https://www.fontfabric.com/fonts/bebas-neue/) | All-caps display font. Eye-catching for poster titles. |
| [**Varela Round**](https://fonts.google.com/specimen/Varela+Round) | Friendly rounded sans-serif. Approachable feel. |

### Novelty & Special Purpose

| Font | Description |
|------|-------------|
| [**XKCD Script**](https://github.com/ipython/xkcd-font) | Handwriting font matching XKCD comics. Use with `matplotlib`'s `xkcd()` mode. |
| [**Special Elite**](https://fonts.google.com/specimen/Special+Elite) | Typewriter font. Great for stylized quotes or asides. |
| [**Cooper Hewitt**](https://www.cooperhewitt.org/open-source-at-cooper-hewitt/cooper-hewitt-the-typeface-by-chester-jenkins/) | Smithsonian design museum's house typeface. Contemporary sans-serif. |
| [**Font Awesome**](https://fontawesome.com/) | Icon font. Useful for presentations and documents with inline icons. |
| [**Iceland**](https://fonts.google.com/specimen/Iceland) | Geometric display font with Nordic character. |
| [**Graduate**](https://fonts.google.com/specimen/Graduate) | Slab serif inspired by college lettering. |
| [**Kameron**](https://fonts.google.com/specimen/Kameron) | Sturdy slab serif for headings. |

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
