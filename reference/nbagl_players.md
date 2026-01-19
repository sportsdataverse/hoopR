# **Get G League Player Data Base from NBA API**

Scrapes the NBA Data API for All Players in G League History

## Usage

``` r
nbagl_players(...)
```

## Arguments

- ...:

  Additional arguments passed to an underlying function like httr.

## Value

Returns a data frame of G League Players from NBA Database

|                 |           |
|-----------------|-----------|
| col_name        | types     |
| nba-affiliation | character |
| season          | integer   |
| permalink       | character |
| tid             | integer   |
| fn              | character |
| ln              | character |
| pid             | integer   |
| num             | character |
| pos             | character |
| dob             | character |
| ht              | character |
| wt              | integer   |
| y               | integer   |
| sn              | character |
| ty              | character |
| co              | character |
| la              | character |
| dy              | character |
| pc              | character |
| fa              | character |
| s               | character |
| twc             | character |
| ta              | character |
| tn              | character |
| tc              | character |

## Details

     nbagl_players()

## See also

Other NBA G-League Functions:
[`nbagl_pbp()`](https://hoopR.sportsdataverse.org/reference/nbagl_pbp.md),
[`nbagl_schedule()`](https://hoopR.sportsdataverse.org/reference/nbagl_schedule.md),
[`nbagl_standings()`](https://hoopR.sportsdataverse.org/reference/nbagl_standings.md)

## Author

Billy Fryer
