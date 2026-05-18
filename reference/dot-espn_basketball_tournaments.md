# Internal: ESPN basketball tournaments index

Fetches the tournament index for a league:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/tournaments`.
Returns a tibble of tournament IDs (each refs a separate detail).

## Usage

``` r
.espn_basketball_tournaments(league, ...)
```
