# Maintenance Log

This file tracks maintenance activities for the dotfiles repository, particularly installation method audits and updates.

## Installation Method Audits

### 2026-01-29: Comprehensive Installation Audit

**Auditor:** Claude Code (via `/suggest-improvements`)
**Scope:** All installation scripts
**Result:** 11/12 tools using optimal installation methods

#### ✅ Verified - No Changes Needed

The following tools were verified to use official recommended installation methods:

| Tool | Method | Location | Official Source |
|------|--------|----------|-----------------|
| pixi | Standalone installer via curl (brew on macOS) | install-apt.sh:134-138 | https://pixi.sh/latest/installation/ |
| uv | Standalone installer via curl | install-apt.sh:82 | https://docs.astral.sh/uv/getting-started/installation/ |
| git-delta | Manual .deb download | install-apt.sh:86-92 | https://dandavison.github.io/delta/installation.html |
| Zotero | zotero-deb repository | install-apt.sh:95-100 | https://www.zotero.org/support/installation |
| Quarto | .deb file download | install-apt.sh:103-109 | https://quarto.org/docs/download/ |
| WezTerm | Official apt repository | install-apt.sh:121-128 | https://wezterm.org/install/linux.html |
| VSCodium | Official apt repository | install-apt.sh:131-147 | https://vscodium.com/ |
| Node.js | NodeSource LTS repository | install-node.sh:10 | https://nodejs.org/ |
| juliaup | Official curl installer | install-julia.sh:10 | https://github.com/JuliaLang/juliaup |
| Miniforge | Official installer script | install-conda.sh:8-20 | https://github.com/conda-forge/miniforge |
| nbdime | pixi global install | install-pixi.sh:13-16 | https://nbdime.readthedocs.io/ |
| Oh My Zsh | Official curl installer | install-zsh.sh:24 | https://ohmyz.sh/ |
| Homebrew | Official curl installer | install-brew.sh:7 | https://brew.sh/ |

#### 🔧 Updated

| Tool | Old Method | New Method | Reason |
|------|------------|------------|--------|
| SourceGit | AppImage from GitHub | Official Debian repository | Better system integration, automatic updates via apt |

**Change Details:**
- **File:** install-apt.sh:112-123
- **Repository:** https://codeberg.org/api/packages/yataro/debian
- **Maintainer:** @aikawayataro
- **Official Source:** https://github.com/sourcegit-scm/sourcegit

### 2026-02-06: Replace SourceGit with GitHub Desktop

**Auditor:** Claude Code (manual request)
**Scope:** Git GUI application

#### 🔧 Updated

| Tool | Old | New | Reason |
|------|-----|-----|--------|
| Git GUI | SourceGit | GitHub Desktop | User preference |

**Change Details:**
- **macOS:** Replaced `sourcegit` cask with `github` cask in install-brew-cask.sh
- **Linux:** Replaced SourceGit Debian repo with shiftkey/desktop apt repo in install-apt.sh
- **Linux Source:** https://github.com/shiftkey/desktop (community-maintained Linux fork)
- **Dock:** Updated macos/dock.sh to reference GitHub Desktop

### 2026-08-14: Comprehensive Installation Audit

**Auditor:** Claude Code (via `/suggest-improvements`)
**Scope:** All installation scripts, both platforms
**Result:** 13/13 tools on correct installation methods; no tool broken, no tool had moved to a better method since January

#### ✅ Verified - No Changes Needed

| Tool | Method | Official Source |
|------|--------|-----------------|
| git-delta | Manual .deb from GitHub releases | https://dandavison.github.io/delta/installation.html — still not in apt; manual .deb remains the documented path |
| Quarto | .deb from GitHub releases | https://quarto.org/docs/download/ — still no official apt repository |
| pixi | curl installer (brew on macOS) | https://pixi.prefix.dev/latest/installation/ — docs site moved off pixi.sh, but the `pixi.sh/install.sh` install URL is unchanged |
| Miniforge | Official installer script | https://github.com/conda-forge/miniforge — shell installer still recommended; macOS PKG installers now also offered |
| uv, gh, eza, WezTerm, VSCodium, GitHub Desktop, Homebrew | unchanged since 2026-01-29 | re-checked, no drift |

#### 🔧 Updated

