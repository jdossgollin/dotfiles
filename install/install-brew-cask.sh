if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
apps=(
    adobe-acrobat-reader   # a standard PDF reader
    dashlane               # password manager
    firefox                # keep it up to date!
    flash-npapi            # adobe flash player
    github                 # can be helpful, I suck at git
    google-backup-and-sync # free storage from columbia
    iterm2                 # superior terminal
    mathpix-snipping-tool  # this is magic!
    miniconda              # package manager
    slack                  # lab group
    spotify                # why not
    the-unarchiver         # easier [un]zipping
    visual-studio-code     # code editor
    zotero                 # reference manager
    zoom                   # we all work remotely now
)
brew cask install "${apps[@]}"
