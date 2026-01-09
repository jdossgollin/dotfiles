#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "${SCRIPT_DIR}")"

# Platform-specific conda installation
if is-macos 2>/dev/null; then
    # Install miniconda via Homebrew
    brew install --cask miniconda

    # Determine correct brew prefix
    BREW_PREFIX="$(get-brew-prefix 2>/dev/null || echo '/opt/homebrew')"
    CONDA_SH="${BREW_PREFIX}/Caskroom/miniconda/base/etc/profile.d/conda.sh"

elif is-linux 2>/dev/null; then
    # Install Miniforge (includes mamba, better for Linux)
    if [[ ! -d "$HOME/miniforge3" ]]; then
        echo "Installing Miniforge..."
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh"
        curl -L "$MINIFORGE_URL" -o /tmp/miniforge.sh
        bash /tmp/miniforge.sh -b -p "$HOME/miniforge3"
        rm /tmp/miniforge.sh
    fi
    CONDA_SH="$HOME/miniforge3/etc/profile.d/conda.sh"
fi

# Initialize conda for current shell if script exists
if [[ -f "$CONDA_SH" ]]; then
    . "$CONDA_SH"
fi

echo "Conda/Mamba installed. Create environments manually with: conda env create -f <file>.yml"
