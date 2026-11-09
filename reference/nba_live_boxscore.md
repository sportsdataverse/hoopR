# **Get NBA Stats API Play-by-Play V3**

**Get NBA Stats API Play-by-Play V3**

**Get NBA Stats API Play-by-Play V3**

**Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play (Multiple Games)**

**Get NBA Stats API play-by-play (Multiple Games)**

**Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live play-by-play**

**Get NBA Stats API Live Boxscore**

**Get NBA Stats API Live Boxscore**

## Usage

``` r
nba_playbyplayv3(game_id, start_period = 0, end_period = 0, ...)

nba_pbp(game_id, on_court = TRUE, version = "v3", p = NULL, ...)

nba_pbps(
  game_ids = NULL,
  on_court = TRUE,
  version = "v3",
  nest_data = FALSE,
  ...
)

nba_live_pbp(game_id, ...)

nba_live_boxscore(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- start_period:

  Start period filter (default: 0 = all periods). Use 1-4 for regulation
  quarters, 5+ for overtime.

- end_period:

  End period filter (default: 0 = all periods). Use 1-4 for regulation
  quarters, 5+ for overtime.

- ...:

  Additional arguments passed to an underlying function like httr.

- on_court:

  If TRUE (default), on-court player IDs are added for each play event.
  V3 uses
  [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)
  stint data; V2 infers lineups from substitution events.

- version:

  Play-by-play version - `"v3"` (default) or `"v2"`. V3 returns richer
  data with shot coordinates, shot values, and V3 action types. Both
  versions reach back to 1996-97 (`playbyplayv2` and `playbyplayv3`
  share the stats.nba.com floor); the 2016-17 floor belongs to the
  data.nba.com / cdn.nba.com liveData feed served by
  [`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md).

- p:

  Optional progress object from `progressr` (default: NULL). Used
  internally by `nba_pbps()`.

- game_ids:

  Game IDs

- nest_data:

  If TRUE returns nested data by game

## Value

A named list of `hoopR_data` tibbles: `PlayByPlay`, `AvailableVideo`.

**PlayByPlay**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| action_number | integer | Sequential action number within a game (V3 PBP). |
| clock | character | Game clock value. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| team_id | integer | Unique team identifier. |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| person_id | integer | Unique player identifier (V3 endpoints). |
| player_name | character | Player name. |
| player_name_i | character | Player name i. |
| x_legacy | integer | V2-format X coordinate (preserved for V3-to-V2 compatibility). |
| y_legacy | integer | V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
| shot_distance | numeric | Shot distance from the basket, in feet. |
| shot_result | character | Shot result ('Made' / 'Missed'). |
| is_field_goal | integer | 1 if the action was a field goal; 0 otherwise. |
| score_home | character | Score home. |
| score_away | character | Score away. |
| points_total | integer | Running total of points scored. |
| location | character | Location. |
| description | character | Long-form description text. |
| action_type | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| sub_type | character | Action sub-type label. |
| video_available | integer | Video available. |
| shot_value | integer | Point value of the shot (2 or 3). |
| action_id | integer | Unique action identifier within a game (V3 PBP). |

**AvailableVideo**

|                 |         |                  |
|-----------------|---------|------------------|
| col_name        | types   | description      |
| video_available | integer | Video available. |

