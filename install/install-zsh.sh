brew install zsh

# change shells -- first add it to list of shells
command -v zsh | sudo tee -a /etc/shells
chsh -s `which zsh`

# Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Syntax highlighting
brew install zsh-syntax-highlighting
