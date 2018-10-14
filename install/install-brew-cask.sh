if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  dashlane                # password manager
  firefox-beta            # keep it up to date!
  github                  # can be helpful, I suck at git
  google-backup-and-sync  # free storage from columbia
  iterm2                  # superior terminal
  mactex                  # install latex on mac
  miniconda               # package manager
  skype                   # can't quite get by w/o this app
  spotify                 # why not
  visual-studio-code      # code editor
  whatsapp                # also doesn't play well with Rambox
  zotero                  # reference manager
)
brew cask install "${apps[@]}"

fonts=(
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
)
brew cask install "${fonts[@]}"
