#!/usr/bin/env bash

# Exit if not Linux or apt not available
if ! is-apt-available 2>/dev/null; then
    echo "Skipped: apt packages (apt not available)"
    return 0 2>/dev/null || exit 0
fi

echo "Installing apt packages..."

sudo apt-get update

# Core development tools
sudo apt-get install -y \
    aspell \
    build-essential \
    curl \
    firefox \
    gh \
    git \
    git-extras \
    git-lfs \
    libboost-all-dev \
    nano \
    nodejs \
    npm \
    pandoc \
    shellcheck \
    tree \
    wget \
    zsh \
    zsh-syntax-highlighting

# Install git LFS
git lfs install --system

# diff-so-fancy (via npm)
if ! command -v diff-so-fancy >/dev/null 2>&1; then
    echo "Installing diff-so-fancy..."
    sudo npm install -g diff-so-fancy
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

# Zotero (via zotero-deb repository)
if ! command -v zotero >/dev/null 2>&1; then
    echo "Installing Zotero..."
    curl -sS https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
    sudo apt-get update
    sudo apt-get install -y zotero
fi

# Quarto (via .deb download)
if ! command -v quarto >/dev/null 2>&1; then
    echo "Installing Quarto..."
    QUARTO_VERSION=$(curl -sS https://quarto.org/docs/download/_download.json | grep -oP '"version":\s*"\K[^"]+' | head -1)
    curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
    sudo dpkg -i "quarto-${QUARTO_VERSION}-linux-amd64.deb"
    rm -f "quarto-${QUARTO_VERSION}-linux-amd64.deb"
fi

# Brave browser (via apt repository)
if ! command -v brave-browser >/dev/null 2>&1; then
    echo "Installing Brave browser..."
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
        sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y brave-browser
fi

# VSCodium (open-source VS Code)
if ! command -v codium >/dev/null 2>&1; then
    echo "Installing VSCodium..."
    # Install prerequisites
    sudo apt-get install -y software-properties-common apt-transport-https

    # Add VSCodium GPG key
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

    # Add VSCodium repository
    echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
        | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y codium
fi

# Apps via snap (only for apps not available in apt)
if is-snap-available 2>/dev/null; then
    echo "Installing snap packages..."

    # cheat - command line cheatsheets
    if ! command -v cheat >/dev/null 2>&1; then
        sudo snap install cheat 2>/dev/null || echo "Note: cheat snap install failed (may need manual install)"
    fi

    # Insync - Google Drive / OneDrive sync
    if ! command -v insync >/dev/null 2>&1; then
        sudo snap install insync 2>/dev/null || echo "Note: Insync snap install failed (may need manual install)"
    fi

    # Obsidian - note taking
    if ! snap list obsidian >/dev/null 2>&1; then
        sudo snap install obsidian --classic 2>/dev/null || echo "Note: Obsidian snap install failed (may need manual install)"
    fi

    # Slack
    if ! command -v slack >/dev/null 2>&1; then
        sudo snap install slack --classic 2>/dev/null || echo "Note: Slack snap install failed (may need manual install)"
    fi

    # Spotify - not in apt
    if ! command -v spotify >/dev/null 2>&1; then
        sudo snap install spotify 2>/dev/null || echo "Note: Spotify snap install failed (may need manual install)"
    fi
fi

# Set Firefox as default browser
if command -v firefox >/dev/null 2>&1 && command -v xdg-settings >/dev/null 2>&1; then
    xdg-settings set default-web-browser firefox.desktop 2>/dev/null || true
fi

echo "apt package installation complete"
echo ""
echo "Note: Some applications must be installed manually on Linux:"
echo "  - Zoom: https://zoom.us/download"
echo "  - Claude desktop: No Linux version available"
echo "  - GitHub Desktop: No official Linux version (use gh CLI instead)"
echo "  - WhatsApp: No official Linux client (use web version)"
