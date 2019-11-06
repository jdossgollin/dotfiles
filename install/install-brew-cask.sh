if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  adobe-acrobat-reader    # a standard PDF reader
  dashlane                # password manager
  firefox-beta            # keep it up to date!
  flash-npapi             # adobe flash player
  github                  # can be helpful, I suck at git
  google-backup-and-sync  # free storage from columbia
  iterm2                  # superior terminal
  mactex                  # latex!
  mathpix-snipping-tool   # magic!
  miniconda               # package manager
  skype                   # chat
  slack                   # lab group
  spotify                 # why not
  the-unarchiver          # easier [un]zipping
  visual-studio-code      # code editor
  whatsapp                # messaging
  zotero                  # reference manager
)
brew cask install "${apps[@]}"