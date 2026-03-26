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

|                                      |           |
|--------------------------------------|-----------|
| col_name                             | types     |
| details                              | character |
| over_under                           | numeric   |
| spread                               | numeric   |
| provider_id                          | integer   |
| provider_name                        | character |
| provider_priority                    | integer   |
| away_team_odds_favorite              | logical   |
| away_team_odds_underdog              | logical   |
| away_team_odds_money_line            | integer   |
| away_team_odds_spread_odds           | numeric   |
| away_team_odds_team_id               | integer   |
| away_team_odds_win_percentage        | numeric   |
| away_team_odds_average_score         | numeric   |
| away_team_odds_money_line_odds       | numeric   |
| away_team_odds_spread_return         | numeric   |
| away_team_odds_spread_record_wins    | integer   |
| away_team_odds_spread_record_losses  | integer   |
| away_team_odds_spread_record_pushes  | integer   |
| away_team_odds_spread_record_summary | character |
| home_team_odds_favorite              | logical   |
| home_team_odds_underdog              | logical   |
| home_team_odds_money_line            | integer   |
| home_team_odds_spread_odds           | numeric   |
| home_team_odds_team_id               | integer   |
| home_team_odds_win_percentage        | numeric   |
| home_team_odds_average_score         | numeric   |
| home_team_odds_money_line_odds       | numeric   |
| home_team_odds_spread_return         | numeric   |
| home_team_odds_spread_record_wins    | integer   |
| home_team_odds_spread_record_losses  | integer   |
| home_team_odds_spread_record_pushes  | integer   |
| home_team_odds_spread_record_summary | character |
| game_id                              | integer   |

**againstTheSpread**

|              |           |
|--------------|-----------|
| col_name     | types     |
| id           | integer   |
| uid          | character |
| display_name | character |
| abbreviation | character |
| logo         | character |
| logos        | list      |
| records      | list      |
| game_id      | integer   |
| team_id      | integer   |

**predictor**

|                           |         |
|---------------------------|---------|
| col_name                  | types   |
| game_id                   | integer |
| home_team_id              | integer |
| away_team_id              | integer |
| away_team_game_projection | numeric |
| away_team_chance_loss     | numeric |

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
#> 2026-03-26 14:51:02.371845: Invalid arguments or no betting data available!
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
