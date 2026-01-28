---
name: execute-plan
description: Executes a plan file step by step with checkpoints. Use after a plan has been reviewed and approved.
---

# Execute Plan

Execute an approved plan file systematically with checkpoints and rollback capability.

## When to Use

- After `/refactor` plan has been approved
- After `/migrate` plan has been approved
- Any `.claude/plans/*.md` file is ready for execution

## See Also

- `/refactor` - creates refactor plans
- `/migrate` - creates migration plans
- `/test` - run after each checkpoint
- `/brainstorm` - if plan needs rethinking

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Edit` - modify files
- `Write` - create new files
- `Bash` - for git and test commands

## Prerequisites

1. A plan file exists in `.claude/plans/`
2. User has reviewed and approved the plan
3. Git working directory is clean (or changes are stashed)

## Ask First

> "Which plan file should I execute? (list files in `.claude/plans/`)"

Or if user specifies:

> "I'll execute `.claude/plans/<name>.md`. The plan has N steps. Execute all, or step by step with confirmation?"

## Execution Modes

### Mode A: Step-by-Step (default for high-risk)

Execute one step, show results, wait for confirmation before next step.

### Mode B: Batch with Checkpoints

Execute all steps, creating git commits as checkpoints. Pause only on errors.

## Execution Process

### 1. Create Safety Checkpoint

```bash
git stash push -m "pre-execution-backup" --include-untracked
# or if clean:
git rev-parse HEAD  # note the commit hash
```

### 2. For Each Step in Plan

1. Announce: "Step N: <description>"
2. Execute the changes
3. Run `/test` if tests exist
4. If tests pass: commit checkpoint
5. If tests fail: pause, offer rollback

### 3. Checkpoint Commits

```bash
git add -A
git commit -m "checkpoint: step N - <description>"
```

### 4. On Failure

```markdown
## Step N Failed

**Error**: <description>

**Options**:
1. Fix and retry this step
2. Rollback to previous checkpoint: `git reset --hard HEAD~1`
3. Rollback to start: `git reset --hard <initial-commit>`
4. Pause and investigate with `/debug`
```

### 5. Completion

```markdown
## Execution Complete

- Steps completed: N/N
- Checkpoints created: N commits
- Tests: passing/failing

**Next steps**:
- Squash checkpoints if desired: `git rebase -i HEAD~N`
- Run `/test` for full test suite
- Run `/pr-ready` before submitting
```

## Plan File Format Expected

Plans should have numbered steps:

```markdown
## Order of Operations

1. First change X
2. Then change Y
3. Finally change Z
```

Or:

```markdown
### 1. <Change title>
- **File**: path/to/file
- **What**: <description>

### 2. ...
```

## Safety Rules

1. **Never force-push** during execution
2. **Always checkpoint** before risky changes
3. **Pause on test failure** - don't continue blindly
4. **Keep plan file open** - update status as you go

## Updating Plan During Execution

Mark completed steps:

```markdown
### 1. <Change title> ✓

### 2. <Change title> (in progress)

### 3. <Change title>
```

## Rollback

If user says "rollback":

```bash
# To last checkpoint
git reset --hard HEAD~1

# To start of execution
git reset --hard <noted-commit>

# Restore stash if used
git stash pop
```

## Integration Notes

After successful execution:

> "Plan executed successfully. Run `/test` for full verification, then `/pr-ready` when ready to submit."

If execution reveals need for more planning:

> "Encountered unexpected complexity. Want to `/brainstorm` this section before continuing?"
