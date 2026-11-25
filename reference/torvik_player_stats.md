# **Bart Torvik Player Season Stats**

**Get player advanced season statistics from
[barttorvik.com](https://barttorvik.com).**

Pulls every player's advanced season stat line for a year (the
`getadvstats.php` CSV export). No API key is required. barttorvik does
not publish column headers for this file, so the column names below are
mapped from Bart Torvik's standard player advanced-stats layout
(consistent from 2010 onward). Data is available from 2008 to present.

Since November 2026 the file has 78 fields: barttorvik appended 11
undocumented fields after the original 67. Those 67 keep their names;
any field after them is returned under its position, `v68` to `v78`. A
file with fewer than 67 fields (2008 and 2009 skip the play-by-play
fields) keeps positional names for every column (`v1`, `v2`, ...), since
the documented names cannot be placed reliably.

## Usage

``` r
torvik_player_stats(year = most_recent_mbb_season())
```

## Arguments

- year:

  (*integer* required): Season, in 4-digit ending-year format (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_player_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_ncaa_results()`](https://hoopR.sportsdataverse.org/reference/torvik_ncaa_results.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_player_stats(year = 2024))
#> ✖ 2026-11-25 07:00:59.045241: Invalid arguments or no player stats available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: HTTP 403 Forbidden from https://barttorvik.com/getadvstats.php
#> data frame with 0 columns and 0 rows
# }
```
