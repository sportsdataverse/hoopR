# **Get NBA Stats API Boxscore Summary V3**

**Get NBA Stats API Boxscore Summary V3**

**Get NBA Stats API Boxscore Summary V3**

## Usage

``` r
nba_boxscoresummaryv3(game_id = "0022200021", ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: GameSummary, GameInfo, ArenaInfo,
Officials, LineScore, InactivePlayers, LastFiveMeetings, OtherStats,
AvailableVideo

**GameSummary**

|                  |           |
|------------------|-----------|
| col_name         | types     |
| game_id          | character |
| game_code        | character |
| game_status      | integer   |
| game_status_text | character |
| period           | integer   |
| game_clock       | character |
| game_time_utc    | character |
| game_et          | character |
| away_team_id     | integer   |
| home_team_id     | integer   |
| duration         | integer   |
| attendance       | integer   |
| sellout          | character |

**GameInfo**

|               |           |
|---------------|-----------|
| col_name      | types     |
| game_id       | character |
| game_date     | character |
| attendance    | integer   |
| game_duration | integer   |

**ArenaInfo**

|                |           |
|----------------|-----------|
| col_name       | types     |
| game_id        | character |
| arena_id       | integer   |
| arena_name     | character |
| arena_city     | character |
| arena_state    | character |
| arena_country  | character |
| arena_timezone | character |

**Officials**

|             |           |
|-------------|-----------|
| col_name    | types     |
| game_id     | character |
| person_id   | integer   |
| name        | character |
| name_i      | character |
| first_name  | character |
| family_name | character |
| jersey_num  | character |

**LineScore**

|               |           |
|---------------|-----------|
| col_name      | types     |
| game_id       | character |
| team_id       | integer   |
| team_city     | character |
| team_name     | character |
| team_tricode  | character |
| team_slug     | character |
| team_wins     | integer   |
| team_losses   | integer   |
| period1_score | integer   |
| period2_score | integer   |
| period3_score | integer   |
| period4_score | integer   |
| score         | integer   |

**InactivePlayers**

|             |           |
|-------------|-----------|
| col_name    | types     |
| game_id     | character |
| team_id     | integer   |
| person_id   | integer   |
| first_name  | character |
| family_name | character |
| jersey_num  | character |

**LastFiveMeetings**

|                   |           |
|-------------------|-----------|
| col_name          | types     |
| recency_order     | integer   |
| game_id           | character |
| game_time_utc     | character |
| game_et           | character |
| game_status       | integer   |
| game_status_text  | character |
| away_team_id      | integer   |
| away_team_city    | character |
| away_team_name    | character |
| away_team_tricode | character |
| away_team_score   | integer   |
| away_team_wins    | integer   |
| away_team_losses  | integer   |
| home_team_id      | integer   |
| home_team_city    | character |
| home_team_name    | character |
| home_team_tricode | character |
| home_team_score   | integer   |
| home_team_wins    | integer   |
| home_team_losses  | integer   |

**OtherStats**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| game_id                   | character |
| team_id                   | integer   |
| team_city                 | character |
| team_name                 | character |
| team_tricode              | character |
| points                    | integer   |
| rebounds_total            | integer   |
| assists                   | integer   |
| steals                    | integer   |
| blocks                    | integer   |
| turnovers                 | integer   |
| field_goals_percentage    | numeric   |
| three_pointers_percentage | numeric   |
| free_throws_percentage    | numeric   |
| points_in_the_paint       | integer   |
| points_second_chance      | integer   |
| points_fast_break         | integer   |
| biggest_lead              | integer   |
| lead_changes              | integer   |
| times_tied                | integer   |
| biggest_scoring_run       | integer   |
| turnovers_team            | integer   |
| turnovers_total           | integer   |
| rebounds_team             | integer   |
| points_from_turnovers     | integer   |
| bench_points              | integer   |

**AvailableVideo**

|                      |           |
|----------------------|-----------|
| col_name             | types     |
| game_id              | character |
| video_available_flag | integer   |
| pt_available         | integer   |
| pt_xyz_available     | integer   |
| wh_status            | integer   |
| hustle_status        | integer   |
| historical_status    | integer   |

## Details

     nba_boxscoresummaryv3(game_id = "0022200021")

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
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md),
[`nba_boxscoreusagev3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoreusagev3.md)

## Author

Saiem Gilani
