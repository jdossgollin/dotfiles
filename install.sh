#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR DOTFILES_CACHE DOTFILES_EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_CACHE="$DOTFILES_DIR/.cache.sh"
DOTFILES_EXTRA_DIR="$DOTFILES_DIR/.extra"

# get access to functions
. "$DOTFILES_DIR/system/.function"

# Package managers & packages
. "$DOTFILES_DIR/install/install-zsh.sh"              # use zsh
. "$DOTFILES_DIR/install/install-brew.sh"             # install software on Homebrew
. "$DOTFILES_DIR/install/install-brew-cask.sh"        # install apps using Homebrew
. "$DOTFILES_DIR/install/install-ruby.sh"             # useful for website

# symbolic links for core
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.latexmkrc" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/apps/git/.gitignore_global" ~

# symbolic links for apps
ln -svf "$DOTFILES_DIR/apps/.rstudio/monitored/user-settings/user-settings" ~/.rstudio-desktop/monitored/user-settings/user-settings
ln -svf "$DOTFILES_DIR/apps/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# OSX defaults
. "$DOTFILES_DIR/macos/defaults.sh"
. "$DOTFILES_DIR/macos/dock.sh"
