if ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
    echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
    return
fi
if test ! $(which brew); then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# Install the Homebrew packages I use on a day-to-day basis.
apps=(
    aspell
    boost
    diff-so-fancy
    dockutil
    gcc
    git
    git-extras
    git-lfs
    nano
    # pandoc
    # pandoc-citeproc
    # pympress
    # shellcheck
    tree
    # wget
)
brew install "${apps[@]}"

# Install git LFS
git lfs install —system

# Remove outdated versions from the cellar
brew cleanup
brew doctor

export DOTFILES_BREW_PREFIX_COREUTILS=$(brew --prefix coreutils)
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

# use git diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
