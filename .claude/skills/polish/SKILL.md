---
name: polish
description: Refines prose at sentence level. Use for final cleanup before submission.
---

# Polish

Improve text at the sentence level: word choice, flow, concision.

## When to Use

- Draft is structurally sound (critique done)
- Final pass before submission
- Specific sentences feel awkward

## See Also

- `/critique` - if structural/argument issues remain
- `/expand` - if sections need more content, not refinement

## Ask First: Scope

> "Polish the whole document, or specific sections/paragraphs?"

For long documents, work section by section.

## Process

### 1. Read Aloud (Mentally)

Identify sentences that:

- Are hard to parse
- Feel wordy
- Have awkward rhythm
- Use weak verbs or vague nouns

### 2. Apply Refinements

**Concision:**

- Cut filler words ("very," "really," "quite," "somewhat")
- Remove redundancy ("past history" → "history")
- Prefer active voice where appropriate

**Clarity:**

- One idea per sentence
- Subject near verb
- Concrete nouns over abstractions

**Flow:**

- Vary sentence length
- Use transitions appropriately
- Maintain consistent tone

**Precision:**

- Replace vague words ("things," "stuff," "aspects")
- Use specific verbs over verb + adverb

### 3. Preserve Voice

Don't over-edit. The goal is clarity, not uniformity. Preserve the author's voice and style.

## Output Format

Show changes with context:

```markdown
## Polished: <section>

**Original:**
> <original sentence or paragraph>

**Revised:**
> <polished version>

**Why:** <brief explanation>

---

<next change>
```

Or for light edits, show inline:

```markdown
## Suggestions

- "very important" → "critical" (concision)
- "It is shown that X" → "X" or "We show X" (active voice)
- ...
```

## Guidelines

### Do

- Make targeted changes
- Explain the reasoning
- Preserve meaning exactly
- Respect author's voice

### Don't

- Rewrite substantially (that's `/expand`)
- Change meaning
- Impose stylistic preferences
- Over-polish (diminishing returns)

## Common Patterns

| Before | After | Why |
|--------|-------|-----|
| "in order to" | "to" | concision |
| "due to the fact that" | "because" | concision |
| "it is important to note that" | (delete or) "notably," | filler |
| "was performed by" | "<subject> performed" | active voice |
| "a number of" | "several" or specific number | precision |

## After Polishing

> "Anything else to refine, or ready to finalize?"
