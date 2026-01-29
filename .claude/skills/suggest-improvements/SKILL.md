---
name: suggest-improvements
description: Reviews installation scripts and suggests better methods by checking official documentation.
---

# Suggest Installation Improvements

Review installation methods and suggest improvements based on official documentation and current best practices.

## When to Use

- Reviewing outdated installation methods
- After adding new tools (to verify you used the best method)
- Periodically auditing dotfiles for maintenance
- Before major system upgrades

## See Also

- `/audit-sync` - check platform consistency after making improvements
- `/uninstall` - remove old tools before replacing them

## Dialogue Rules

**ONE question at a time. Multiple choice. Validate before continuing.**

## Process

### 1. Check Recent Audits

**Before starting, read `.claude/MAINTENANCE.md` to check:**

- When was the last audit performed?
- Which tools were recently verified?
- Are there any tools flagged to watch?

**If an audit was performed within the last 6 months:**

Ask the user:
> "The last comprehensive audit was performed on YYYY-MM-DD (X days ago). All tools were verified at that time.
>
> Would you like to:
> A) Skip audit (too recent)
> B) Check specific tools anyway
> C) Focus only on tools flagged to watch"

**If no MAINTENANCE.md exists or audit is older than 6 months:** Proceed with full audit.

### 2. Ask: What to Review?

> "What would you like to review?
> A) All installation scripts (comprehensive audit)
> B) Specific tool or category (e.g., Python, terminal apps)
> C) Recent additions (tools added in last N commits)
> D) Security-focused review (curl-piped-to-bash, etc.)"

### 3. Autonomous Research Phase

For each tool found, research its official installation docs:

**Use WebSearch or WebFetch to find:**

```
Search: "<tool-name> official installation documentation <platform>"
Search: "<tool-name> recommended install method ubuntu/homebrew"
```

**Key questions to answer:**

- What does the official documentation recommend?
- Has the project moved to a different installation method?
- Are we using an outdated approach?
- Is there a package manager option we're missing?
- Are we installing from a trusted source?

**DO NOT assume:**

- That mise is better than conda (check user's workflow needs)
- That snap is better than flatpak or apt (distro and tool dependent)
- That the newest tool is always better (consider stability)

### 3. Analyze Installation Patterns

**Look for these patterns in install scripts:**

| Pattern | Concern | Research Needed |
|---------|---------|-----------------|
| `curl ... \| bash` | Security risk | Is there a package manager option? |
| `curl ... \| sudo bash` | High security risk | Official repo available? |
| Hardcoded version downloads | No auto-updates | Package manager available? |
| Manual .deb downloads | Maintenance burden | Official apt repo exists? |
| GitHub release downloads | May be correct | Check if package manager has it |
| Adding custom repos | Maintenance | Still recommended by project? |

### 4. Present Findings (ONE tool at a time)

After researching, present findings for ONE tool:

```markdown
## 🔍 Review: <tool-name>

**Current method:**
- [install/install-apt.sh:85](install/install-apt.sh#L85)
- Manual download from GitHub releases

**Official recommendation (from docs):**
- Official apt repository available: https://...
- Installation command: `sudo apt-get install <tool>`

**Comparison:**

| Aspect | Current | Suggested |
|--------|---------|-----------|
| Security | Manual download | Official signed repo |
| Updates | Manual re-download | `apt upgrade` |
| Maintenance | High | Low |

**Recommendation:**
Switch to official apt repository.
```

**Then ask:**

> "Apply this improvement?
> A) Yes, update installation script
> B) Skip, current method is fine
> C) Discuss further"

### 5. Category-Specific Considerations

#### Package Managers (conda, mise, asdf, etc.)

**Research user's workflow before suggesting changes:**

- Is conda needed for scientific packages? (numpy, scipy, pytorch)
- Does user need environment isolation?
- What's their primary language workflow?
- Are there conflicts with system packages?

**DO NOT suggest replacing conda with mise unless:**

- User explicitly wants to simplify
- User doesn't use scientific Python packages
- User confirmed they understand the trade-offs

#### GUI Applications (Linux)

**Check official docs for their preference:**

- Snap (Ubuntu-native, sandboxed)
- Flatpak (cross-distro, sandboxed)
- apt (native packages, best integration)
- AppImage (portable, manual updates)

**Different apps have different recommendations:**

- VSCode → Official .deb repo exists
- Spotify → Official snap is recommended
- Firefox → apt on Ubuntu, snap on some others

