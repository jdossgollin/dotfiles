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

## Dialogue Rules

See [dialogue-rules.md](../dialogue-rules.md). Key points:

- **Present summary incrementally** for long documents
- **Validate understanding** before proceeding

## Ask First: Scope

> "Summarize the whole document, or a specific section?"

For long documents, offer to summarize section by section.

## Process

### 1. Read and Extract

For each major section, identify:

- **Main claim/point**: What is this section arguing?
- **Key evidence**: What backs it up?
- **Gaps**: What's asserted but not supported?

### 2. Present Main Argument First

Start with the core:

> "The main argument seems to be: <1-2 sentences>
>
> Is that right?"

Wait for confirmation before continuing.

### 3. Walk Through Structure

After main argument is confirmed:

> "The structure is:
> 1. **<Section>**: <what it does>
> 2. **<Section>**: <what it does>
>
> Want me to go deeper on any section?"

### 4. Note Observations

If relevant, mention:

- Strengths in the current draft
- Gaps or unclear areas
- Structural observations

## Output Format (Full Summary)

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

### Observations

- <structural note, gap, or strength>
```

## After Summarizing

> "Ready to critique? (use `/critique`)"

Or if restructuring needed:

> "Want to rework the structure? (use `/outline`)"
