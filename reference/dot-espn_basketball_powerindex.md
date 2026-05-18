# Internal: ESPN basketball season power index (long format)

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/powerindex`,
iterating through pages until all teams' BPI-and-related metrics are
collected. The endpoint returns all season types in a single paginated
response; filtering happens client-side. `season_type` accepts a scalar
or vector — default `c(2L, 3L)` keeps regular season + postseason rows.

## Usage

``` r
.espn_basketball_powerindex(
  league,
  season,
  season_type = c(2L, 3L),
  page_limit = 100L,
  ...
)
```
