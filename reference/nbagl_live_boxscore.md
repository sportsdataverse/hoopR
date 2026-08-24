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
