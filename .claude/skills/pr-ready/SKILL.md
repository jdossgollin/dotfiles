---
name: pr-ready
description: Prepare changes for pull request
---

# PR Ready

Orchestrate pre-PR checks (runs other skills).

## When to Use

- About to open a pull request
- Want a comprehensive check before sharing code

## See Also

- `/git-worktree` - if developing in a separate worktree
- `/brand-guidelines` - to check documentation style consistency

## Orchestrates

- `/test` - verify tests pass
- `/update-docs` - verify docs are current
- `/refactor` (optional) - suggest improvements

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for git and test commands

## Checklist

### 1. Tests

Use the Skill tool to invoke `test`:

- All tests pass?
- New code has test coverage?

### 2. Docs

Use the Skill tool to invoke `update-docs`:

- README accurate?
- API docs updated?
- CHANGELOG entry?

### 3. Code Quality (ask first)

- Want a refactor review?
- If yes: use the Skill tool to invoke `refactor` (creates plan, doesn't auto-implement)

## Output

Summary of PR readiness:

```
✓ Tests passing (15/15)
✓ Docs updated
⚠ Suggested refactors (see .claude/plans/refactor-*.md)
```

User decides what to address before creating PR.
