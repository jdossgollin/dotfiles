# Sourced by zsh for EVERY shell — including non-interactive ones (scripts,
# cron, tool shells that don't read .zshrc). Keep this minimal: only things
# that every shell genuinely needs.

export DOTFILES_DIR="$HOME/.dotfiles"

# Per-machine path anchors (GITHUB_REPOS, GDRIVE_WORK, GDRIVE_PERSONAL).
# Defined here (not just .zshrc) so non-interactive shells get them too.
# .zshrc also sources these; re-sourcing is idempotent.
if [[ -f "$DOTFILES_DIR/.paths" ]]; then
    source "$DOTFILES_DIR/.paths"
elif [[ -f "$DOTFILES_DIR/.paths.template" ]]; then
    source "$DOTFILES_DIR/.paths.template"
fi
