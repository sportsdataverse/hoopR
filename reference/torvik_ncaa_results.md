# **Bart Torvik NCAA Tournament Results**

**Get historical NCAA tournament performance from
[barttorvik.com](https://barttorvik.com), by team, coach, conference or
seed.**

Returns raw and adjusted NCAA tournament results, including PASE
(performance above seed expectation) and PAKE (performance above KenPom
expectation) plus round-by-round appearance counts. No API key is
required. Data runs from 2000 to present.

## Usage

``` r
torvik_ncaa_results(min_year, max_year, type = "team")
```

## Arguments

- min_year:

  (*integer* required): Minimum tournament year (4-digit, e.g. `2010`).

- max_year:

  (*integer* required): Maximum tournament year (4-digit, e.g. `2024`).

- type:

  (*character* optional): Aggregation level. One of `team` (default),
  `coach`, `conf`, or `seed`.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "torvik_ncaa_results")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other Torvik Functions:
[`torvik_game_schedule()`](https://hoopR.sportsdataverse.org/reference/torvik_game_schedule.md),
[`torvik_game_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_game_stats.md),
[`torvik_player_stats()`](https://hoopR.sportsdataverse.org/reference/torvik_player_stats.md),
[`torvik_ratings()`](https://hoopR.sportsdataverse.org/reference/torvik_ratings.md),
[`torvik_team_factors()`](https://hoopR.sportsdataverse.org/reference/torvik_team_factors.md)

## Examples

``` r
# \donttest{
  try(torvik_ncaa_results(min_year = 2010, max_year = 2024, type = "conf"))
#> ✖ 2026-11-13 17:40:05.390463: Invalid arguments or no NCAA tournament results available!
#> ✖ Args: min_year = 2010, max_year = 2024, type = "conf"
#> ✖ Error: `clean_names()` requires that either names or dimnames be non-null.
#> data frame with 0 columns and 0 rows
# }
```
