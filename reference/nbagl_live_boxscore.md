# **Get NBA G-League Stats API Live Boxscore**

**Get NBA G-League Stats API Live Boxscore**

**Get NBA G-League Stats API Live Boxscore**

## Usage

``` r
nbagl_live_boxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: game_details, arena, officials,
home_team_boxscore, away_team_boxscore, home_team_player_boxscore,
away_team_player_boxscore, home_team_linescores, away_team_linescores

**game_details**

|                              |           |
|------------------------------|-----------|
| col_name                     | types     |
| game_id                      | character |
| game_time_local              | character |
| game_time_utc                | character |
| game_time_home               | character |
| game_time_away               | character |
| game_et                      | character |
| duration                     | integer   |
| game_code                    | character |
| game_status_text             | character |
| game_status                  | integer   |
| regulation_periods           | integer   |
| period                       | integer   |
| game_clock                   | character |
| attendance                   | integer   |
| sellout                      | character |
| home_team_id                 | integer   |
| home_team_name               | character |
| home_team_city               | character |
| home_team_tricode            | character |
| home_team_score              | integer   |
| home_team_in_bonus           | character |
| home_team_timeouts_remaining | integer   |
| away_team_id                 | integer   |
| away_team_name               | character |
| away_team_city               | character |
| away_team_tricode            | character |
| away_team_score              | integer   |
| away_team_in_bonus           | character |
| away_team_timeouts_remaining | integer   |

**arena**

|                |           |
|----------------|-----------|
| col_name       | types     |
| arena_id       | integer   |
| arena_name     | character |
| arena_city     | character |
| arena_state    | character |
| arena_country  | character |
| arena_timezone | character |

**officials**

|             |           |
|-------------|-----------|
| col_name    | types     |
| person_id   | integer   |
| name        | character |
| name_i      | character |
| first_name  | character |
| family_name | character |
| jersey_num  | character |
| assignment  | character |

**home_team_boxscore**

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| team_id                         | integer   |
| team_name                       | character |
| team_city                       | character |
| team_tricode                    | character |
| team_score                      | integer   |
| team_in_bonus                   | character |
| team_timeouts_remaining         | integer   |
| assists                         | integer   |
| assists_turnover_ratio          | numeric   |
| bench_points                    | integer   |
| biggest_lead                    | integer   |
| biggest_lead_score              | character |
| biggest_scoring_run             | integer   |
| biggest_scoring_run_score       | character |
| blocks                          | integer   |
| blocks_received                 | integer   |
| fast_break_points_attempted     | integer   |
| fast_break_points_made          | integer   |
| fast_break_points_percentage    | numeric   |
| field_goals_attempted           | integer   |
| field_goals_effective_adjusted  | numeric   |
| field_goals_made                | integer   |
| field_goals_percentage          | numeric   |
| fouls_offensive                 | integer   |
| fouls_drawn                     | integer   |
| fouls_personal                  | integer   |
| fouls_team                      | integer   |
| fouls_technical                 | integer   |
| fouls_team_technical            | integer   |
| free_throws_attempted           | integer   |
| free_throws_made                | integer   |
| free_throws_percentage          | numeric   |
| lead_changes                    | integer   |
| minutes                         | character |
| minutes_calculated              | character |
| points                          | integer   |
| points_against                  | integer   |
| points_fast_break               | integer   |
| points_from_turnovers           | integer   |
| points_in_the_paint             | integer   |
| points_in_the_paint_attempted   | integer   |
| points_in_the_paint_made        | integer   |
| points_in_the_paint_percentage  | numeric   |
| points_second_chance            | integer   |
| rebounds_defensive              | integer   |
| rebounds_offensive              | integer   |
| rebounds_personal               | integer   |
| rebounds_team                   | integer   |
| rebounds_team_defensive         | integer   |
| rebounds_team_offensive         | integer   |
| rebounds_total                  | integer   |
| second_chance_points_attempted  | integer   |
| second_chance_points_made       | integer   |
| second_chance_points_percentage | numeric   |
| steals                          | integer   |
| three_pointers_attempted        | integer   |
| three_pointers_made             | integer   |
| three_pointers_percentage       | numeric   |
| time_leading                    | character |
| times_tied                      | integer   |
| true_shooting_attempts          | numeric   |
| true_shooting_percentage        | numeric   |
| turnovers                       | integer   |
| turnovers_team                  | integer   |
| turnovers_total                 | integer   |
| two_pointers_attempted          | integer   |
| two_pointers_made               | integer   |
| two_pointers_percentage         | numeric   |

**away_team_boxscore**

|                                 |           |
|---------------------------------|-----------|
| col_name                        | types     |
| team_id                         | integer   |
| team_name                       | character |
| team_city                       | character |
| team_tricode                    | character |
| team_score                      | integer   |
| team_in_bonus                   | character |
| team_timeouts_remaining         | integer   |
| assists                         | integer   |
| assists_turnover_ratio          | numeric   |
| bench_points                    | integer   |
| biggest_lead                    | integer   |
| biggest_lead_score              | character |
| biggest_scoring_run             | integer   |
| biggest_scoring_run_score       | character |
| blocks                          | integer   |
| blocks_received                 | integer   |
| fast_break_points_attempted     | integer   |
| fast_break_points_made          | integer   |
| fast_break_points_percentage    | numeric   |
| field_goals_attempted           | integer   |
| field_goals_effective_adjusted  | numeric   |
| field_goals_made                | integer   |
| field_goals_percentage          | numeric   |
| fouls_offensive                 | integer   |
| fouls_drawn                     | integer   |
| fouls_personal                  | integer   |
| fouls_team                      | integer   |
| fouls_technical                 | integer   |
| fouls_team_technical            | integer   |
| free_throws_attempted           | integer   |
| free_throws_made                | integer   |
| free_throws_percentage          | numeric   |
| lead_changes                    | integer   |
| minutes                         | character |
| minutes_calculated              | character |
| points                          | integer   |
| points_against                  | integer   |
| points_fast_break               | integer   |
| points_from_turnovers           | integer   |
| points_in_the_paint             | integer   |
| points_in_the_paint_attempted   | integer   |
| points_in_the_paint_made        | integer   |
| points_in_the_paint_percentage  | numeric   |
| points_second_chance            | integer   |
| rebounds_defensive              | integer   |
| rebounds_offensive              | integer   |
| rebounds_personal               | integer   |
| rebounds_team                   | integer   |
| rebounds_team_defensive         | integer   |
| rebounds_team_offensive         | integer   |
| rebounds_total                  | integer   |
| second_chance_points_attempted  | integer   |
| second_chance_points_made       | integer   |
| second_chance_points_percentage | numeric   |
| steals                          | integer   |
| three_pointers_attempted        | integer   |
| three_pointers_made             | integer   |
| three_pointers_percentage       | numeric   |
| time_leading                    | character |
| times_tied                      | integer   |
| true_shooting_attempts          | numeric   |
| true_shooting_percentage        | numeric   |
| turnovers                       | integer   |
| turnovers_team                  | integer   |
| turnovers_total                 | integer   |
| two_pointers_attempted          | integer   |
| two_pointers_made               | integer   |
| two_pointers_percentage         | numeric   |

**home_team_player_boxscore**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_score                | integer   |
| team_in_bonus             | character |
| team_timeouts_remaining   | integer   |
| status                    | character |
| order                     | integer   |
| person_id                 | integer   |
| jersey_num                | character |
| position                  | character |
| starter                   | character |
| oncourt                   | character |
| played                    | character |
| assists                   | integer   |
| blocks                    | integer   |
| blocks_received           | integer   |
| field_goals_attempted     | integer   |
| field_goals_made          | integer   |
| field_goals_percentage    | numeric   |
| fouls_offensive           | integer   |
| fouls_drawn               | integer   |
| fouls_personal            | integer   |
| fouls_technical           | integer   |
| free_throws_attempted     | integer   |
| free_throws_made          | integer   |
| free_throws_percentage    | numeric   |
| minus                     | numeric   |
| minutes                   | character |
| minutes_calculated        | character |
| plus                      | numeric   |
| plus_minus_points         | numeric   |
| points                    | integer   |
| points_fast_break         | integer   |
| points_in_the_paint       | integer   |
| points_second_chance      | integer   |
| rebounds_defensive        | integer   |
| rebounds_offensive        | integer   |
| rebounds_total            | integer   |
| steals                    | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_made       | integer   |
| three_pointers_percentage | numeric   |
| turnovers                 | integer   |
| two_pointers_attempted    | integer   |
| two_pointers_made         | integer   |
| two_pointers_percentage   | numeric   |
| name                      | character |
| name_i                    | character |
| first_name                | character |
| family_name               | character |
| not_playing_reason        | character |
| not_playing_description   | character |

**away_team_player_boxscore**

|                           |           |
|---------------------------|-----------|
| col_name                  | types     |
| team_id                   | integer   |
| team_name                 | character |
| team_city                 | character |
| team_tricode              | character |
| team_score                | integer   |
| team_in_bonus             | character |
| team_timeouts_remaining   | integer   |
| status                    | character |
| order                     | integer   |
| person_id                 | integer   |
| jersey_num                | character |
| position                  | character |
| starter                   | character |
| oncourt                   | character |
| played                    | character |
| assists                   | integer   |
| blocks                    | integer   |
| blocks_received           | integer   |
| field_goals_attempted     | integer   |
| field_goals_made          | integer   |
| field_goals_percentage    | numeric   |
| fouls_offensive           | integer   |
| fouls_drawn               | integer   |
| fouls_personal            | integer   |
| fouls_technical           | integer   |
| free_throws_attempted     | integer   |
| free_throws_made          | integer   |
| free_throws_percentage    | numeric   |
| minus                     | numeric   |
| minutes                   | character |
| minutes_calculated        | character |
| plus                      | numeric   |
| plus_minus_points         | numeric   |
| points                    | integer   |
| points_fast_break         | integer   |
| points_in_the_paint       | integer   |
| points_second_chance      | integer   |
| rebounds_defensive        | integer   |
| rebounds_offensive        | integer   |
| rebounds_total            | integer   |
| steals                    | integer   |
| three_pointers_attempted  | integer   |
| three_pointers_made       | integer   |
| three_pointers_percentage | numeric   |
| turnovers                 | integer   |
| two_pointers_attempted    | integer   |
| two_pointers_made         | integer   |
| two_pointers_percentage   | numeric   |
| name                      | character |
| name_i                    | character |
| first_name                | character |
| family_name               | character |
| not_playing_reason        | character |
| not_playing_description   | character |

**home_team_linescores**

|             |           |
|-------------|-----------|
| col_name    | types     |
| period      | integer   |
| period_type | character |
| score       | integer   |

**away_team_linescores**

|             |           |
|-------------|-----------|
| col_name    | types     |
| period      | integer   |
| period_type | character |
| score       | integer   |

## Details

     nbagl_live_boxscore(game_id = "2052500034")

## See also

Other NBA G-League Functions:
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Saiem Gilani
