# **Get Current G League Standings from NBA API**

Scrapes the NBA Data API for G League Standings

## Usage

``` r
nbagl_standings(season = most_recent_nba_season() - 1, ...)
```

## Arguments

- season:

  Season - 4 digit, i.e. 2021

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a tibble of the G League Season Standings

|          |           |
|----------|-----------|
| col_name | types     |
| val      | character |
| di_val   | character |
| tid      | integer   |
| see      | integer   |
| cli      | integer   |
| clid     | integer   |
| clic     | integer   |
| elim     | integer   |
| str      | character |
| l10      | character |
| dr       | character |
| cr       | character |
| l        | integer   |
| w        | integer   |
| hr       | character |
| ar       | character |
| gb       | numeric   |
| gbd      | numeric   |
| ta       | character |
| tn       | character |
| tc       | character |

## Details

     nbagl_standings(season = most_recent_nba_season() - 1)

## See also

Other NBA G-League Functions:
[`nbagl_live_boxscore()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_boxscore.md),
[`nbagl_live_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_live_pbp.md),
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_players()`](https://hoopR.sportsdataverse.org/reference/nbagl_players.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md)

## Author

Billy Fryer