| Tool | Old Method | New Method | Reason |
|------|------------|------------|--------|
| Node.js | `curl ... setup_lts.x \| sudo bash -` | Download setup script to a temp file, then `sudo -E bash` it | Matches NodeSource's current documented instructions and removes the highest-priority pattern in the security list below. A truncated download cannot execute as a partial script. |
| Zotero | `retorquere/zotero-deb` | `retorquere/zotero-pkg` | Upstream renamed the repo. The old URL still resolves via GitHub's rename redirect, so this was cosmetic, not breakage. |
| Oh My Zsh | `raw.github.com` | `raw.githubusercontent.com` | Matches the documented URL. The old host redirects, so this was cosmetic. |
| juliaup (macOS) | `brew install juliaup` | Official curl installer, same as Linux | Upstream advises against package-manager builds: "the Juliaup variants provided by [OS-specific software repositories] currently have some drawbacks." Contradicts the 2026-01-29 table, which listed the brew install as verified. |

**Note on the juliaup change:** guarded by `command -v juliaup`, so it is a no-op on any machine that already has the Homebrew build. Migrating an existing machine requires `brew uninstall juliaup` first. As of this audit, this Mac still runs the Homebrew build (1.21.0).

**Investigated and dismissed:** NodeSource's `setup_*.x` scripts were deprecated in 2023, and much of the web still says so. That deprecation was reversed — the current DEV_README says the scripts are "back by popular demand," and the live script carries no deprecation notice and emits the current `nodistro` suite. The script itself is fine; only the piping pattern changed.

#### Next Audit Recommended

- **When:** every 3 months, tracked by a recurring Todoist task in Personal ("Audit dotfiles install methods and third-party agent skills"). Cadence moved from 6 months to 3 on 2026-08-14, when third-party agent skills were added; those are pinned and go stale silently.
- **Focus:** Check for new official repositories or installation method changes, and update pinned agent skills.
- **Command:** `/suggest-improvements` → Option A (comprehensive audit)

## Notes for Future Audits

### Tools to Watch

- **git-delta**: Currently uses manual .deb download. Monitor for potential official apt repository.
- **Quarto**: Currently uses manual .deb download. Monitor for potential official apt repository.
- **NodeSource**: Verify LTS version is still the recommended approach vs. NVM or other methods.
- **Third-party agent skills** (`install/install-agent-skills.sh`): pinned, never auto-updated. The installer skips any skill already present, and the `skills` CLI copies files rather than checking out a repo, so an installed skill stays at the commit it was fetched at. Check upstream for changes and update deliberately:

  ```bash
  npx --yes skills update <name> --global
  ```

  Currently installed: `humanizer` (blader/humanizer), fetched 2026-08-14 at hash `523374d`. Skills run with full agent permissions, so review a diff before updating. Snyk rated this package High Risk at install time while Gen rated it Safe and Socket reported 0 alerts; the contents have not been audited.

### Scientific Computing Considerations

This repository prioritizes scientific computing workflows. When auditing Python/R/Julia tools:

- **pixi**: The default environment manager for new Python projects. It resolves conda-forge and PyPI packages in one lockfile, so it covers the scientific packages with non-Python dependencies (BLAS, CUDA, etc.) that plain pip cannot.
- **Conda/Mamba**: Still installed via Miniforge for existing environments and for anything already defined in an `environment.yml`. Do not propose removing Miniforge without first checking `conda env list` — it typically holds long-lived project environments that pixi does not replace.
- **pixi globals**: Machine-wide CLI tools installed with `pixi global install` land in `~/.pixi/bin`, which `system/.path` prepends on both platforms. `nbdime` lives here because `.gitconfig` declares the `jupyternotebook` diff/merge drivers; it is deliberately not installed into the conda base env.
- **Julia**: juliaup is the official recommended method (not manual downloads)
- **uv**: Retained because several `claude-skills` scripts use PEP 723 inline metadata with `#!/usr/bin/env -S uv run --script` shebangs, which pixi has no equivalent for.

**Do not** suggest replacing conda or pixi with mise/asdf unless user explicitly requests workflow simplification.

### Security Patterns to Monitor

Pattern priority for security review:

1. **High Priority:** `curl ... | sudo bash`
2. **Medium Priority:** Unsigned GitHub releases
3. **Low Priority:** Manual version pinning without auto-updates

### Repository Health

- All curl-to-bash installers use `-fsSL` flags (secure)
- All apt repositories use signed keys (GPG verification)
- Most tools support automatic updates via package managers
