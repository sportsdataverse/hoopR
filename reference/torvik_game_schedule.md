# **Bart Torvik Season Schedule & Results**

**Get the full game-by-game schedule and results for a season from
[barttorvik.com](https://barttorvik.com).**

Pulls Bart Torvik's "super schedule" (the `{year}_super_sked.json`
file): one row per game with the pre-game prediction, both teams'
adjusted efficiencies and tempo, the final result, and post-game
game-quality metrics. No API key is required. Data is available from
2008 to present.

## Usage

``` r
torvik_game_schedule(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_game_schedule")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Torvik Functions:
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  # Interactive only: a whole season's schedule, 3-5 s of parsing.
  try(torvik_game_schedule(year = 2024))
#> ✖ 2026-11-13 21:18:03.876212: Invalid arguments or no schedule available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> data frame with 0 columns and 0 rows
# }
```
