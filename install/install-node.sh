#!/usr/bin/env bash

# Install Node.js based on platform
if is-macos 2>/dev/null; then
    brew install node
elif is-linux 2>/dev/null; then
    # Use NodeSource for latest LTS
    if ! command -v node >/dev/null 2>&1; then
        echo "Installing Node.js via NodeSource..."
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
fi

# Install global npm packages
# On Linux, install claude-code via npm (macOS uses Homebrew cask)
if command -v npm >/dev/null 2>&1 && is-linux 2>/dev/null; then
    npm install -g @anthropic-ai/claude-code
fi
