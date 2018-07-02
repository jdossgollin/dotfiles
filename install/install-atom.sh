# install the Atom text editor/IDE and some packages
brew cask install atom

packages=(
  Hydrogen
  atom-beautify
  atom-latex
  atom-material-syntax-dark
  atom-material-ui
  emacs-plus
  file-icons
  language-latex
  language-markdown
  language-stan
  linter
  linter-ui-default
  linter-chktex
  linter-mypy
  tablr
)

for item in ${packages[*]}; do
    echo "================================================="
    echo "installing ${item} with atom package manager"
    apm install ${item}
done
