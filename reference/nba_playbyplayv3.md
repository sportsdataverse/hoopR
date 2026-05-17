# **Get NBA Stats API Play-by-Play V3**

**Get NBA Stats API Play-by-Play V3**

**Get NBA Stats API Play-by-Play V3**

## Usage

``` r
nba_playbyplayv3(game_id, start_period = 0, end_period = 0, ...)
```

## Arguments

- game_id:

  Game ID - 10-digit zero-padded ID (e.g., '0022201086')

- start_period:

  Start period filter (default: 0 = all periods). Use 1-4 for regulation
  quarters, 5+ for overtime.

- end_period:

  End period filter (default: 0 = all periods). Use 1-4 for regulation
  quarters, 5+ for overtime.

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayByPlay, AvailableVideo

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

## Details

     nba_playbyplayv3(game_id = "0022201086")

## See also

Other NBA PBP Functions:
[`nba_data_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_data_pbp.md),
[`nba_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_live_pbp.md),
[`nba_pbp()`](https://hoopR.sportsdataverse.org/reference/nba_pbp.md),
[`nba_pbps()`](https://hoopR.sportsdataverse.org/reference/nba_pbps.md),
[`nba_winprobabilitypbp()`](https://hoopR.sportsdataverse.org/reference/nba_winprobabilitypbp.md)

## Author

Saiem Gilani
