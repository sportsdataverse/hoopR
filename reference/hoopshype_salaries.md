# **HoopsHype Player Salaries**

**Get NBA player salaries from [HoopsHype](https://hoopshype.com).**

Returns the player salary table from HoopsHype's salaries page (current
season plus the projected future-season salaries HoopsHype lists). No
API key is required. Dollar figures are returned as numeric.

**Note:** HoopsHype is a Next.js app that renders only its ~20 top-paid
players into static HTML; the full league list (≈670 contracts) is
served by a cursor-paginated GraphQL API that runs client-side and is
not reachable without executing the page's JavaScript. This function
therefore returns HoopsHype's highest-salary rows. For the full league
use
[`espn_nba_player_contracts()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_contracts.md)
(ESPN); for team-level cap totals use
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md).

## Usage

``` r
hoopshype_salaries()
```

## Value

A `hoopR_data` tibble with one row per player. The first numeric column
is the current-season salary; subsequent `x{year}_{year}` columns are
future-season salaries as listed by HoopsHype:

|          |           |                              |
|----------|-----------|------------------------------|
| col_name | types     | description                  |
| rank     | integer   | Salary rank.                 |
| player   | character | Player name.                 |
| salary   | numeric   | Current-season salary (USD). |

Future-season salary columns (e.g. `x2025_26`, `x2026_27`) are returned
as numeric when present.

## See also

Other Salary & Draft Functions:
[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md),
[`spotrac_team_cap()`](https://hoopR.sportsdataverse.org/reference/spotrac_team_cap.md)

## Examples

``` r
# \donttest{
  try(hoopshype_salaries())
#> ── Player salaries from hoopshype.com ─────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 13:48:47 UTC
#> # A tibble: 20 × 6
#>    rank  player             salary x2026_27 x2027_28 x2028_29
#>    <chr> <chr>               <dbl>    <dbl>    <dbl>    <dbl>
#>  1 1     Stephen Curry    59606817 62587158       NA       NA
#>  2 T2    Nikola Jokic     55224526 59033114 62841702       NA
#>  3 T2    Joel Embiid      55224526 59539018 64302139 69065261
#>  4 4     Kevin Durant     54708608 43902439 46097561       NA
#>  5 T5    Anthony Davis    54126450 58456566 62786682       NA
#>  6 T5    Jimmy Butler     54126450 56832773       NA       NA
#>  7 T5    Jayson Tatum     54126450 58456566 62786682 67116798
#>  8 T5    G. Antetokounmpo 54126450 58456566 62786682       NA
#>  9 T9    K. Towns         53142264 57078728 61015192       NA
#> 10 T9    Jaylen Brown     53142264 57078728 61015192 64951656
#> 11 T9    Devin Booker     53142264 57078728 61015192 69877500
#> 12 12    LeBron James     52627153       NA       NA       NA
#> 13 13    Paul George      51666090 54126380 56586670       NA
#> 14 14    Kawhi Leonard    50000000 50300000       NA       NA
#> 15 15    Zach LaVine      47499660 48967380       NA       NA
#> 16 T16   Trae Young       46394100 48967380       NA       NA
#> 17 T16   Lauri Markkanen  46394100 46113154 49824681 53536209
#> 18 T16   Donovan Mitchell 46394100 50105628 53817156       NA
#> 19 T16   Cade Cunningham  46394100 50105628 53817156 57528684
#> 20 T16   Evan Mobley      46394100 50105628 53817156 57528684
# }
```
