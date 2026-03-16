# **Get NBA Stats API Boxscore Defensive V2**

**Get NBA Stats API Boxscore Defensive V2**

**Get NBA Stats API Boxscore Defensive V2**

## Usage

``` r
nba_boxscoredefensivev2(
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

  Start period filter - default: 0

- end_period:

  End period filter - default: 0

- start_range:

  Start range filter (in tenths of a second) - default: 0

- end_range:

  End range filter (in tenths of a second) - default: 0

- range_type:

  Range type - 0: by half, 1: by period, 2: custom range

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: home_team_player_defensive,
away_team_player_defensive, home_team_totals_defensive,
away_team_totals_defensive

**home_team_player_defensive**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| game_id                          | character |
| away_team_id                     | integer   |
| home_team_id                     | integer   |
| team_id                          | integer   |
| team_name                        | character |
| team_city                        | character |
| team_tricode                     | character |
| team_slug                        | character |
| person_id                        | integer   |
| first_name                       | character |
| family_name                      | character |
| name_i                           | character |
| player_slug                      | character |
| position                         | character |
| comment                          | character |
| jersey_num                       | character |
| matchup_minutes                  | character |
| partial_possessions              | numeric   |
| switches_on                      | integer   |
| player_points                    | integer   |
| defensive_rebounds               | integer   |
| matchup_assists                  | integer   |
| matchup_turnovers                | integer   |
| steals                           | integer   |
| blocks                           | integer   |
| matchup_field_goals_made         | integer   |
| matchup_field_goals_attempted    | integer   |
| matchup_field_goal_percentage    | numeric   |
| matchup_three_pointers_made      | integer   |
| matchup_three_pointers_attempted | integer   |
| matchup_three_pointer_percentage | numeric   |

**away_team_player_defensive**

|                                  |           |
|----------------------------------|-----------|
| col_name                         | types     |
| game_id                          | character |
| away_team_id                     | integer   |
| home_team_id                     | integer   |
| team_id                          | integer   |
| team_name                        | character |
| team_city                        | character |
| team_tricode                     | character |
| team_slug                        | character |
| person_id                        | integer   |
| first_name                       | character |
| family_name                      | character |
| name_i                           | character |
| player_slug                      | character |
| position                         | character |
| comment                          | character |
| jersey_num                       | character |
| matchup_minutes                  | character |
| partial_possessions              | numeric   |
| switches_on                      | integer   |
| player_points                    | integer   |
| defensive_rebounds               | integer   |
| matchup_assists                  | integer   |
| matchup_turnovers                | integer   |
| steals                           | integer   |
| blocks                           | integer   |
| matchup_field_goals_made         | integer   |
| matchup_field_goals_attempted    | integer   |
| matchup_field_goal_percentage    | numeric   |
| matchup_three_pointers_made      | integer   |
| matchup_three_pointers_attempted | integer   |
| matchup_three_pointer_percentage | numeric   |

**home_team_totals_defensive**

|              |           |
|--------------|-----------|
| col_name     | types     |
| game_id      | character |
| away_team_id | integer   |
| home_team_id | integer   |
| team_id      | integer   |
| team_name    | character |
| team_city    | character |
| team_tricode | character |
| team_slug    | character |

**away_team_totals_defensive**

|              |           |
|--------------|-----------|
| col_name     | types     |
| game_id      | character |
| away_team_id | integer   |
| home_team_id | integer   |
| team_id      | integer   |
| team_name    | character |
| team_city    | character |
| team_tricode | character |
| team_slug    | character |

## Details

     nba_boxscoredefensivev2(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
