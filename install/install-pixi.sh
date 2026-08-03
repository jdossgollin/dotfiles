#!/usr/bin/env bash

# pixi global tools (pixi itself comes from install-brew.sh / install-apt.sh)
# Installs to $PIXI_HOME/bin (~/.pixi/bin), which system/.path prepends.

if ! command -v pixi >/dev/null 2>&1; then
    echo "Skipped: pixi global tools (pixi not installed)"
    return 0 2>/dev/null || exit 0
fi

# nbdime powers the .gitconfig jupyternotebook diff/merge drivers.
# Exposes git-nbdiffdriver, git-nbdifftool, git-nbmergedriver, git-nbmergetool.
if ! command -v git-nbdiffdriver >/dev/null 2>&1; then
    echo "Installing nbdime (notebook diff/merge for git)..."
    pixi global install nbdime || echo "Warning: nbdime failed to install"
fi
