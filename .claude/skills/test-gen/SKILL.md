---
name: test-gen
description: Generate unit tests for a function
---

# Test Generator

Create new tests for specified function(s).

## When to Use

- No tests exist for code you want to test
- Want to add test coverage before refactoring
- Want to capture a bug as a regression test (after `/debug`)

## See Also

- `/test` - if tests exist and you want to run them

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents

## Ask First

- Which functions to test?
- Test framework preference? (pytest, unittest, Julia Test)
- Focus areas? (edge cases, error handling, typical usage)

## Generate Tests Covering

1. **Happy path**: typical inputs
2. **Edge cases**: empty, None/nothing, boundary values
3. **Error cases**: invalid inputs, expected exceptions
4. **Type variations**: if function accepts multiple types

## Language-Specific Patterns

### Julia

- Use `@testset` for grouping, can be nested
- `@test expr` for boolean assertions
- `@test a ≈ b` for floating point (or `@test a ≈ b atol=1e-6`)
- `@test_throws ErrorType expr` for expected exceptions
- `@test_logs (:warn, "message") expr` for log output
- `@test_broken` for known failures (skip with `@test_skip`)
- `@inferred f(x)` to test type stability

### Python (pytest)

- Use `pytest.raises(ErrorType)` for expected exceptions
- Use `pytest.approx()` for floating point
- Use `@pytest.mark.parametrize` for test variants
- Use fixtures for setup/teardown

## Output

- Tests with descriptive names
- Comments explaining what each test verifies
- Suggest test file location

Present tests for review before writing to file.
