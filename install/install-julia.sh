#!/usr/bin/env bash

# Install juliaup. Same official installer on both platforms: upstream advises
# against the Homebrew build ("the Juliaup variants provided by [OS-specific
# software repositories] currently have some drawbacks"), so macOS uses curl too.
# Self-updates in place; `brew upgrade` is not involved.
if ! command -v juliaup >/dev/null 2>&1; then
    echo "Installing juliaup..."
    curl -fsSL https://install.julialang.org | sh -s -- -y || echo "Warning: juliaup failed to install"
    # Add to path for current session
    export PATH="$HOME/.juliaup/bin:$PATH"
fi

# Configure Julia versions (platform agnostic)
if command -v juliaup >/dev/null 2>&1; then
    juliaup add release
    juliaup default release
    juliaup update
fi
