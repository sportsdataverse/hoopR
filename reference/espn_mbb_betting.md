# **Get ESPN MBB's Betting information**

**Get ESPN MBB's Betting information**

## Usage

``` r
espn_mbb_betting(game_id)
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

Other ESPN MBB Functions:
[`espn_mbb_conferences()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_conferences.md),
[`espn_mbb_game_all()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_all.md),
[`espn_mbb_game_rosters()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_game_rosters.md),
[`espn_mbb_pbp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_pbp.md),
[`espn_mbb_player_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_box.md),
[`espn_mbb_player_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_player_stats.md),
[`espn_mbb_rankings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_rankings.md),
[`espn_mbb_scoreboard()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_scoreboard.md),
[`espn_mbb_standings()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_standings.md),
[`espn_mbb_team_box()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_box.md),
[`espn_mbb_team_current_roster()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_current_roster.md),
[`espn_mbb_team_stats()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_team_stats.md),
[`espn_mbb_teams()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_teams.md),
[`espn_mbb_wp()`](https://hoopR.sportsdataverse.org/reference/espn_mbb_wp.md)

## Examples

``` r
# \donttest{
try(espn_mbb_betting(game_id = 401256760))
#> 2026-03-24 04:17:37.657546: Invalid arguments or no betting data available!
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
