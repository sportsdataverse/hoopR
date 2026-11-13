# **Bart Torvik Game Stats**

**Get per-game team statistics from
[barttorvik.com](https://barttorvik.com).**

Pulls one row per team-game for a season (the `getgamestats.php`
export): adjusted and raw offensive/defensive efficiency, the four
factors on both ends, tempo, the result, pre-game win probability, and
the opposing coach. No API key is required. barttorvik does not publish
column headers for this file, so the column names below are mapped from
its observed positional layout. Data is available from 2008 to present.

## Usage

``` r
torvik_game_stats(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per team-game. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_game_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  # Interactive only: every team-game of a season, 4-5 s of parsing.
  try(torvik_game_stats(year = 2024))
#> ✖ 2026-11-13 18:20:14.516448: Invalid arguments or no game stats available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> data frame with 0 columns and 0 rows
# }
```
