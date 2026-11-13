# **HoopsHype Player Salaries**

**Get NBA player salaries from HoopsHype (hoopshype.com).**

Returns the full league's player salaries, one row per player per
contract season (current plus future seasons HoopsHype lists). No API
key is required; dollar figures are returned as numeric.

HoopsHype is a Next.js app whose single salaries page paginates
client-side, but each team's salary page (`/salaries/{team}/`) embeds
that team's complete roster in its `__NEXT_DATA__` payload. This
function iterates the 30 team pages and stitches them together (~30
requests per call) using a team-by-team approach.

## Usage

``` r
hoopshype_salaries()
```

## Value

A `hoopR_data` tibble with one row per player-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "hoopshype_salaries")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Salary & Draft Functions:
[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(hoopshype_salaries())
#> ── Player salaries from hoopshype.com ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:51:39 UTC
#> # A tibble: 0 × 0
# }
```
