# Internal: ESPN basketball single-season info

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{year}`
and returns a named list with components `Info`, `Types`, `Athletes`,
`Coaches`, `Teams`, and `Awards`. Components that contain only `$ref`
URLs are returned as character vectors – they are NOT auto-resolved.

## Usage

``` r
.espn_basketball_season_info(league, season, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- season:

  numeric. Season year.

- ...:

  Unused; reserved for forward compatibility.

## Value

Named list of tibbles/data frames, or an empty list on error.
