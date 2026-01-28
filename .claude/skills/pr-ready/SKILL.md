---
name: pr-ready
description: Prepare changes for pull request
---

# PR Ready

Prepare current branch for PR.

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for git and test commands

## Checklist

### 1. Tests

Run `/test-debug`:

- All tests pass?
- New code has test coverage?

### 2. Docs

Run `/update-docs`:

- README accurate?
- API docs updated?
- CHANGELOG entry?

### 3. Code Quality (ask first)

- Want a `/refactor` review?
- If yes: creates plan, doesn't auto-implement

## Output

Summary of PR readiness:

```
✓ Tests passing (15/15)
✓ Docs updated
⚠ Suggested refactors (see .claude/plans/refactor-*.md)
```

User decides what to address before creating PR.
