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
    miniconda          # python package manager
    obsidian           # note taking
    raindropio         # bookmark manager
    rambox-pro         # all-in-one messaging
    slack              # lab group
    spotify            # why not
    the-unarchiver     # easier [un]zipping
    quarto             # next gen RMarkdown / bookdown
    visual-studio-code # code editor
    zoom               # we all work remotely now
    zotero             # reference manager
)
brew install --cask "${cask_apps[@]}"

brew tap buo/cask-upgrade
brew cu --all --cleanup --yes
