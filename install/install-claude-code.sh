#!/usr/bin/env bash

# Claude Code CLI — Anthropic's official native installer (cross-platform).
# Installs to ~/.local/bin (already on PATH via system/.path).
# Previously installed via Homebrew cask (macOS) / npm (Linux); the native
# installer is now the recommended method and self-updates in place.

# Skip in CI (avoids network install in headless test runs)
if [[ -n "${CI:-}" ]]; then
    echo "Skipped: claude-code (CI environment)"
    return 2>/dev/null || exit 0
fi

if command -v claude >/dev/null 2>&1; then
    echo "claude-code: already installed ($(claude --version 2>/dev/null))"
else
    echo "Installing Claude Code via native installer..."
    curl -fsSL https://claude.ai/install.sh | bash || echo "Warning: claude-code failed to install"
fi
