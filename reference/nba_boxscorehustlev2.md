# **Get NBA Stats API Boxscore Hustle V2**

**Get NBA Stats API Boxscore Hustle V2**

**Get NBA Stats API Boxscore Hustle V2**

## Usage

``` r
nba_boxscorehustlev2(game_id = "0022200021", ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: home_team_player_hustle,
away_team_player_hustle, home_team_hustle_totals,
away_team_hustle_totals

**home_team_player_hustle**

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
| points                          | integer   |
| contested_shots                 | integer   |
| contested_shots2pt              | integer   |
| contested_shots3pt              | integer   |
| deflections                     | integer   |
| charges_drawn                   | integer   |
| screen_assists                  | integer   |
| screen_assist_points            | integer   |
| loose_balls_recovered_offensive | integer   |
| loose_balls_recovered_defensive | integer   |
| loose_balls_recovered_total     | integer   |
| offensive_box_outs              | integer   |
| defensive_box_outs              | integer   |
| box_out_player_team_rebounds    | integer   |
| box_out_player_rebounds         | integer   |
| box_outs                        | integer   |

**away_team_player_hustle**

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
| points                          | integer   |
| contested_shots                 | integer   |
| contested_shots2pt              | integer   |
| contested_shots3pt              | integer   |
| deflections                     | integer   |
| charges_drawn                   | integer   |
| screen_assists                  | integer   |
| screen_assist_points            | integer   |
| loose_balls_recovered_offensive | integer   |
| loose_balls_recovered_defensive | integer   |
| loose_balls_recovered_total     | integer   |
| offensive_box_outs              | integer   |
| defensive_box_outs              | integer   |
| box_out_player_team_rebounds    | integer   |
| box_out_player_rebounds         | integer   |
| box_outs                        | integer   |

**home_team_totals_hustle**

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
| minutes                         | character |
| points                          | integer   |
| contested_shots                 | integer   |
| contested_shots2pt              | integer   |
| contested_shots3pt              | integer   |
| deflections                     | integer   |
| charges_drawn                   | integer   |
| screen_assists                  | integer   |
| screen_assist_points            | integer   |
| loose_balls_recovered_offensive | integer   |
| loose_balls_recovered_defensive | integer   |
| loose_balls_recovered_total     | integer   |
| offensive_box_outs              | integer   |
| defensive_box_outs              | integer   |
| box_out_player_team_rebounds    | integer   |
| box_out_player_rebounds         | integer   |
| box_outs                        | integer   |

**away_team_totals_hustle**

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
| minutes                         | character |
| points                          | integer   |
| contested_shots                 | integer   |
| contested_shots2pt              | integer   |
| contested_shots3pt              | integer   |
| deflections                     | integer   |
| charges_drawn                   | integer   |
| screen_assists                  | integer   |
| screen_assist_points            | integer   |
| loose_balls_recovered_offensive | integer   |
| loose_balls_recovered_defensive | integer   |
| loose_balls_recovered_total     | integer   |
| offensive_box_outs              | integer   |
| defensive_box_outs              | integer   |
| box_out_player_team_rebounds    | integer   |
| box_out_player_rebounds         | integer   |
| box_outs                        | integer   |

## Details

     nba_boxscorehustlev2(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoresummaryv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoresummaryv3.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
