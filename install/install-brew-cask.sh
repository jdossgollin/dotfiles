if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
cask_apps=(
    brave-browser      # second browser to separate work/life
    claude             # Claude desktop app
    claude-code        # AI coding assistant CLI
    firefox            # keep it up to date!
    github             # can be helpful, I suck at git
    insync             # Google Drive / OneDrive sync
    iterm2             # better terminal
    obsidian           # note taking
    raindropio         # bookmark manager
    slack              # lab group
    spotify            # why not
    the-unarchiver     # easier [un]zipping
    quarto             # next gen RMarkdown / bookdown
    visual-studio-code # code editor
    whatsapp # messaging
    zoom     # we all work remotely now
    zotero   # reference manager
)

# Install each cask, skipping if already installed
for app in "${cask_apps[@]}"; do
    if brew list --cask "$app" &>/dev/null; then
        echo "$app already installed via Homebrew, skipping"
    else
        echo "Installing $app..."
        brew install --cask "$app" || echo "Warning: $app failed to install (may already exist)"
    fi
done

# Install cask apps
brew tap buo/cask-upgrade

brew cu --all --cleanup --yes

# Set Firefox as default browser (requires user confirmation dialog)
if command -v defaultbrowser >/dev/null 2>&1; then
    defaultbrowser firefox
fi
