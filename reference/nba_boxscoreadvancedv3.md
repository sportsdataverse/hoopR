# **Get NBA Stats API Boxscore Advanced V3**

**Get NBA Stats API Boxscore Advanced V3**

**Get NBA Stats API Boxscore Advanced V3**

## Usage

``` r
nba_boxscoreadvancedv3(
  game_id = "0022200021",
  start_period = 0,
  end_period = 14,
  start_range = 0,
  end_range = 0,
  range_type = 0,
  ...
)
```

## Arguments

- game_id:

  Game ID

- start_period:

  start_period

- end_period:

  end_period

- start_range:

  start_range

- end_range:

  end_range

- range_type:

  range_type

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

A list of data frames: home_team_player_advanced,
away_team_player_advanced, home_team_totals_advanced,
away_team_totals_advanced

**home_team_player_advanced**

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| game_id                         | character |
| away_team_id                    | integer   |
| home_team_id                    | integer   |
| team_id                         | integer   |
| team_name                       | character |
| team_city                       | character |
| team_tricode                    | character |
| team_slug                       | character |
| person_id                       | integer   |
| first_name                      | character |
| family_name                     | character |
| name_i                          | character |
| player_slug                     | character |
| position                        | character |
| comment                         | character |
| jersey_num                      | character |
| minutes                         | character |
| estimated_offensive_rating      | numeric   |
| offensive_rating                | numeric   |
| estimated_defensive_rating      | numeric   |
| defensive_rating                | numeric   |
| estimated_net_rating            | numeric   |
| net_rating                      | numeric   |
| assist_percentage               | numeric   |
| assist_to_turnover              | numeric   |
| assist_ratio                    | numeric   |
| offensive_rebound_percentage    | numeric   |
| defensive_rebound_percentage    | numeric   |
| rebound_percentage              | numeric   |
| turnover_ratio                  | numeric   |
| effective_field_goal_percentage | numeric   |
| true_shooting_percentage        | numeric   |
| usage_percentage                | numeric   |
| estimated_usage_percentage      | numeric   |
| estimated_pace                  | numeric   |
| pace                            | numeric   |
| pace_per40                      | numeric   |
| possessions                     | numeric   |
| pie                             | numeric   |

**away_team_player_advanced**

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| game_id                         | character |
| away_team_id                    | integer   |
| home_team_id                    | integer   |
| team_id                         | integer   |
| team_name                       | character |
| team_city                       | character |
| team_tricode                    | character |
| team_slug                       | character |
| person_id                       | integer   |
| first_name                      | character |
| family_name                     | character |
| name_i                          | character |
| player_slug                     | character |
| position                        | character |
| comment                         | character |
| jersey_num                      | character |
| minutes                         | character |
| estimated_offensive_rating      | numeric   |
| offensive_rating                | numeric   |
| estimated_defensive_rating      | numeric   |
| defensive_rating                | numeric   |
| estimated_net_rating            | numeric   |
| net_rating                      | numeric   |
| assist_percentage               | numeric   |
| assist_to_turnover              | numeric   |
| assist_ratio                    | numeric   |
| offensive_rebound_percentage    | numeric   |
| defensive_rebound_percentage    | numeric   |
| rebound_percentage              | numeric   |
| turnover_ratio                  | numeric   |
| effective_field_goal_percentage | numeric   |
| true_shooting_percentage        | numeric   |
| usage_percentage                | numeric   |
| estimated_usage_percentage      | numeric   |
| estimated_pace                  | numeric   |
| pace                            | numeric   |
| pace_per40                      | numeric   |
| possessions                     | numeric   |
| pie                             | numeric   |

**home_team_totals_advanced**

|                                    |           |
|------------------------------------|-----------|
| col_name                           | types     |
| game_id                            | character |
| away_team_id                       | integer   |
| home_team_id                       | integer   |
| team_id                            | integer   |
| team_name                          | character |
| team_city                          | character |
| team_tricode                       | character |
| team_slug                          | character |
| minutes                            | character |
| estimated_offensive_rating         | numeric   |
| offensive_rating                   | numeric   |
| estimated_defensive_rating         | numeric   |
| defensive_rating                   | numeric   |
| estimated_net_rating               | numeric   |
| net_rating                         | numeric   |
| assist_percentage                  | numeric   |
| assist_to_turnover                 | numeric   |
| assist_ratio                       | numeric   |
| offensive_rebound_percentage       | numeric   |
| defensive_rebound_percentage       | numeric   |
| rebound_percentage                 | numeric   |
| estimated_team_turnover_percentage | numeric   |
| turnover_ratio                     | numeric   |
| effective_field_goal_percentage    | numeric   |
| true_shooting_percentage           | numeric   |
| usage_percentage                   | numeric   |
| estimated_usage_percentage         | numeric   |
| estimated_pace                     | numeric   |
| pace                               | numeric   |
| pace_per40                         | numeric   |
| possessions                        | numeric   |
| pie                                | numeric   |

**away_team_totals_advanced**

|                                    |           |
|------------------------------------|-----------|
| col_name                           | types     |
| game_id                            | character |
| away_team_id                       | integer   |
| home_team_id                       | integer   |
| team_id                            | integer   |
| team_name                          | character |
| team_city                          | character |
| team_tricode                       | character |
| team_slug                          | character |
| minutes                            | character |
| estimated_offensive_rating         | numeric   |
| offensive_rating                   | numeric   |
| estimated_defensive_rating         | numeric   |
| defensive_rating                   | numeric   |
| estimated_net_rating               | numeric   |
| net_rating                         | numeric   |
| assist_percentage                  | numeric   |
| assist_to_turnover                 | numeric   |
| assist_ratio                       | numeric   |
| offensive_rebound_percentage       | numeric   |
| defensive_rebound_percentage       | numeric   |
| rebound_percentage                 | numeric   |
| estimated_team_turnover_percentage | numeric   |
| turnover_ratio                     | numeric   |
| effective_field_goal_percentage    | numeric   |
| true_shooting_percentage           | numeric   |
| usage_percentage                   | numeric   |
| estimated_usage_percentage         | numeric   |
| estimated_pace                     | numeric   |
| pace                               | numeric   |
| pace_per40                         | numeric   |
| possessions                        | numeric   |
| pie                                | numeric   |

## Details

     nba_boxscoreadvancedv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
