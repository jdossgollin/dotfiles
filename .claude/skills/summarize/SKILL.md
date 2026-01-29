---
name: summarize
description: Distills key points from a draft. Use when returning to old work or before critiquing.
---

# Summarize

Extract the main arguments and structure from existing text.

## When to Use

- Returning to a draft after time away
- Before running `/critique` on a long document
- Understanding what's already written before expanding

## See Also

- `/critique` - after summarizing, to evaluate the draft
- `/outline` - if you want to restructure based on summary

## Process

### 1. Identify Scope

Ask if not clear:

- Summarize the whole document?
- Summarize a specific section?

### 2. Read and Extract

For each major section, identify:

- **Main claim/point**: What is this section arguing or explaining?
- **Key evidence/support**: What backs up the claim?
- **Gaps**: What's asserted but not supported?

### 3. Identify Structure

- What's the logical flow?
- How do sections connect?
- Is there a clear thread?

## Output Format

```markdown
## Summary: <document title>

### Main Argument

<1-2 sentences: the core thesis or purpose>

### Structure

1. **<Section name>**: <what it does>
2. **<Section name>**: <what it does>
...

### Key Points

- <point 1>
- <point 2>
- ...

### Observations

- <structural note, gap, or strength>
```

## After Summarizing

> "Ready to critique? (use `/critique`)"

Or if restructuring needed:

> "Want to rework the structure? (use `/outline`)"
