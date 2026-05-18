# Internal: ESPN basketball single ranking snapshot for one week

Returns the long-format ranked teams for one (season x season-type x
week x ranking-source). Typically 25 rows (AP Top 25 / Coaches Poll).

## Usage

``` r
.espn_basketball_week_ranking(
  league,
  season,
  season_type = 2L,
  week,
  ranking_id,
  ...
)
```
