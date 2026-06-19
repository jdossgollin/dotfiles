#!/usr/bin/env bash
# Set up the per-machine path anchors (~/.dotfiles/.paths).
#
# Sourced by install.sh. Idempotent: if .paths already exists it leaves it
# alone. Otherwise it copies .paths.template and prompts for the three
# per-machine anchors, defaulting to the template values.
set -euo pipefail

PATHS_FILE="$DOTFILES_DIR/.paths"
TEMPLATE="$DOTFILES_DIR/.paths.template"

if [[ -f "$PATHS_FILE" ]]; then
    echo "Path anchors already exist ($PATHS_FILE) — leaving them untouched."
    echo "  Edit $PATHS_FILE by hand to change GITHUB_REPOS / GDRIVE_* bases."
    return 0 2>/dev/null || exit 0
fi

if [[ ! -f "$TEMPLATE" ]]; then
    echo "Missing $TEMPLATE — cannot set up path anchors."
    return 0 2>/dev/null || exit 0
fi

echo ""
echo "Setting up per-machine path anchors..."

# Prompt only when interactive; otherwise (CI) accept template defaults silently.
ask() {
    local var="$1" default="$2" reply
    if [[ -t 0 ]]; then
        read -r -p "  $var [$default]: " reply || reply=""
        echo "${reply:-$default}"
    else
        echo "$default"
    fi
}

GITHUB_REPOS="$(ask GITHUB_REPOS "$HOME/Documents")"
GDRIVE_WORK="$(ask GDRIVE_WORK "$HOME/gdrive-work")"
GDRIVE_PERSONAL="$(ask GDRIVE_PERSONAL "$HOME/gdrive-personal")"

# Start from the template, then override the three anchors with the answers.
# Repo lines hang off the anchors, so they follow automatically.
cp "$TEMPLATE" "$PATHS_FILE"
set-config GITHUB_REPOS "$GITHUB_REPOS" "$PATHS_FILE"
set-config GDRIVE_WORK "$GDRIVE_WORK" "$PATHS_FILE"
set-config GDRIVE_PERSONAL "$GDRIVE_PERSONAL" "$PATHS_FILE"

echo "Wrote $PATHS_FILE"
echo "  Repos live by convention at \$GITHUB_REPOS/<owner>/<repo> (no registry)."
