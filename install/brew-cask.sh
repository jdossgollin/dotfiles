if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask

# List of apps
apps=(
  adobe-acrobat-reader # alternative to reading PDFs in Preview
  Astro # astro mail
  boostnote # note-taking
  cd-to # open terminal window in current directory
  firefox-beta # keep it up to date!
  github-desktop # can be helpful
  handbrake # work with media
  insomniax # cool app to keep system awake with closed lid or long time idle
  java # for R
  kindle # Amazon kindle reader
  latexit # for latex equations and Word/PPT/etc
  mactex # install latex on mac
  miniconda # python (and R)
  quodlibet # great lightweight music organizer & file manager
  skim # PDF viewer that plays nicely with latex extension in Atom
  slack #
  skype # for some reason doesn't play well with rambox
  spotify # why not
  whatsapp # also doesn't play well with Rambox
)
brew cask install "${apps[@]}"

fonts=(
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
)
brew cask install "${fonts[@]}"
