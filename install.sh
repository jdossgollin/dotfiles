#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$DOTFILES_DIR/.extra"

# get access to functions
. "$DOTFILES_DIR/system/.function"

# Update dotfiles itself first
if is-executable git -a -d "$DOTFILES_DIR/.git"; then git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master; fi

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

# miscellaneous symlinks
ln -sfv "$DOTFILES_DIR/system/.latexmkrc" ~

# Package managers & packages
. "$DOTFILES_DIR/install/install-brew.sh"       # install software on Homebrew
. "$DOTFILES_DIR/install/install-bash.sh"       # use bash shell
. "$DOTFILES_DIR/install/install-brew-cask.sh"  # install apps using Homebrew
. "$DOTFILES_DIR/install/install-atom.sh"       # install Atom and packages
. "$DOTFILES_DIR/install/install-conda.sh"      # install miniconda and a few packages
. "$DOTFILES_DIR/install/install-npm.sh"        # install npm and a few packages
. "$DOTFILES_DIR/install/install-gem.sh"        # install ruby gem and a few packages

# file symlink
ln -sfv "$DOTFILES_DIR/apps/emacs.d/init.el" ~/.emacs.d/init.el
ln -svf "$DOTFILES_DIR/apps/.atom/config.cson" ~/.atom/config.cson
ln -svf "$DOTFILES_DIR/apps/.rstudio/monitored/user-settings/user-settings" ~/.rstudio-desktop/monitored/user-settings/user-settings

# OSX defaults
. $"$DOTFILES_DIR/macos/defaults.sh"
. $"$DOTFILES_DIR/macos/dock.sh"
