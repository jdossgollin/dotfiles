#!/usr/bin/env bash

# Setup logging
mkdir -p ~/.dotfiles/logs
LOG_FILE="$HOME/.dotfiles/logs/install_$(date '+%Y%m%d_%H%M%S').log"
exec 1> >(tee "${LOG_FILE}")
exec 2> >(tee "${LOG_FILE}" >&2)
echo "Installation started at $(date '+%Y-%m-%d %H:%M:%S')"

# Error handling
set -e
trap 'echo "[$(date "+%Y-%m-%d %H:%M:%S")] Error on line $LINENO. Exit code: $?" | tee -a "${LOG_FILE}"' ERR

# Get current dir (so we can run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$DOTFILES_DIR/.extra"

# Get access to platform detection functions
. "$DOTFILES_DIR/system/.function"

# Platform-specific initialization
if is-macos; then
    echo "Detected macOS"
    # Detect architecture and set Homebrew path
    if [[ "$(uname -m)" == "arm64" ]]; then
        BREW_PREFIX="/opt/homebrew"
    else
        BREW_PREFIX="/usr/local"
    fi

    # Initialize Homebrew if installed
    if [[ -x "${BREW_PREFIX}/bin/brew" ]]; then
        eval "$("${BREW_PREFIX}/bin/brew" shellenv)"
        # Only add to .zprofile if not already present
        if ! grep -q 'brew shellenv' ~/.zprofile 2>/dev/null; then
            echo "eval \"\$(${BREW_PREFIX}/bin/brew shellenv)\"" >> ~/.zprofile
        fi
    fi
elif is-linux; then
    echo "Detected Linux"
    # Ensure apt is up to date
    if is-apt-available; then
        sudo apt-get update
    fi
fi

# Create function for modular installation
install_package() {
    echo "Installing $1..."
    if ! $2; then
        echo "Failed to install $1"
        return 1
    fi
}

# Platform-specific package installation
if is-macos; then
    install_package "brew" ". $DOTFILES_DIR/install/install-brew.sh"
    install_package "zsh" ". $DOTFILES_DIR/install/install-zsh.sh"
    install_package "brew cask" ". $DOTFILES_DIR/install/install-brew-cask.sh"
    install_package "fonts" ". $DOTFILES_DIR/install/install-fonts.sh"
elif is-linux; then
    install_package "apt packages" ". $DOTFILES_DIR/install/install-apt.sh"
    install_package "zsh" ". $DOTFILES_DIR/install/install-zsh.sh"
    install_package "fonts" ". $DOTFILES_DIR/install/install-fonts.sh"
fi

# Cross-platform installations
install_package "conda" ". $DOTFILES_DIR/install/install-conda.sh"
install_package "node" ". $DOTFILES_DIR/install/install-node.sh"
install_package "julia" ". $DOTFILES_DIR/install/install-julia.sh"

# Symbolic links for shell, git, etc (same for all platforms)
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/apps/wezterm/wezterm.lua" ~/.wezterm.lua

# VSCodium settings (platform-specific paths)
if is-macos; then
    VSCODIUM_USER_DIR="$HOME/Library/Application Support/VSCodium/User"
elif is-linux; then
    VSCODIUM_USER_DIR="$HOME/.config/VSCodium/User"
fi
if [[ -n "$VSCODIUM_USER_DIR" ]]; then
    mkdir -p "$VSCODIUM_USER_DIR"
    ln -sfv "$DOTFILES_DIR/apps/.vscode/settings.json" "$VSCODIUM_USER_DIR/settings.json"
fi

# Claude Code configuration
mkdir -p ~/.claude

# Install Claude skills repo (includes CLAUDE.md and skills)
if [ -d ~/.claude/skills/.git ]; then
    echo "Updating Claude skills..."
    git -C ~/.claude/skills pull --quiet
else
    echo "Installing Claude skills..."
    git clone https://github.com/jdossgollin/claude-skills ~/.claude/skills 2>/dev/null || \
        echo "Note: Could not clone claude-skills. Clone manually or create ~/.claude/skills"
fi

# Symlink global CLAUDE.md from skills repo
if [ -f ~/.claude/skills/CLAUDE.md ]; then
    ln -sfv ~/.claude/skills/CLAUDE.md ~/.claude/CLAUDE.md
fi

# Link language-specific rules from dotfiles
ln -sfnv "$DOTFILES_DIR/.claude/rules" ~/.claude/rules
# Set global gitignore
git config --global core.excludesfile ~/.gitignore_global

# Configure git identity from secrets (if available)
if [[ -f "$DOTFILES_DIR/secrets/.git_identity" ]]; then
    echo "Configuring git identity from secrets..."
    source "$DOTFILES_DIR/secrets/.git_identity"
    [[ -n "$GIT_USER_NAME" ]] && git config --global user.name "$GIT_USER_NAME"
    [[ -n "$GIT_USER_EMAIL" ]] && git config --global user.email "$GIT_USER_EMAIL"
    [[ -n "$GIT_GITHUB_USER" ]] && git config --global github.user "$GIT_GITHUB_USER"
else
    echo ""
    echo "NOTE: Git identity not configured."
    echo "  1. Copy the template: cp $DOTFILES_DIR/secrets/.git_identity.template $DOTFILES_DIR/secrets/.git_identity"
    echo "  2. Edit with your details"
    echo "  3. Re-run this script or configure manually with 'git config --global user.name/email'"
    echo ""
fi

# Set platform-specific git credential helper
if is-macos; then
    git config --global credential.helper osxkeychain
elif is-linux; then
    git config --global credential.helper cache
fi

# Enable permissions for all the binaries in ./bin
find "$DOTFILES_DIR/bin/" -type f -exec chmod +x {} \;

# macOS-specific defaults
if is-macos; then
    . "$DOTFILES_DIR/macos/dock.sh"
fi

echo ""
echo "Installation complete!"
echo "Log file: ${LOG_FILE}"
echo ""
echo "Next steps:"
echo "  1. Set up git identity (see above if not already done)"
echo "  2. Restart your terminal or run: source ~/.zshrc"
if is-macos; then
    echo "  3. Run 'dotfiles macos' to apply macOS system preferences"
fi
echo ""
echo "Claude Code MCP setup (optional):"
echo "  claude mcp add github --transport http https://api.githubcopilot.com/mcp/ --scope user"
echo "  claude mcp add context7 --transport http https://mcp.context7.com/mcp --scope user"
echo "  Then run /mcp in a Claude Code session to authenticate"
