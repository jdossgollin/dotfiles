#!/usr/bin/env bash

# Linux CLI tools and apps via apt/snap. macOS equivalent: install-brew.sh + install-brew-cask.sh
# Run /audit-sync to verify parity between platforms.

# Exit if not Linux or apt not available
if ! is-apt-available; then
    echo "Skipped: apt packages (apt not available)"
    return 0 2>/dev/null || exit 0
fi

echo "Installing apt packages..."

sudo apt-get update

# Map apt package names to their CLI commands (for existence check)
# Format: "package:command" (command defaults to package name if omitted)
apt_packages=(
    # Shell
    "zsh"                       # Modern shell (replaces bash)
    "zsh-syntax-highlighting"   # Fish-like syntax highlighting for zsh

    # Core utilities
    "curl"                      # HTTP client
    "wget"                      # File downloader
    "git"                       # Version control
    "git-extras"                # Extra git commands (git-summary, git-effort, etc.)
    "git-lfs"                   # Git Large File Storage
    "nano"                      # Simple text editor
    "build-essential:gcc"       # C/C++ compiler toolchain
    "libboost-all-dev"          # C++ Boost libraries (no CLI command)
    "p7zip-full:7z"             # 7-Zip file archiver

    # Modern CLI replacements
    "bat:batcat"                # cat with syntax highlighting (Ubuntu names it batcat)
    "fd-find:fdfind"            # Modern find replacement (Ubuntu names it fd-find)
    "fzf"                       # Fuzzy finder for files, history, etc.
    "ripgrep:rg"                # Fast grep replacement
    "btop"                      # Modern system monitor (top/htop replacement)
    "ncdu"                      # Interactive disk usage analyzer
    "tree"                      # Directory tree viewer
    "tldr"                      # Simplified man pages with examples
    "jq"                        # JSON processor
    "direnv"                    # Per-directory environment variables

    # Dev tools
    "shellcheck"                # Shell script linter
    "pandoc"                    # Universal document converter
    "nodejs:node"               # JavaScript runtime
    "npm"                       # Node.js package manager

    # Media & science
    "ffmpeg"                    # Audio/video processing
    "imagemagick:magick"        # Image manipulation (convert, resize, etc.)
    "aspell"                    # Spell checker
)

# Build list of packages to install
to_install=()
for entry in "${apt_packages[@]}"; do
    IFS=':' read -r pkg cmd <<< "$entry"
    cmd="${cmd:-$pkg}"  # default to package name

    if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
        echo "$pkg: already installed via apt"
    elif command -v "$cmd" >/dev/null 2>&1; then
        echo "$pkg: found '$cmd' in PATH, skipping"
    else
        to_install+=("$pkg")
    fi
done

