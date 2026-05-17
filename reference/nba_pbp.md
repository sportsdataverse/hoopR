# **Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play**

**Get NBA Stats API play-by-play**

## Usage

``` r
nba_pbp(game_id, on_court = TRUE, version = "v3", p = NULL, ...)
```

## Arguments

- game_id:

  Game ID - 10-digit zero-padded ID (e.g., '0022201086')

- on_court:

  If TRUE (default), on-court player IDs are added for each play event.
  V3 uses
  [`nba_gamerotation()`](https://hoopR.sportsdataverse.org/reference/nba_gamerotation.md)
  stint data; V2 infers lineups from substitution events.

- version:

  Play-by-play version - `"v3"` (default) or `"v2"`. V3 returns richer
  data with shot coordinates, shot values, and V3 action types. V2 is
  available from 2016-17 onwards.

- p:

  Optional progress object from `progressr` (default: NULL). Used
  internally by
  [`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md).

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame: PlayByPlay

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

## Details

     nba_pbp(game_id = '0022201086')
     nba_pbp(game_id = '0022201086', version = "v2")

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_playbyplayv3()`](https://hoopR.sportsdataverse.org/reference/nba_playbyplayv3.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

## Author

Jason Lee
