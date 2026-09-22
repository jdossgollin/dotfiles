#!/usr/bin/env bash
# TaskNotes CLI — terminal interface to TaskNotes Obsidian plugin
# Requires: node, npm, TaskNotes plugin with API enabled
# Note: as of 2026-09-22 the CLI's list command is behind the plugin API
# (uses GET instead of POST for /api/tasks/query). Track upstream for a fix.

set -e

INSTALL_DIR="$HOME/tools/tasknotes-cli"

if [[ -d "$INSTALL_DIR" ]]; then
    echo "tasknotes-cli already installed at $INSTALL_DIR, pulling latest..."
    cd "$INSTALL_DIR" && git pull && npm install
else
    echo "Installing tasknotes-cli..."
    mkdir -p "$HOME/tools"
    git clone https://github.com/callumalpass/tasknotes-cli.git "$INSTALL_DIR"
    cd "$INSTALL_DIR" && npm install
fi

npm link
echo "tasknotes-cli installed: $(which tn)"
