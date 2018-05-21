#!/usr/bin/env bash

brew  cask install miniconda

echo "================================================="
echo "installing conda python packages"
conda install --yes --channel conda-forge \
  bottleneck \
  cartopy \
  cython \
  dask \
  flake8 \
  future \
  ipython \
  jedi \
  jupyter \
  matplotlib \
  netcdf4 \
  numpy \
  pandas \
  scipy \
  scikit-learn \
  statsmodels \
  six \
  tqdm \
  xarray

# install from r channel
echo "================================================="
echo "installing r-essentials"
conda install --yes -c r r-essentials rstudio
