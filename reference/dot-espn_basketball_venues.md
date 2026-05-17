# Internal: ESPN basketball venues catalog

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/venues`
with standard core-v2 pagination and returns a flat tibble of venue
rows.

## Usage

``` r
.espn_basketball_venues(league, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- ...:

  Unused; reserved for forward compatibility.

## Value

A `hoopR_data` tibble, or `NULL` on error.
