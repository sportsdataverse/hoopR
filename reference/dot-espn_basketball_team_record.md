# Internal: ESPN basketball per-season-type team record

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/types/{season_type}/teams/{team_id}/record`
and returns a tibble with one row per record type (overall, home, away,
vs conference, etc).

## Usage

``` r
.espn_basketball_team_record(league, team_id, season, season_type = 2L, ...)
```
