# Internal: ESPN basketball per-season team roster (core-v2)

Distinct from the site-v2-backed `espn_*_team_roster()` — this is the
core-v2 endpoint `/seasons/{y}/teams/{id}/athletes`, which returns the
authoritative per-season athlete list as `$ref` URLs. Useful for
era-correct rosters across all 4 leagues.

## Usage

``` r
.espn_basketball_team_season_roster(league, team_id, season, ...)
```
