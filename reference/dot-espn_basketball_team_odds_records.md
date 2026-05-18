# Internal: ESPN basketball team odds-records (long format)

Returns one row per (category x stat) for a team's odds-related records
in a (season x season-type). ESPN's `odds-records` is sparse — many
(team x season-type) combinations return 404, so the wrapper returns an
empty tibble in that case.

## Usage

``` r
.espn_basketball_team_odds_records(
  league,
  team_id,
  season,
  season_type = 0L,
  ...
)
```
