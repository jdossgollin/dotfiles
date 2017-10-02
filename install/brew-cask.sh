if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  adobe-acrobat-reader # alternative to reading PDFs in Preview
  cd-to # open terminal window in current directory
  firefox-beta # keep it up to date!
  font-fira-code # cool font for code
  handbrake # work with media
  insomniax # cool app to keep system awake with closed lid or long time idle
  java
  kindle # Amazon kindle reader
  mactex # install latex on mac
  miniconda # python (and R)
  rambox # cool app to keep a bunch of gmail, slack, etc windows open at once
  skim # PDF viewer that plays nicely with latex extension in Atom
  skype # for some reason doesn't play well with rambox
  spotify # why not
)
brew cask install "${apps[@]}"

fonts=(
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
)
brew cask install "${fonts[@]}"
