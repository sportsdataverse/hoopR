# **Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live play-by-play**

## Usage

``` r
nba_live_pbp(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

|                              |           |
|------------------------------|-----------|
| col_name                     | types     |
| event_num                    | integer   |
| clock                        | character |
| time_actual                  | character |
| period                       | integer   |
| period_type                  | character |
| action_type                  | character |
| sub_type                     | character |
| qualifiers                   | list      |
| player1_id                   | integer   |
| x                            | numeric   |
| y                            | numeric   |
| offense_team_id              | integer   |
| home_score                   | character |
| away_score                   | character |
| edited                       | character |
| order                        | integer   |
| is_target_score_last_period  | logical   |
| x_legacy                     | integer   |
| y_legacy                     | integer   |
| is_field_goal                | integer   |
| side                         | character |
| description                  | character |
| person_ids_filter            | list      |
| team_id                      | integer   |
| team_tricode                 | character |
| descriptor                   | character |
| jump_ball_recovered_name     | character |
| jump_ball_recoverd_person_id | integer   |
| player_name                  | character |
| player_name_i                | character |
| jump_ball_won_player_name    | character |
| jump_ball_won_person_id      | integer   |
| jump_ball_lost_player_name   | character |
| jump_ball_lost_person_id     | integer   |
| area                         | character |
| area_detail                  | character |
| shot_distance                | numeric   |
| shot_result                  | character |
| points_total                 | integer   |
| assist_player_name_initial   | character |
| assist_person_id             | integer   |
| assist_total                 | integer   |
| shot_action_number           | integer   |
| rebound_total                | integer   |
| rebound_defensive_total      | integer   |
| rebound_offensive_total      | integer   |
| official_id                  | integer   |
| foul_personal_total          | integer   |
| foul_technical_total         | integer   |
| foul_drawn_player_name       | character |
| foul_drawn_person_id         | integer   |
| block_player_name            | character |
| block_person_id              | integer   |
| turnover_total               | integer   |
| steal_player_name            | character |
| steal_person_id              | integer   |
| player2_id                   | integer   |
| player3_id                   | integer   |

## Details

     nba_live_pbp(game_id = '0022201086')

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

Other NBA Live Functions:
[`nba_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore.md),
[`nba_todays_scoreboard()`](https://hoopR.sportsdataverse.org/reference/nba_todays_scoreboard.md)

## Author

Saiem Gilani
