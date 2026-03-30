# macOS CLI tools via Homebrew. Linux equivalent: install-apt.sh
# Run /audit-sync to verify parity between platforms.

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
brew upgrade || echo "brew upgrade reported issues (non-fatal)"

# Map brew formula names to their CLI commands (for existence check)
# Format: "formula:command" (command defaults to formula name if omitted)
apps=(
    "aspell"            # Spell checker
    "bat"               # Modern cat with syntax highlighting
    "btop"              # Modern resource monitor
    "defaultbrowser"    # Set default browser from CLI
    "eza"               # Modern ls replacement
    "fzf"               # Fuzzy finder
    "gh"                # GitHub CLI
    "git"               # Version control
    "git-delta:delta"   # Better git diff viewer
    "git-extras"        # Additional git commands
    "git-lfs"           # Git Large File Storage
    "nano"              # Simple text editor
    "ncdu"              # Disk usage analyzer
    "node"              # JavaScript runtime
    "p7zip:7z"          # File archiver
    "ripgrep:rg"        # Fast text search
    "shellcheck"        # Shell script linter
    "tldr"              # Simplified man pages
    "tree"              # Directory tree viewer
    "uv"                # Python package manager
    "wget"              # Download files from web
    "fd"                # Modern find replacement
    "jq"                # JSON processor
    "yq"                # YAML processor
    "direnv"            # Per-directory environments
    "ruff"              # Fast Python linter/formatter
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

# Heavy compile-from-source packages (skip in CI to avoid timeout)
if [[ -z "${CI:-}" ]]; then
    brew list boost &>/dev/null || brew install boost              # C++ libraries
    brew list gcc &>/dev/null || brew install gcc                   # GNU compiler collection
    brew list ffmpeg &>/dev/null || brew install ffmpeg             # Audio/video processing
    brew list imagemagick &>/dev/null || brew install imagemagick   # Image manipulation tools
    brew list pandoc &>/dev/null || brew install pandoc             # Document converter
fi

# dockutil for managing macOS dock
if ! command -v dockutil >/dev/null 2>&1; then
    brew install dockutil
fi

# TeX Live (full distribution, ~5GB, skip in CI to avoid timeout)
if ! command -v pdflatex >/dev/null 2>&1 && [[ -z "${CI:-}" ]]; then
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
