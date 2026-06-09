# **NBADraft.net Mock Draft**

**Get the latest mock draft from
[NBADraft.net](https://www.nbadraft.net).**

Returns the current consensus mock draft (both rounds), one row per
pick. No API key is required.

## Usage

``` r
nbadraft_mock_draft(year = NULL)
```

## Arguments

- year:

  (*integer* optional): Draft year (e.g. `2025`). Defaults to the site's
  current mock; older years use the `/{year}/` path when available.

## Value

A `hoopR_data` tibble with one row per mock-draft pick:

|          |           |                                                   |
|----------|-----------|---------------------------------------------------|
| col_name | types     | description                                       |
| round    | integer   | Draft round (1 or 2).                             |
| pick     | integer   | Pick number within the round.                     |
| team     | character | Projected team (`*` traded-pick marker stripped). |
| player   | character | Projected player.                                 |
| height   | character | Player height.                                    |
| weight   | character | Player weight.                                    |
| position | character | Player position.                                  |
| school   | character | Player school / pre-draft team.                   |
| class    | character | Player class / draft eligibility.                 |

## See also

Other Salary & Draft Functions:
[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(nbadraft_mock_draft())
#> ── Mock draft from nbadraft.net ───────────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 16:58:58 UTC
#> # A tibble: 0 × 0
# }
```
