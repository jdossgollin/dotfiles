#!/usr/bin/env bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "${SCRIPT_DIR}")"

# Install Miniforge (includes mamba, conda-forge default) on all platforms
if [[ ! -d "$HOME/miniforge3" ]]; then
    echo "Installing Miniforge..."
    if is-macos 2>/dev/null; then
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-$(uname -m).sh"
    elif is-linux 2>/dev/null; then
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-$(uname -m).sh"
    else
        echo "Unsupported platform"
        exit 1
    fi
    MINIFORGE_TMP="$(mktemp "${TMPDIR:-/tmp}/miniforge.XXXXXXXXXX.sh")"
    curl -L "$MINIFORGE_URL" -o "$MINIFORGE_TMP"
    bash "$MINIFORGE_TMP" -b -p "$HOME/miniforge3"
    rm -f "$MINIFORGE_TMP"
fi
CONDA_SH="$HOME/miniforge3/etc/profile.d/conda.sh"

# Initialize conda for current shell if script exists
if [[ -f "$CONDA_SH" ]]; then
    . "$CONDA_SH"
fi

echo "Conda/Mamba installed. Create environments manually with: conda env create -f <file>.yml"
