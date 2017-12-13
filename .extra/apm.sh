#!/usr/bin/env bash

brew cask install atom
apm update && apm upgrade

apps=(
  autocomplete-bibtex
  hydrogen
  kite
  language-latex
  language-r
  language-stan
  latextools
  markdown-preview-plus
)

apm install "${apps[@]}"