A `hoopR_data` tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| event_num | character | Sequential event number within the game (V2 PBP). |
| event_type | character | Event / play type code (V2 PBP). |
| event_action_type | character | Numeric event-action-type code (V2 PBP). |
| period | numeric | Period of the game (1-4 quarters; 5+ for OT). |
| clock | character | Game clock value. |
| minute_game | numeric | Minute game. |
| time_remaining | numeric | Time remaining. |
| wc_time_string | character | Wc time string. |
| time_quarter | character | Time quarter. |
| minute_remaining_quarter | numeric | Minute remaining quarter. |
| seconds_remaining_quarter | numeric | Seconds remaining quarter. |
| action_type | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| sub_type | character | Action sub-type label. |
| home_description | character | Home team's description. |
| neutral_description | character | Neutral description. |
| visitor_description | character | Visitor description. |
| description | character | Long-form description text. |
| location | character | Location. |
| score | character | Final score. |
| away_score | numeric | Away team score at the time of the play. |
| home_score | numeric | Home team score at the time of the play. |
| score_margin | character | Score margin. |
| person1type | character | Person1type. |
| player1_id | character | V2 PBP primary player ID (e.g. shooter / fouler). |
| player1_name | character | V2 PBP primary player name. |
| player1_team_id | character | Team ID of player1. |
| player1_team_city | character | Player1 team city. |
| player1_team_nickname | character | Player1 team nickname. |
| player1_team_abbreviation | character | Player1 team abbreviation. |
| person2type | character | Person2type. |
| player2_id | character | V2 PBP secondary player ID (e.g. assister / fouled-by). |
| player2_name | character | V2 PBP secondary player name. |
| player2_team_id | character | Team ID of player2. |
| player2_team_city | character | Player2 team city. |
| player2_team_nickname | character | Player2 team nickname. |
| player2_team_abbreviation | character | Player2 team abbreviation. |
| person3type | character | Person3type. |
| player3_id | character | V2 PBP tertiary player ID (e.g. blocker). |
| player3_name | character | V2 PBP tertiary player name. |
| player3_team_id | character | Team ID of player3. |
| player3_team_city | character | Player3 team city. |
| player3_team_nickname | character | Player3 team nickname. |
| player3_team_abbreviation | character | Player3 team abbreviation. |
| video_available_flag | character | Video available flag. |
| team_leading | character | Team leading. |
| x_legacy | integer | V2-format X coordinate (preserved for V3-to-V2 compatibility). |
| y_legacy | integer | V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
| shot_distance | numeric | Shot distance from the basket, in feet. |
| shot_result | character | Shot result ('Made' / 'Missed'). |
| is_field_goal | integer | 1 if the action was a field goal; 0 otherwise. |
| points_total | integer | Running total of points scored. |
| shot_value | integer | Point value of the shot (2 or 3). |
| away_player1 | numeric | Away team's player1. |
| away_player2 | numeric | Away team's player2. |
| away_player3 | numeric | Away team's player3. |
| away_player4 | numeric | Away team's player4. |
| away_player5 | numeric | Away team's player5. |
| home_player1 | numeric | Home team's player1. |
| home_player2 | numeric | Home team's player2. |
| home_player3 | numeric | Home team's player3. |
| home_player4 | numeric | Home team's player4. |
| home_player5 | numeric | Home team's player5. |

A tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| event_num | character | Sequential event number within the game (V2 PBP). |
| event_type | character | Event / play type code (V2 PBP). |
| event_action_type | character | Numeric event-action-type code (V2 PBP). |
| period | numeric | Period of the game (1-4 quarters; 5+ for OT). |
| clock | character | Game clock value. |
| minute_game | numeric | Minute game. |
| time_remaining | numeric | Time remaining. |
| wc_time_string | character | Wc time string. |
| time_quarter | character | Time quarter. |
| minute_remaining_quarter | numeric | Minute remaining quarter. |
| seconds_remaining_quarter | numeric | Seconds remaining quarter. |
| action_type | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| sub_type | character | Action sub-type label. |
| home_description | character | Home team's description. |
| neutral_description | character | Neutral description. |
| visitor_description | character | Visitor description. |
| description | character | Long-form description text. |
| location | character | Location. |
| score | character | Final score. |
| away_score | numeric | Away team score at the time of the play. |
| home_score | numeric | Home team score at the time of the play. |
| score_margin | character | Score margin. |
| person1type | character | Person1type. |
| player1_id | character | V2 PBP primary player ID (e.g. shooter / fouler). |
| player1_name | character | V2 PBP primary player name. |
| player1_team_id | character | Team ID of player1. |
| player1_team_city | character | Player1 team city. |
| player1_team_nickname | character | Player1 team nickname. |
| player1_team_abbreviation | character | Player1 team abbreviation. |
| person2type | character | Person2type. |
| player2_id | character | V2 PBP secondary player ID (e.g. assister / fouled-by). |
| player2_name | character | V2 PBP secondary player name. |
| player2_team_id | character | Team ID of player2. |
| player2_team_city | character | Player2 team city. |
| player2_team_nickname | character | Player2 team nickname. |
| player2_team_abbreviation | character | Player2 team abbreviation. |
| person3type | character | Person3type. |
| player3_id | character | V2 PBP tertiary player ID (e.g. blocker). |
| player3_name | character | V2 PBP tertiary player name. |
| player3_team_id | character | Team ID of player3. |
| player3_team_city | character | Player3 team city. |
| player3_team_nickname | character | Player3 team nickname. |
| player3_team_abbreviation | character | Player3 team abbreviation. |
| video_available_flag | character | Video available flag. |
| team_leading | character | Team leading. |
| x_legacy | integer | V2-format X coordinate (preserved for V3-to-V2 compatibility). |
| y_legacy | integer | V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
| shot_distance | numeric | Shot distance from the basket, in feet. |
| shot_result | character | Shot result ('Made' / 'Missed'). |
| is_field_goal | integer | 1 if the action was a field goal; 0 otherwise. |
| points_total | integer | Running total of points scored. |
| shot_value | integer | Point value of the shot (2 or 3). |
| away_player1 | numeric | Away team's player1. |
| away_player2 | numeric | Away team's player2. |
| away_player3 | numeric | Away team's player3. |
| away_player4 | numeric | Away team's player4. |
| away_player5 | numeric | Away team's player5. |
| home_player1 | numeric | Home team's player1. |
| home_player2 | numeric | Home team's player2. |
| home_player3 | numeric | Home team's player3. |
| home_player4 | numeric | Home team's player4. |
| home_player5 | numeric | Home team's player5. |

