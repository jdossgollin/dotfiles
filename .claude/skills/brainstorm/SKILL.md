---
name: brainstorm
description: Explores ideas through Socratic questioning before implementation. Use when requirements are unclear or design needs refinement.
---

# Brainstorm

Refine ideas through structured questioning before diving in.

## When to Use

- Requirements are vague or incomplete
- Multiple approaches seem viable
- Design decisions need exploration
- Starting a new feature, project, or document

## See Also

**For code:**

- `/refactor` - after brainstorming, when ready to plan changes
- `/execute-plan` - after plan is approved

**For writing:**

- `/outline` - after brainstorming, when ready to structure
- `/expand` - after outline is set

## Dialogue Rules

**These rules are critical. Follow them exactly.**

### One Question Per Message

Ask ONE question, then wait. Do not ask multiple questions or dump a list.

```
❌ "What's the goal? Who's the audience? What constraints exist?"
✓ "What problem are we trying to solve?"
```

### Prefer Multiple Choice

When possible, offer structured options rather than open-ended questions:

```
❌ "What approach do you want to take?"
✓ "Which direction fits better?
   A) Build on the existing auth system
   B) Replace with OAuth provider
   C) Something else"
```

### Incremental Validation

After presenting ideas (max 200-300 words), pause and check:

```
"Does this direction feel right so far?"
```

Do NOT present a complete design upfront. Build understanding incrementally.

### 2-3 Alternatives with Trade-offs

Before finalizing any direction, present options:

```markdown
## Option A: <name>
**Approach**: <1-2 sentences>
**Pros**: <key advantages>
**Cons**: <key disadvantages>

## Option B: <name>
...
```

Then ask: "Which resonates? Or hybrid?"

## Process

### 1. Understand the Goal

Start with ONE question about the core problem:

> "What's the main problem we're solving?"

Wait for response. Then explore audience, success criteria—one at a time.

### 2. Explore Constraints

Ask about constraints incrementally:

- Hard requirements?
- Resources/timeline?
- What already exists?

### 3. Generate Options

Present 2-3 approaches with trade-offs (see format above).

### 4. Refine

For the emerging direction, probe:

- "What could go wrong with this?"
- "What's the simplest version that works?"

### 5. Converge

Summarize (briefly) and confirm:

> "So we're going with X because Y. Ready to move forward?"

## Output

**Do NOT write code or prose.** Output is understanding:

1. Refined problem statement
2. Key decisions made
3. Recommended approach
4. Open questions for later

## After Brainstorming

**For code:**

> "Ready to make a plan? (use `/refactor` in plan mode)"

**For writing:**

> "Ready to structure? (use `/outline`)"
