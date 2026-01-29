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

## Philosophy

**Don't dive in first.** Understand the problem deeply before writing code or prose.

## Process

### 1. Understand the Goal

Ask clarifying questions:

- What problem are we solving?
- Who is the user/audience?
- What does success look like?

### 2. Explore Constraints

- What are the hard requirements?
- What resources are available?
- What's the timeline?
- What's already built that we can use?

### 3. Generate Options

Present 2-4 approaches:

```markdown
## Option A: <name>

**Approach**: <brief description>
**Pros**: <advantages>
**Cons**: <disadvantages>
**Effort**: low/medium/high

## Option B: <name>

...
```

### 4. Socratic Refinement

For each option, ask:

- What could go wrong?
- What assumptions are we making?
- How would this scale?
- What's the simplest version that works?

### 5. Converge

- Summarize the emerging direction
- Identify remaining open questions
- Ask: "Does this direction feel right?"

## Output

**Do NOT write code.** Output is:

1. Refined problem statement
2. Key decisions made
3. Recommended approach
4. Open questions for later

## After Brainstorming

**For code:**

> "Ready to make a plan? (use `/refactor` in plan mode)"

**For writing:**

> "Ready to structure? (use `/outline`)"

Or if more exploration needed:

> "Want to explore option B more deeply?"
