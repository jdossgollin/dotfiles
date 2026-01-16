if ! is-executable curl -o ! is-executable git; then
    echo "Skipped: Homebrew (missing: curl and/or git)"
    return
fi
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Initialize Homebrew in current shell
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

brew update
brew upgrade

# Install the Homebrew packages I use on a day-to-day basis.
apps=(
    aspell         # spell checker
    boost          # some C/C++ libraries
    cheat          # command line help https://github.com/cheat/cheat
    defaultbrowser # set default browser from CLI
    diff-so-fancy  # when you run git diff, get cleaner output
    gcc            # C compiler
    git            # for version control!
    git-extras    # extra utilities for git, helpful
    git-lfs       # use git large file storage (see github docs)
    nano          # built-in text editor, not powerful but lightweight
    node
    pandoc     # convert between Markdown, latex, HTML, Word, and more
    shellcheck # check spelling mistakes in the shell
    tree       # update the version installed by default
    uvicorn    # python package manager
    wget       # update the version installed by default
)
brew install "${apps[@]}"

# Group dependencies by purpose
development_tools=(
    gcc     # Pin gcc version
    git     # Pin git version
    git-lfs # Pin git-lfs version
)

utilities=(
    aspell
    pandoc
    wget
)

brew install "${development_tools[@]}"
brew install "${utilities[@]}"

# the default version of dockutil on brew is old and doesn't work
# workaround: https://github.com/webpro/dotfiles/issues/30
brew install dockutil

# Install git LFS
git lfs install --system

# Remove outdated versions from the cellar
brew cleanup

# Clean up unnecessary taps (these are now built-in)
brew untap homebrew/cask 2>/dev/null || true
brew untap homebrew/core 2>/dev/null || true

brew doctor || echo "brew doctor reported warnings (non-fatal)"

export DOTFILES_BREW_PREFIX_COREUTILS=$(brew --prefix coreutils)
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

# use git diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
