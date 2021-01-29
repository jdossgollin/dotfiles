#!/usr/bin/env bash

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

# use package managers to install some key packages
. "$DOTFILES_DIR/install/install-zsh.sh"       # use zsh
. "$DOTFILES_DIR/install/install-brew.sh"      # install software on Homebrew
. "$DOTFILES_DIR/install/install-brew-cask.sh" # install apps using Homebrew
. "$DOTFILES_DIR/install/install-conda.sh"     # install apps using Homebrew
. "$DOTFILES_DIR/install/install-fonts.sh"     # install fonts using Homebrew
# . "$DOTFILES_DIR/install/install-docker.sh"    # use docker!

# symbolic links for shell, git, etc
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitignore_global" ~

# enable permissions for all the binaries in ./bin
find $DOTFILES_DIR/bin/ -type f -name "*.sh" -exec chmod +x {} \;

# OSX defaults
. "$DOTFILES_DIR/macos/dock.sh"
