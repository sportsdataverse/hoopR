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

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| game_id         | character |
| action_number   | integer   |
| clock           | character |
| period          | integer   |
| team_id         | integer   |
| person_id       | integer   |
| player_name     | character |
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
| video_available | logical   |
| shot_value      | integer   |
| action_id       | integer   |
| away_player1    | numeric   |
| away_player2    | numeric   |
| away_player3    | numeric   |
| away_player4    | numeric   |
| away_player5    | numeric   |
| home_player1    | numeric   |
| home_player2    | numeric   |
| home_player3    | numeric   |
| home_player4    | numeric   |
| home_player5    | numeric   |

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