A `hoopR_data` tibble with one row per play-by-play event.

|  |  |  |
|----|----|----|
| col_name | types | description |
| event_num | integer | Sequential event number within the game (V2 PBP). |
| clock | character | Game clock value. |
| time_actual | character | Time actual. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type. |
| action_type | character | Action type label (e.g. 'Made Shot', 'Substitution'). |
| sub_type | character | Action sub-type label. |
| qualifiers | list | Qualifiers. |
| player1_id | integer | V2 PBP primary player ID (e.g. shooter / fouler). |
| x | numeric | X. |
| y | numeric | Y. |
| offense_team_id | integer | Unique identifier for offense team. |
| home_score | character | Home team score at the time of the play. |
| away_score | character | Away team score at the time of the play. |
| edited | character | Edited. |
| order | integer | Display order within the result set. |
| is_target_score_last_period | logical | Is target score last period. |
| x_legacy | integer | V2-format X coordinate (preserved for V3-to-V2 compatibility). |
| y_legacy | integer | V2-format Y coordinate (preserved for V3-to-V2 compatibility). |
| is_field_goal | integer | 1 if the action was a field goal; 0 otherwise. |
| side | character | Side label (e.g. 'home', 'away', or 'overUnder'). |
| description | character | Long-form description text. |
| person_ids_filter | list | Person ids filter. |
| team_id | integer | Unique team identifier. |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| descriptor | character | Descriptor. |
| jump_ball_recovered_name | character | Jump ball recovered name. |
| jump_ball_recoverd_person_id | integer | Unique identifier for jump ball recoverd person. |
| player_name | character | Player name. |
| player_name_i | character | Player name i. |
| jump_ball_won_player_name | character | Jump ball won player name. |
| jump_ball_won_person_id | integer | Unique identifier for jump ball won person. |
| jump_ball_lost_player_name | character | Jump ball lost player name. |
| jump_ball_lost_person_id | integer | Unique identifier for jump ball lost person. |
| area | character | Area. |
| area_detail | character | Area detail. |
| shot_distance | numeric | Shot distance from the basket, in feet. |
| shot_result | character | Shot result ('Made' / 'Missed'). |
| points_total | integer | Running total of points scored. |
| assist_player_name_initial | character | Assist player name initial. |
| assist_person_id | integer | Unique identifier for assist person. |
| assist_total | integer | Assist total. |
| shot_action_number | integer | Shot action number. |
| rebound_total | integer | Rebound total. |
| rebound_defensive_total | integer | Rebound defensive total. |
| rebound_offensive_total | integer | Rebound offensive total. |
| official_id | integer | Unique official / referee identifier. |
| foul_personal_total | integer | Foul personal total. |
| foul_technical_total | integer | Foul technical total. |
| foul_drawn_player_name | character | Foul drawn player name. |
| foul_drawn_person_id | integer | Unique identifier for foul drawn person. |
| block_player_name | character | Block player name. |
| block_person_id | integer | Unique identifier for block person. |
| turnover_total | integer | Turnover total. |
| steal_player_name | character | Steal player name. |
| steal_person_id | integer | Unique identifier for steal person. |
| player2_id | integer | V2 PBP secondary player ID (e.g. assister / fouled-by). |
| player3_id | integer | V2 PBP tertiary player ID (e.g. blocker). |

A named list of `hoopR_data` tibbles: `game_details`, `arena`,
`officials`, `home_team_boxscore`, `away_team_boxscore`,
`home_team_player_boxscore`, `away_team_player_boxscore`,
`home_team_linescores`, `away_team_linescores`.

