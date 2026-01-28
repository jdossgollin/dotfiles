---
name: brand-guidelines
description: Maintains consistent documentation style across a project. Use when creating or reviewing documentation for style consistency.
---

# Brand Guidelines

Maintain consistent documentation style, terminology, and formatting.

## When to Use

- Creating new documentation (`/doc-gen`)
- Reviewing documentation (`/update-docs`)
- Ensuring consistency across a project
- Setting up style guide for a new project

## See Also

- `/doc-gen` - uses these guidelines when creating docs
- `/update-docs` - uses these guidelines when updating docs
- `/refactor` - for code review (not docs)

## Available Tools

- `Grep` - find terminology usage
- `Glob` - find documentation files
- `Read` - read existing docs

## Guidelines Location

Project-specific guidelines live in: `.claude/brand.md` (optional)

If no `.claude/brand.md` exists, use sensible defaults.

## Process

### 1. Check for Existing Guidelines

```bash
# Look for style guides
.claude/brand.md
docs/STYLE.md
CONTRIBUTING.md (style section)
```

### 2. Infer from Existing Docs

If no explicit guide, analyze:

- README.md style and tone
- Existing documentation patterns
- Comment style in code

### 3. Apply Consistently

When creating/updating docs, match existing patterns.

## Default Guidelines (if none specified)

### Tone

- **Clear over clever**: Prioritize understanding
- **Active voice**: "Run the command" not "The command should be run"
- **Direct**: Address the reader as "you"
- **Concise**: Omit needless words

### Formatting

- **Headings**: Sentence case ("Getting started" not "Getting Started")
- **Code blocks**: Always specify language
- **Lists**: Parallel structure
- **Line length**: One sentence per line in source (for better diffs)

### Terminology

Be consistent with:

- Project name capitalization
- Technical term spelling (e.g., "JavaScript" not "Javascript")
- Abbreviation usage (define on first use)

### Structure

Standard README sections:

1. Title + one-line description
2. Installation
3. Usage (quick start)
4. Configuration (if applicable)
5. Contributing
6. License

## Creating a Brand Guide

If user wants to establish guidelines:

```markdown
# Project Style Guide

## Voice

- Tone: [formal/conversational/technical]
- Audience: [developers/users/both]

## Terminology

| Use | Don't use |
|-----|-----------|
| API key | api-key, API-key |
| setup | set up (noun) |

## Formatting

- Headings: [sentence/title case]
- Code blocks: [language specification rules]
- Line wrapping: [one sentence per line / 80 chars]

## Boilerplate

Standard header/footer for docs:
[template]
```

Write to `.claude/brand.md`

## Checking Consistency

### Terminology Scan

```bash
# Find inconsistent capitalization
grep -ri "javascript" docs/  # should be "JavaScript"
grep -ri "api-key" docs/     # should be "API key"
```

### Structure Check

- Do all pages have required sections?
- Are headings consistent depth?
- Are code examples formatted consistently?

## Output

When reviewing:

```markdown
## Style Consistency Report

### Terminology Issues

- **docs/setup.md:15**: "Javascript" → "JavaScript"
- **README.md:42**: "api-key" → "API key"

### Formatting Issues

- **docs/api.md**: Code block missing language specifier

### Structure Issues

- **docs/config.md**: Missing "Examples" section (present in other pages)

### Recommendations

- Consider adding `.claude/brand.md` to codify these patterns
```

## Integration Notes

When `/doc-gen` is invoked:

1. Check for `.claude/brand.md`
2. Read existing docs to infer style
3. Apply consistent style to new documentation

When `/update-docs` is invoked:

1. Check changes against brand guidelines
2. Flag any style inconsistencies
3. Suggest fixes

After creating documentation:

> "Documentation created. Run `/brand-guidelines` to verify style consistency across the project."
