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

## Dialogue Rules

See [dialogue-rules.md](../dialogue-rules.md). Key points:

- **One question at a time**
- **Incremental feedback** (don't dump everything at once)
- **Validate before continuing** ("Does this resonate?")

## Ask First: Feedback Level

> "What kind of feedback?
> A) Argument/structure (big picture)
> B) Clarity (is it easy to follow?)
> C) Comprehensive (both)"

Wait for response. **Default to A** for papers and grants if user is uncertain.

## Process

### 1. Read for Understanding

First pass: understand what the text is trying to say. Don't critique yet.

### 2. Start with Biggest Issue

Identify the MOST important issue. Present it:

> "The main thing I noticed: <issue>. Does this resonate, or should I look at something else?"

Wait for response before continuing.

### 3. Continue Incrementally

After validation, present 2-3 more issues. Then pause:

> "Want me to continue, or focus on one of these?"

### 4. Specific Locations

Always reference specific locations (section names, paragraphs, or quotes).

## Feedback Levels

**Argument/Structure:**

- Is the main claim clear?
- Is each claim supported by evidence?
- Are there logical gaps or leaps?
- Does the order make sense?

**Clarity:**

- Is the audience clear?
- Are technical terms explained?
- Are sentences parseable on first read?

## Output Format (when presenting multiple issues)

```markdown
## Issues Found

**Most important:**
- **<location>**: <issue and why it matters>

**Also notable:**
- **<location>**: <issue>
- **<location>**: <issue>

Should I continue, or discuss one of these?
```

## Guidelines

### Do

- Start with the biggest issue
- Be specific (point to exact locations)
- Explain why something is an issue
- Acknowledge what works

### Don't

- Dump 10 issues at once
- Rewrite the text (that's `/polish`)
- Be vague ("this section is weak")
- Make changes without permission

## After Critiquing

If structural issues:

> "Want to rework the outline? (use `/outline`)"

If ready for refinement:

> "Ready to polish? (use `/polish`)"
