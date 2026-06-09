# **HoopsHype Player Salaries**

**Get NBA player salaries from [HoopsHype](https://hoopshype.com).**

Returns the full league's player salaries, one row per player per
contract season (current plus future seasons HoopsHype lists). No API
key is required; dollar figures are returned as numeric.

HoopsHype is a Next.js app whose single salaries page paginates
client-side, but each team's salary page (`/salaries/{team}/`) embeds
that team's complete roster in its `__NEXT_DATA__` payload. This
function iterates the 30 team pages and stitches them together (≈30
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
#> ── Player salaries from hoopshype.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 22:03:54 UTC
#> # A tibble: 2,110 × 13
#>    player_id player        first_name last_name team_id team       season salary
#>    <chr>     <chr>         <chr>      <chr>     <chr>   <chr>       <int>  <int>
#>  1 522878    CJ McCollum   CJ         McCollum  1       Atlanta H…   2025 3.07e7
#>  2 1230356   Jalen Johnson NA         NA        NA      NA           2029 3   e7
#>  3 1230356   Jalen Johnson NA         NA        NA      NA           2026 3   e7
#>  4 1230356   Jalen Johnson NA         NA        NA      NA           2028 3   e7
#>  5 1230356   Jalen Johnson NA         NA        NA      NA           2025 3   e7
#>  6 1230356   Jalen Johnson NA         NA        NA      NA           2027 3   e7
#>  7 1230356   Jalen Johnson NA         NA        NA      NA           2024 4.51e6
#>  8 1230356   Jalen Johnson NA         NA        NA      NA           2023 2.93e6
#>  9 1230356   Jalen Johnson NA         NA        NA      NA           2022 2.79e6
#> 10 1230356   Jalen Johnson NA         NA        NA      NA           2021 2.66e6
#> # ℹ 2,100 more rows
#> # ℹ 5 more variables: cap_allocation <int>, team_option <lgl>,
#> #   player_option <lgl>, two_way <lgl>, qualifying_offer <lgl>
# }
```
