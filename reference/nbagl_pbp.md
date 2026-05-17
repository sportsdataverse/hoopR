# **Get NBA Data API Play-by-Play for G-League Games**

Retrieves G-League play-by-play using the NBA Stats play-by-play
pipeline.

## Usage

``` r
nbagl_pbp(game_id, on_court = TRUE, ...)
```

## Arguments

- game_id:

  Game ID - 10 digits, i.e. 0021900001

- on_court:

  If TRUE (default), on-court player IDs are added for each play event.

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame of play-by-play with core columns: When
`on_court = TRUE`, lineup columns are included and may be `NA` when
lineup inference data is unavailable for a given game.

|  |  |  |
|----|----|----|
| col_name | types | description |
| game_id | character | Unique game identifier. |
| action_number | integer | Sequential action number within a game (V3 PBP). |
| clock | character | Game clock value. |
| period | integer | Period of the game (1-4 quarters; 5+ for OT). |
| team_id | integer | Unique team identifier. |
| person_id | integer | Unique player identifier (V3 endpoints). |
| player_name | character | Player name. |
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
| video_available | logical | Video available. |
| shot_value | integer | Point value of the shot (2 or 3). |
| action_id | integer | Unique action identifier within a game (V3 PBP). |
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

     nbagl_pbp(game_id = "2052500034")

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
