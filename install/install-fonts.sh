#!/usr/bin/env bash

if is-macos 2>/dev/null; then
    # macOS font installation via Homebrew
    fonts=(
        font-cooper-hewitt
        font-cormorant
        font-crimson-text
        font-dejavu
        font-dejavu-sans-mono-for-powerline
        font-eb-garamond
        font-fira-code
        font-fira-mono
        font-fira-mono-for-powerline
        font-fira-sans
        font-fontawesome
        font-gfs-didot
        font-graduate
        font-iceland
        font-juliamono
        font-kameron
        font-lato
        font-meslo-lg-nerd-font
        font-old-standard-tt
        font-open-sans
        font-roboto
        font-source-code-pro
        font-source-code-pro-for-powerline
        font-special-elite
        font-tex-gyre-pagella
        font-tex-gyre-pagella-math
        font-trebuchet-ms
        font-varela-round
        font-xkcd
        font-xkcd-script
    )

    brew install --cask "${fonts[@]}" || echo "Some fonts failed to install (non-fatal)"

elif is-linux 2>/dev/null; then
    # Linux font installation
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    # Install via apt where available
    if is-apt-available 2>/dev/null; then
        sudo apt-get install -y fonts-firacode fonts-dejavu 2>/dev/null || true
    fi

    # Download Meslo Nerd Font (required for Powerlevel10k)
    echo "Downloading MesloLGS NF fonts for Powerlevel10k..."
    MESLO_URL="https://github.com/romkatv/powerlevel10k-media/raw/master"
    for style in "Regular" "Bold" "Italic" "Bold Italic"; do
        font_file="MesloLGS NF ${style}.ttf"
        encoded_file=$(echo "$font_file" | sed 's/ /%20/g')
        if [[ ! -f "${FONT_DIR}/${font_file}" ]]; then
            curl -fLo "${FONT_DIR}/${font_file}" "${MESLO_URL}/${encoded_file}" 2>/dev/null || \
                echo "Warning: Could not download ${font_file}"
        fi
    done

    # Refresh font cache
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -fv
    fi

    echo "Fonts installed to ${FONT_DIR}"
fi
