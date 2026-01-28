---
name: review-code
description: Review code changes, PRs, or unfamiliar code
---

# Code Review

Review code for bugs, design issues, and improvements.

## When to Use

- Reviewing a PR or someone else's code
- Understanding unfamiliar code before working on it
- Want feedback/critique without immediately changing anything

## See Also

- `/refactor` - if you want to PLAN changes to code you own (not just review)

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for git commands

Do NOT shell out for search/read operations - use the dedicated tools.

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

- Do tests exist for changed code?
- If no tests: suggest `/test-gen`
- If tests exist but seem incomplete: note gaps

### 4. Check Reproducibility (data science code)

For notebooks or data pipelines, consider suggesting `/check-reproducibility`.

## Output Format

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

## Questions for Author

- <clarifying questions about intent>

## Related Checks

- [ ] Tests cover changes? (if not, consider `/test-gen`)
- [ ] Performance sensitive? (if yes, consider `/profile`)
- [ ] Data pipeline? (if yes, consider `/check-reproducibility`)
```

## After Review

Present findings. User decides:

- Which issues to address
- Whether to run suggested follow-up skills
- Whether to request changes or approve
