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

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_team_factors")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
#> ✖ 2026-11-25 05:19:50.338197: Invalid arguments or no team four factors available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: HTTP 403 Forbidden from https://barttorvik.com/2024_fffinal.csv
#> data frame with 0 columns and 0 rows
# }
```
