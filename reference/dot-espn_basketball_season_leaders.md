# Internal: ESPN basketball season-type leaders (long format)

Returns one row per (season_type x category x leader). Sample with the
default `season_type = c(2L, 3L)`: 14 categories x 25 leaders x 2 season
types = ~700 rows.

## Usage

``` r
.espn_basketball_season_leaders(league, season, season_type = c(2L, 3L), ...)
```
