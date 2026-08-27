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

A `hoopR_data` tibble with one row per team/coach/conference/seed:

|               |           |                                                |
|---------------|-----------|------------------------------------------------|
| col_name      | types     | description                                    |
| rk            | integer   | Rank within the queried split.                 |
| team          | character | Team / coach / conference / seed (per `type`). |
| pake          | numeric   | Performance above KenPom expectation (wins).   |
| pase          | numeric   | Performance above seed expectation (wins).     |
| wins          | integer   | Total tournament wins.                         |
| loss          | integer   | Total tournament losses.                       |
| w_percent     | numeric   | Tournament win percentage.                     |
| r64           | integer   | Round of 64 appearances.                       |
| r32           | integer   | Round of 32 appearances.                       |
| s16           | integer   | Sweet 16 appearances.                          |
| e8            | integer   | Elite 8 appearances.                           |
| f4            | integer   | Final 4 appearances.                           |
| f2            | integer   | Championship-game appearances.                 |
| champ         | integer   | National championships.                        |
| top2          | integer   | Top-2 (runner-up or champion) finishes.        |
| f4_percent    | numeric   | Final 4 rate.                                  |
| champ_percent | numeric   | Championship rate.                             |
| min_year      | integer   | Minimum year queried (echoes `min_year`).      |
| max_year      | integer   | Maximum year queried (echoes `max_year`).      |
| type          | character | Aggregation level queried (echoes `type`).     |

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
#> ✖ 2026-08-27 18:06:48.723125: Invalid arguments or no NCAA tournament results available!
#> ✖ Args: min_year = 2010, max_year = 2024, type = "conf"
#> ✖ Error: `clean_names()` requires that either names or dimnames be non-null.
#> data frame with 0 columns and 0 rows
# }
```