if [[ ${#to_install[@]} -gt 0 ]]; then
    echo "Installing: ${to_install[*]}"
    sudo apt-get install -y "${to_install[@]}"
else
    echo "All apt packages already installed"
fi

# TeX Live (very large ~5GB, installed separately to avoid blocking other packages)
if ! command -v pdflatex >/dev/null 2>&1; then
    echo "Installing texlive-full (this may take a while)..."
    sudo apt-get install -y texlive-full || echo "Warning: texlive-full failed to install (non-fatal)"
fi

# Firefox (snap-only on Ubuntu 24.04+, may not work in all environments)
if ! command -v firefox >/dev/null 2>&1; then
    echo "Installing Firefox..."
    sudo apt-get install -y firefox 2>/dev/null || \
        (is-snap-available && sudo snap install firefox) || \
        echo "Warning: Firefox install failed (install manually or via snap)"
fi

# Install git LFS
command -v git-lfs >/dev/null 2>&1 && git lfs install --system

# === Third-party tools (external repos/downloads, failures are non-fatal) ===

# GitHub CLI (not in default Ubuntu repos, needs official PPA)
if ! command -v gh >/dev/null 2>&1; then
    echo "Installing GitHub CLI..."
    (
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
            sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
        sudo apt-get update
        sudo apt-get install -y gh
    ) || echo "Warning: GitHub CLI failed to install"
fi

# eza (modern ls replacement, not in standard apt repos)
if ! command -v eza >/dev/null 2>&1; then
    echo "Installing eza..."
    (
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] https://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update
        sudo apt-get install -y eza
    ) || echo "Warning: eza failed to install"
fi

# uv (fast Python package manager)
if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh || echo "Warning: uv failed to install"
fi

# yq (YAML processor, not in standard apt repos)
if ! command -v yq >/dev/null 2>&1; then
    echo "Installing yq..."
    (
        YQ_VERSION=$(curl -sS https://api.github.com/repos/mikefarah/yq/releases/latest | grep -oP '"tag_name":\s*"\K[^"]+')
        if [[ -n "$YQ_VERSION" ]]; then
            curl -fLo /tmp/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"
            sudo install /tmp/yq /usr/local/bin/yq
            rm -f /tmp/yq
        fi
    ) || echo "Warning: yq failed to install"
fi

# ruff (fast Python linter/formatter, not in standard apt repos)
if ! command -v ruff >/dev/null 2>&1 && command -v uv >/dev/null 2>&1; then
    echo "Installing ruff..."
    uv tool install ruff || echo "Warning: ruff failed to install"
fi

# git-delta (syntax-highlighted diffs, replaces diff-so-fancy)
if ! command -v delta >/dev/null 2>&1; then
    echo "Installing git-delta..."
    (
        DELTA_VERSION=$(curl -sS https://api.github.com/repos/dandavison/delta/releases/latest | grep -oP '"tag_name":\s*"\K[^"]+')
        curl -LO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
        sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
        rm -f "git-delta_${DELTA_VERSION}_amd64.deb"
    ) || echo "Warning: git-delta failed to install"
fi

# Zotero (via zotero-deb repository)
if ! command -v zotero >/dev/null 2>&1; then
    echo "Installing Zotero..."
    (
        curl -sS https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
        sudo apt-get update
        sudo apt-get install -y zotero
    ) || echo "Warning: Zotero failed to install"
fi

# Quarto (via .deb download)
if ! command -v quarto >/dev/null 2>&1; then
    echo "Installing Quarto..."
    (
        QUARTO_VERSION=$(curl -sS https://quarto.org/docs/download/_download.json | grep -oP '"version":\s*"\K[^"]+' | head -1)
        curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
        sudo dpkg -i "quarto-${QUARTO_VERSION}-linux-amd64.deb"
        rm -f "quarto-${QUARTO_VERSION}-linux-amd64.deb"
    ) || echo "Warning: Quarto failed to install"
fi

# GitHub Desktop (Git GUI, via shiftkey/desktop Linux fork)
if ! command -v github-desktop >/dev/null 2>&1; then
    echo "Installing GitHub Desktop..."
    (
        wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg >/dev/null
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" | \
            sudo tee /etc/apt/sources.list.d/shiftkey-packages.list >/dev/null
        sudo apt-get update
        sudo apt-get install -y github-desktop
    ) || echo "Warning: GitHub Desktop failed to install"
fi

# WezTerm terminal (cross-platform, replaces iTerm2)
if ! command -v wezterm >/dev/null 2>&1; then
    echo "Installing WezTerm..."
    (
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | \
            sudo tee /etc/apt/sources.list.d/wezterm.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y wezterm
    ) || echo "Warning: WezTerm failed to install"
fi

# VSCodium (open-source VS Code)
if ! command -v codium >/dev/null 2>&1; then
    echo "Installing VSCodium..."
    (
        sudo apt-get install -y software-properties-common apt-transport-https
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
            | gpg --dearmor \
            | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
        echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
            | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y codium
    ) || echo "Warning: VSCodium failed to install"
fi

# Apps via snap (only for apps not available in apt)
if is-snap-available; then
    echo "Installing snap packages..."

    # Map snap names to cli command and app name for existence checks
    # Format: "snap_name:cli_cmd:app_name:flags" (use - for empty fields)
    snap_apps=(
        "slack:slack:Slack:--classic"       # Team messaging
        "spotify:spotify:Spotify:-"         # Music streaming
    )

    for entry in "${snap_apps[@]}"; do
        IFS=':' read -r snap_name cli_cmd app_name flags <<< "$entry"
        [[ "$cli_cmd" == "-" ]] && cli_cmd=""
        [[ "$app_name" == "-" ]] && app_name=""
        [[ "$flags" == "-" ]] && flags=""

        if snap list "$snap_name" &>/dev/null; then
            echo "$snap_name: already installed via snap"
            continue
        fi
        if [[ -n "$cli_cmd" ]] && command -v "$cli_cmd" >/dev/null 2>&1; then
            echo "$snap_name: found '$cli_cmd' in PATH, skipping"
            continue
        fi
        if [[ -n "$app_name" ]] && app-exists "$app_name"; then
            echo "$snap_name: found '$app_name' app, skipping"
            continue
        fi

        echo "Installing $snap_name..."
        sudo snap install "$snap_name" $flags 2>/dev/null || echo "Note: $snap_name snap install failed (may need manual install)"
    done
fi

# Set Firefox as default browser
if command -v firefox >/dev/null 2>&1 && command -v xdg-settings >/dev/null 2>&1; then
    xdg-settings set default-web-browser firefox.desktop 2>/dev/null || true
fi

echo "apt package installation complete"
echo ""
echo "Note: Some applications must be installed manually on Linux:"
echo "  - Zoom: https://zoom.us/download"
echo "  - WhatsApp: No official Linux client (use web version)"
