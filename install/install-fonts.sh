#!/usr/bin/env bash

# Skip font installation in CI (large downloads, not what CI tests)
if [[ -n "${CI:-}" ]]; then
    echo "Skipped: font installation (CI environment)"
    return 0 2>/dev/null || exit 0
fi

if is-macos; then
    # macOS font installation via Homebrew
    # For descriptions and visual specimens, see: docs/font-specimens.typ
    fonts=(
        # Terminal & coding
        font-meslo-lg-nerd-font             # Required for Powerlevel10k
        font-jetbrains-mono
        font-cascadia-code
        font-fira-code
        font-fira-mono
        font-fira-mono-for-powerline
        font-geist-mono
        font-commit-mono
        font-intel-one-mono
        font-iosevka
        font-monaspace
        font-source-code-pro
        font-source-code-pro-for-powerline
        font-juliamono

        # Scientific writing (LaTeX/Quarto)
        font-libertinus                     # Includes math font
        font-stix-two-text                  # Includes math font
        font-stix-two-math
        font-eb-garamond
        font-crimson-text
        font-cormorant
        font-old-standard-tt
        font-tex-gyre-pagella
        font-tex-gyre-pagella-math
        font-alegreya
        font-cinzel
        font-gfs-didot
        font-merriweather

        # Presentations & UI
        font-inter
        font-dm-sans
        font-atkinson-hyperlegible
        font-roboto
        font-open-sans
        font-lato
        font-montserrat
        font-fira-sans
        font-oswald
        font-bebas-neue
        font-varela-round

        # Novelty & special purpose
        font-xkcd
        font-xkcd-script
        font-special-elite
        font-cooper-hewitt
        font-fontawesome
        font-iceland
        font-graduate
        font-kameron

        # System
        font-dejavu
        font-dejavu-sans-mono-for-powerline
        font-trebuchet-ms
    )

    brew install --cask "${fonts[@]}" || echo "Some fonts failed to install (non-fatal)"

elif is-linux; then
    # Linux font installation
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    # Install via apt where available (covers: Fira Code, DejaVu, Cascadia Code,
    # Font Awesome, Roboto, Lato, Open Sans, Montserrat, EB Garamond, TeX Gyre)
    if is-apt-available; then
        sudo apt-get install -y fonts-firacode fonts-dejavu fonts-cascadia-code \
            fonts-font-awesome fonts-roboto fonts-lato fonts-open-sans \
            fonts-montserrat fonts-ebgaramond fonts-texgyre 2>/dev/null || true
    fi

    # Helper: download and install a zip of fonts (from Google Fonts or GitHub)
    install_font_zip() {
        local name="$1" url="$2"
        if ls "$FONT_DIR"/"$name"*.ttf &>/dev/null || ls "$FONT_DIR"/"$name"*.otf &>/dev/null; then
            echo "$name: already installed"
            return
        fi
        echo "Downloading $name..."
        local tmp="$(mktemp -d "${TMPDIR:-/tmp}/font-${name}.XXXXXXXXXX")"
        if curl -fLo "$tmp/font.zip" "$url" 2>/dev/null; then
            unzip -o -q "$tmp/font.zip" -d "$tmp/extracted" 2>/dev/null
            find "$tmp/extracted" \( -name '*.ttf' -o -name '*.otf' \) -exec cp {} "$FONT_DIR/" \;
            echo "$name: installed"
        else
            echo "Warning: Could not download $name"
        fi
        rm -rf "$tmp"
    }

    # For descriptions and visual specimens, see: docs/font-specimens.typ
    # Fonts already covered by apt above are NOT re-downloaded here.

    # Terminal & coding (not in apt)
    install_font_zip "JetBrainsMono" "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip"
    install_font_zip "GeistMono"    "https://github.com/vercel/geist-font/releases/latest/download/geist-font.zip"
    install_font_zip "CommitMono"   "https://fonts.google.com/download?family=Commit+Mono"
    install_font_zip "IntelOneMono" "https://fonts.google.com/download?family=Intel+One+Mono"
    IOSEVKA_VER=$(curl -sS https://api.github.com/repos/be5invis/Iosevka/releases/latest | grep -oP '"tag_name":\s*"v?\K[^"]+' || echo "")
    if [[ -n "$IOSEVKA_VER" ]]; then
        install_font_zip "Iosevka" "https://github.com/be5invis/Iosevka/releases/download/v${IOSEVKA_VER}/PkgTTF-Iosevka-${IOSEVKA_VER}.zip"
    fi
    install_font_zip "Monaspace"    "https://github.com/githubnext/monaspace/releases/latest/download/monaspace-v1.101.zip"
    install_font_zip "SourceCodePro" "https://github.com/adobe-fonts/source-code-pro/releases/latest/download/OTF-source-code-pro.zip"
    install_font_zip "JuliaMono"    "https://github.com/cormullion/juliamono/releases/latest/download/JuliaMono-ttf.tar.gz"
    install_font_zip "FiraMono"     "https://fonts.google.com/download?family=Fira+Mono"

    # Scientific writing (not in apt)
    install_font_zip "Libertinus"   "https://github.com/alerque/libertinus/releases/latest/download/Libertinus-7.051.zip"
    install_font_zip "STIXTwoText"  "https://fonts.google.com/download?family=STIX+Two+Text"
    install_font_zip "STIXTwoMath"  "https://fonts.google.com/download?family=STIX+Two+Math"
    install_font_zip "CrimsonText"  "https://fonts.google.com/download?family=Crimson+Text"
    install_font_zip "Cormorant"    "https://fonts.google.com/download?family=Cormorant"
    install_font_zip "OldStandardTT" "https://fonts.google.com/download?family=Old+Standard+TT"
    install_font_zip "Alegreya"     "https://fonts.google.com/download?family=Alegreya"
    install_font_zip "Cinzel"       "https://fonts.google.com/download?family=Cinzel"
    install_font_zip "Merriweather" "https://fonts.google.com/download?family=Merriweather"

    # Presentations & UI (not in apt)
    install_font_zip "Inter"        "https://fonts.google.com/download?family=Inter"
    install_font_zip "DMSans"       "https://fonts.google.com/download?family=DM+Sans"
    install_font_zip "AtkinsonHyperlegible" "https://fonts.google.com/download?family=Atkinson+Hyperlegible"
    install_font_zip "FiraSans"     "https://fonts.google.com/download?family=Fira+Sans"
    install_font_zip "Oswald"       "https://fonts.google.com/download?family=Oswald"
    install_font_zip "BebasNeue"    "https://fonts.google.com/download?family=Bebas+Neue"
    install_font_zip "VarelaRound"  "https://fonts.google.com/download?family=Varela+Round"

    # Novelty & special purpose (not in apt)
    install_font_zip "xkcd-font"    "https://github.com/ipython/xkcd-font/archive/refs/heads/master.zip"
    install_font_zip "SpecialElite" "https://fonts.google.com/download?family=Special+Elite"
    install_font_zip "CooperHewitt" "https://github.com/cooperhewitt/cooperhewitt-typeface/archive/refs/heads/master.zip"
    install_font_zip "Graduate"     "https://fonts.google.com/download?family=Graduate"
    install_font_zip "Iceland"      "https://fonts.google.com/download?family=Iceland"
    install_font_zip "Kameron"      "https://fonts.google.com/download?family=Kameron"

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
