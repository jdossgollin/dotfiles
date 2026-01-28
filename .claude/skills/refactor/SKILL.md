---
name: refactor
description: Review code and create improvement plan
---

# Refactor

Plan improvements to code you own (creates plan, then implements after approval).

## When to Use

- You want to improve code structure, readability, or design
- You're ready to make changes (after plan approval)

## See Also

- `/review-code` - if you just want critique/feedback without planning changes

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents

Do NOT shell out for search/read operations - use the dedicated tools.

## Scope Identification

- If diff/files provided: analyze those
- If "recent changes": ask for clarification (commit hash, branch, files?)

## Pre-Refactor Check

- Do unit tests exist for this code?
- If no tests: recommend `/test-gen` BEFORE refactoring

## Analysis

- Readability and naming
- Code duplication
- Function complexity
- Error handling
- Type safety

## Output: Plan File

Write plan to `.claude/plans/refactor-<topic>.md`:

```markdown
# Refactor Plan: <topic>

Date: YYYY-MM-DD

## Summary

<What's being improved and why>

## Proposed Changes (ranked by impact)

### 1. <Change title>

- **File**: path/to/file.py
- **What**: <description>
- **Why**: <benefit>
- **Risk**: low/medium/high

### 2. ...

## Test Coverage

- [ ] Existing tests cover this code
- [ ] New tests needed for: ...

## Order of Operations

1. First change X (lowest risk)
2. Then change Y
3. ...
```

## After Writing Plan

STOP. Tell user:

> "Refactor plan written to `.claude/plans/refactor-<topic>.md`. Please review and edit, then say 'proceed' or give feedback."

Only implement after explicit approval.

**Mandatory when implementing:**

- Update docstrings/type hints if signatures change
