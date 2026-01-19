# **Get NBA Stats API Boxscore Matchups V3**

**Get NBA Stats API Boxscore Matchups V3**

**Get NBA Stats API Boxscore Matchups V3**

## Usage

``` r
nba_boxscorematchupsv3(
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

A list of data frames: home_team_player_matchups,
away_team_player_matchups

**home_team_player_matchups**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | character |
| away_team_id                      | integer   |
| home_team_id                      | integer   |
| team_id                           | integer   |
| team_name                         | character |
| team_city                         | character |
| team_tricode                      | character |
| team_slug                         | character |
| person_id                         | integer   |
| first_name                        | character |
| family_name                       | character |
| name_i                            | character |
| player_slug                       | character |
| position                          | character |
| comment                           | character |
| jersey_num                        | character |
| matchups_person_id                | integer   |
| matchups_first_name               | character |
| matchups_family_name              | character |
| matchups_name_i                   | character |
| matchups_player_slug              | character |
| matchups_jersey_num               | character |
| matchup_minutes                   | character |
| matchup_minutes_sort              | numeric   |
| partial_possessions               | numeric   |
| percentage_defender_total_time    | numeric   |
| percentage_offensive_total_time   | numeric   |
| percentage_total_time_both_on     | numeric   |
| switches_on                       | integer   |
| player_points                     | integer   |
| team_points                       | integer   |
| matchup_assists                   | integer   |
| matchup_potential_assists         | integer   |
| matchup_turnovers                 | integer   |
| matchup_blocks                    | integer   |
| matchup_field_goals_made          | integer   |
| matchup_field_goals_attempted     | integer   |
| matchup_field_goals_percentage    | numeric   |
| matchup_three_pointers_made       | integer   |
| matchup_three_pointers_attempted  | integer   |
| matchup_three_pointers_percentage | numeric   |
| help_blocks                       | integer   |
| help_field_goals_made             | integer   |
| help_field_goals_attempted        | integer   |
| help_field_goals_percentage       | numeric   |
| matchup_free_throws_made          | integer   |
| matchup_free_throws_attempted     | integer   |
| shooting_fouls                    | integer   |

**away_team_player_matchups**

|                                   |           |
|-----------------------------------|-----------|
| col_name                          | types     |
| game_id                           | character |
| away_team_id                      | integer   |
| home_team_id                      | integer   |
| team_id                           | integer   |
| team_name                         | character |
| team_city                         | character |
| team_tricode                      | character |
| team_slug                         | character |
| person_id                         | integer   |
| first_name                        | character |
| family_name                       | character |
| name_i                            | character |
| player_slug                       | character |
| position                          | character |
| comment                           | character |
| jersey_num                        | character |
| matchups_person_id                | integer   |
| matchups_first_name               | character |
| matchups_family_name              | character |
| matchups_name_i                   | character |
| matchups_player_slug              | character |
| matchups_jersey_num               | character |
| matchup_minutes                   | character |
| matchup_minutes_sort              | numeric   |
| partial_possessions               | numeric   |
| percentage_defender_total_time    | numeric   |
| percentage_offensive_total_time   | numeric   |
| percentage_total_time_both_on     | numeric   |
| switches_on                       | integer   |
| player_points                     | integer   |
| team_points                       | integer   |
| matchup_assists                   | integer   |
| matchup_potential_assists         | integer   |
| matchup_turnovers                 | integer   |
| matchup_blocks                    | integer   |
| matchup_field_goals_made          | integer   |
| matchup_field_goals_attempted     | integer   |
| matchup_field_goals_percentage    | numeric   |
| matchup_three_pointers_made       | integer   |
| matchup_three_pointers_attempted  | integer   |
| matchup_three_pointers_percentage | numeric   |
| help_blocks                       | integer   |
| help_field_goals_made             | integer   |
| help_field_goals_attempted        | integer   |
| help_field_goals_percentage       | numeric   |
| matchup_free_throws_made          | integer   |
| matchup_free_throws_attempted     | integer   |
| shooting_fouls                    | integer   |

## Details

     nba_boxscorematchupsv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
