# Internal: ESPN basketball single ranking-source snapshots index

Returns one row per weekly snapshot for a ranking source (e.g. AP Top
25). Each row's `ref` URL resolves to the actual ranked teams for that
week via
[`.espn_basketball_week_ranking()`](https://hoopR.sportsdataverse.org/reference/dot-espn_basketball_week_ranking.md)
(forthcoming).

## Usage

``` r
.espn_basketball_season_ranking(league, season, ranking_id, ...)
```
