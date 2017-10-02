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
brew tap homebrew/science
brew tap caskroom/cask
brew tap caskroom/fonts

# Install the Homebrew packages I use on a day-to-day basis.
apps=(
    bash-completion
    boost
    curl
    ffmpeg
    gdal
    geos
    git
    gmt # cool mapping softwares
    java
    libsvg
    libxml2
    markdown
    pandoc
    pandoc-citeproc
    poppler # for pdfunite
    source-highlight
    tree
    wget
    youtube-dl
)

brew install "${apps[@]}"



# Remove outdated versions from the cellar
brew cleanup
brew doctor

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
