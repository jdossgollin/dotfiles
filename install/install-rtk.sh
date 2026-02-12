#!/usr/bin/env bash

# Install RTK (Rust Token Killer) - saves LLM tokens by filtering CLI output
# https://github.com/rtk-ai/rtk

if command -v rtk >/dev/null 2>&1; then
    echo "RTK already installed: $(rtk --version 2>/dev/null || echo 'unknown version')"
else
    echo "Installing RTK..."
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
fi

# Configure RTK globally for Claude Code (hook + minimal RTK.md)
if command -v rtk >/dev/null 2>&1; then
    echo "Configuring RTK for Claude Code..."
    rtk init -g --auto-patch
fi
