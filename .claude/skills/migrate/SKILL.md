---
name: migrate
description: Migrate between versions, frameworks, or patterns
---

# Migrate

Migrate code between versions, frameworks, or patterns.

## When to Use

- Upgrading library versions (pandas 1.x → 2.x)
- Upgrading language versions (Python 3.9 → 3.12)
- Switching frameworks (unittest → pytest)

## See Also

- `/deps-check` - to identify what needs upgrading first
- `/brainstorm` - if unsure about migration approach
- `/execute-plan` - to execute an approved migration plan

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for running migration tools
- Context7 MCP (if installed): `resolve-library-id`, `query-docs`

Do NOT shell out for search/read operations - use the dedicated tools.

## Gather Information

Ask:

- What are you migrating from/to? (e.g., pandas 1.x → 2.x, Python 3.9 → 3.12)
- Full codebase or specific files?
- Any known pain points or blockers?

## Migration Process

### 1. Fetch Current Documentation

If Context7 MCP is available, use it to get up-to-date docs:

1. `resolve-library-id` with the library name
2. `query-docs` with the library ID and "migration guide" or "breaking changes"

Look for:

- Official migration guides
- Breaking changes / deprecation notices
- New recommended patterns

### 2. Scan Codebase for Affected Patterns

Use Grep to find deprecated patterns, old APIs, etc.

Track findings:

```markdown
| Pattern | Files | Count | Migration |
|---------|-------|-------|-----------|
| `pd.append()` | 5 | 12 | Use `pd.concat()` |
| `df.iteritems()` | 3 | 8 | Use `df.items()` |
```

### 3. Check Dependencies

Use `/deps-check` thinking to verify:

- Are all dependencies compatible with target version?
- Any transitive dependency conflicts?

### 4. Create Migration Plan

Write to `.claude/plans/migrate-<topic>.md`:

```markdown
# Migration Plan: <from> → <to>

Date: YYYY-MM-DD

## Overview

- **From**: <current version/framework>
- **To**: <target version/framework>
- **Scope**: <files/modules affected>

## Breaking Changes to Address

### 1. <Change category>

- **What changed**: <description>
- **Files affected**: <list>
- **Migration**: <how to update>
- **Docs reference**: <link or context7 source>

### 2. ...

## New Features to Consider

- <optional improvements available in new version>

## Order of Operations

1. Update dependencies
2. Fix breaking changes (in order)
3. Run tests
4. Optional: adopt new patterns

## Rollback Plan

<how to revert if needed>
```

### 5. After Writing Plan

STOP. Tell user:

> "Migration plan written to `.claude/plans/migrate-<topic>.md`. Please review. Say 'proceed' to start migration or give feedback."

## During Migration

- Make changes incrementally
- Run `/test` after each major change
- Commit working states frequently

## After Migration

Suggest:

- Run full test suite (`/test`)
- Update documentation (`/update-docs`)
- Check reproducibility (`/check-reproducibility`) if environment changed
