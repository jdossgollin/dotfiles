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
