---
name: git-commit
description: Generate semantic commit message from staged changes
---

# Git Commit

Generate structured commit message from staged changes.

## When to Use

- Ready to commit and want a well-formatted message
- Want to check if docs need updating before commit

## May Call

- `/update-docs` - if changes touch public APIs (asks first)

## Available Tools

- `Bash` - for git commands
- `Read` - read file contents if needed

## Process

### 1. Read Diff

```bash
git diff --staged
```

### 2. Categorize (conventional commits)

- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation
- `style`: formatting
- `refactor`: restructuring
- `test`: adding tests
- `chore`: maintenance

### 3. Compose Message

- Subject: `<type>(<scope>): <description>` (< 50 chars)
- Body: bulleted list of what changed and WHY

### 4. Pre-Commit Check

If changes touch public APIs or user-facing features:

- Ask: "Should I check if docs need updating? (y/n)"
- If yes: use the Skill tool to invoke `update-docs`

### 5. Present for Review

Do NOT auto-commit.

## Example Output

```
feat(data-loader): add parquet support

- Add pyarrow dependency for parquet reading
- Implement lazy loading for large files
- Update data-read docs with new format
```
