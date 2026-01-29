---
name: critique
description: Evaluates argument strength and clarity. Use when reviewing a draft for feedback.
---

# Critique

Evaluate a draft for argument quality, structure, and clarity.

## When to Use

- Draft is complete (or section is complete)
- Want feedback before sharing
- Stuck and need perspective

## See Also

- `/summarize` - to understand a draft before critiquing
- `/polish` - for sentence-level refinement (after addressing critique)
- `/outline` - if structural problems require reorganization

## Ask First: Feedback Level

> "What kind of feedback? (argument/structure, clarity, or comprehensive)"

**Default to argument/structure** for papers and grants.

### Feedback Levels

- **Argument/structure**: Is the logic sound? Are claims supported? Does flow make sense?
- **Clarity**: Is it easy to follow? Are terms defined? Is anything confusing?
- **Comprehensive**: Both of the above

## Process

### 1. Read for Understanding

First pass: understand what the text is trying to say.

### 2. Evaluate (based on level)

**Argument/Structure:**

- Is the main claim clear?
- Is each claim supported by evidence?
- Are there logical gaps or leaps?
- Does the order make sense?
- Are counterarguments addressed?

**Clarity:**

- Is the audience clear?
- Are technical terms explained?
- Are sentences parseable on first read?
- Is anything ambiguous?

### 3. Note Specific Issues

Reference specific locations (section names, paragraphs, or quotes).

## Output Format

```markdown
## Critique: <document/section>

### Strengths

- <what works well>

### Issues

**Argument/Structure:**

- **<location>**: <issue and why it matters>
- ...

**Clarity:**

- **<location>**: <issue>
- ...

### Suggestions

1. <specific actionable suggestion>
2. ...

### Questions

- <clarifying questions about intent>
```

## Guidelines

### Do

- Be specific (point to exact locations)
- Explain why something is an issue
- Prioritize (major issues first)
- Acknowledge what works

### Don't

- Rewrite the text (that's `/polish`)
- Suggest style changes in argument critique
- Be vague ("this section is weak")
- Make changes without permission

## After Critiquing

If structural issues:

> "Want to rework the outline? (use `/outline`)"

If ready for refinement:

> "Ready to polish? (use `/polish`)"
