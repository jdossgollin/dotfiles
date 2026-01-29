---
paths:
  - "**/*.tex"
  - "**/*.bib"
  - "**/*.cls"
  - "**/*.sty"
---

# LaTeX

## Document Type Detection

- **Beamer slides**: Look for `\documentclass{beamer}` or `\usepackage{beamer}`
- **Article/Report**: Standard document classes

## Beamer-Specific (when detected)

- One idea per frame
- Maximum 5-7 bullet points per slide
- TikZ in separate files
- Use `\pause` sparingly

## Document Structure (non-slides)

- One sentence per line (easier git diffs)
- Use sub-files or sub-folders for complex documents
- TikZ figures always in separate files (e.g., `figures/diagram.tex`)
- Keep preamble in separate .sty file for complex documents

## Best Practices

- Define macros for frequently used terms: `\newcommand{\method}{Monte Carlo}`
- Use `\cref{}` for cross-references (cleveref package)
- Prefer booktabs for tables (`\toprule`, `\midrule`, `\bottomrule`)
- Use siunitx for numbers and units

## Building

- Use latexmk for compilation
- Check for undefined references, missing citations, overfull boxes
