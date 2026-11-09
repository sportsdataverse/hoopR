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

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbagl_live_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
