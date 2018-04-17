if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  Astro                 # astro mail
  cd-to                 # open terminal window in current directory
  firefox-beta          # keep it up to date!
  github                # can be helpful, I suck at git
  kindle                # Amazon kindle reader
  latexit               # for latex equations and Word/PPT/etc
  mactex                # install latex on mac
  skim                  # PDF viewer that plays nicely with latex extension in Atom
  slack                 # messaging
  spotify               # why not
  whatsapp              # also doesn't play well with Rambox
  zotero                # bibliography management
)
brew cask install "${apps[@]}"

fonts=(
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
)
brew cask install "${fonts[@]}"