if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
apps=(
    brave-browser         # second browser to separate work/life
    firefox               # keep it up to date!
    github                # can be helpful, I suck at git
    iterm2                # better terminal
    mathpix-snipping-tool # this is magic!
    notion                # note taking
    raindropio            # bookmark manager
    selfcontrol           # block distractions
    slack                 # lab group
    spotify               # why not
    the-unarchiver        # easier [un]zipping
    quarto                # next gen RMarkdown / bookdown
    visual-studio-code    # code editor
    whatsapp              # benefits of having this on desktop are questionable
    zoom                  # we all work remotely now
    zotero                # reference manager
)
brew install --cask "${apps[@]}"
