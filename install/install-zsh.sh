brew install zsh

# change shells -- first add it to list of shells
command -v zsh | sudo tee -a /etc/shells
if test ! ${CI:-}; then
    # it will ask for a password on Travis CI
    chsh -s `which zsh`
fi

# Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Syntax highlighting
brew install zsh-syntax-highlighting

# install z for completion
brew install z
