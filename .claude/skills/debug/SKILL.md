---
name: debug
description: Debugs crashes, wrong outputs, or unexpected behavior. Use for any bug not caught by tests.
---

# Debug

Systematic root cause analysis for bugs.

## When to Use

- Script crashes or throws errors
- Function returns wrong output
- Unexpected behavior

## See Also

- `/test` - if you have failing tests (run that first)
- `/profile` - if issue is performance, not correctness

## Gather Information

Ask if not provided:

- Expected behavior?
- Actual behavior?
- Steps to reproduce?
- Recent changes?

## Debug Process

### 1. Reproduce

- Run the failing case
- Confirm the error
- If can't reproduce: ask for more details

### 2. Isolate

- Identify failing code path
- Narrow to smallest reproducing case

### 3. Hypothesize

List 2-4 causes ranked by likelihood:

```markdown
1. **Most likely**: <hypothesis> - <reasoning>
2. **Possible**: <hypothesis> - <reasoning>
```

### 4. Test Hypotheses

- Add diagnostic output
- Check variable values at key points
- Verify assumptions

### 5. Root Cause

- Explain what's happening vs. expected
- Show specific line(s) causing issue

### 6. Fix

- Show fix with explanation
- Note edge cases handled

## Language-Specific Tools

- **Python**: See [python-debugging.md](python-debugging.md)
- **Julia**: See [julia-debugging.md](julia-debugging.md)

## Output Format

```markdown
## Problem

<concise description>

## Root Cause

<explanation>

**Location**: `file.py:42`

## Fix

<code change>

## Verification

<how to confirm>
```

## After Fix

> "Want a regression test? (use `/test-gen`)"

Present fix for review before implementing.
