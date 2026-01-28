---
paths:
  - "**/*.md"
  - "!CLAUDE.md"
  - "!**/SKILL.md"
---

# Markdown

## Formatting (Linting Compliance)

- Blank line after headings
- Blank line before and after lists
- Blank line before and after code blocks
- No trailing whitespace
- Single blank line between sections (not multiple)
- Use ATX-style headings (`#` not underlines)

## Markdown Flavor

- Identify the markdown flavor being used (GitHub, Pandoc, etc.)
- Document flavor in frontmatter or HTML comment if ambiguous
- Example: `<!-- markdown: gfm -->` or in YAML frontmatter

## Math Rendering

- If math rendering is available (Quarto, Jupyter, LaTeX-enabled): use LaTeX math
- If no math rendering (GitHub README): use Unicode sparingly or avoid math
- Prefer `$x^2$` over `x²` when math is rendered
- For GitHub: state equations in words or link to rendered version
