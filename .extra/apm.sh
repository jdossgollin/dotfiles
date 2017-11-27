#!/usr/bin/env bash

brew cask install atom
apm update && apm upgrade

apps=(
  autocomplete-bibtex
  autocomplete-python
  hydrogen
  language-latex
  language-r
  language-stan
  latextools
  make-runner
  markdown-preview-plus
  script
)

apm install "${apps[@]}"
