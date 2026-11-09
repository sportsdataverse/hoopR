# **Get G League Schedule from NBA API**

Retrieves G-League schedule data via the NBA Stats API schedule
endpoint.

## Usage

``` r
nbagl_schedule(
  league_id = "20",
  season = year_to_season(most_recent_nba_season() - 1),
  ...
)
```

## Arguments

- league_id:

  League - default: '20' (G-League).

- season:

  Season - format 2020-21.

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

A data frame with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "nbagl_schedule")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

     nbagl_schedule(season = most_recent_nba_season() - 1)

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
