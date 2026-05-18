# Internal: ESPN basketball season power index (long format)

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/powerindex`,
iterating through pages until all teams' BPI-and-related metrics are
collected. Returns a long tibble: one row per (team x stat).

## Usage

``` r
.espn_basketball_powerindex(
  league,
  season,
  season_type = 2L,
  page_limit = 100L,
  ...
)
```
