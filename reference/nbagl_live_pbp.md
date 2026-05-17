# **Get NBA G-League Stats API Live play-by-play**

**Get NBA G-League Stats API Live play-by-play**

**Get NBA G-League Stats API Live play-by-play**

## Usage

``` r
nbagl_live_pbp(game_id, ...)
```

## Arguments

- game_id:

  Game ID

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

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

## Details

     nbagl_live_pbp(game_id = '2052500034')

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Saiem Gilani
