-- Shorthand for solution-only content: ::: {.solution-block} ... :::
-- Shown or removed based on the document's `solution:` metadata field
-- (defaults to shown), e.g. `quarto render doc.qmd -M solution:false`.
-- Same idea as ::: {.content-hidden unless-meta="solution"} ... :::, but
-- with the default flipped: without `solution:` set, solutions are shown.
--
-- Note: the class is named "solution-block", not "solution", because Quarto
-- reserves the bare `.solution` class for its own built-in proof-like
-- environment (a styled "Solution." callout), which would consume the div
-- before this filter runs.

function Pandoc(doc)
  local show_solutions = true
  if doc.meta.solution ~= nil then
    show_solutions = doc.meta.solution == true
  end

  return doc:walk {
    Div = function(el)
      if el.classes:includes("solution-block") then
        if show_solutions then
          return el.content
        else
          return {}
        end
      end
    end
  }
end
