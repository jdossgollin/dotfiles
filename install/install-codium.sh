#!/usr/bin/env bash
# VSCodium extensions. The cask/apt package is installed by install-brew-cask.sh
# / install-apt.sh; settings are symlinked by install.sh.

if ! command -v codium >/dev/null 2>&1; then
    echo "codium not on PATH; skipping extensions"
    return 0 2>/dev/null || exit 0
fi

# Lowercased list of what is already present. Refreshed after each install so
# dependencies pulled in by another extension are not reinstalled.
list-codium-extensions() {
    codium --list-extensions </dev/null | tr '[:upper:]' '[:lower:]'
}

echo "Installing VSCodium extensions..."
installed=$(list-codium-extensions)
while read -r ext; do
    [[ -z "$ext" || "$ext" == \#* ]] && continue
    if grep -qxF "$(echo "$ext" | tr '[:upper:]' '[:lower:]')" <<< "$installed"; then
        continue
    fi
    # </dev/null so codium cannot swallow the extension list on this loop's stdin.
    if codium --install-extension "$ext" </dev/null; then
        installed=$(list-codium-extensions)
    else
        echo "Warning: $ext failed to install"
    fi
done < "$DOTFILES_DIR/apps/.vscode/extensions.txt"
