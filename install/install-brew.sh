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
    aspell        # spell checker
    boost         # some C/C++ libraries
    cheat         # command line help https://github.com/cheat/cheat
    diff-so-fancy # when you run git diff, get cleaner output
    dockutil      # to edit what lives on the dock
    gcc           # C compiler
    git           # for version control!
    git-extras    # extra utilities for git, helpful
    git-lfs       # use git large file storage (see github docs)
    nano          # built-in text editor, not powerful but lightweight
    pandoc        # convert between Markdown, latex, HTML, Word, and more
    ruby          # for web development
    shellcheck    # check spelling mistakes in the shell
    tree          # update the version installed by default
    wget          # update the version installed by default
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
