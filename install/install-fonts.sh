brew tap homebrew/cask-fonts

fonts=(
  homebrew/cask-fonts/font-changa-one
  homebrew/cask-fonts/font-charter
  homebrew/cask-fonts/font-cooper-hewitt
  homebrew/cask-fonts/font-crimson-text
  homebrew/cask-fonts/font-eb-garamond
  homebrew/cask-fonts/font-fira-code
  homebrew/cask-fonts/font-fira-mono
  homebrew/cask-fonts/font-fira-mono-for-powerline
  homebrew/cask-fonts/font-fira-sans
  homebrew/cask-fonts/font-gfs-didot
  homebrew/cask-fonts/font-graduate
  homebrew/cask-fonts/font-ibm-plex
  homebrew/cask-fonts/font-iceland
  homebrew/cask-fonts/font-kameron
  homebrew/cask-fonts/font-lato
  homebrew/cask-fonts/font-old-standard-tt
  homebrew/cask-fonts/font-open-sans
  homebrew/cask-fonts/font-open-sans-condensed
  homebrew/cask-fonts/font-roboto
  homebrew/cask-fonts/font-roboto-condensed
  homebrew/cask-fonts/font-source-code-pro
  homebrew/cask-fonts/font-source-code-pro-for-powerline
  homebrew/cask-fonts/font-special-elite
  homebrew/cask-fonts/font-titillium
  homebrew/cask-fonts/font-trebuchet-ms
  homebrew/cask-fonts/font-varela-round
)

brew cask install "${fonts[@]}"
