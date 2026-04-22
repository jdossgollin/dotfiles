#!/usr/bin/env bash

# Install Node.js based on platform
if is-macos; then
    brew install node
elif is-linux; then
    # Use NodeSource for latest LTS
    if ! command -v node >/dev/null 2>&1; then
        echo "Installing Node.js via NodeSource..."
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
        sudo apt-get install -y nodejs
    fi
fi

# Install global npm packages
# On Linux, install claude-code via npm (macOS uses Homebrew cask)
if command -v npm >/dev/null 2>&1 && is-linux; then
    sudo npm install -g @anthropic-ai/claude-code || echo "Warning: claude-code npm install failed"
fi

# Cross-platform global npm packages
if command -v npm >/dev/null 2>&1; then
    npm install -g canvaslms-cli || echo "Warning: canvaslms-cli npm install failed"  # Canvas LMS CLI
fi
