---
name: test-gen
description: Generate unit tests for a function
---

# Test Generator

Generate tests for specified function(s).

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

## Output

- Tests with descriptive names
- Comments explaining what each test verifies
- Suggest test file location

Present tests for review before writing to file.
