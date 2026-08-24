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

A `hoopR_data` tibble with one row per team-game:

|            |           |                                                     |
|------------|-----------|-----------------------------------------------------|
| col_name   | types     | description                                         |
| date       | character | Game date (M/D/YY).                                 |
| type       | numeric   | Game-type flag.                                     |
| team       | character | Team name.                                          |
| conf       | character | Team conference.                                    |
| opp        | character | Opponent name.                                      |
| venue      | character | Venue relative to `team` (`H`/`A`/`N`).             |
| result     | character | Result string (e.g. `L, 78-73`).                    |
| adj_oe     | numeric   | Adjusted offensive efficiency.                      |
| adj_de     | numeric   | Adjusted defensive efficiency.                      |
| oe         | numeric   | Raw offensive efficiency (points/100 poss).         |
| off_efg    | numeric   | Offensive effective field goal percentage.          |
| off_to     | numeric   | Offensive turnover percentage.                      |
| off_or     | numeric   | Offensive rebound percentage.                       |
| off_ftr    | numeric   | Offensive free-throw rate.                          |
| de         | numeric   | Raw defensive efficiency (points allowed/100 poss). |
| def_efg    | numeric   | Defensive effective field goal percentage allowed.  |
| def_to     | numeric   | Defensive turnover percentage forced.               |
| def_or     | numeric   | Defensive (opponent) rebound percentage.            |
| def_ftr    | numeric   | Defensive free-throw rate allowed.                  |
| game_score | numeric   | Bart Torvik single-game quality score.              |
| opp_conf   | character | Opponent conference.                                |
| year       | integer   | Season (4-digit ending-year).                       |
| tempo      | numeric   | Game tempo (possessions).                           |
| muid       | character | Matchup unique id.                                  |
| coach      | character | Team head coach.                                    |
| opp_coach  | character | Opponent head coach.                                |
| win_prob   | numeric   | Pre-game win probability for `team`.                |

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
  try(torvik_game_stats(year = 2024))
#> ✖ 2026-08-24 19:30:29.091476: Invalid arguments or no game stats available for 2024!
#> ✖ Args: year = 2024
#> ✖ Error: lexical error: invalid char in json text.                                        <!DOCTYPE HTML PUBLIC "-//W3C//                      (right here) ------^ 
#> data frame with 0 columns and 0 rows
# }
```