**Pattern to follow:**

```markdown
1. Check app's official Linux page
2. Note their recommended method
3. Consider integration needs (system tray, etc.)
4. Suggest based on official docs, not assumptions
```

#### Security-Focused Review

If user requested security review, flag:

```markdown
## 🔒 Security Concerns

**High priority:**
- [install/install-x.sh:42](install/install-x.sh#L42): curl piped to sudo bash
  - Research: Official repo available at https://...

**Medium priority:**
- [install/install-y.sh:18](install/install-y.sh#L18): Unsigned GitHub release
  - Research: Project now provides signed releases

**Low priority:**
- [install/install-z.sh:55](install/install-z.sh#L55): Manual version pinning
  - Consider: Allow patch updates with `~>` constraint
```

### 6. Implementation

After user approves, use Edit tool to update installation script.

**Show before/after:**

```markdown
## ✏️ Updating [install/install-apt.sh](install/install-apt.sh)

**Before:**
```bash
curl -LO https://github.com/.../release.deb
sudo dpkg -i release.deb
```

**After:**
```bash
curl -fsSL https://official.repo/key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/app.gpg
echo "deb [signed-by=/usr/share/keyrings/app.gpg] https://repo.url stable main" | sudo tee /etc/apt/sources.list.d/app.list
sudo apt-get update
sudo apt-get install -y app
```
```

### 7. Verification

After changes:

```markdown
## ✅ Updated

**Changed files:**
- [install/install-apt.sh](install/install-apt.sh)

**Next steps:**
1. Test installation on fresh Ubuntu system (VM or Docker)
2. Verify the tool works correctly
3. Commit: `git add install/ && git commit -m "Improve <tool> installation method"`

**To test:**
```bash
# In a fresh Ubuntu container:
docker run -it ubuntu:latest
cd /path/to/dotfiles
bash install/install-apt.sh
```
```

## Research Sources Priority

1. **Official project documentation** (highest priority)
2. **Official GitHub repository README/docs**
3. **Package manager official documentation** (brew.sh, snapcraft.io, etc.)
4. **Distro-specific recommendations** (Ubuntu wiki, Arch wiki)
5. **Community consensus** (lowest priority - verify with official sources)

## Example Research Process

For a tool like "delta" (git-delta):

```markdown
1. Search: "git-delta official installation"
2. Find: https://github.com/dandavison/delta
3. Read: Installation section in README
4. Check: Homebrew (✅ brew install git-delta)
5. Check: Ubuntu (❌ not in apt, manual .deb recommended)
6. Conclusion: Current method matches official recommendation
```

## Considerations for Scientific Computing

This dotfiles repo prioritizes scientific computing. Consider:

- **Conda**: Often necessary for scientific packages (BLAS, CUDA, etc.)
- **Julia**: juliaup is the official recommended method
- **R**: Consider multiple installation methods (apt, conda, from source)
- **Python tools**: uv is newer and faster, but conda needed for non-Python deps
- **LaTeX**: Full TeX Live vs minimal texlive-core trade-offs

**Ask user about their needs before suggesting changes in this domain.**

## Output: Update MAINTENANCE.md

**After completing an audit, append results to `.claude/MAINTENANCE.md`:**

1. **Read the existing file** to understand the format
2. **Add new audit entry** with:
   - Date
   - Scope (comprehensive, specific tools, security review)
   - Tools verified (table format)
   - Tools updated (table format)
   - Next audit recommendation
3. **Update "Tools to Watch"** section if needed

**Format:**

```markdown
### YYYY-MM-DD: [Audit Type]

**Auditor:** Claude Code (via `/suggest-improvements`)
**Scope:** [Description]
**Result:** X/Y tools using optimal installation methods

#### ✅ Verified - No Changes Needed

| Tool | Method | Location | Official Source |
|------|--------|----------|-----------------|
| ... | ... | ... | ... |

#### 🔧 Updated

| Tool | Old Method | New Method | Reason |
|------|------------|------------|--------|
| ... | ... | ... | ... |

**Change Details:**
- **File:** [file:line]
- **Repository:** [URL]
- ...

#### Next Audit Recommended

- **When:** YYYY-MM-DD (6 months)
- **Focus:** [Specific areas to check]
```

## After Improvements

Suggest:

```
Run `/audit-sync` to ensure improvements are consistent across both platforms.
```
