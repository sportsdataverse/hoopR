# **Bart Torvik Team Four Factors**

**Get team four-factor and shooting splits from
[barttorvik.com](https://barttorvik.com).**

Pulls the season four-factors table (the `{year}_fffinal.csv` file):
effective field goal %, turnover %, offensive/defensive rebound %,
free-throw rate, plus 2P/3P/FT shooting splits and assist rates – each
paired with its national rank. No API key is required. Data is available
from 2008 to present.

## Usage

``` r
torvik_team_factors(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per team. Each statistic is paired
with an interspersed national-rank column (`rk`, `rk_2`, ...):

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_name | character | Team name. |
| e_fg_percent | numeric | Effective field goal percentage (offense). |
| e_fg_percent_def | numeric | Effective field goal percentage allowed (defense). |
| ftr | numeric | Free-throw rate (offense). |
| ftr_def | numeric | Free-throw rate allowed (defense). |
| or_percent | numeric | Offensive rebound percentage. |
| dr_percent | numeric | Defensive rebound percentage. |
| to_percent | numeric | Turnover percentage (offense). |
| to_percent_def | numeric | Turnover percentage forced (defense). |
| x3p_percent | numeric | Three-point percentage (offense). |
| x3p_d_percent | numeric | Three-point percentage allowed (defense). |
| x2p_percent | numeric | Two-point percentage (offense). |
| x2p_percent_d | numeric | Two-point percentage allowed (defense). |
| ft_percent | numeric | Free-throw percentage (offense). |
| ft_percent_d | numeric | Free-throw percentage allowed (defense). |
| x3p_rate | numeric | Three-point attempt rate (offense). |
| x3p_rate_d | numeric | Three-point attempt rate allowed (defense). |
| arate | numeric | Assist rate (offense). |
| arate_d | numeric | Assist rate allowed (defense). |
| year | integer | Season (echoes the `year` argument). |

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md)

## Examples

``` r
# \donttest{
  try(torvik_team_factors(year = 2024))
#> ── Bart Torvik team four factors from barttorvik.com ──────────── hoopR 3.1.0 ──
#> ℹ Data updated: 2026-06-09 13:12:55 UTC
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
