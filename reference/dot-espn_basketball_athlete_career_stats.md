# Internal: ESPN basketball athlete career statistics (long format)

Returns one row per (stat_type x category x stat) for an athlete's
career stats. By default fetches both regular-season (type 0) and
postseason (type 1) and binds them, exposed via a `stat_type_id` column.
Pass a single integer (0 / 1 / 2) to fetch one type only.

## Usage

``` r
.espn_basketball_athlete_career_stats(league, athlete_id, stat_type = 0L, ...)
```

## Details

Stat type codes: 0 = regular season (default endpoint), 1 = postseason,
2 = career aggregate.
