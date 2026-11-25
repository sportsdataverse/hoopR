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

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_ratings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
#> ✖ 2026-11-25 03:34:34.490109: Invalid arguments or no T-Rank ratings available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: HTTP 403 Forbidden from https://barttorvik.com/2024_team_results.csv
#> data frame with 0 columns and 0 rows
# }
```
