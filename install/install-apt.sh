#!/usr/bin/env bash

# Exit if not Linux or apt not available
if ! is-apt-available 2>/dev/null; then
    echo "Skipped: apt packages (apt not available)"
    return 0 2>/dev/null || exit 0
fi

echo "Installing apt packages..."

sudo apt-get update

# Map apt package names to their CLI commands (for existence check)
# Format: "package:command" (command defaults to package name if omitted)
apt_packages=(
    "aspell"
    "bat:batcat"        # Ubuntu names it batcat
    "btop"
    "build-essential:gcc"
    "curl"
    "firefox"
    "fzf"
    "gh"
    "git"
    "git-extras"
    "git-lfs"
    "libboost-all-dev"  # library, no command check
    "nano"
    "ncdu"
    "nodejs:node"
    "npm"
    "p7zip-full:7z"
    "pandoc"
    "ripgrep:rg"
    "shellcheck"
    "tldr"
    "tree"
    "wget"
    "zsh"
    "zsh-syntax-highlighting"
    "texlive-full:pdflatex"
)

# Build list of packages to install
to_install=()
for entry in "${apt_packages[@]}"; do
    IFS=':' read -r pkg cmd <<< "$entry"
    cmd="${cmd:-$pkg}"  # default to package name

    if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
        echo "$pkg: already installed via apt"
    elif command -v "$cmd" >/dev/null 2>&1; then
        echo "$pkg: found '$cmd' in PATH, skipping"
    else
        to_install+=("$pkg")
    fi
done

if [[ ${#to_install[@]} -gt 0 ]]; then
    echo "Installing: ${to_install[*]}"
    sudo apt-get install -y "${to_install[@]}"
else
    echo "All apt packages already installed"
fi

# Install git LFS
git lfs install --system

# eza (modern ls replacement, not in standard apt repos)
if ! command -v eza >/dev/null 2>&1; then
    echo "Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update
    sudo apt-get install -y eza
fi

# uv (fast Python package manager)
if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# git-delta (syntax-highlighted diffs, replaces diff-so-fancy)
if ! command -v delta >/dev/null 2>&1; then
    echo "Installing git-delta..."
    DELTA_VERSION=$(curl -sS https://api.github.com/repos/dandavison/delta/releases/latest | grep -oP '"tag_name":\s*"\K[^"]+')
    curl -LO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
    sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb"
    rm -f "git-delta_${DELTA_VERSION}_amd64.deb"
fi

# Zotero (via zotero-deb repository)
if ! command -v zotero >/dev/null 2>&1; then
    echo "Installing Zotero..."
    curl -sS https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
    sudo apt-get update
    sudo apt-get install -y zotero
fi

# Quarto (via .deb download)
if ! command -v quarto >/dev/null 2>&1; then
    echo "Installing Quarto..."
    QUARTO_VERSION=$(curl -sS https://quarto.org/docs/download/_download.json | grep -oP '"version":\s*"\K[^"]+' | head -1)
    curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb"
    sudo dpkg -i "quarto-${QUARTO_VERSION}-linux-amd64.deb"
    rm -f "quarto-${QUARTO_VERSION}-linux-amd64.deb"
fi

# SourceGit (open-source Git GUI, replaces GitHub Desktop)
if ! command -v sourcegit >/dev/null 2>&1; then
    echo "Installing SourceGit..."
    # Add SourceGit GPG key
    curl https://codeberg.org/api/packages/yataro/debian/repository.key | sudo tee /etc/apt/keyrings/sourcegit.asc >/dev/null

    # Add SourceGit repository
    echo "deb [signed-by=/etc/apt/keyrings/sourcegit.asc, arch=amd64,arm64] https://codeberg.org/api/packages/yataro/debian generic main" | \
        sudo tee /etc/apt/sources.list.d/sourcegit.list >/dev/null

    sudo apt-get update
    sudo apt-get install -y sourcegit
fi

# WezTerm terminal (cross-platform, replaces iTerm2)
if ! command -v wezterm >/dev/null 2>&1; then
    echo "Installing WezTerm..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | \
        sudo tee /etc/apt/sources.list.d/wezterm.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y wezterm
fi

# VSCodium (open-source VS Code)
if ! command -v codium >/dev/null 2>&1; then
    echo "Installing VSCodium..."
    # Install prerequisites
    sudo apt-get install -y software-properties-common apt-transport-https

    # Add VSCodium GPG key
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

    # Add VSCodium repository
    echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
        | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y codium
fi

# Apps via snap (only for apps not available in apt)
if is-snap-available 2>/dev/null; then
    echo "Installing snap packages..."

    # Map snap names to cli command and app name for existence checks
    # Format: "snap_name:cli_cmd:app_name:flags" (use - for empty fields)
    snap_apps=(
        "insync:insync:Insync:-"
        "slack:slack:Slack:--classic"
        "spotify:spotify:Spotify:-"
    )

    for entry in "${snap_apps[@]}"; do
        IFS=':' read -r snap_name cli_cmd app_name flags <<< "$entry"
        [[ "$cli_cmd" == "-" ]] && cli_cmd=""
        [[ "$app_name" == "-" ]] && app_name=""
        [[ "$flags" == "-" ]] && flags=""

        if snap list "$snap_name" &>/dev/null; then
            echo "$snap_name: already installed via snap"
            continue
        fi
        if [[ -n "$cli_cmd" ]] && command -v "$cli_cmd" >/dev/null 2>&1; then
            echo "$snap_name: found '$cli_cmd' in PATH, skipping"
            continue
        fi
        if [[ -n "$app_name" ]] && app-exists "$app_name"; then
            echo "$snap_name: found '$app_name' app, skipping"
            continue
        fi

        echo "Installing $snap_name..."
        sudo snap install "$snap_name" $flags 2>/dev/null || echo "Note: $snap_name snap install failed (may need manual install)"
    done
fi

# Set Firefox as default browser
if command -v firefox >/dev/null 2>&1 && command -v xdg-settings >/dev/null 2>&1; then
    xdg-settings set default-web-browser firefox.desktop 2>/dev/null || true
fi

echo "apt package installation complete"
echo ""
echo "Note: Some applications must be installed manually on Linux:"
echo "  - Zoom: https://zoom.us/download"
echo "  - Claude desktop: No Linux version available"
echo "  - WhatsApp: No official Linux client (use web version)"