**game_details**

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| game_time_local | character | Game time local. |
| game_time_utc | character | Game start time in UTC (ISO 8601 timestamp). |
| game_time_home | character | Game time home. |
| game_time_away | character | Game time away. |
| game_et | character | Game et. |
| duration | integer | Duration. |
| game_code | character | ESPN game code (numeric identifier). |
| game_status_text | character | Game status display text (e.g. 'Final', '4:32 - 4th'). |
| game_status | integer | Game status label. |
| regulation_periods | integer | Regulation periods. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| game_clock | character | Game clock. |
| attendance | integer | Reported attendance. |
| sellout | character | Sellout. |
| home_team_id | integer | Unique identifier for the home team. |
| home_team_name | character | Home team name. |
| home_team_city | character | Home team city / location. |
| home_team_tricode | character | Home team three-letter code. |
| home_team_score | integer | Home team's score. |
| home_team_in_bonus | character | Home team's team in bonus. |
| home_team_timeouts_remaining | integer | Home team's team timeouts remaining. |
| away_team_id | integer | Unique identifier for the away team. |
| away_team_name | character | Away team name. |
| away_team_city | character | Away team city / location. |
| away_team_tricode | character | Away team three-letter code. |
| away_team_score | integer | Away team's score. |
| away_team_in_bonus | character | Away team's team in bonus. |
| away_team_timeouts_remaining | integer | Away team's team timeouts remaining. |

**arena**

|                |           |                              |
|----------------|-----------|------------------------------|
| col_name       | types     | description                  |
| arena_id       | integer   | Unique identifier for arena. |
| arena_name     | character | Arena name.                  |
| arena_city     | character | Arena city.                  |
| arena_state    | character | Arena state.                 |
| arena_country  | character | Arena country.               |
| arena_timezone | character | Arena timezone.              |

**officials**

|             |           |                                          |
|-------------|-----------|------------------------------------------|
| col_name    | types     | description                              |
| person_id   | integer   | Unique player identifier (V3 endpoints). |
| name        | character | Display name.                            |
| name_i      | character | Initialed name (e.g. 'A. Wilson').       |
| first_name  | character | Player's first name.                     |
| family_name | character | Player's family / last name.             |
| jersey_num  | character | Jersey number worn by the player.        |
| assignment  | character | Assignment.                              |

**home_team_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| assists | integer | Total assists. |
| assists_turnover_ratio | numeric | Assists turnover ratio. |
| bench_points | integer | Points scored by the bench. |
| biggest_lead | integer | Biggest lead. |
| biggest_lead_score | character | Biggest lead score. |
| biggest_scoring_run | integer | Biggest scoring run. |
| biggest_scoring_run_score | character | Biggest scoring run score. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| fast_break_points_attempted | integer | Number of fast break points attempted. |
| fast_break_points_made | integer | Number of fast break points made. |
| fast_break_points_percentage | numeric | Fast break points percentage (0-1 decimal). |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_effective_adjusted | numeric | Field goals effective adjusted. |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_team | integer | Fouls team. |
| fouls_technical | integer | Technical fouls. |
| fouls_team_technical | integer | Fouls team technical. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| lead_changes | integer | Lead changes. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| points | integer | Points scored. |
| points_against | integer | Points allowed. |
| points_fast_break | integer | Fast-break points scored. |
| points_from_turnovers | integer | Points from turnovers. |
| points_in_the_paint | integer | Points in the paint. |
| points_in_the_paint_attempted | integer | Number of points in the paint attempted. |
| points_in_the_paint_made | integer | Number of points in the paint made. |
| points_in_the_paint_percentage | numeric | Points in the paint percentage (0-1 decimal). |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_personal | integer | Rebounds personal. |
| rebounds_team | integer | Rebounds team. |
| rebounds_team_defensive | integer | Rebounds team defensive. |
| rebounds_team_offensive | integer | Rebounds team offensive. |
| rebounds_total | integer | Total rebounds. |
| second_chance_points_attempted | integer | Number of second chance points attempted. |
| second_chance_points_made | integer | Number of second chance points made. |
| second_chance_points_percentage | numeric | Second chance points percentage (0-1 decimal). |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| time_leading | character | Time leading. |
| times_tied | integer | Times tied. |
| true_shooting_attempts | numeric | Number of true shooting attempted. |
| true_shooting_percentage | numeric | True shooting percentage (0-1). |
| turnovers | integer | Total turnovers. |
| turnovers_team | integer | Turnovers team. |
| turnovers_total | integer | Turnovers total. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |

