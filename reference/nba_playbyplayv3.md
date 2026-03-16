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

  Start period filter - default: 0 (all periods)

- end_period:

  End period filter - default: 0 (all periods)

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a named list of data frames: PlayByPlay, AvailableVideo

**PlayByPlay**

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| game_id         | character |
| action_number   | integer   |
| clock           | character |
| period          | integer   |
| team_id         | integer   |
| team_tricode    | character |
| person_id       | integer   |
| player_name     | character |
| player_name_i   | character |
| x_legacy        | integer   |
| y_legacy        | integer   |
| shot_distance   | numeric   |
| shot_result     | character |
| is_field_goal   | integer   |
| score_home      | character |
| score_away      | character |
| points_total    | integer   |
| location        | character |
| description     | character |
| action_type     | character |
| sub_type        | character |
| video_available | integer   |
| shot_value      | integer   |
| action_id       | integer   |

**AvailableVideo**

|                 |         |
|-----------------|---------|
| col_name        | types   |
| video_available | integer |

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
