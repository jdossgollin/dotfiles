# Global Coding Preferences

## Communication Style

- Be concise
- Ask for clarification rather than assuming and diving down the wrong path
- When uncertain about requirements, stop and ask

## Complex Projects

For multi-step or architectural work:

1. Use plan mode to think through the approach
2. Write plans to `.claude/plans/<topic>.md` (gitignored)
3. STOP after writing plan and tell user to review
4. User will edit/comment in the plan file
5. Only proceed after explicit approval

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

| Need to... | Use | Notes |
|------------|-----|-------|
| Run tests | `/test` | Summarizes failures, suggests `/debug` |
| Debug issues | `/debug` | Root cause analysis for any bug |
| Review or improve code | `/refactor` | Asks: review only or plan changes? |
| Create new tests | `/test-gen` | |
| Create new docs | `/doc-gen` | For new documentation |
| Sync docs with changes | `/update-docs` | After code changes |
| Pre-PR checklist | `/pr-ready` | Orchestrates test, docs, review |
| Audit reproducibility | `/check-reproducibility` | |
| Export environment | `/env-export` | |
| Upgrade versions | `/migrate` | |
| Parse data files | `/data-read` | |
| Clean notebooks | `/notebook-clean` | |
