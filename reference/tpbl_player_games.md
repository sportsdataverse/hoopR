# **Get TPBL Player Game Log**

A player's game log in one division: one row per game played, with that
game's whole stat line.

Endpoint:
`GET https://api.tpbl.basketball/api/players/{player_id}/games/stats`

## Usage

``` r
tpbl_player_games(player_id, division_id)
```

## Arguments

- player_id:

  Required. TPBL player id (one per person across seasons and teams);
  `player_id` in tpbl_roster. Not the GoHoops person id and not the
  roster id.

- division_id:

  Required. TPBL division id (one competition phase of one season: 1, 2,
  5, 6, 7 = 2024-25 preseason, regular season, playoffs, postseason
  challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 = 2026-27);
  `division_id` in tpbl_divisions. Not the GoHoops division id. Without
  it the API answers HTTP 422; an unknown id answers HTTP 500, which is
  not retried.

## Value

A `hoopR_data` tibble: A player's game log in one division: one row per
game played, with that game's whole stat line. An empty answer raises
`hoopR_no_data`; the columns are always these, in this order (sdv-py
`tpbl_player_games`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
| gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
| gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). His roster in the division: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
| player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
| division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. The division asked for. Not the GoHoops division id. |
| gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
| team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. The team the player played for in that game. |
| team | character | Name of the team the player played for in that game. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
| game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
| gohoops_game_id | integer | GoHoops game id (key space: GoHoops games; 1242 for TPBL game 6). Not the TPBL game id. |
| game_title | character | Game title: the division name and the game number counted from the end (`<division name> Game 124` = regular season, game 124). |
| home_team_id | integer | TPBL team id of the home team of the game (franchise, 2-8). |
| away_team_id | integer | TPBL team id of the away team of the game (franchise, 2-8). |
| home_score | integer | Home team final score in the game. |
| away_score | integer | Away team final score in the game. |
| venue | character | Venue name in Traditional Chinese (the API's game location). |
| tipoff | POSIXct | Scheduled tip-off as a naive timestamp (no zone). Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
| periods_played | integer | Number of quarters in which the player was on court in this game. |
| score | integer | Points scored by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| rebounds | integer | Total rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (offensive + defensive). |
| assists | integer | Assists by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| steals | integer | Steals by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| blocks | integer | Blocked shots by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| turnovers | integer | Turnovers committed by the player in the game of this row (accumulated_stats of a one-game row is that game's total); equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
| fouls | integer | Fouls charged by the player in the game of this row (accumulated_stats of a one-game row is that game's total): personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
| roster_fouls | integer | Fouls charged to the roster member by the player in the game of this row (accumulated_stats of a one-game row is that game's total); equals fouls in the committed samples (meaning inferred from the name). |
| bench_fouls | integer | Fouls charged to the bench by the player in the game of this row (accumulated_stats of a one-game row is that game's total); 0 in every committed sample (meaning inferred from the name). |
| time_on_court | integer | Seconds on court by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
| two_pointers_made | integer | 2-point field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_missed | integer | 2-point field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_attempted | integer | 2-point field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_made | integer | 3-point field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_missed | integer | 3-point field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_attempted | integer | 3-point field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| free_throws_made | integer | Free throws made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| free_throws_missed | integer | Free throws missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| free_throws_attempted | integer | Free throws attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_made | integer | Field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_missed | integer | Field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_attempted | integer | Field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_made_in_the_paint | integer | Field goals made in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_missed_in_the_paint | integer | Field goals missed in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_attempted_in_the_paint | integer | Field goals attempted in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_made_on_fast_break | integer | Field goals made on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_missed_on_fast_break | integer | Field goals missed on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_attempted_on_fast_break | integer | Field goals attempted on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_made_on_second_chance | integer | Field goals made on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_missed_on_second_chance | integer | Field goals missed on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| field_goals_attempted_on_second_chance | integer | Field goals attempted on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| defensive_rebounds | integer | Defensive rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| offensive_rebounds | integer | Offensive rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| offensive_fouls | integer | Fouls committed on offense by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| defensive_fouls | integer | Fouls committed on defense by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| personal_fouls | integer | Personal fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (excludes technical, unsportsmanlike and disqualifying fouls). |
| technical_fouls | integer | Technical fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| unsportsmanlike_fouls | integer | Unsportsmanlike fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| disqualifying_fouls | integer | Disqualifying fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| bad_pass_turnovers | integer | Turnovers of type 'bad pass' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| ball_handling_turnovers | integer | Turnovers of type 'ball-handling error' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| out_of_bounds_turnovers | integer | Turnovers of type 'out of bounds' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| travel_turnovers | integer | Turnovers of type 'traveling' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_seconds_turnovers | integer | Turnovers of type 'three-second violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| five_seconds_turnovers | integer | Turnovers of type 'five-second violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| back_court_turnovers | integer | Turnovers of type 'back-court violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| offensive_goal_tending_turnovers | integer | Turnovers of type 'offensive goaltending' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| double_dribble_turnovers | integer | Turnovers of type 'double dribble' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| carry_turnovers | integer | Turnovers of type 'carrying' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| offensive_foul_turnovers | integer | Turnovers of type 'offensive foul' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| other_turnovers | integer | Turnovers of type 'other' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| plus_minus | integer | Plus/minus: the team's point differential while the player was on court (standard definition; not independently checked). |
| fast_break_points | integer | Points scored on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| points_in_paint | integer | Points scored in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| points_off_turnovers | integer | Points scored off opponent turnovers by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_jump_shot_made | integer | 2-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_jump_shot_missed | integer | 2-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_jump_shot_attempted | integer | 2-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_jump_shot_made | integer | 3-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_jump_shot_missed | integer | 3-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_jump_shot_attempted | integer | 3-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_layup_made | integer | 2-point field goals made that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_layup_missed | integer | 2-point field goals missed that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_layup_attempted | integer | 2-point field goals attempted that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_driving_layup_made | integer | 2-point field goals made that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_driving_layup_missed | integer | 2-point field goals missed that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_driving_layup_attempted | integer | 2-point field goals attempted that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_dunk_made | integer | 2-point field goals made that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_dunk_missed | integer | 2-point field goals missed that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_dunk_attempted | integer | 2-point field goals attempted that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_dunk_made | integer | 2-point field goals made that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_dunk_missed | integer | 2-point field goals missed that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_dunk_attempted | integer | 2-point field goals attempted that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_tip_in_made | integer | 2-point field goals made that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_tip_in_missed | integer | 2-point field goals missed that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_putback_tip_in_attempted | integer | 2-point field goals attempted that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_alley_oop_made | integer | 2-point field goals made that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_alley_oop_missed | integer | 2-point field goals missed that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_alley_oop_attempted | integer | 2-point field goals attempted that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_hook_shot_made | integer | 2-point field goals made that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_hook_shot_missed | integer | 2-point field goals missed that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_hook_shot_attempted | integer | 2-point field goals attempted that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_hook_shot_made | integer | 3-point field goals made that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_hook_shot_missed | integer | 3-point field goals missed that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_hook_shot_attempted | integer | 3-point field goals attempted that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_floating_jump_shot_made | integer | 2-point field goals made that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_floating_jump_shot_missed | integer | 2-point field goals missed that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_floating_jump_shot_attempted | integer | 2-point field goals attempted that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_floating_jump_shot_made | integer | 3-point field goals made that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_floating_jump_shot_missed | integer | 3-point field goals missed that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_floating_jump_shot_attempted | integer | 3-point field goals attempted that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_fadeaway_jump_shot_made | integer | 2-point field goals made that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_fadeaway_jump_shot_missed | integer | 2-point field goals missed that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_fadeaway_jump_shot_attempted | integer | 2-point field goals attempted that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_fadeaway_jump_shot_made | integer | 3-point field goals made that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_fadeaway_jump_shot_missed | integer | 3-point field goals missed that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_fadeaway_jump_shot_attempted | integer | 3-point field goals attempted that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_turnaround_jump_shot_made | integer | 2-point field goals made that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_turnaround_jump_shot_missed | integer | 2-point field goals missed that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_turnaround_jump_shot_attempted | integer | 2-point field goals attempted that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_turnaround_jump_shot_made | integer | 3-point field goals made that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_turnaround_jump_shot_missed | integer | 3-point field goals missed that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_turnaround_jump_shot_attempted | integer | 3-point field goals attempted that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_step_back_jump_shot_made | integer | 2-point field goals made that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_step_back_jump_shot_missed | integer | 2-point field goals missed that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_step_back_jump_shot_attempted | integer | 2-point field goals attempted that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_step_back_jump_shot_made | integer | 3-point field goals made that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_step_back_jump_shot_missed | integer | 3-point field goals missed that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_step_back_jump_shot_attempted | integer | 3-point field goals attempted that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_pull_up_jump_shot_made | integer | 2-point field goals made that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_pull_up_jump_shot_missed | integer | 2-point field goals missed that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| two_pointers_pull_up_jump_shot_attempted | integer | 2-point field goals attempted that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_pull_up_jump_shot_made | integer | 3-point field goals made that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_pull_up_jump_shot_missed | integer | 3-point field goals missed that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| three_pointers_pull_up_jump_shot_attempted | integer | 3-point field goals attempted that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
| efficiency | integer | Efficiency rating by the player in the game of this row (accumulated_stats of a one-game row is that game's total): (points + rebounds + assists + steals + blocks) - (missed field goals + missed free throws + turnovers); verified on all 4,237 played player lines of 189 games. |
| pir | integer | Performance index rating: efficiency minus fouls (the API's performance_index_rating; checked on 189 games of the box-score lines). |
| two_pointers_percentage | double | 2-point field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| three_pointers_percentage | double | 3-point field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| free_throws_percentage | double | Free throws percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| field_goals_percentage | double | Field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
| turnovers_percentage | double | Turnover percentage, 0-100 (a one-decimal string on the API; the exact formula is not documented). |
| efg | double | Effective field-goal percentage, 0-100 (the API's effective_field_goals_percentage, a one-decimal string). |
| tsp | double | True-shooting percentage, 0-100 (the API's true_shooting_percentage, a one-decimal string). |

## Details

- Unofficial and unsupported: these are the routes the tpbl.basketball
  site's own front end calls on api.tpbl.basketball (read from its
  JavaScript bundle). The API is keyless and needs no headers;
  tpbl.basketball/robots.txt answers 200 with an empty body. The runtime
  waits at least 1 s before every request, retries included. Payloads
  are not redistributed as release assets.

- Coverage: three seasons so far (2024-25 = season 2025 to 2026-27 =
  season 2027). There is NO play-by-play route; the two shot lists carry
  court coordinates only, with no shooter, game, quarter or time. Names
  (teams with their sponsor, venues, players, referees) are Traditional
  Chinese; the column descriptions translate the codes.

- Seasons are END years (2026 = 2025-26). The API keys a season by its
  own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27); the runtime
  reads tpbl_seasons once per session and sends that id. A year the list
  lacks is `hoopR_no_data`.

- Ids: every route takes TPBL's own ids (season, division, team, game,
  player); the `gohoops_*` ids belong to GoHoops, the stats platform
  behind the league, and are echoed beside them. The box score keys its
  players by gohoops_roster_id (a person registered with one squad in
  one season), not by the TPBL player id: join tpbl_box_players to
  tpbl_roster on gohoops_roster_id. Every id is an integer. tipoff is a
  POSIXct in Asia/Taipei (the API sends naive Taiwan-local times).

- Finished games only: the game wrappers first read the game detail
  (cached per session) and refuse (`hoopR_asset_fetch`) a game that is
  not COMPLETED or still live; the box-score wrappers also refuse a
  stats body whose teams (in home / away order), final scores, quarter
  count or player points disagree with it. The season game list, the
  roster and the player game log are checked against the object asked
  for; the two shot lists name no team, player or division in the body,
  so only their shape and court bounds are checked. tpbl_games(verify =
  TRUE) also checks every division's completed games against its
  standings (falling back to the team-filtered lists for a division
  whose standings answer empty, as the 2024-25 playoffs do).

- Errors are classed conditions, all inheriting `hoopR_error`:
  `hoopR_no_data` (HTTP 404, a season the API does not list, an empty
  list such as the standings of a playoff division), `hoopR_bad_request`
  (a non-integer id or season, HTTP 400 / 422, an invalid verify or
  rounds, raised before the request where it can be) and
  `hoopR_asset_fetch` (any other failure: a non-2xx after retries, a
  non-JSON body, an error envelope, an unfinished game, a body that
  disagrees with the object asked for). HTTP 500 is retried on every
  route except the player game log, where an unknown division_id answers
  500 deterministically: it fails after one request. Wrappers raise;
  they never warn and return an empty frame.

     tpbl_player_games(player_id = 75, division_id = 2)

## See also

Other TPBL Functions:
[`tpbl_box_player_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_player_periods.md),
[`tpbl_box_players()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_players.md),
[`tpbl_box_team_periods()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_team_periods.md),
[`tpbl_box_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_box_teams.md),
[`tpbl_divisions()`](https://hoopR.sportsdataverse.org/reference/tpbl_divisions.md),
[`tpbl_game()`](https://hoopR.sportsdataverse.org/reference/tpbl_game.md),
[`tpbl_games()`](https://hoopR.sportsdataverse.org/reference/tpbl_games.md),
[`tpbl_player_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_player_shots.md),
[`tpbl_referees()`](https://hoopR.sportsdataverse.org/reference/tpbl_referees.md),
[`tpbl_roster()`](https://hoopR.sportsdataverse.org/reference/tpbl_roster.md),
[`tpbl_seasons()`](https://hoopR.sportsdataverse.org/reference/tpbl_seasons.md),
[`tpbl_standings()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings.md),
[`tpbl_standings_against()`](https://hoopR.sportsdataverse.org/reference/tpbl_standings_against.md),
[`tpbl_team_shots()`](https://hoopR.sportsdataverse.org/reference/tpbl_team_shots.md),
[`tpbl_teams()`](https://hoopR.sportsdataverse.org/reference/tpbl_teams.md)
