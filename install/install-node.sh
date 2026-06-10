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

# Cross-platform global npm packages
# Note: Claude Code is installed via install-claude-code.sh (native installer)
if command -v npm >/dev/null 2>&1; then
    npm install -g canvaslms-cli || echo "Warning: canvaslms-cli npm install failed"  # Canvas LMS CLI
fi
