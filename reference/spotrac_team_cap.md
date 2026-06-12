# **Spotrac NBA Team Salary Cap**

**Get team salary-cap allocations from
[Spotrac](https://www.spotrac.com).**

Returns one row per team with cap allocations, cap space, active-player
counts and average age for a season. No API key is required.

## Usage

``` r
spotrac_team_cap(season = most_recent_nba_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_nba_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_nba_season.md).

## Value

A `hoopR_data` tibble with one row per team (columns reflect Spotrac's
table; dollar figures are returned as numeric):

|                       |           |                                        |
|-----------------------|-----------|----------------------------------------|
| col_name              | types     | description                            |
| rank                  | integer   | Spotrac cap rank.                      |
| team                  | character | Team abbreviation.                     |
| record                | character | Win-loss record.                       |
| players_active        | integer   | Number of active players.              |
| avg_age_team          | numeric   | Average roster age.                    |
| total_cap_allocations | numeric   | Total cap allocations (USD).           |
| cap_space_all         | numeric   | Cap space / over-the-cap amount (USD). |
| season                | integer   | Season (echoes the `season` argument). |

## See also

Other Salary & Draft Functions:
[`hoopshype_salaries()`](https://hoopR.sportsdataverse.org/reference/hoopshype_salaries.md),
[`nbadraft_mock_draft()`](https://hoopR.sportsdataverse.org/reference/nbadraft_mock_draft.md)

## Examples

``` r
# \donttest{
  try(spotrac_team_cap(season = 2024))
#> ── Team salary cap from spotrac.com ───────────────────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 02:35:20 UTC
#> # A tibble: 32 × 11
#>     rank team  record players_active avg_age_team total_cap_allocations
#>    <int> <chr> <chr>           <dbl> <chr>                        <dbl>
#>  1     1 DET   44-38              15 25.0                     141808220
#>  2     2 ORL   41-41              15 25.3                     152959238
#>  3     3 UTA   17-65              15 23.9                     154114022
#>  4     4 SAS   34-48              15 25.2                     162809380
#>  5     5 OKC   68-14              15 24.2                     166001694
#>  6     6 CHA   19-63              15 25.2                     167423486
#>  7     7 MEM   48-34              15 24.6                     167814933
#>  8     8 CHI   39-43              15 24.6                     168006873
#>  9     9 PHI   24-58              15 26.6                     170340647
#> 10    10 IND   50-32              15 25.7                     171232577
#> # ℹ 22 more rows
#> # ℹ 5 more variables: cap_space_all <dbl>, active <dbl>, active_top_3 <dbl>,
#> #   dead_cap <dbl>, season <int>
# }
```
