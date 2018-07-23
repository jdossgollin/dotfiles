if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  anki                    # this is so cool
  boostnote               # occasionally useful note app
  cd-to                   # open terminal window in current directory
  dashlane                # password manager
  firefox-beta            # keep it up to date!
  github                  # can be helpful, I suck at git
  google-backup-and-sync  # free storage from columbia
  google-earth-pro        # i love this app
  iterm2                  # superior terminal
  java                    # java for some r applications
  mactex                  # install latex on mac
  papers                  # excellent papers app
  slack                   # messaging
  skype                   # can't quite get by w/o this app
  spotify                 # why not
  visual-studio-code      # code editor
  whatsapp                # also doesn't play well with Rambox
)
brew cask install "${apps[@]}"

fonts=(
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
)
brew cask install "${fonts[@]}"
