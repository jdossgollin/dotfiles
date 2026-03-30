#!/usr/bin/env bash

# Install Miniforge (includes mamba, conda-forge default) on all platforms
if [[ ! -d "$HOME/miniforge3" ]]; then
    echo "Installing Miniforge..."
    if is-macos; then
        MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-$(uname -m).sh"
    elif is-linux; then
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

# Install nbdime for Jupyter notebook diffs (required by .gitconfig nbdiff/nbmerge drivers)
if command -v conda >/dev/null 2>&1 && ! command -v git-nbdiffdriver >/dev/null 2>&1; then
    echo "Installing nbdime (notebook diff/merge for git)..."
    conda install -y -n base -c conda-forge nbdime && \
        nbdime config-git --enable --global || echo "Warning: nbdime failed to install"
fi

echo "Conda/Mamba installed. Create environments manually with: conda env create -f <file>.yml"
