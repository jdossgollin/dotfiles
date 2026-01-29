---
name: audit-sync
description: Audits dotfiles to ensure macOS and Linux installations are properly synchronized.
---

# Audit Platform Sync

Audit cross-platform consistency between macOS and Linux installation scripts and configurations.

## When to Use

- Before committing major changes to installation scripts
- Periodically (quarterly) to catch drift
- After adding new tools
- Before pushing to a new machine

## See Also

- `/suggest-improvements` - after audit, to improve installation methods
- `/uninstall` - to remove tools found only on one platform

## Dialogue Rules

**ONE question at a time. Multiple choice. Validate before continuing.**

## Process

### 1. Ask: Audit Scope

> "What should I audit?
> A) Full audit (all packages, configs, paths)
> B) Just installation scripts (brew vs apt)
> C) Just configuration files (system/.*, apps/*)
> D) Specific category (e.g., GUI apps, CLI tools)"

### 2. Autonomous Analysis Phase

**Read and compare systematically:**

```bash
# Installation scripts
[install/install-brew.sh](install/install-brew.sh)
[install/install-brew-cask.sh](install/install-brew-cask.sh)
[install/install-apt.sh](install/install-apt.sh)

# Configuration files
[system/.path](system/.path)
[system/.alias](system/.alias)
[system/.env](system/.env)
[system/.function](system/.function)

# Application configs
[apps/](apps/) directory
```

### 3. Extract Package Lists

**Build parallel lists:**

macOS packages:

- From `brew install` array in [install/install-brew.sh](install/install-brew.sh)
- From `brew install --cask` array in [install/install-brew-cask.sh](install/install-brew-cask.sh)

Linux packages:

- From `apt-get install` array in [install/install-apt.sh](install/install-apt.sh)
- From `snap install` commands in [install/install-apt.sh](install/install-apt.sh)
- From manual installations in [install/install-apt.sh](install/install-apt.sh)

### 4. Categorize Differences

**Use judgment to categorize each difference:**

| Category | Meaning | Action |
|----------|---------|--------|
| **Identical** | Same tool, same name | ✅ No action |
| **Different names** | Same tool, platform naming (bat/batcat) | ✅ Expected |
| **Platform-specific** | Only makes sense on one platform (dockutil) | ✅ Expected |
| **Missing equivalent** | Tool on one platform, no counterpart | ⚠️ Investigate |
| **Different approach** | Different tools for same purpose | ⚠️ Evaluate |

### 5. Check Configuration Files

**Look for platform-specific issues:**

Patterns to flag:

```bash
# Hardcoded paths without platform check
export PATH="/opt/homebrew/bin:$PATH"  # ⚠️ macOS-only path

# Should be:
if is-macos; then
    export PATH="$(get-brew-prefix)/bin:$PATH"
fi
```

**Check for:**

- Hardcoded `/opt/homebrew` or `/usr/local` without platform detection
- Aliases that assume macOS-only commands
- PATH entries that won't exist on Linux
- Functions that don't handle both platforms

### 6. Present Findings (Organized by Priority)

**Report structure:**

```markdown
# 🚦 Platform Sync Audit

## ✅ Properly Synced (Sample)

**Cross-platform tools:**
- git (brew/apt) ✓
- fzf (brew/apt) ✓
- ripgrep (brew/apt as 'rg') ✓
- bat (brew as 'bat', apt as 'batcat') ✓ - different names, expected

**GUI applications:**
- Firefox (cask/apt) ✓
- VSCodium (cask/apt) ✓
- WezTerm (cask/apt via custom repo) ✓

## ⚠️ Potential Issues

### Missing on Linux

- **defaultbrowser** (macOS brew)
  - Purpose: Set default browser from CLI
  - Linux equivalent: `xdg-settings` (already available in Ubuntu)
  - Action: ✅ Intentional - Linux has built-in alternative

### Missing on macOS

- **build-essential** (Linux apt)
  - Purpose: GCC and build tools
  - macOS equivalent: Xcode Command Line Tools
  - Action: ✅ Intentional - different installation method

### Configuration Issues

- [system/.path:15](system/.path#L15) - Hardcoded `/opt/homebrew`
  - Should use: `$(get-brew-prefix)` or platform check
  - Action: ⚠️ Fix recommended

## 🔍 Different Approaches (Evaluate)

### Git diff viewer

- macOS: git-delta (via brew 'git-delta')
- Linux: git-delta (via manual .deb download)
- Status: ✅ Same tool, different install method - acceptable

### Package X

- macOS: tool-a (lightweight, 5MB)
- Linux: tool-b (full-featured, 50MB)
- Status: ⚠️ Inconsistent - recommend syncing to same tool
```

### 7. Ask for Priorities (ONE question)

After presenting findings:

> "What should we address first?
> A) Fix configuration file issues (hardcoded paths)
> B) Sync missing packages across platforms
> C) Review different approaches
> D) Generate full detailed report"

### 8. Implementation

Based on user choice, use Edit tool to fix issues.

**Example: Fixing hardcoded paths**

```markdown
## ✏️ Fixing [system/.path](system/.path)

**Before:**

```bash
export PATH="/opt/homebrew/bin:$PATH"
```

**After:**

```bash
if is-macos; then
    export PATH="$(get-brew-prefix)/bin:$PATH"
fi
```

```

## Patterns to Recognize

### Expected Differences

**Tool name variations (acceptable):**

| Tool | macOS | Linux | Notes |
|------|-------|-------|-------|
| bat | `bat` | `batcat` | Ubuntu naming |
| gcc | `gcc` | `build-essential` | Package vs meta-package |
| 7zip | `p7zip` | `p7zip-full` | Different package names |

**Platform-only tools (acceptable):**

| Tool | Platform | Reason |
|------|----------|--------|
| dockutil | macOS only | Manages macOS Dock |
| xdg-settings | Linux only | Desktop environment integration |
| defaults | macOS only | macOS preferences system |

**Different installation methods (evaluate case-by-case):**

| Tool | macOS | Linux | Assessment |
|------|-------|-------|------------|
| Quarto | brew cask | Manual .deb | Check if apt repo exists now |
| WezTerm | brew cask | Custom apt repo | Both official - ✓ |
| delta | brew formula | Manual .deb | Both from official sources - ✓ |

### Issues to Flag

**Missing cross-platform tools:**

- CLI tools that should work on both but are only installed on one
- Development tools (git, compilers, etc.) missing from one platform
- Cross-platform GUI apps (VSCode, Firefox) only on one platform

**Configuration incompatibilities:**

- Hardcoded macOS paths without platform checks
- Aliases for macOS-only commands
- Functions that don't detect platform
- PATH entries that assume one platform's directory structure

## Special Considerations

### Scientific Computing Tools

**Conda/Mamba:**

- Should be identical on both platforms
- Check [install/install-conda.sh](install/install-conda.sh) uses platform detection correctly

**Julia:**

- juliaup should work identically on both
- Verify in [install/install-julia.sh](install/install-julia.sh)

**R, LaTeX, etc.:**

- May have different installation methods per platform (acceptable)
- Verify both platforms have equivalent functionality

### GUI Applications

**Different approaches may be intentional:**

- macOS: Unified cask system
- Linux: Mix of apt, snap, flatpak, AppImage depending on what's best for each app

**Don't flag as issue if:**

- Both platforms have the same app
- Installation method follows official recommendations
- Both versions have feature parity

## Verification After Fixes

Suggest testing:

```markdown
## ✅ Audit Complete

**Issues fixed:**

- Fixed hardcoded paths in [system/.path](system/.path)
- Added missing tool X to Linux
- Synced tool Y installation method

**Next steps:**

1. Test on both platforms if possible
2. Commit changes: `git add . && git commit -m "Sync platforms"`
3. Re-run `/audit-sync` to verify

**To test:**

```bash
# On macOS:
source system/.path && echo $PATH

# On Linux:
source system/.path && echo $PATH
```

## Output: Conversation Only

Do not write plans to files. Present audit results, ask for priorities, make fixes interactively.

## After Audit

Suggest:

```text
Run `/suggest-improvements` to check if any installation methods can be modernized.
```
