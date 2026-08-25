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
  data with shot coordinates, shot values, and V3 action types. V2 is
  available from 2016-17 onwards.

- p:

  Optional progress object from `progressr` (default: NULL). Used
  internally by `nba_pbps()`.

- game_ids:

  Game IDs

- nest_data:

  If TRUE returns nested data by game

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

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_pbp_schema.md)
table.

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_pbp_schema.md)
table.

Returns a data frame: PlayByPlay

Columns as documented in the shared
[nba_live_pbp_schema](https://hoopR.sportsdataverse.org/reference/nba_live_pbp_schema.md)
table.

Returns a named list of data frames: game_details, arena, officials,
home_team_boxscore, away_team_boxscore, home_team_player_boxscore,
away_team_player_boxscore, home_team_linescores, away_team_linescores

**game_details**

Columns as documented in the shared
[nba_live_boxscore_game_details_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_game_details_schema.md)
table.

**arena**

Columns as documented in the shared
[nba_live_boxscore_arena_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_arena_schema.md)
table.

**officials**

Columns as documented in the shared
[nba_live_boxscore_officials_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_officials_schema.md)
table.

**home_team_boxscore**

Columns as documented in the shared
[nba_live_boxscore_home_team_boxscore_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_home_team_boxscore_schema.md)
table.

**away_team_boxscore**

Columns as documented in the shared
[nba_live_boxscore_home_team_boxscore_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_home_team_boxscore_schema.md)
table.

**home_team_player_boxscore**

Columns as documented in the shared
[nba_live_boxscore_home_team_player_boxscore_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_home_team_player_boxscore_schema.md)
table.

**away_team_player_boxscore**

Columns as documented in the shared
[nba_live_boxscore_home_team_player_boxscore_schema](https://hoopR.sportsdataverse.org/reference/nba_live_boxscore_home_team_player_boxscore_schema.md)
table.

**home_team_linescores**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| period      | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type.                                  |
| score       | integer   | Final score.                                  |

**away_team_linescores**

|             |           |                                               |
|-------------|-----------|-----------------------------------------------|
| col_name    | types     | description                                   |
| period      | integer   | Period of the game (1-4 quarters; 5+ for OT). |
| period_type | character | Period type.                                  |
| score       | integer   | Final score.                                  |

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
