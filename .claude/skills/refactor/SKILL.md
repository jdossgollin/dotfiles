---
name: refactor
description: Review code and optionally plan improvements
---

# Refactor

Review code for issues and optionally plan improvements.

## When to Use

- Reviewing a PR or someone else's code
- Want feedback on code quality
- Planning improvements to code you own

## See Also

- `/brainstorm` - if requirements need clarification first
- `/test-gen` - if tests don't exist (recommended before refactoring)
- `/profile` - if performance is the concern
- `/execute-plan` - to execute an approved refactor plan

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for git commands

Do NOT shell out for search/read operations - use the dedicated tools.

## Ask First: Mode

> "Review only (feedback, no changes), or plan changes (create plan file)?"

## Scope Identification

Ask if not clear:

- Reviewing a PR? (get PR number or branch)
- Reviewing specific files?
- Reviewing recent changes? (commit range)

## Review Process

### 1. Understand Context

- What is this code trying to do?
- What's the broader system context?

### 2. Check for Issues

**Correctness:**

- Logic errors, off-by-one, edge cases
- Error handling gaps
- Race conditions (concurrent code)

**Design:**

- Does it fit existing patterns in the codebase?
- Unnecessary complexity?
- Missing abstractions or over-abstraction?

**Maintainability:**

- Clear naming and structure?
- Adequate (not excessive) comments?
- Type hints where expected?

**Performance (if relevant):**

- Obvious inefficiencies?
- Suggest `/profile` for deeper analysis

### 3. Check Test Coverage

- Do tests exist for this code?
- If no tests: suggest `/test-gen`
- If tests exist but incomplete: note gaps

### 4. Check Reproducibility (data science code)

For notebooks or data pipelines, consider suggesting `/check-reproducibility`.

## Output: Review Only Mode

```markdown
## Summary

<1-2 sentence overview>

## Issues Found

### Critical (must fix)

- **file.py:42** - <issue description>

### Suggested (recommend fixing)

- **file.py:88** - <issue description>

### Nitpicks (optional)

- **file.py:15** - <minor suggestion>

## Questions

- <clarifying questions about intent>

## Related Checks

- [ ] Tests cover changes? (if not, consider `/test-gen`)
- [ ] Performance sensitive? (if yes, consider `/profile`)
```

Present findings. Done.

## Output: Plan Changes Mode

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
