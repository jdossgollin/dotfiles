if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# Map cask names to their CLI command and/or app bundle name
# Format: "cask_name:cli_command:App Name" (use - for empty fields)
cask_apps=(
    "claude:-:Claude"
    "claude-code:claude:-"
    "firefox:firefox:Firefox"
    "insync:insync:Insync"
    "slack:-:Slack"
    "slidepilot:-:SlidePilot"
    "github:-:GitHub Desktop"
    "spotify:-:Spotify"
    "stats:-:Stats"
    "quarto:quarto:-"
    "vscodium:codium:VSCodium"
    "wezterm:wezterm:WezTerm"
    "whatsapp:-:WhatsApp"
    "zoom:-:zoom.us"
    "zotero:zotero:Zotero"
)

# Install each cask, skipping if already installed
for entry in "${cask_apps[@]}"; do
    IFS=':' read -r cask_name cli_cmd app_name <<< "$entry"
    [[ "$cli_cmd" == "-" ]] && cli_cmd=""
    [[ "$app_name" == "-" ]] && app_name=""

    # Check if already installed (brew, CLI, or app bundle)
    if brew list --cask "$cask_name" &>/dev/null; then
        echo "$cask_name: already installed via Homebrew"
        continue
    fi
    if [[ -n "$cli_cmd" ]] && command -v "$cli_cmd" >/dev/null 2>&1; then
        echo "$cask_name: found '$cli_cmd' in PATH, skipping"
        continue
    fi
    if [[ -n "$app_name" ]] && app-exists "$app_name"; then
        echo "$cask_name: found '$app_name' app, skipping"
        continue
    fi

    echo "Installing $cask_name..."
    brew install --cask "$cask_name" || echo "Warning: $cask_name failed to install"
done

# Install cask apps
brew tap buo/cask-upgrade

brew cu --all --cleanup --yes

# Set Firefox as default browser (requires user confirmation dialog)
if command -v defaultbrowser >/dev/null 2>&1; then
    defaultbrowser firefox
fi
