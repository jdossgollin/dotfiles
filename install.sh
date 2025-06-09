#!/usr/bin/env bash

# Setup logging
mkdir -p ~/.dotfiles/logs
LOG_FILE="$HOME/.dotfiles/logs/install_$(date '+%Y%m%d_%H%M%S').log"
exec 1> >(tee "${LOG_FILE}")
exec 2> >(tee "${LOG_FILE}" >&2)
echo "Installation started at $(date '+%Y-%m-%d %H:%M:%S')"

# Error handling
set -e
trap 'echo "[$(date '+%Y-%m-%d %H:%M:%S')] Error on line $LINENO. Exit code: $?" | tee -a "${LOG_FILE}"' ERR

# Version check
if [[ "$(sw_vers -productVersion)" < "10.15" ]]; then
    echo "Error: macOS 10.15 or higher required"
    exit 1
fi

# get the brew command
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)

# Get current dir (so we can run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$DOTFILES_DIR/.extra"

# get access to functions
. "$DOTFILES_DIR/system/.function"

# Create functions for modular installation
install_package() {
    echo "Installing $1..."
    if ! $2; then
        echo "Failed to install $1"
        return 1
    fi
}

# use package managers to install some key packages
install_package "zsh" ". $DOTFILES_DIR/install/install-zsh.sh"
install_package "brew" ". $DOTFILES_DIR/install/install-brew.sh"
install_package "brew cask" ". $DOTFILES_DIR/install/install-brew-cask.sh"
install_package "fonts" ". $DOTFILES_DIR/install/install-fonts.sh"

# symbolic links for shell, git, etc
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitignore_global" ~

# set global gitignore
git config --global core.excludesfile ~/.gitignore_global

# enable permissions for all the binaries in ./bin
find $DOTFILES_DIR/bin/ -type f -exec chmod +x {} \;

# OSX defaults
. "$DOTFILES_DIR/macos/dock.sh"
