#!/usr/bin/env bash
# Checks that the `.solution-block` filter shows solutions by default / with
# `solution: true` and removes them with `solution: false`, for html, pdf
# (checked on the intermediate LaTeX, which needs no TeX install) and ipynb.
#
# Usage: check_solution_block.sh <theme> <qmd file>
#   e.g. check_solution_block.sh fubstyle-theme fubstyle-theme/template-html.qmd
set -euo pipefail

theme="$1"
qmd="$2"
marker="Solution:"   # text that only occurs inside the .solution-block of the template

# <quarto --to value>:<file extension of the result>
formats=("${theme}-html:html" "latex:tex" "ipynb:ipynb")

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

failures=0
for entry in "${formats[@]}"; do
  to="${entry%%:*}"
  ext="${entry##*:}"

  # <label>:<extra quarto args>:<solution expected in output? yes|no>
  for case in "default::yes" "shown:-M solution:true:yes" "hidden:-M solution:false:no"; do
    label="${case%%:*}"; rest="${case#*:}"
    args="${rest%:*}"; expected="${rest##*:}"

    out="$tmp/$to-$label"
    # shellcheck disable=SC2086
    quarto render "$qmd" --to "$to" --no-execute $args --output-dir "$out" >/dev/null 2>&1 \
      || { echo "FAIL: rendering $to ($label) failed"; failures=$((failures + 1)); continue; }

    if grep -rq --include="*.$ext" -F "$marker" "$out"; then found=yes; else found=no; fi
    if [ "$found" = "$expected" ]; then
      echo "ok:   $to, solution $label -> marker present: $found"
    else
      echo "FAIL: $to, solution $label -> marker present: $found (expected $expected)"
      failures=$((failures + 1))
    fi
  done
done

if [ "$failures" -gt 0 ]; then
  echo "::error::solution test FAILED ($failures check(s) failed)"
  [ -n "${GITHUB_STEP_SUMMARY:-}" ] && echo "### ❌ Solution test failed ($failures check(s))" >> "$GITHUB_STEP_SUMMARY"
  exit 1
fi

echo "solution test passed"
# Visible as an annotation and in the run summary on GitHub (no-ops locally)
echo "::notice title=Solution test::solution test passed (html, pdf/latex, ipynb: shown by default, hidden with solution: false)"
[ -n "${GITHUB_STEP_SUMMARY:-}" ] && echo "### ✅ Solution test passed" >> "$GITHUB_STEP_SUMMARY"
exit 0
