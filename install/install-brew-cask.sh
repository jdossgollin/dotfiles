# macOS GUI apps via Homebrew Cask. Linux equivalents in: install-apt.sh (apt/snap section)
# Run /audit-sync to verify parity between platforms.

if ! is-macos -o ! is-executable brew; then
    echo "Skipped: Homebrew-Cask"
    return
fi

# Skip GUI apps in CI (not testable in headless environment)
if [[ -n "${CI:-}" ]]; then
    echo "Skipped: Homebrew-Cask (CI environment)"
    return
fi

# Map cask names to their CLI command and/or app bundle name
# Format: "cask_name:cli_command:App Name" (use - for empty fields)
cask_apps=(
    # Dev tools
    "vscodium:codium:VSCodium"          # Open-source VS Code editor
    "wezterm:wezterm:WezTerm"           # GPU-accelerated terminal emulator
    "github:-:GitHub Desktop"           # Git GUI client
    "claude-code:claude:-"              # Claude Code CLI
    "quarto:quarto:-"                   # Scientific publishing (markdown → PDF/HTML/slides)

    # Browsers & communication
    "firefox:firefox:Firefox"           # Web browser
    "slack:-:Slack"                     # Team messaging
    "whatsapp:-:WhatsApp"              # Personal messaging
    "zoom:-:zoom.us"                    # Video conferencing

    # Productivity
    "google-drive:-:Google Drive"       # Cloud file sync
    "zotero:zotero:Zotero"             # Reference manager for academic papers
    "slidepilot:-:SlidePilot"          # PDF presentation tool (presenter view)
    "spotify:-:Spotify"                 # Music streaming
    "stats:-:Stats"                     # macOS menubar system monitor
    "signal:-:Signal"                   # Encrypted messaging
    "wispr-flow:-:Wispr Flow"           # Voice dictation
    "iguanatexmac:-:IguanaTex"         # LaTeX equations in Keynote/PowerPoint
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
