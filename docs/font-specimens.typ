// Font Specimen Sheet for dotfiles
// Compile with: typst compile font-specimens.typ
// Requires: all fonts from install/install-fonts.sh installed

#set page(margin: (x: 1in, y: 0.8in))
#set text(font: "Inter", size: 10pt)

// Colors
#let heading-color = rgb("#1a1a2e")
#let category-color = rgb("#16213e")
#let accent = rgb("#e94560")
#let subtle = rgb("#888888")
#let sample-bg = rgb("#f5f5f5")

// Font specimen block
#let specimen(name, display-name, description) = {
  v(4pt)
  grid(
    columns: (1fr, auto),
    text(weight: "bold", fill: heading-color)[#display-name],
    text(size: 8pt, fill: subtle)[#description],
  )
  v(2pt)
  block(
    fill: sample-bg,
    radius: 3pt,
    inset: 8pt,
    width: 100%,
  )[
    #set text(font: name)
    #text(size: 13pt)[The quick brown fox jumps over the lazy dog.]\
    #text(size: 9pt)[ABCDEFGHIJKLM NOPQRSTUVWXYZ abcdefghijklm nopqrstuvwxyz]\
    #text(size: 9pt)[0123456789 \$%&\@\#!? ()\[\]{} +-=<> :: -> => != >=]
  ]
  v(2pt)
}

// Title
#align(center)[
  #text(size: 28pt, weight: "bold", fill: heading-color)[Font Specimens]
  #v(4pt)
  #text(size: 12pt, fill: subtle)[dotfiles #sym.bullet #datetime.today().display()]
  #v(2pt)
  #text(size: 9pt, fill: subtle)[Installed by `install/install-fonts.sh` on macOS and Linux]
]

#v(8pt)
#line(length: 100%, stroke: 0.5pt + subtle)
#v(8pt)

// ── Terminal & Coding ──────────────────────────────────
#text(size: 18pt, weight: "bold", fill: category-color)[Terminal & Coding]

#specimen("MesloLGS NF", "MesloLGS Nerd Font", "Required for Powerlevel10k prompt")
#specimen("JetBrains Mono", "JetBrains Mono", "Default coding font — tall x-height, ligatures")
#specimen("Cascadia Code", "Cascadia Code", "Microsoft — cursive italics variant")
#specimen("Fira Code", "Fira Code", "Pioneer of coding ligatures")
#specimen("Geist Mono", "Geist Mono", "Vercel — clean and minimal")
#specimen("Commit Mono", "Commit Mono", "Neutral, purpose-built for code")
#specimen("Intel One Mono", "Intel One Mono", "Optimized for small sizes and low-res displays")
#specimen("Iosevka", "Iosevka", "Narrow monospace — fits more columns")
#specimen("Monaspace Neon", "Monaspace Neon", "GitHub — texture healing (Neon variant)")
#specimen("Source Code Pro", "Source Code Pro", "Adobe — clean and widely supported")
#specimen("Fira Mono", "Fira Mono", "Mozilla — pairs with Fira Sans")
#specimen("JuliaMono", "JuliaMono", "Scientific computing — full Unicode math symbols")

#pagebreak()

// ── Scientific Writing ─────────────────────────────────
#text(size: 18pt, weight: "bold", fill: category-color)[Scientific Writing (LaTeX / Quarto)]
#v(2pt)

#specimen("Libertinus Serif", "Libertinus", "Modern Linux Libertine successor — includes math font")
#specimen("STIX Two Text", "STIX Two", "Scientific publishers (AMS, AIP, IEEE) — full math coverage")
#specimen("EB Garamond", "EB Garamond", "Beautiful Garamond revival")
#specimen("Crimson Text", "Crimson Text", "Old-style serif inspired by Minion")
#specimen("Cormorant", "Cormorant", "Display serif inspired by Garamond")
#specimen("Old Standard TT", "Old Standard TT", "Early 20th century academic feel")
#specimen("TeX Gyre Pagella", "TeX Gyre Pagella", "Free Palatino equivalent — LaTeX standard")
#specimen("Alegreya", "Alegreya", "Dynamic serif with small caps — thesis and book work")
#specimen("Cinzel", "Cinzel", "Roman inscriptions — great for titles")
#specimen("Merriweather", "Merriweather", "Designed for comfortable on-screen reading")

