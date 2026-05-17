# **Get ESPN NBA's Betting information**

**Get ESPN NBA's Betting information**

## Usage

``` r
espn_nba_betting(game_id)
```

## Arguments

- game_id:

  Game ID

## Value

Returns a named list of data frames: pickcenter, againstTheSpread,
predictor

**pickcenter**

|  |  |  |
|----|----|----|
| col_name | types | description |
| details | character | Details. |
| over_under | numeric | Over under. |
| spread | numeric | Spread. |
| provider_id | integer | Unique identifier for provider. |
| provider_name | character | Provider name. |
| provider_priority | integer | Provider priority. |
| away_team_odds_favorite | logical | Away team's team odds favorite. |
| away_team_odds_underdog | logical | Away team's team odds underdog. |
| away_team_odds_money_line | integer | Away team's team odds money line. |
| away_team_odds_spread_odds | numeric | Away team's team odds spread odds. |
| away_team_odds_team_id | integer | Unique identifier for away team odds team. |
| away_team_odds_win_percentage | numeric | Away team odds win percentage (0-1 decimal). |
| away_team_odds_average_score | numeric | Away team's team odds average score. |
| away_team_odds_money_line_odds | numeric | Away team's team odds money line odds. |
| away_team_odds_spread_return | numeric | Away team's team odds spread return. |
| away_team_odds_spread_record_wins | integer | Away team's team odds spread record wins. |
| away_team_odds_spread_record_losses | integer | Away team's team odds spread record losses. |
| away_team_odds_spread_record_pushes | integer | Away team's team odds spread record pushes. |
| away_team_odds_spread_record_summary | character | Away team's team odds spread record summary. |
| home_team_odds_favorite | logical | Home team's team odds favorite. |
| home_team_odds_underdog | logical | Home team's team odds underdog. |
| home_team_odds_money_line | integer | Home team's team odds money line. |
| home_team_odds_spread_odds | numeric | Home team's team odds spread odds. |
| home_team_odds_team_id | integer | Unique identifier for home team odds team. |
| home_team_odds_win_percentage | numeric | Home team odds win percentage (0-1 decimal). |
| home_team_odds_average_score | numeric | Home team's team odds average score. |
| home_team_odds_money_line_odds | numeric | Home team's team odds money line odds. |
| home_team_odds_spread_return | numeric | Home team's team odds spread return. |
| home_team_odds_spread_record_wins | integer | Home team's team odds spread record wins. |
| home_team_odds_spread_record_losses | integer | Home team's team odds spread record losses. |
| home_team_odds_spread_record_pushes | integer | Home team's team odds spread record pushes. |
| home_team_odds_spread_record_summary | character | Home team's team odds spread record summary. |
| game_id | integer | Unique game identifier. |

**againstTheSpread**

|              |           |                                         |
|--------------|-----------|-----------------------------------------|
| col_name     | types     | description                             |
| id           | integer   | Id.                                     |
| uid          | character | ESPN UID string (universal identifier). |
| display_name | character | Display name.                           |
| abbreviation | character | Short abbreviation.                     |
| logo         | character | Team or league logo URL.                |
| logos        | list      | Logos.                                  |
| records      | list      | Records.                                |
| game_id      | integer   | Unique game identifier.                 |
| team_id      | integer   | Unique team identifier.                 |

**predictor**

|                           |         |                                      |
|---------------------------|---------|--------------------------------------|
| col_name                  | types   | description                          |
| game_id                   | integer | Unique game identifier.              |
| home_team_id              | integer | Unique identifier for the home team. |
| away_team_id              | integer | Unique identifier for the away team. |
| away_team_game_projection | numeric | Away team's team game projection.    |
| away_team_chance_loss     | numeric | Away team's team chance loss.        |

## See also

Other ESPN NBA Functions:
[`espn_nba_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_all.md),
[`espn_nba_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_nba_game_rosters.md),
[`espn_nba_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_pbp.md),
[`espn_nba_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_box.md),
[`espn_nba_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_player_stats.md),
[`espn_nba_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_nba_scoreboard.md),
[`espn_nba_standings()`](https://hoopR.sportsdataverse.org/reference/espn_nba_standings.md),
[`espn_nba_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_box.md),
[`espn_nba_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_current_roster.md),
[`espn_nba_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_nba_team_stats.md),
[`espn_nba_teams()`](https://hoopR.sportsdataverse.org/reference/espn_nba_teams.md),
[`espn_nba_wp()`](https://hoopR.sportsdataverse.org/reference/espn_nba_wp.md)

## Examples

``` r
# \donttest{
try(espn_nba_betting(game_id = 401283399))
#> ✖ 2026-05-17 15:42:32.596389: Invalid arguments or no betting data available!
#> ✖ Args: game_id = 401283399
#> ✖ Error: Can't select columns that don't exist. ✖ Column `links` doesn't exist.
#> $pickcenter
#> data frame with 0 columns and 0 rows
#> 
#> $againstTheSpread
#> data frame with 0 columns and 0 rows
#> 
#> $predictor
#> data frame with 0 columns and 0 rows
#> 
# }
```
