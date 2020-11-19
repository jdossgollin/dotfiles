if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
apps=(
    brave-browser          # second browser to separate work/life
    dashlane               # password manager
    firefox                # keep it up to date!
    flash-npapi            # adobe flash player
    github                 # can be helpful, I suck at git
    google-backup-and-sync # free storage from columbia
    iterm2                 # better terminal
    joplin                 # note taking
    julia-lts              # programming language!
    mactex-no-gui          # latex
    mathpix-snipping-tool  # this is magic!
    slack                  # lab group
    spotify                # why not
    the-unarchiver         # easier [un]zipping
    visual-studio-code     # code editor
    whatsapp               # benefits of having this on desktop are questionable
    zoomus                 # we all work remotely now
    zotero                 # reference manager
)
brew cask install "${apps[@]}"
