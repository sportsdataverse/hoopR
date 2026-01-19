# **Get NBA Stats API Boxscore Traditional V3**

**Get NBA Stats API Boxscore Traditional V3**

**Get NBA Stats API Boxscore Traditional V3**

## Usage

``` r
nba_boxscoretraditionalv3(
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

A list of data frames: home_team_player_traditional,
away_team_player_traditional, home_team_totals_traditional,
away_team_totals_traditional, home_team_starters_totals,
away_team_starters_totals, home_team_bench_totals,
away_team_bench_totals

**home_team_player_traditional**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| person_id                 | integer   |
| first_name                | character |
| family_name               | character |
| name_i                    | character |
| player_slug               | character |
| position                  | character |
| comment                   | character |
| jersey_num                | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |
| plus_minus_points         | numeric   |

**away_team_player_traditional**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| person_id                 | integer   |
| first_name                | character |
| family_name               | character |
| name_i                    | character |
| player_slug               | character |
| position                  | character |
| comment                   | character |
| jersey_num                | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |
| plus_minus_points         | numeric   |

**home_team_totals_traditional**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |
| plus_minus_points         | numeric   |

**away_team_totals_traditional**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |
| plus_minus_points         | numeric   |

**home_team_starters_totals**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |

**away_team_starters_totals**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |

**home_team_bench_totals**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |

**away_team_bench_totals**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| away_team_id              | integer   |
| home_team_id              | integer   |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_slug                 | character |
| minutes                   | character |
| field_goals_made          | integer   |
| field_goals_attempted     | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_made       | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_percentage | numeric   |
| free_throws_made          | integer   |
| free_throws_attempted     | integer   |
| free_throws_percentage    | numeric   |
| rebounds_offensive        | integer   |
| rebounds_defensive        | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| fouls_personal            | integer   |
| points                    | integer   |

## Details

     nba_boxscoretraditionalv3(game_id = "0022200021")

## See also

Other NBA Boxscore V3 Functions:
[`nba_boxscoreadvancedv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreadvancedv3.md),
[`nba_boxscoredefensivev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoredefensivev2.md),
[`nba_boxscorefourfactorsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorefourfactorsv3.md),
[`nba_boxscorehustlev2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorehustlev2.md),
[`nba_boxscorematchupsv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorematchupsv3.md),
[`nba_boxscoremiscv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoremiscv3.md),
[`nba_boxscoreplayertrackv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreplayertrackv3.md),
[`nba_boxscorescoringv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscorescoringv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
