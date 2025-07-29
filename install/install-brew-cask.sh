if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
cask_apps=(
    brave-browser      # second browser to separate work/life
    firefox            # keep it up to date!
    github             # can be helpful, I suck at git
    iterm2             # better terminal
    obsidian           # note taking
    raindropio         # bookmark manager
    slack              # lab group
    spotify            # why not
    superhuman         # email client
    the-unarchiver     # easier [un]zipping
    quarto             # next gen RMarkdown / bookdown
    visual-studio-code # code editor
    visual-studio-code@insiders
    whatsapp # messaging
    zoom     # we all work remotely now
    zotero   # reference manager
)
brew install --cask "${cask_apps[@]}"

# Install cask apps
brew tap buo/cask-upgrade

brew cu --all --cleanup --yes
