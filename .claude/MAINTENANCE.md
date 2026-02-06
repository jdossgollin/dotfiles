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
| uv | Standalone installer via curl | install-apt.sh:82 | https://docs.astral.sh/uv/getting-started/installation/ |
| git-delta | Manual .deb download | install-apt.sh:86-92 | https://dandavison.github.io/delta/installation.html |
| Zotero | zotero-deb repository | install-apt.sh:95-100 | https://www.zotero.org/support/installation |
| Quarto | .deb file download | install-apt.sh:103-109 | https://quarto.org/docs/download/ |
| WezTerm | Official apt repository | install-apt.sh:121-128 | https://wezterm.org/install/linux.html |
| VSCodium | Official apt repository | install-apt.sh:131-147 | https://vscodium.com/ |
| Node.js | NodeSource LTS repository | install-node.sh:10 | https://nodejs.org/ |
| juliaup | Official curl installer | install-julia.sh:10 | https://github.com/JuliaLang/juliaup |
| Miniforge | Official installer script | install-conda.sh:8-20 | https://github.com/conda-forge/miniforge |
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

#### Next Audit Recommended

- **When:** 2026-07-29 (6 months)
- **Focus:** Check for new official repositories or installation method changes
- **Command:** `/suggest-improvements` → Option A (comprehensive audit)

## Notes for Future Audits

### Tools to Watch

- **git-delta**: Currently uses manual .deb download. Monitor for potential official apt repository.
- **Quarto**: Currently uses manual .deb download. Monitor for potential official apt repository.
- **NodeSource**: Verify LTS version is still the recommended approach vs. NVM or other methods.

### Scientific Computing Considerations

This repository prioritizes scientific computing workflows. When auditing Python/R/Julia tools:

- **Conda/Mamba**: Essential for scientific packages with non-Python dependencies (BLAS, CUDA, etc.)
- **Julia**: juliaup is the official recommended method (not manual downloads)
- **uv**: Faster than pip but doesn't replace conda for scientific packages

**Do not** suggest replacing conda with mise/asdf unless user explicitly requests workflow simplification.

### Security Patterns to Monitor

Pattern priority for security review:

1. **High Priority:** `curl ... | sudo bash`
2. **Medium Priority:** Unsigned GitHub releases
3. **Low Priority:** Manual version pinning without auto-updates

### Repository Health

- All curl-to-bash installers use `-fsSL` flags (secure)
- All apt repositories use signed keys (GPG verification)
- Most tools support automatic updates via package managers
