#!/usr/bin/env bash

# Third-party Claude Code skills, installed with the `skills` CLI (npx, no
# global npm install). The CLI unpacks each skill into ~/.agents/skills/<name>
# and symlinks it from ~/.claude/skills. That directory symlinks into the
# claude-skills repo, so the link shows up there and is gitignored: these are
# reprovisioned per machine, not vendored.
#
# Run after install-node.sh (needs npx) and install-claude-code.sh.
#
# Skills are pinned, not auto-updated: an installed skill is skipped below, and
# the CLI copies files rather than tracking a repo. Update deliberately with
# `npx --yes skills update <name> --global`. See .claude/MAINTENANCE.md.

# Skip in CI (avoids network install in headless test runs)
if [[ -n "${CI:-}" ]]; then
    echo "Skipped: agent skills (CI environment)"
    return 2>/dev/null || exit 0
fi

if ! command -v npx >/dev/null 2>&1; then
    echo "Warning: npx not found; skipping agent skills."
    return 2>/dev/null || exit 0
fi

# <repo>:<installed skill directory name>
AGENT_SKILLS=(
    # Strips AI-writing tells (inflated symbolism, em-dash overuse, rule of
    # three) from prose. Based on Wikipedia's "Signs of AI writing" guide.
    "blader/humanizer:humanizer"
)

for entry in "${AGENT_SKILLS[@]}"; do
    repo="${entry%%:*}"
    skill_dir="${entry##*:}"
    link="$HOME/.claude/skills/$skill_dir"
    target="$HOME/.agents/skills/$skill_dir"

    # -e follows symlinks, so a broken link fails this test and gets rebuilt.
    if [[ -e "$link/SKILL.md" ]]; then
        echo "agent skill: $skill_dir already installed"
        continue
    fi

    echo "Installing agent skill: $repo..."
    npx --yes skills add "$repo" --global --yes \
        || echo "Warning: could not install agent skill $repo"

    # The CLI writes a symlink relative to ~/.claude/skills, but that path is
    # itself a symlink into the claude-skills repo, so the relative target
    # resolves against the repo and dangles. Rebuild it as an absolute link.
    if [[ -d "$target" ]] && [[ ! -e "$link/SKILL.md" ]]; then
        ln -sfn "$target" "$link"
    fi

    if [[ -e "$link/SKILL.md" ]]; then
        echo "agent skill: $skill_dir ready"
    else
        echo "Warning: agent skill $skill_dir did not resolve at $link"
    fi
done
