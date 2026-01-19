# **Get NBA Data API Play-by-Play for G-League Games**

Scrapes the NBA Data API for Play By Play for G League games

## Usage

``` r
nbagl_pbp(game_id, ...)
```

## Arguments

- game_id:

  Game ID - 10 digits, i.e. 0021900001

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame of play by play with the following columns:

|          |           |
|----------|-----------|
| col_name | types     |
| period   | integer   |
| evt      | integer   |
| wallclk  | character |
| cl       | character |
| de       | character |
| locX     | integer   |
| locY     | integer   |
| opt1     | integer   |
| opt2     | integer   |
| opt3     | integer   |
| opt4     | integer   |
| mtype    | integer   |
| etype    | integer   |
| opid     | character |
| tid      | integer   |
| pid      | integer   |
| hs       | integer   |
| vs       | integer   |
| epid     | character |
| oftid    | integer   |
| ord      | integer   |
| pts      | integer   |

## Details

     nbagl_pbp(game_id = "2012200001")

## See also

Other NBA G-League Functions:
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
