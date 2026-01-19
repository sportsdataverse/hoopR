# **Get NBA Stats API Boxscore Scoring V3**

**Get NBA Stats API Boxscore Scoring V3**

**Get NBA Stats API Boxscore Scoring V3**

## Usage

``` r
nba_boxscorescoringv3(
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

A list of data frames: home_team_player_scoring,
away_team_player_scoring, home_team_totals_scoring,
away_team_totals_scoring

**home_team_player_scoring**

|                                     |           |
|-------------------------------------|-----------|
| col_name                            | types     |
| game_id                             | character |
| away_team_id                        | integer   |
| home_team_id                        | integer   |
| team_id                             | integer   |
| team_name                           | character |
| team_city                           | character |
| team_tricode                        | character |
| team_slug                           | character |
| person_id                           | integer   |
| first_name                          | character |
| family_name                         | character |
| name_i                              | character |
| player_slug                         | character |
| position                            | character |
| comment                             | character |
| jersey_num                          | character |
| minutes                             | character |
| percentage_field_goals_attempted2pt | numeric   |
| percentage_field_goals_attempted3pt | numeric   |
| percentage_points2pt                | numeric   |
| percentage_points_midrange2pt       | numeric   |
| percentage_points3pt                | numeric   |
| percentage_points_fast_break        | numeric   |
| percentage_points_free_throw        | numeric   |
| percentage_points_off_turnovers     | numeric   |
| percentage_points_paint             | numeric   |
| percentage_assisted2pt              | numeric   |
| percentage_unassisted2pt            | numeric   |
| percentage_assisted3pt              | numeric   |
| percentage_unassisted3pt            | numeric   |
| percentage_assisted_fgm             | numeric   |
| percentage_unassisted_fgm           | numeric   |

**away_team_player_scoring**

|                                     |           |
|-------------------------------------|-----------|
| col_name                            | types     |
| game_id                             | character |
| away_team_id                        | integer   |
| home_team_id                        | integer   |
| team_id                             | integer   |
| team_name                           | character |
| team_city                           | character |
| team_tricode                        | character |
| team_slug                           | character |
| person_id                           | integer   |
| first_name                          | character |
| family_name                         | character |
| name_i                              | character |
| player_slug                         | character |
| position                            | character |
| comment                             | character |
| jersey_num                          | character |
| minutes                             | character |
| percentage_field_goals_attempted2pt | numeric   |
| percentage_field_goals_attempted3pt | numeric   |
| percentage_points2pt                | numeric   |
| percentage_points_midrange2pt       | numeric   |
| percentage_points3pt                | numeric   |
| percentage_points_fast_break        | numeric   |
| percentage_points_free_throw        | numeric   |
| percentage_points_off_turnovers     | numeric   |
| percentage_points_paint             | numeric   |
| percentage_assisted2pt              | numeric   |
| percentage_unassisted2pt            | numeric   |
| percentage_assisted3pt              | numeric   |
| percentage_unassisted3pt            | numeric   |
| percentage_assisted_fgm             | numeric   |
| percentage_unassisted_fgm           | numeric   |

**home_team_totals_scoring**

|                                     |           |
|-------------------------------------|-----------|
| col_name                            | types     |
| game_id                             | character |
| away_team_id                        | integer   |
| home_team_id                        | integer   |
| team_id                             | integer   |
| team_name                           | character |
| team_city                           | character |
| team_tricode                        | character |
| team_slug                           | character |
| minutes                             | character |
| percentage_field_goals_attempted2pt | numeric   |
| percentage_field_goals_attempted3pt | numeric   |
| percentage_points2pt                | numeric   |
| percentage_points_midrange2pt       | numeric   |
| percentage_points3pt                | numeric   |
| percentage_points_fast_break        | numeric   |
| percentage_points_free_throw        | numeric   |
| percentage_points_off_turnovers     | numeric   |
| percentage_points_paint             | numeric   |
| percentage_assisted2pt              | numeric   |
| percentage_unassisted2pt            | numeric   |
| percentage_assisted3pt              | numeric   |
| percentage_unassisted3pt            | numeric   |
| percentage_assisted_fgm             | numeric   |
| percentage_unassisted_fgm           | numeric   |

**away_team_totals_scoring**

|                                     |           |
|-------------------------------------|-----------|
| col_name                            | types     |
| game_id                             | character |
| away_team_id                        | integer   |
| home_team_id                        | integer   |
| team_id                             | integer   |
| team_name                           | character |
| team_city                           | character |
| team_tricode                        | character |
| team_slug                           | character |
| minutes                             | character |
| percentage_field_goals_attempted2pt | numeric   |
| percentage_field_goals_attempted3pt | numeric   |
| percentage_points2pt                | numeric   |
| percentage_points_midrange2pt       | numeric   |
| percentage_points3pt                | numeric   |
| percentage_points_fast_break        | numeric   |
| percentage_points_free_throw        | numeric   |
| percentage_points_off_turnovers     | numeric   |
| percentage_points_paint             | numeric   |
| percentage_assisted2pt              | numeric   |
| percentage_unassisted2pt            | numeric   |
| percentage_assisted3pt              | numeric   |
| percentage_unassisted3pt            | numeric   |
| percentage_assisted_fgm             | numeric   |
| percentage_unassisted_fgm           | numeric   |

## Details

     nba_boxscorescoringv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