**away_team_boxscore**

Same columns as the **home_team_boxscore** table above.

**home_team_player_boxscore**

|  |  |  |
|----|----|----|
| col_name | types | description |
| team_id | integer | Unique team identifier. |
| team_name | character | Full team display name (e.g. 'Las Vegas Aces'). |
| team_city | character | Team city or region (e.g. 'Las Vegas'). |
| team_tricode | character | Three-letter team code (e.g. 'LAS' / 'NYL'). |
| team_score | integer | Team's score / final score. |
| team_in_bonus | character | Team in bonus. |
| team_timeouts_remaining | integer | Team timeouts remaining. |
| status | character | Status label. |
| order | integer | Display order within the result set. |
| person_id | integer | Unique player identifier (V3 endpoints). |
| jersey_num | character | Jersey number worn by the player. |
| position | character | Listed roster position (G, F, C, etc.). |
| starter | character | TRUE if the player was in the starting lineup; FALSE otherwise. |
| oncourt | character | Oncourt. |
| played | character | Played. |
| assists | integer | Total assists. |
| blocks | integer | Total blocks. |
| blocks_received | integer | Shots blocked by opponents while attempting. |
| field_goals_attempted | integer | Field goal attempts (2-pt + 3-pt). |
| field_goals_made | integer | Field goals made (2-pt + 3-pt). |
| field_goals_percentage | numeric | Field goal percentage (0-1 decimal). |
| fouls_offensive | integer | Offensive fouls. |
| fouls_drawn | integer | Personal fouls drawn (by opponent's actions). |
| fouls_personal | integer | Personal fouls. |
| fouls_technical | integer | Technical fouls. |
| free_throws_attempted | integer | Free throw attempts. |
| free_throws_made | integer | Free throws made. |
| free_throws_percentage | numeric | Free throw percentage (0-1 decimal). |
| minus | numeric | Minus. |
| minutes | character | Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
| minutes_calculated | character | Minutes calculated from game-clock differences. |
| plus | numeric | Plus. |
| plus_minus_points | numeric | Plus/minus point differential while on court. |
| points | integer | Points scored. |
| points_fast_break | integer | Fast-break points scored. |
| points_in_the_paint | integer | Points in the paint. |
| points_second_chance | integer | Second-chance points scored. |
| rebounds_defensive | integer | Defensive rebounds. |
| rebounds_offensive | integer | Offensive rebounds. |
| rebounds_total | integer | Total rebounds. |
| steals | integer | Total steals. |
| three_pointers_attempted | integer | Three-point field goal attempts. |
| three_pointers_made | integer | Three-point field goals made. |
| three_pointers_percentage | numeric | Three-point field goal percentage (0-1 decimal). |
| turnovers | integer | Total turnovers. |
| two_pointers_attempted | integer | Number of two pointers attempted. |
| two_pointers_made | integer | Number of two pointers made. |
| two_pointers_percentage | numeric | Two pointers percentage (0-1 decimal). |
| name | character | Display name. |
| name_i | character | Initialed name (e.g. 'A. Wilson'). |
| first_name | character | Player's first name. |
| family_name | character | Player's family / last name. |
| not_playing_reason | character | Not playing reason. |
| not_playing_description | character | Not playing description. |

**away_team_player_boxscore**

Same columns as the **home_team_player_boxscore** table above.

**home_team_linescores**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| period      | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type.                                  |
| score       | integer   | Final score.                                  |

**away_team_linescores**

Same columns as the **home_team_linescores** table above.

## Details

     nba_playbyplayv3(game_id = "0022201086")

     nba_pbp(game_id = '0022201086')
     nba_pbp(game_id = '0022201086', version = "v2")

    y <- c("0022201086", "0022200021")

    nba_pbps(game_ids = y)
    nba_pbps(game_ids = y, version = "v2")

     nba_live_pbp(game_id = '0022201086')

     nba_live_boxscore(game_id = "0022201086")

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md)

Other NBA Live Functions:
[`nba_schedule()`](https://hoopR.sportsdataverse.org/reference/nba_schedule.md)

Other NBA Boxscore Functions:
[`nba_boxscoretraditionalv2()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv2.md),
[`nba_boxscoretraditionalv3()`](https://hoopR.sportsdataverse.org/reference/nba_boxscoretraditionalv3.md)

## Author

Saiem Gilani

Jason Lee
