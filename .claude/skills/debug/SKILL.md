---
name: debug
description: Debug crashes, wrong outputs, or unexpected behavior
---

# Debug

Systematic debugging for issues not caught by tests.

## When to Use

- Script crashes or throws unexpected errors
- Function returns wrong output
- Behavior differs from expectation but no test catches it

## See Also

- `/test-debug` - if you have failing tests (use that instead)
- `/profile` - if the issue is performance, not correctness

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for running code with instrumentation

Do NOT shell out for search/read operations - use the dedicated tools.

## Gather Information

Ask if not provided:

- What's the expected behavior?
- What's the actual behavior?
- Steps to reproduce?
- Any recent changes?

## Debug Process

### 1. Reproduce the Issue

- Run the failing case
- Confirm the error/behavior
- If can't reproduce: ask for more details

### 2. Isolate the Problem

- Identify the failing code path
- Narrow down to smallest reproducing case
- Check inputs at each stage

### 3. Generate Hypotheses

List 2-4 potential causes, ranked by likelihood:

```markdown
1. **Most likely**: <hypothesis> - because <reasoning>
2. **Possible**: <hypothesis> - because <reasoning>
3. **Less likely**: <hypothesis> - because <reasoning>
```

### 4. Test Hypotheses

- Add diagnostic output (print/logging)
- Check variable values at key points
- Verify assumptions about data/state

### 5. Identify Root Cause

- Explain what's actually happening vs. expected
- Show the specific line(s) causing the issue

### 6. Propose Fix

- Show the fix with explanation
- Explain why it solves the problem
- Note any edge cases the fix handles

## After Finding Fix

### Suggest Follow-ups

**Capture as test:**

> "Want me to create a test that catches this bug? (use `/test-gen`)"

This prevents regression.

**If fix reveals deeper issues:**

> "This fix works, but I noticed structural issues. Want a refactor plan? (use `/refactor`)"

**If performance was the issue:**

> "The bug was performance-related. Want to profile further? (use `/profile`)"

## Output Format

```markdown
## Problem

<concise description of the issue>

## Root Cause

<explanation of what's wrong and why>

**Location**: `file.py:42`

## Fix

<code change with explanation>

## Verification

<how to confirm the fix works>

## Suggested Follow-up

- [ ] Add regression test (`/test-gen`)
```

Present fix for review before implementing.
