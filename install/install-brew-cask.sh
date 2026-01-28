if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# List of apps
cask_apps=(
    claude             # Claude desktop app
    claude-code        # AI coding assistant CLI
    firefox            # keep it up to date!
    insync             # Google Drive / OneDrive sync
    slack              # lab group
    sourcegit          # open-source Git GUI (replaces GitHub Desktop)
    spotify            # why not
    stats              # menu bar system monitor (replaces Activity Monitor)
    quarto             # next gen RMarkdown / bookdown
    vscodium           # code editor (open-source VS Code)
    wezterm            # cross-platform terminal (replaces iTerm2)
    whatsapp           # messaging
    zoom               # we all work remotely now
    zotero             # reference manager
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
