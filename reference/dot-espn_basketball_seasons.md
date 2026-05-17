# Internal: ESPN basketball seasons catalog

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons?limit=200`
and returns a flat tibble of season rows.

## Usage

``` r
.espn_basketball_seasons(league, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- ...:

  Unused; reserved for forward compatibility.

## Value

A `hoopR_data` tibble, or `NULL` on error.
