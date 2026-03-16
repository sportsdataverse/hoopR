# **Get NBA Stats API Boxscore Player Tracking V3**

**Get NBA Stats API Boxscore Player Tracking V3**

**Get NBA Stats API Boxscore Player Tracking V3**

## Usage

``` r
nba_boxscoreplayertrackv3(
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

Returns a named list of data frames: home_team_player_player_track,
away_team_player_player_track, home_team_totals_player_track,
away_team_totals_player_track

**home_team_player_player_track**

|                                       |           |
|---------------------------------------|-----------|
| col_name                              | types     |
| game_id                               | character |
| away_team_id                          | integer   |
| home_team_id                          | integer   |
| team_id                               | integer   |
| team_name                             | character |
| team_city                             | character |
| team_tricode                          | character |
| team_slug                             | character |
| person_id                             | integer   |
| first_name                            | character |
| family_name                           | character |
| name_i                                | character |
| player_slug                           | character |
| position                              | character |
| comment                               | character |
| jersey_num                            | character |
| minutes                               | character |
| speed                                 | numeric   |
| distance                              | numeric   |
| rebound_chances_offensive             | integer   |
| rebound_chances_defensive             | integer   |
| rebound_chances_total                 | integer   |
| touches                               | integer   |
| secondary_assists                     | integer   |
| free_throw_assists                    | integer   |
| passes                                | integer   |
| assists                               | integer   |
| contested_field_goals_made            | integer   |
| contested_field_goals_attempted       | integer   |
| contested_field_goal_percentage       | numeric   |
| uncontested_field_goals_made          | integer   |
| uncontested_field_goals_attempted     | integer   |
| uncontested_field_goals_percentage    | numeric   |
| field_goal_percentage                 | numeric   |
| defended_at_rim_field_goals_made      | integer   |
| defended_at_rim_field_goals_attempted | integer   |
| defended_at_rim_field_goal_percentage | numeric   |

**away_team_player_player_track**

|                                       |           |
|---------------------------------------|-----------|
| col_name                              | types     |
| game_id                               | character |
| away_team_id                          | integer   |
| home_team_id                          | integer   |
| team_id                               | integer   |
| team_name                             | character |
| team_city                             | character |
| team_tricode                          | character |
| team_slug                             | character |
| person_id                             | integer   |
| first_name                            | character |
| family_name                           | character |
| name_i                                | character |
| player_slug                           | character |
| position                              | character |
| comment                               | character |
| jersey_num                            | character |
| minutes                               | character |
| speed                                 | numeric   |
| distance                              | numeric   |
| rebound_chances_offensive             | integer   |
| rebound_chances_defensive             | integer   |
| rebound_chances_total                 | integer   |
| touches                               | integer   |
| secondary_assists                     | integer   |
| free_throw_assists                    | integer   |
| passes                                | integer   |
| assists                               | integer   |
| contested_field_goals_made            | integer   |
| contested_field_goals_attempted       | integer   |
| contested_field_goal_percentage       | numeric   |
| uncontested_field_goals_made          | integer   |
| uncontested_field_goals_attempted     | integer   |
| uncontested_field_goals_percentage    | numeric   |
| field_goal_percentage                 | numeric   |
| defended_at_rim_field_goals_made      | integer   |
| defended_at_rim_field_goals_attempted | integer   |
| defended_at_rim_field_goal_percentage | numeric   |

**home_team_totals_player_track**

|                                       |           |
|---------------------------------------|-----------|
| col_name                              | types     |
| game_id                               | character |
| away_team_id                          | integer   |
| home_team_id                          | integer   |
| team_id                               | integer   |
| team_name                             | character |
| team_city                             | character |
| team_tricode                          | character |
| team_slug                             | character |
| minutes                               | character |
| distance                              | numeric   |
| rebound_chances_offensive             | integer   |
| rebound_chances_defensive             | integer   |
| rebound_chances_total                 | integer   |
| touches                               | integer   |
| secondary_assists                     | integer   |
| free_throw_assists                    | integer   |
| passes                                | integer   |
| assists                               | integer   |
| contested_field_goals_made            | integer   |
| contested_field_goals_attempted       | integer   |
| contested_field_goal_percentage       | numeric   |
| uncontested_field_goals_made          | integer   |
| uncontested_field_goals_attempted     | integer   |
| uncontested_field_goals_percentage    | numeric   |
| field_goal_percentage                 | numeric   |
| defended_at_rim_field_goals_made      | integer   |
| defended_at_rim_field_goals_attempted | integer   |
| defended_at_rim_field_goal_percentage | numeric   |

**away_team_totals_player_track**

|                                       |           |
|---------------------------------------|-----------|
| col_name                              | types     |
| game_id                               | character |
| away_team_id                          | integer   |
| home_team_id                          | integer   |
| team_id                               | integer   |
| team_name                             | character |
| team_city                             | character |
| team_tricode                          | character |
| team_slug                             | character |
| minutes                               | character |
| distance                              | numeric   |
| rebound_chances_offensive             | integer   |
| rebound_chances_defensive             | integer   |
| rebound_chances_total                 | integer   |
| touches                               | integer   |
| secondary_assists                     | integer   |
| free_throw_assists                    | integer   |
| passes                                | integer   |
| assists                               | integer   |
| contested_field_goals_made            | integer   |
| contested_field_goals_attempted       | integer   |
| contested_field_goal_percentage       | numeric   |
| uncontested_field_goals_made          | integer   |
| uncontested_field_goals_attempted     | integer   |
| uncontested_field_goals_percentage    | numeric   |
| field_goal_percentage                 | numeric   |
| defended_at_rim_field_goals_made      | integer   |
| defended_at_rim_field_goals_attempted | integer   |
| defended_at_rim_field_goal_percentage | numeric   |

## Details

     nba_boxscoreplayertrackv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
