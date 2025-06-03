brew tap homebrew/cask-fonts

fonts=(
  font-changa-one
  font-cooper-hewitt
  font-cormorant
  font-crimson-text
  font-dejavu
  font-dejavu-sans-mono-for-powerline
  font-eb-garamond
  font-fira-code
  font-fira-mono
  font-fira-mono-for-powerline
  font-fira-sans
  font-fontawesome
  font-gfs-didot
  font-graduate
  font-iceland
  font-juliamono
  font-kameron
  font-lato
  font-meslo-lg-nerd-font
  font-old-standard-tt
  font-open-sans
  font-open-sans-condensed
  font-roboto
  font-source-code-pro
  font-source-code-pro-for-powerline
  font-special-elite
  font-tex-gyre-pagella
  font-tex-gyre-pagella-math
  font-trebuchet-ms
  font-varela-round
  font-xkcd
  font-xkcd-script
)

# arch -arm64 brew install svn
brew install --cask "${fonts[@]}"
