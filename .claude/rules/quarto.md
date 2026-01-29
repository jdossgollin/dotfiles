---
paths:
  - "**/*.qmd"
---

# Quarto

## Document Type Detection

- **Slides**: `format: revealjs` in YAML frontmatter
- **Document**: `format: html`, `format: pdf`, `format: docx`

## Slides-Specific (when detected)

- One slide per `##` heading
- Maximum 5-7 points per slide
- Use speaker notes (`::: {.notes}`)
- Use `{.smaller}` for code blocks

## Document Best Practices

- Use Quarto cross-references (`@fig-`, `@tbl-`, `@eq-`)
- Label computational chunks: `#| label: fig-example`
- Use callouts for important notes

## Markdown Formatting

- Blank line after headings
- Blank line before/after lists and code blocks
- Use LaTeX math (`$x^2$`) not Unicode when math renders

## Math Rendering

- Quarto renders math - prefer `$x^2$` over Unicode `x²`
- Use display math `$$...$$` for important equations
