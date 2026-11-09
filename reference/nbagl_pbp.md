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

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbagl_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
