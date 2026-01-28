---
name: test-gen
description: Generates unit tests for functions. Use when adding test coverage or user asks for tests.
---

# Test Generator

Generate tests for specified function(s).

## When to Use

- No tests exist for code
- Adding coverage before refactoring
- Capturing a bug as regression test (after `/debug`)

## See Also

- `/test` - run existing tests

## Ask First

- Which functions to test?
- Test framework preference?
- Focus areas? (edge cases, errors, typical usage)

## Generate Tests Covering

1. **Happy path**: typical inputs
2. **Edge cases**: empty, None/nothing, boundary values
3. **Error cases**: invalid inputs, expected exceptions
4. **Type variations**: if function accepts multiple types

## Language-Specific

- **Python**: See [python-testing.md](python-testing.md)
- **Julia**: See [julia-testing.md](julia-testing.md)

## Output

- Tests with descriptive names
- Comments explaining what each test verifies
- Suggest test file location

Present tests for review before writing to file.
