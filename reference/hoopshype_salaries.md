# **HoopsHype Player Salaries**

**Get NBA player salaries from
[HoopsHype](https://www.hoopshype.com/).**

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

A `hoopR_data` tibble with one row per player-season:

|                  |           |                                        |
|------------------|-----------|----------------------------------------|
| col_name         | types     | description                            |
| player_id        | character | HoopsHype player id.                   |
| player           | character | Player name.                           |
| first_name       | character | Player first name.                     |
| last_name        | character | Player last name.                      |
| team_id          | character | HoopsHype team id.                     |
| team             | character | Team name.                             |
| season           | integer   | Contract season (4-digit ending year). |
| salary           | numeric   | Salary for the season (USD).           |
| cap_allocation   | numeric   | Cap allocation for the season (USD).   |
| team_option      | logical   | Whether the season is a team option.   |
| player_option    | logical   | Whether the season is a player option. |
| two_way          | logical   | Whether it is a two-way contract.      |
| qualifying_offer | logical   | Whether it is a qualifying offer.      |

## See also

Other Salary & Draft Functions:
[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(hoopshype_salaries())
#> ── Player salaries from hoopshype.com ────────────────────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-09 03:49:19 UTC
#> # A tibble: 0 × 0
# }
```
