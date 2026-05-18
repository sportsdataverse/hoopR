# Internal: ESPN basketball per-season-type team record

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/types/{season_type}/teams/{team_id}/record`
and returns a tibble with one row per (season_type x record_type).
`season_type` accepts a scalar or vector; default `c(2L, 3L)` fetches
regular season + postseason and binds.

## Usage

``` r
.espn_basketball_team_record(
  league,
  team_id,
  season,
  season_type = c(2L, 3L),
  ...
)
```
