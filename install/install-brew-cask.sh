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
    mathpix-snipping-tool  # this is magic!
    slack                  # lab group
    spotify                # why not
    the-unarchiver         # easier [un]zipping
    visual-studio-code     # code editor
    whatsapp               # benefits of having this on desktop are questionable
    zotero                 # reference manager
    zoomus                 # we all work remotely now
)
brew cask install "${apps[@]}"

# iTerm2
brew cask install iterm2
