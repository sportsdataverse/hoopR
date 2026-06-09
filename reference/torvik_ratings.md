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
#> ℹ Data updated: 2026-06-09 13:12:54 UTC
#> # A tibble: 5 × 2
#>   html                                       year
#>   <chr>                                     <int>
#> 1 <head><title>403 Forbidden</title></head>  2024
#> 2 <body>                                     2024
#> 3 <center><h1>403 Forbidden</h1></center>    2024
#> 4 </body>                                    2024
#> 5 </html>                                    2024
# }
```
