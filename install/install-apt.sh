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
    build-essential \
    curl \
    wget \
    git \
    git-lfs \
    nano \
    tree \
    shellcheck \
    pandoc \
    zsh \
    zsh-syntax-highlighting

# Install git LFS
git lfs install --system

# VS Code (via Microsoft repository)
if ! command -v code >/dev/null 2>&1; then
    echo "Installing VS Code..."
    # Install prerequisites
    sudo apt-get install -y software-properties-common apt-transport-https

    # Add Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

    # Add VS Code repository
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
        sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y code

    rm -f /tmp/packages.microsoft.gpg
fi

# Apps via snap (only for apps not available in apt)
if is-snap-available 2>/dev/null; then
    echo "Installing snap packages..."

    # Spotify - not in apt
    if ! command -v spotify >/dev/null 2>&1; then
        sudo snap install spotify 2>/dev/null || echo "Note: Spotify snap install failed (may need manual install)"
    fi

    # Slack
    if ! command -v slack >/dev/null 2>&1; then
        sudo snap install slack --classic 2>/dev/null || echo "Note: Slack snap install failed (may need manual install)"
    fi
fi

echo "apt package installation complete"
echo ""
echo "Note: Some applications must be installed manually on Linux:"
echo "  - Zoom: https://zoom.us/download"
echo "  - Zotero: https://www.zotero.org/download/"
