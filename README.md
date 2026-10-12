# quarto-template-fubstyle

[![Check Quarto Themes](https://github.com/PhilippBach/quarto-template-fubstyle/actions/workflows/check_templates.yml/badge.svg)](https://github.com/PhilippBach/quarto-template-fubstyle/actions/workflows/check_templates.yml)

Quarto extension providing the `fubstyle-theme` html, revealjs, pdf and ipynb formats.

## Installing the extension

From within your Quarto project:

```bash
quarto add PhilippBach/quarto-template-fubstyle/fubstyle-theme
```

This installs the extension into your project's `_extensions` directory.

## Using the theme

Set the format in your document's YAML front matter to one of `fubstyle-theme-html`,
`fubstyle-theme-revealjs`, `fubstyle-theme-pdf` or `fubstyle-theme-ipynb`:

```yaml
---
title: "Title"
format: fubstyle-theme-revealjs
---
```

See [`fubstyle-theme/template-html.qmd`](fubstyle-theme/template-html.qmd) and
[`fubstyle-theme/template-revealjs.qmd`](fubstyle-theme/template-revealjs.qmd) for examples
demonstrating the available formatting features for each format.

## Optional exercises and solutions

Two shorthand divs are available in all four formats:

```markdown
::: {.optional-exercise}
Exercise text. Override the heading with `title="..."`.
:::

::: {.solution-block}
Solution text, shown with a bold "Solution" title.
:::
```

- `.optional-exercise` renders as a callout (html, revealjs, pdf) or as a
  blockquote with a bold title (ipynb). The default title is
  "🎓 Optional: Advanced Exercise".
- `.solution-block` is shown when the `solution` metadata field is `true` or
  unset, and removed when it is `false`. This works the same way in html,
  revealjs, pdf and ipynb.

Render a student copy without solutions:

```bash
quarto render doc.qmd --to fubstyle-theme-html -M solution:false
quarto render doc.qmd --to fubstyle-theme-revealjs -M solution:false
quarto render doc.qmd --to fubstyle-theme-pdf -M solution:false
quarto render doc.qmd --to fubstyle-theme-ipynb -M solution:false
```

The pdf format requires a LaTeX installation (for example TinyTeX via
`quarto install tinytex`).

### Notes on the pdf format

The pdf format only attaches the two filters. It does not ship a LaTeX header:
course-specific preamble code (for example a shared `header.tex`) should stay in
your own project and be added per document or project with `include-in-header`.
