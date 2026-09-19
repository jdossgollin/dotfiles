#!/usr/bin/env bash
# VSCodium extensions. The cask/apt package is installed by install-brew-cask.sh
# / install-apt.sh; settings are symlinked by install.sh.

if ! command -v codium >/dev/null 2>&1; then
    echo "codium not on PATH; skipping extensions"
    return 0 2>/dev/null || exit 0
fi

echo "Installing VSCodium extensions..."
installed=$(codium --list-extensions | tr '[:upper:]' '[:lower:]')
while read -r ext; do
    [[ -z "$ext" || "$ext" == \#* ]] && continue
    if grep -qxF "$(echo "$ext" | tr '[:upper:]' '[:lower:]')" <<< "$installed"; then
        continue
    fi
    codium --install-extension "$ext" || echo "Warning: $ext failed to install"
done < "$DOTFILES_DIR/apps/.vscode/extensions.txt"
