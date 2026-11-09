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

A named list of `hoopR_data` tibbles: `game_details`, `arena`,
`officials`, `home_team_boxscore`, `away_team_boxscore`,
`home_team_player_boxscore`, `away_team_player_boxscore`,
`home_team_linescores`, `away_team_linescores`. Their column names and
types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "nbagl_live_boxscore")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

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
