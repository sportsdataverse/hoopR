# Internal: ESPN basketball tournament seasons list

Fetches the seasons in which a tournament was held:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/tournaments/{tournament_id}/seasons`.
Each item is a `$ref` to a per-season tournament resource. Year is
parsed from the URL.

## Usage

``` r
.espn_basketball_tournament_seasons(league, tournament_id, ...)
```
