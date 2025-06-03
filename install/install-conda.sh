# This is short but merits its own function

# arch -arm64 brew install wget

# Detect architecture
if [[ $(uname -m) == 'arm64' ]]; then
    MINICONDA_INSTALLER="Miniconda3-latest-MacOSX-arm64.sh"
else
    MINICONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
fi

cd ~
wget "https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER" -O miniconda.sh || exit 1
bash miniconda.sh -b -p $HOME/anaconda/ || exit 1
rm miniconda.sh
