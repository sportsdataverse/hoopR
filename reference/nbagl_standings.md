# **Get Current G League Standings from NBA API**

Retrieves G-League standings via the NBA Stats API standings endpoint.

## Usage

``` r
nbagl_standings(
  league_id = "20",
  season = year_to_season(most_recent_nba_season() - 2),
  season_type = "Regular Season",
  season_year = "",
  ...
)
```

## Arguments

- league_id:

  League - default: '20' (G-League).

- season:

  Season - format 2020-21.

- season_type:

  Season Type - Regular Season, Playoffs, All-Star.

- season_year:

  Season year filter (optional).

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

A named list of data frames: `Standings`. Their column names and types
are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "nbagl_standings")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

     nbagl_standings(season = year_to_season(most_recent_nba_season() - 2))

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md)

## Author

Billy Fryer
