brew tap homebrew/cask-fonts

fonts=(
  homebrew/cask-fonts/font-changa-one
  homebrew/cask-fonts/font-crimson-text
  homebrew/cask-fonts/font-fira-code
  homebrew/cask-fonts/font-fira-mono
  homebrew/cask-fonts/font-fira-mono-for-powerline
  homebrew/cask-fonts/font-fira-sans
  homebrew/cask-fonts/font-kameron
  homebrew/cask-fonts/font-graduate
  homebrew/cask-fonts/font-iceland
  homebrew/cask-fonts/font-lato
  homebrew/cask-fonts/font-old-standard-tt
  homebrew/cask-fonts/font-open-sans
  homebrew/cask-fonts/font-open-sans-condensed
  homebrew/cask-fonts/font-roboto
  homebrew/cask-fonts/font-roboto-condensed
  homebrew/cask-fonts/font-titillium
  homebrew/cask-fonts/font-varela-round
  homebrew/cask-fonts/font-special-elite
)

brew cask install "${fonts[@]}"
