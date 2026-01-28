---
name: git-worktree
description: Manages git worktrees for parallel development. Use when working on multiple features simultaneously or testing changes in isolation.
---

# Git Worktree

Manage git worktrees for parallel development without stashing or branch switching.

## When to Use

- Working on multiple features simultaneously
- Need to test changes in isolation
- Reviewing a PR while working on something else
- Running long tests while continuing development

## See Also

- `/brainstorm` - before starting a new feature branch
- `/pr-ready` - when ready to submit work from a worktree
- `/refactor` - reviewing code across worktrees

## Available Tools

- `Bash` - for git worktree commands
- `Glob` - to find files across worktrees
- `Read` - to read files in any worktree

## Concepts

**Worktree**: A separate working directory linked to the same repo. Each worktree can have a different branch checked out.

**Location**: Worktrees are created outside the main repo directory to keep things clean.

## Commands Reference

```bash
# List existing worktrees
git worktree list

# Create worktree for new feature
git worktree add ../project-feature feature-branch

# Create worktree for existing remote branch
git worktree add ../project-review origin/pr-branch

# Remove worktree when done
git worktree remove ../project-feature

# Prune stale worktree metadata
git worktree prune
```

## Workflow: Parallel Feature Development

### 1. Create Worktree

Ask:
- What branch are you working on?
- New branch or existing?

```bash
# For new branch
git worktree add ../<repo>-<feature> -b <feature-branch>

# For existing branch
git worktree add ../<repo>-<feature> <existing-branch>
```

### 2. Work in Worktree

Navigate to the worktree directory. Changes there are independent of main worktree.

### 3. Return to Main

When done, switch back to main worktree. The other worktree persists.

### 4. Cleanup

When branch is merged:

```bash
git worktree remove ../<repo>-<feature>
git branch -d <feature-branch>
```

## Workflow: PR Review

```bash
# Create worktree for PR
git fetch origin pull/123/head:pr-123
git worktree add ../project-pr-123 pr-123

# Review in isolation
cd ../project-pr-123
# run tests, explore code

# Cleanup after review
git worktree remove ../project-pr-123
git branch -D pr-123
```

## Workflow: Long-Running Tests

```bash
# Create worktree for test run
git worktree add ../project-test HEAD

# In that worktree, run tests
cd ../project-test && pytest  # or julia test

# Continue development in main worktree
```

## Integration with Other Skills

After creating worktree, suggest:

> "Worktree created at `../<name>`. You can:
> - Use `/brainstorm` to plan the feature
> - Use `/test` to run tests in isolation
> - Use `/pr-ready` when ready to submit"

When worktree work is complete:

> "Ready to merge? Use `/pr-ready` to check everything, then clean up the worktree."

## Common Issues

**Worktree locked**: Another process has it open. Close editors/terminals in that directory.

**Branch in use**: Can't check out a branch that's already checked out in another worktree. Use a new branch or remove the other worktree.

**Relative paths**: Be careful with paths. Use absolute paths or understand you're in a different directory.
