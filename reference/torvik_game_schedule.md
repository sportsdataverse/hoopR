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

A `hoopR_data` tibble with one row per game (key columns shown; the
`_1`/`_2` suffixes denote `team1` and `team2`):

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| muid        | character | Matchup unique id.                            |
| date        | character | Game date (M/D/YY).                           |
| conmatch    | character | Conference matchup descriptor.                |
| matchup     | character | Ranked-matchup descriptor.                    |
| prediction  | character | Pre-game prediction (favorite, score, win %). |
| ttq         | numeric   | Torvik Thrill Quotient (game excitement).     |
| conf        | numeric   | Conference-game flag.                         |
| venue       | numeric   | Venue / neutral-site flag.                    |
| team1       | character | Team 1 name.                                  |
| t1oe        | numeric   | Team 1 offensive efficiency in the game.      |
| t1de        | numeric   | Team 1 defensive efficiency in the game.      |
| team2       | character | Team 2 name.                                  |
| t2oe        | numeric   | Team 2 offensive efficiency in the game.      |
| t2de        | numeric   | Team 2 defensive efficiency in the game.      |
| gp          | numeric   | Game-played flag (1 if completed).            |
| result      | character | Final result string.                          |
| tempo       | numeric   | Game tempo (possessions).                     |
| possessions | numeric   | Possessions in the game.                      |
| t1pts       | numeric   | Team 1 points.                                |
| t2pts       | numeric   | Team 2 points.                                |
| winner      | character | Winning team.                                 |
| loser       | character | Losing team.                                  |
| gamevalue   | numeric   | Game quality value.                           |
| t1ppp       | numeric   | Team 1 points per possession.                 |
| t2ppp       | numeric   | Team 2 points per possession.                 |
| overtimes   | numeric   | Number of overtimes.                          |
| year        | integer   | Season (echoes the `year` argument).          |

Additional adjusted-efficiency, quality, and ranking columns (`t1adjo`,
`t2adjd`, `t1qual`, `mismatch`, `t1rk`, ...) are also returned.

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
  try(torvik_game_schedule(year = 2024))
#> ✖ 2026-06-13 03:14:11.984908: Invalid arguments or no schedule available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> data frame with 0 columns and 0 rows
# }
```
