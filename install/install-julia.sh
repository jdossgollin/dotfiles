#!/usr/bin/env bash

# Install juliaup based on platform
if is-macos 2>/dev/null; then
    brew install juliaup
elif is-linux 2>/dev/null; then
    # Official juliaup installer for Linux
    if ! command -v juliaup >/dev/null 2>&1; then
        echo "Installing juliaup..."
        curl -fsSL https://install.julialang.org | sh -s -- -y
        # Add to path for current session
        export PATH="$HOME/.juliaup/bin:$PATH"
    fi
fi

# Configure Julia versions (platform agnostic)
if command -v juliaup >/dev/null 2>&1; then
    juliaup add release
    juliaup default release
    juliaup update
fi
