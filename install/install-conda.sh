# This is short but merits its own function

# arch -arm64 brew install wget

cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh
bash anaconda.sh -b -p $HOME/anaconda/
~/anaconda/bin/conda install mamba -c conda-forge
