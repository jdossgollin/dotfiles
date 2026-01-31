---
name: uninstall
description: Removes a package from dotfiles and both macOS/Linux systems. Searches autonomously for all references.
---

# Uninstall Package or Application

Remove a package or application completely from dotfiles and system.

## When to Use

- Removing unused packages to clean up
- Switching to alternative tools
- Decluttering installation scripts

## See Also

- `/audit-sync` - after uninstall, to check if both platforms are still synced
- `/suggest-improvements` - before uninstall, to find better alternatives

## Process

### 1. Autonomous Search Phase

**Search broadly** - do not ask user where to look. Use Grep and Read tools to find:

```bash
# Search ALL install scripts
grep -r "<package-name>" install/

# Search ALL config files
grep -r "<package-name>" system/ apps/ runcom/

# Search conda environment files
grep -r "<package-name>" conda/

# Check documentation
grep -r "<package-name>" *.md docs/
```

Look for:

- Package name in arrays (brew, apt, conda, npm)
- Command aliases referencing the tool
- PATH additions
- Environment variables
- Configuration blocks
- Comments mentioning the tool
- Symlinks to config files

### 2. Analyze What You Found

Use judgment to determine:

- **Core vs auxiliary**: Is this a critical dependency?
- **Used by other tools**: Will removing this break something?
- **Config complexity**: Simple removal or needs careful cleanup?
- **User data**: Are there config/data directories that persist?

### 3. Present Findings (ONE question at a time)

**First, show what you found:**

```markdown
## 🔍 Uninstall Analysis: <package>

**Found in:**
- [install/install-brew.sh:42](install/install-brew.sh#L42)
- [install/install-apt.sh:28](install/install-apt.sh#L28)
- [system/.alias:15](system/.alias#L15)

**Dependencies:**
<None found | Tool X depends on this>

**User data locations:**
- `~/.config/<package>/` (config files)
- `~/Library/Application Support/<package>/` (macOS only)
```

**Then ask ONE question:**

> "Proceed with uninstall?
> A) Yes, remove completely
> B) Keep in dotfiles but uninstall from system
> C) Cancel"

### 4. Generate Uninstall Commands

Based on what you found during search, create platform-specific commands.

**Patterns to recognize:**

| Pattern Found | Command |
|---------------|---------|
| `brew install foo` | `brew uninstall foo` |
| `brew install --cask bar` | `brew uninstall --cask bar` |
| `apt-get install baz` | `sudo apt-get remove --purge baz` |
| `snap install qux` | `sudo snap remove qux` |
| `curl ... \| sudo dpkg -i` | Manual removal (identify binary location) |
| `*.AppImage` in `/usr/local/bin` | `sudo rm /usr/local/bin/<name>` |
| Custom repo added | Remove repo, then remove package |
| `conda install` | `conda remove <pkg>` |
| `npm install -g` | `npm uninstall -g <pkg>` |

### 5. Execute Removal

**For system uninstall:**

Provide commands for the user's current platform FIRST:

```bash
# Detect current platform
if is-macos; then
    # macOS commands here
elif is-linux; then
    # Linux commands here
fi
```

**For dotfiles cleanup:**

Use Edit tool to:
1

1. Remove from installation script arrays
2. Remove config blocks (may span multiple lines)
3. Remove aliases/functions/env vars
4. Clean up comments that reference the tool

### 6. Verification

After changes:

```markdown
## ✅ Removed

**Installation scripts:**
- Removed from [install/install-brew.sh](install/install-brew.sh)
- Removed from [install/install-apt.sh](install/install-apt.sh)

**Configuration:**
- Removed alias from [system/.alias](system/.alias)

**Next steps:**
1. Run uninstall command for your platform (shown above)
2. Optionally remove config: `rm -rf ~/.config/<package>`
3. Commit changes: `git add -A && git commit -m "Remove <package>"`
```

## Special Cases - Use Judgment

### Manual Installations

If you find patterns like:

```bash
curl -LO "https://..."
sudo dpkg -i file.deb
rm file.deb
```

Trace where it installed to:

- Check `/usr/local/bin/` for binaries
- Check `/opt/` for application directories
- Look for custom repo additions in `/etc/apt/sources.list.d/`

### System Dependencies

**Never remove without warning:**

- git, curl, wget, zsh, bash, gcc, make
- Tools used by dotfiles scripts (fzf, ripgrep used in .zshrc)

**Warn and suggest alternatives:**

```
⚠️ Warning: `fzf` is used in your .zshrc for command history search.
Removing it will break this feature.

Alternative: Keep fzf, or remove the fzf config blocks from .zshrc first.

Proceed anyway? (y/n)
```

### Application Bundles (macOS)

If it's a cask app, also mention:

```bash
# Cask uninstall usually removes app, but check:
rm -rf ~/Library/Application\ Support/<AppName>
rm -rf ~/Library/Preferences/com.<company>.<app>.plist
rm -rf ~/Library/Caches/<AppName>
```

### Conda Environments

Search [conda/](conda/) directory for YAML files:

```bash
grep -r "package-name" conda/
```

If found, warn:

```
⚠️ Found in conda environment files:
- [conda/science.yml](conda/science.yml)

This will be removed from the install script, but existing conda
environments won't be updated automatically.

Recreate environments with: `conda env update -f conda/<name>.yml`
```

## Safety Checklist

Before confirming removal:

- [ ] Not a system-critical package
- [ ] Not a dependency of dotfiles scripts
- [ ] User has confirmed removal
- [ ] Identified all config/data locations
- [ ] Generated correct uninstall commands for both platforms

## Output: Conversation Only

Do not write plans to files. This is an interactive task - search, present findings, ask for confirmation, then execute.

## After Uninstall

Suggest:

```
Run `/audit-sync` to verify both platforms are still consistent.
```
