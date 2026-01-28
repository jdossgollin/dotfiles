#!/usr/bin/env bash

# Install zsh based on platform
if is-macos 2>/dev/null; then
    brew install zsh
    brew install zsh-syntax-highlighting
    brew install z
elif is-apt-available 2>/dev/null; then
    sudo apt-get install -y zsh zsh-syntax-highlighting
fi

# Change default shell - first add to list of shells
if ! grep -q "$(command -v zsh)" /etc/shells 2>/dev/null; then
    command -v zsh | sudo tee -a /etc/shells
fi

# Change shell (skip in CI environments)
if [[ -z "${CI:-}" ]]; then
    chsh -s "$(command -v zsh)"
fi

# Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

echo ""
echo "==> After install, open WezTerm and run 'p10k configure' if you want to customize the Powerlevel10k theme"
echo "    (Fonts are already configured in ~/.wezterm.lua)"
