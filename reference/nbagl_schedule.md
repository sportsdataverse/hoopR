# **Get G League Schedule from NBA API**

Scrapes the NBA Data API for G League Schedule for a Given Season

## Usage

``` r
nbagl_schedule(season = most_recent_nba_season() - 1, ...)
```

## Arguments

- season:

  Season - 4 digit, i.e. 2021

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame of the G League Season Schedule

|          |           |
|----------|-----------|
| col_name | types     |
| mon      | character |
| gid      | character |
| gcode    | character |
| seri     | character |
| is       | integer   |
| gdte     | character |
| htm      | character |
| vtm      | character |
| etm      | character |
| an       | character |
| ac       | character |
| as       | character |
| st       | character |
| stt      | character |
| gdtutc   | character |
| utctm    | character |
| ppdst    | character |
| seq      | integer   |
| bd_b     | list      |
| v_tid    | integer   |
| v_re     | character |
| v_ta     | character |
| v_tn     | character |
| v_tc     | character |
| v_s      | character |
| h_tid    | integer   |
| h_re     | character |
| h_ta     | character |
| h_tn     | character |
| h_tc     | character |
| h_s      | character |
| ptsls_pl | list      |

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
