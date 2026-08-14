#!/usr/bin/env bash

# Install Node.js based on platform
if is-macos; then
    brew install node
elif is-linux; then
    # Use NodeSource for latest LTS. Download the setup script and run it as a
    # separate step rather than piping into sudo bash, per NodeSource's own
    # instructions: a truncated download can't execute as a partial script.
    if ! command -v node >/dev/null 2>&1; then
        echo "Installing Node.js via NodeSource..."
        NODESOURCE_SETUP="$(mktemp)"
        if curl -fsSL https://deb.nodesource.com/setup_lts.x -o "$NODESOURCE_SETUP"; then
            sudo -E bash "$NODESOURCE_SETUP"
            sudo apt-get install -y nodejs
        else
            echo "Warning: could not download the NodeSource setup script"
        fi
        rm -f "$NODESOURCE_SETUP"
    fi
fi

# Cross-platform global npm packages
# Note: Claude Code is installed via install-claude-code.sh (native installer)
if command -v npm >/dev/null 2>&1; then
    npm install -g canvaslms-cli || echo "Warning: canvaslms-cli npm install failed"  # Canvas LMS CLI
fi
