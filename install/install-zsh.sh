brew install zsh

# change shells -- first add it to list of shells
command -v zsh | sudo tee -a /etc/shells
chsh -s `which zsh`

# Oh My Zsh
curl -L http://install.ohmyz.sh | sh

# Syntax highlighting
brew install zsh-syntax-highlighting

# Powerline fonts -- needed for the theme of choice
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# install z for completion
brew install z
