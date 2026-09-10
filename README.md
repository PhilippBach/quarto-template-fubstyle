# quarto-template-fubstyle

[![Check Quarto Themes](https://github.com/PhilippBach/quarto-template-fubstyle/actions/workflows/check_templates.yml/badge.svg)](https://github.com/PhilippBach/quarto-template-fubstyle/actions/workflows/check_templates.yml)

Quarto extension providing the `fubstyle-theme` HTML and revealjs formats.

## Installing the extension

From within your Quarto project:

```bash
quarto add PhilippBach/quarto-template-fubstyle/fubstyle-theme
```

This installs the extension into your project's `_extensions` directory.

## Using the theme

Set the format in your document's YAML front matter to `fubstyle-theme-html` or
`fubstyle-theme-revealjs`:

```yaml
---
title: "Title"
format: fubstyle-theme-revealjs
---
```

See [`fubstyle-theme/template-html.qmd`](fubstyle-theme/template-html.qmd) and
[`fubstyle-theme/template-revealjs.qmd`](fubstyle-theme/template-revealjs.qmd) for examples
demonstrating the available formatting features for each format.
