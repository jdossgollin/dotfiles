---
name: test
description: Run test suite and summarize results
---

# Test

Run tests and report results. Delegates debugging to `/debug`.

## When to Use

- Run the test suite
- Check if tests pass before committing/pushing
- Get a summary of test failures

## See Also

- `/debug` - to analyze and fix failures (called after this skill if needed)
- `/test-gen` - if tests don't exist yet
- `/git-worktree` - to run tests in isolation while continuing development

## Available Tools

- `Bash` - for running test commands
- `Read` - to check test configuration

## Process

### 1. Identify Test Framework

- Python: pytest, unittest
- Julia: Test stdlib, TestItemRunner
- Check for config files (pytest.ini, pyproject.toml, test/runtests.jl)

### 2. Run Tests

Run the appropriate test command and capture output.

### 3. Report Results

**If all pass:**

```
✓ All tests passing (X/X)
```

Done.

**If failures:**

Summarize each failure concisely (2-3 lines):

```markdown
## Test Results: X/Y passing

### Failures

1. **test_function_name** (test_file.py:42)
   - AssertionError: expected 5, got 4
   - Context: testing edge case with empty input

2. **test_other_thing** (test_file.py:88)
   - TypeError: 'NoneType' has no attribute 'foo'
   - Context: missing null check
```

### 4. Suggest Next Step

If failures exist:

> "X tests failed. Run `/debug` to analyze and fix?"

Do NOT attempt to fix failures - that's `/debug`'s job.
