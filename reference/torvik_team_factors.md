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
#> ℹ Data updated: 2026-06-12 03:26:36 UTC
#> # A tibble: 362 × 42
#>    team_name e_fg_percent    rk e_fg_percent_def  rk_2   ftr  rk_3 ftr_def  rk_4
#>    <chr>            <dbl> <int>            <dbl> <int> <dbl> <int>   <dbl> <int>
#>  1 North Da…         50.2   204             52.4   281  32.2   190    29.6   108
#>  2 Appalach…         52.7    71             45.4     6  31.6   216    20.7     2
#>  3 San Fran…         55      22             49.5   113  23.5   356    37.9   298
#>  4 Bradley           55.1    18             47.6    40  27.5   319    35.1   253
#>  5 Eastern …         50.6   180             49.8   138  32     197    29.5   102
#>  6 Long Bea…         48.5   265             51.1   214  37.8    57    32.3   170
#>  7 Utah St.          54      43             49.8   134  39      35    30.6   126
#>  8 Gonzaga           57       6             47.3    32  30.7   240    25.2    19
#>  9 Valparai…         46.2   331             54.5   348  23.3   357    30.7   131
#> 10 Pepperdi…         50.8   164             54.7   352  32.6   183    33.9   218
#> # ℹ 352 more rows
#> # ℹ 33 more variables: or_percent <dbl>, rk_5 <int>, dr_percent <dbl>,
#> #   rk_6 <int>, to_percent <dbl>, rk_7 <int>, to_percent_def <dbl>, rk_8 <int>,
#> #   x3p_percent <dbl>, rk_9 <int>, x3p_d_percent <dbl>, rk_10 <int>,
#> #   x2p_percent <dbl>, rk_11 <int>, x2p_percent_d <dbl>, rk_12 <int>,
#> #   ft_percent <dbl>, rk_13 <int>, ft_percent_d <dbl>, rk_14 <int>,
#> #   x3p_rate <dbl>, rk_15 <int>, x3p_rate_d <dbl>, rk_16 <int>, arate <dbl>, …
# }
```
