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
    p7zip-full \
    pandoc \
    shellcheck \
    tree \
    wget \
    zsh \
    zsh-syntax-highlighting

# Install git LFS
git lfs install --system

# git-delta (syntax-highlighted diffs, replaces diff-so-fancy)
if ! command -v delta >/dev/null 2>&1; then
    echo "Installing git-delta..."
    DELTA_VERSION=$(curl -sS https://api.github.com/repos/dandavison/delta/releases/latest | grep -oP '"tag_name":\s*"\K[^"]+')
    curl -LO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
    rm -f "git-delta_${DELTA_VERSION}_amd64.deb"
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

# SourceGit (open-source Git GUI, replaces GitHub Desktop)
if ! command -v sourcegit >/dev/null 2>&1; then
    echo "Installing SourceGit..."
    SOURCEGIT_VERSION=$(curl -sS https://api.github.com/repos/sourcegit-scm/sourcegit/releases/latest | grep -oP '"tag_name":\s*"v\K[^"]+')
    curl -LO "https://github.com/sourcegit-scm/sourcegit/releases/download/v${SOURCEGIT_VERSION}/sourcegit_${SOURCEGIT_VERSION}.linux-x64.AppImage"
    chmod +x "sourcegit_${SOURCEGIT_VERSION}.linux-x64.AppImage"
    sudo mv "sourcegit_${SOURCEGIT_VERSION}.linux-x64.AppImage" /usr/local/bin/sourcegit
fi

# WezTerm terminal (cross-platform, replaces iTerm2)
if ! command -v wezterm >/dev/null 2>&1; then
    echo "Installing WezTerm..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | \
        sudo tee /etc/apt/sources.list.d/wezterm.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y wezterm
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
echo "  - WhatsApp: No official Linux client (use web version)"
