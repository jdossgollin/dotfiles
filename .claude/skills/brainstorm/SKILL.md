---
name: brainstorm
description: Explores ideas through Socratic questioning before implementation. Use when requirements are unclear or design needs refinement.
---

# Brainstorm

Refine ideas through structured questioning before diving into code.

## When to Use

- Requirements are vague or incomplete
- Multiple approaches seem viable
- Design decisions need exploration
- Starting a new feature or project

## See Also

- `/refactor` - after brainstorming, when ready to plan changes
- `/execute-plan` - after plan is approved
- `/git-worktree` - if working on multiple approaches in parallel

## Philosophy

**Don't code first.** Understand the problem deeply before writing.

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

> "Ready to make a plan? (use `/refactor` in plan mode)"

Or if more exploration needed:

> "Want to explore option B more deeply?"
