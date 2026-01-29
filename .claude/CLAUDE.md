# Global Coding Preferences

## Communication Style

- Be concise
- Ask for clarification rather than assuming and diving down the wrong path
- When uncertain about requirements, stop and ask
- Use iterative dialogue patterns: one question at a time, prefer multiple choice, validate before continuing

## Complex Projects

For multi-step or architectural work:

1. Use `/brainstorm` to clarify goals and create structure
2. Write plans to `docs/ROADMAP.md` (packages) or `docs/OUTLINE.md` (documents)
3. Use Rolling Wave Planning: detail only H1 (this week), keep H2/H3 as bullets
4. STOP after writing plan and tell user to review
5. Only proceed after explicit approval
6. Use `/execute-plan` to implement, updating checkboxes as you go

## File-Based Planning

Plans live in files, not conversation context:

| File | Purpose |
|------|---------|
| `docs/ROADMAP.md` | Feature roadmap for packages/software |
| `docs/OUTLINE.md` | Hierarchical structure for documents |
| `.claude/INBOX.md` | Unstructured idea capture (triage with `/brainstorm`) |
| `.claude/brand.md` | Style/terminology guide (optional) |

## Subagents

Use subagents for:

- Research tasks
- Exploring unfamiliar codebases
- Parallel independent tasks

## Code Quality

- Write clear, readable code
- Use descriptive variable names
- Keep functions focused
- Prefer simplicity over cleverness

## Before Making Changes

- Read existing code first
- Understand the patterns already in use
- Match existing style and conventions

## Skills Quick Reference

Skills are installed at `~/.claude/skills/`. See `ARCHITECTURE.md` there for full details.

### Meta / Session Management

| Need to... | Use | Notes |
|------------|-----|-------|
| Restore context | `/status` | Start of session or after time away |
| Plan or triage ideas | `/brainstorm` | Creates ROADMAP/OUTLINE, processes INBOX |
| Pre-PR checklist | `/pr-ready` | Orchestrates test, docs, review |

### Writing (papers, slides, grants)

| Need to... | Use | Notes |
|------------|-----|-------|
| Turn outline into prose | `/expand` | Section by section |
| Summarize or evaluate | `/critique` | Asks: summarize, critique, or both? |
| Sentence-level refinement | `/polish` | Word choice, flow, concision |

### Code Execution

| Need to... | Use | Notes |
|------------|-----|-------|
| Implement approved plan | `/execute-plan` | Updates checkboxes in plan file |

### Code Review

| Need to... | Use | Notes |
|------------|-----|-------|
| Review or improve code | `/refactor` | Asks: review only or plan changes? |

### Testing & Debug

| Need to... | Use | Notes |
|------------|-----|-------|
| Run tests | `/test` | Summarizes failures, suggests `/debug` |
| Create new tests | `/test-gen` | |
| Debug issues | `/debug` | Root cause analysis |
| Profile performance | `/profile` | Find bottlenecks |

### Documentation

| Need to... | Use | Notes |
|------------|-----|-------|
| Create or update docs | `/docs` | Detects what needs updating |

### Data Science

| Need to... | Use | Notes |
|------------|-----|-------|
| Audit reproducibility | `/check-reproducibility` | Includes dependency health check |
| Export environment | `/env-export` | |
| Clean notebooks | `/notebook-clean` | |

### Utilities

| Need to... | Use | Notes |
|------------|-----|-------|
| Parallel development | `/git-worktree` | Work on multiple branches |
| Upgrade versions | `/migrate` | Framework/version upgrades |
