if ! is-executable curl -o ! is-executable git; then
    echo "Skipped: Homebrew (missing: curl and/or git)"
    return
fi
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Initialize Homebrew in current shell
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

brew update
brew upgrade

# Map brew formula names to their CLI commands (for existence check)
# Format: "formula:command" (command defaults to formula name if omitted)
apps=(
    "aspell"            # Spell checker
    "bat"               # Modern cat with syntax highlighting
    "boost"             # C++ libraries, no command
    "btop"              # Modern resource monitor
    "defaultbrowser"    # Set default browser from CLI
    "eza"               # Modern ls replacement
    "fzf"               # Fuzzy finder
    "gcc"               # GNU compiler collection
    "gh"                # GitHub CLI
    "git"               # Version control
    "imagemagick:magick" # Image manipulation tools
    "git-delta:delta"   # Better git diff viewer
    "git-extras"        # Additional git commands
    "git-lfs"           # Git Large File Storage
    "nano"              # Simple text editor
    "ncdu"              # Disk usage analyzer
    "node"              # JavaScript runtime
    "p7zip:7z"          # File archiver
    "pandoc"            # Document converter
    "ripgrep:rg"        # Fast text search
    "shellcheck"        # Shell script linter
    "tldr"              # Simplified man pages
    "tree"              # Directory tree viewer
    "uv"                # Python package manager
    "wget"              # Download files from web
)

# Install each formula, skipping if command already exists
to_install=()
for entry in "${apps[@]}"; do
    IFS=':' read -r formula cmd <<< "$entry"
    cmd="${cmd:-$formula}"  # default to formula name

    if brew list "$formula" &>/dev/null; then
        echo "$formula: already installed via Homebrew"
    elif command -v "$cmd" >/dev/null 2>&1; then
        echo "$formula: found '$cmd' in PATH, skipping"
    else
        to_install+=("$formula")
    fi
done

if [[ ${#to_install[@]} -gt 0 ]]; then
    echo "Installing: ${to_install[*]}"
    brew install "${to_install[@]}"
else
    echo "All brew formulae already installed"
fi

# dockutil for managing macOS dock
if ! command -v dockutil >/dev/null 2>&1; then
    brew install dockutil
fi

# TeX Live (full distribution, no GUI apps)
if ! command -v pdflatex >/dev/null 2>&1; then
    echo "Installing MacTeX (no GUI)..."
    brew install --cask mactex-no-gui
fi

# Dashlane CLI (requires custom tap)
if ! command -v dcli >/dev/null 2>&1; then
    brew install dashlane/tap/dashlane-cli
fi

# Install git LFS
git lfs install --system

# Remove outdated versions from the cellar
brew cleanup

# Clean up unnecessary taps (these are now built-in)
brew untap homebrew/cask 2>/dev/null || true
brew untap homebrew/core 2>/dev/null || true

brew doctor || echo "brew doctor reported warnings (non-fatal)"

export DOTFILES_BREW_PREFIX_COREUTILS=$(brew --prefix coreutils)
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
