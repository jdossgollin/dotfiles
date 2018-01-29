if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

# Some Taps
brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

# Install the Homebrew packages I use on a day-to-day basis.
apps=(
    boost
    coreutils
    curl
    diff-so-fancy
    drake
    dockutil
    fasd
    ffmpeg
    gifsicle
    git
    git-extras
    git-lfs
    gnu-sed --with-default-names
    grep --with-default-names
    hub
    imagemagick
    jq
    libsvg
    libxml2
    lynx
    mackup # back up some config files
    markdown
    nano
    pandoc
    pandoc-citeproc
    peco
    poppler # for pdfunite
    psgrep
    shellcheck
    source-highlight
    tree
    unar
    wget
    wifi-password
    youtube-dl
)
brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
brew doctor

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
