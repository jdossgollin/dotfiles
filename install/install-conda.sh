#!/usr/bin/env bash

brew  cask install miniconda3

packages=(
  flake8
  ipython
  jedi
  jupyter
  matplotlib
  numpy
  pandas
  scipy
  scikit-learn
  statsmodels
  xarray
)

for item in ${packages[*]}; do
    echo "================================================="
    echo "installing ${item}"
    conda install --yes ${item}
done

# install from r channel
conda install --yes -c r r-essentials
echo "================================================="
echo "installing r-essentials"
