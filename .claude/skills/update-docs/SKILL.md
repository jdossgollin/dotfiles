---
name: update-docs
description: Check and update documentation for recent changes
---

# Update Docs

Sync existing documentation with code changes.

## When to Use

- Code changed and docs may be stale
- Called from `/git-commit` or `/pr-ready` to check doc accuracy

## See Also

- `/doc-gen` - if no docs exist yet (create from scratch)

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents

## Scope Detection

- If called directly: ask what changed or check recent commits
- If called from `/git-commit` or `/pr-ready`: use that context

## Checks

### 1. README.md

- Installation instructions still accurate?
- Usage examples still work?
- New features documented?
- Removed features cleaned up?

### 2. docs/ folder (if exists)

- API docs match current signatures?
- Tutorials reference current code?

### 3. Docstrings (quick scan)

- Changed functions have updated docstrings?

### 4. CHANGELOG (if exists)

- Entry for this change?

## Output

- List what needs updating
- Draft updates for review
- Ask before writing changes

Keep docs concise - match existing style.
