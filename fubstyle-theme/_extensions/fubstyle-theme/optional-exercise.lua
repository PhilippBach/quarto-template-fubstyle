-- Shorthand for the optional / advanced exercise box.
--
--   ::: {.optional-exercise}
--   Exercise text ...
--   :::
--
-- Override the heading with `title="..."`.
--
-- html / pdf: the div is turned into an (untyped) Quarto callout, which the
--   theme styles via `.optional-exercise.callout`.
-- ipynb (and other non-callout formats): Jupyter does not understand
--   `::: {.callout}` fences, so the div is turned into a plain blockquote
--   with a bold title instead.

local default_title = "🎓 Optional — Advanced Exercise"

function Div(div)
  if not div.classes:includes("optional-exercise") or div.classes:includes("callout") then
    return nil
  end

  local title = div.attributes["title"] or default_title

  if quarto.doc.is_format("ipynb") or quarto.doc.is_format("markdown") then
    local blocks = pandoc.List({ pandoc.Para({ pandoc.Strong(pandoc.Inlines(title)) }) })
    blocks:extend(div.content)
    return pandoc.BlockQuote(blocks)
  end

  return quarto.Callout({
    type = "none",
    appearance = div.attributes["appearance"] or "default",
    title = pandoc.Inlines(title),
    content = div.content,
    attr = div.attr,
    icon = false,
  })
end
