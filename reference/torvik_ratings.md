# **Bart Torvik T-Rank Ratings**

**Get year-end / current T-Rank team ratings and adjusted efficiencies
from [barttorvik.com](https://barttorvik.com).**

Pulls the full T-Rank team table for a season (the
`{year}_team_results.csv` file). No API key is required. Data is
available from 2008 to present.

## Usage

``` r
torvik_ratings(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024` for the 2023-24 season). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per team:

|  |  |  |
|----|----|----|
| col_name | types | description |
| rank | integer | Overall T-Rank (barthag) rank. |
| team | character | Team name. |
| conf | character | Conference abbreviation. |
| record | character | Overall win-loss record. |
| adjoe | numeric | Adjusted offensive efficiency (pts/100 poss). |
| oe_rank | integer | National rank of adjusted offensive efficiency. |
| adjde | numeric | Adjusted defensive efficiency (pts/100 poss). |
| de_rank | integer | National rank of adjusted defensive efficiency. |
| barthag | numeric | Power rating: win probability vs. an average team. |
| proj_w | numeric | Projected wins. |
| proj_l | numeric | Projected losses. |
| pro_con_w | numeric | Projected conference wins. |
| pro_con_l | numeric | Projected conference losses. |
| con_rec | character | Conference record. |
| sos | numeric | Strength of schedule. |
| ncsos | numeric | Non-conference strength of schedule. |
| consos | numeric | Conference strength of schedule. |
| qual_o | numeric | Quality-adjusted offensive efficiency. |
| qual_d | numeric | Quality-adjusted defensive efficiency. |
| qual_barthag | numeric | Quality-adjusted power rating. |
| wab | numeric | Wins above bubble. |
| wab_rk | integer | National rank of wins above bubble. |
| adjt | numeric | Adjusted tempo (possessions per 40 minutes). |
| year | integer | Season (4-digit ending-year; echoes the `year` argument). |

Additional projected / opponent / conference split columns (`proj_sos`,
`opp_oe`, `con_adj_oe`, `con_pf`, `fun`, ...) are also returned.

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_ratings(year = 2024))
#> ── Bart Torvik T-Rank ratings from barttorvik.com ─────────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-12 03:26:35 UTC
#> # A tibble: 362 × 46
#>     rank team     conf  record adjoe oe_rank adjde de_rank barthag rank_2 proj_w
#>    <int> <chr>    <chr> <chr>  <dbl>   <int> <dbl>   <int>   <dbl>  <int>  <dbl>
#>  1     1 Connect… BE    37-3    128.       1  91.3       4   0.980      1     37
#>  2     2 Houston  B12   32-5    120.      15  86.5       1   0.977      2     32
#>  3     3 Purdue   B10   34-5    126.       3  94.5      15   0.965      3     34
#>  4     4 Auburn   SEC   27-8    121.      10  93.1       7   0.953      4     27
#>  5     5 Iowa St. B12   29-8    114.      53  87.7       2   0.952      5     29
#>  6     6 Arizona  P12   27-9    121.      12  93.3       8   0.950      6     27
#>  7     7 Tenness… SEC   27-9    116.      31  90.4       3   0.945      7     27
#>  8     8 Duke     ACC   27-9    121.       9  95.5      20   0.940      8     27
#>  9     9 North C… ACC   29-8    119.      18  94.3      14   0.937      9     29
#> 10    10 Creight… BE    25-10   122.       8  97.1      32   0.931     10     25
#> # ℹ 352 more rows
#> # ℹ 35 more variables: proj_l <dbl>, pro_con_w <dbl>, pro_con_l <dbl>,
#> #   con_rec <chr>, sos <dbl>, ncsos <dbl>, consos <dbl>, proj_sos <dbl>,
#> #   proj_noncon_sos <dbl>, proj_con_sos <dbl>, elite_sos <dbl>,
#> #   elite_noncon_sos <dbl>, opp_oe <dbl>, opp_de <dbl>, opp_proj_oe <dbl>,
#> #   opp_proj_de <dbl>, con_adj_oe <dbl>, con_adj_de <dbl>, qual_o <dbl>,
#> #   qual_d <dbl>, qual_barthag <dbl>, qual_games <dbl>, fun <dbl>, …
# }
```
