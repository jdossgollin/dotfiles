#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$DOTFILES_DIR/.extra"

# Common functions
. "$DOTFILES_DIR/system/.function"
. "$DOTFILES_DIR/system/.function_network"

# Update dotfiles itself first
if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/system/.mackup.cfg" ~
ln -sfv "$DOTFILES_DIR/system/.latexmkrc" ~

# Package managers & packages
. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/bash.sh"
. "$DOTFILES_DIR/install/brew-cask.sh"

# Install extra stuff (R, Python, Atom, Docker)
. "$DOTFILES_EXTRA_DIR/conda.sh"
. "$DOTFILES_EXTRA_DIR/docker.sh"
. "$DOTFILES_EXTRA_DIR/R.sh"
