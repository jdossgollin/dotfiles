---
name: test-debug
description: Run tests, analyze failures, propose fixes
---

# Test and Debug

Run tests and debug failures.

## When to Use

- Tests exist and you want to run them
- Tests are failing and you need to fix the CODE (not the tests)

## See Also

- `/test-gen` - if tests don't exist yet
- `/debug` - for bugs not caught by tests (crashes, wrong output)

## Available Tools

- `Grep` - ripgrep-based search (use instead of `grep` or `rg` in bash)
- `Glob` - fast file pattern matching (use instead of `find`)
- `Read` - read file contents (use instead of `cat`)
- `Bash` - for running commands (pytest, julia, git, etc.)

Do NOT shell out for search/read operations - use the dedicated tools.

## Phase 1: Run Tests

1. Identify test framework (pytest, Julia Test, etc.)
2. Run test suite
3. If all pass: report success, done
4. If failures: proceed to Phase 2

## Phase 2: Analyze Failures

For each failure:

1. Parse error message and stack trace
2. Generate 2-3 hypotheses for root cause
3. Identify the actual bug location (may not be in test file)

## Phase 3: Propose Fixes

**CRITICAL GUARDRAILS:**

- NEVER modify tests just to make them pass
- NEVER delete or skip failing tests
- NEVER weaken assertions (e.g., changing `assertEqual` to `assertTrue`)
- Tests define expected behavior - fix the CODE, not the test
- Exception: if test itself has a bug (wrong expected value), explain clearly

**For each fix:**

- Explain root cause
- Show proposed code change
- Explain why this fixes the issue without compromising functionality

## Phase 4: Review

Present all proposed fixes. Ask before implementing.

User may want to fix some manually or adjust approach.