#v(12pt)

// ── Presentations & UI ─────────────────────────────────
#text(size: 18pt, weight: "bold", fill: category-color)[Presentations & UI (Slides / Posters)]
#v(2pt)

#specimen("Inter", "Inter", "Most popular UI typeface — legible at all sizes")
#specimen("DM Sans", "DM Sans", "Clean geometric sans-serif")
#specimen("Atkinson Hyperlegible", "Atkinson Hyperlegible", "Braille Institute — maximum readability")
#specimen("Roboto", "Roboto", "Google's signature typeface")
#specimen("Open Sans", "Open Sans", "Humanist sans-serif — web and print")
#specimen("Lato", "Lato", "Warm sans-serif — professional without being cold")
#specimen("Montserrat", "Montserrat", "Geometric sans — great for headings")
#specimen("Fira Sans", "Fira Sans", "Mozilla — pairs with Fira Code/Mono")
#specimen("Oswald", "Oswald", "Condensed sans — bold and attention-grabbing")
#specimen("Bebas Neue", "Bebas Neue", "All-caps display — eye-catching poster titles")
#specimen("Varela Round", "Varela Round", "Friendly rounded sans-serif")

#pagebreak()

// ── Novelty & Special Purpose ──────────────────────────
#text(size: 18pt, weight: "bold", fill: category-color)[Novelty & Special Purpose]
#v(2pt)

#specimen("Special Elite", "Special Elite", "Typewriter font for stylized quotes")
#specimen("Cooper Hewitt", "Cooper Hewitt", "Smithsonian design museum typeface")
#specimen("Iceland", "Iceland", "Geometric display with Nordic character")
#specimen("Graduate", "Graduate", "Slab serif inspired by college lettering")
#specimen("Kameron", "Kameron", "Sturdy slab serif for headings")

#v(16pt)
#line(length: 100%, stroke: 0.5pt + subtle)
#v(10pt)

// ── Pairing Suggestions ────────────────────────────────
#text(size: 18pt, weight: "bold", fill: category-color)[Suggested Pairings]
#v(8pt)

#table(
  columns: (auto, auto, auto, auto),
  stroke: none,
  inset: 6pt,
  table.header(
    table.hline(stroke: 1.5pt),
    [*Use Case*], [*Heading*], [*Body*], [*Code*],
    table.hline(stroke: 0.5pt),
  ),
  [Academic paper],    [---],          [Libertinus],       [JuliaMono],
  [LaTeX default],     [---],          [TeX Gyre Pagella], [Source Code Pro],
  [Modern paper],      [Montserrat],   [Inter],            [JetBrains Mono],
  [Thesis / book],     [Cinzel],       [Alegreya],         [Fira Code],
  [Slides (clean)],    [Bebas Neue],   [Inter],            [Geist Mono],
  [Slides (warm)],     [Montserrat],   [Lato],             [JetBrains Mono],
  [Slides (bold)],     [Oswald],       [Open Sans],        [Cascadia Code],
  [Accessible],        [Montserrat],   [Atkinson Hyperl.], [Intel One Mono],
  [Poster],            [Bebas Neue],   [Roboto],           [Fira Code],
  table.hline(stroke: 1.5pt),
)

#v(12pt)
#text(size: 8pt, fill: subtle)[
  Generated from `docs/font-specimens.typ`.
  Compile with `typst compile font-specimens.typ` after running `install/install-fonts.sh`.
  Fonts that are not installed will use a fallback.
]
