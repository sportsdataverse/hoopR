# Internal: ESPN basketball franchises index

Fetches the paginated franchise index
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/franchises?limit=200`
and returns a tibble of franchise IDs and the `$ref` URL for each — feed
the IDs to
[`.espn_basketball_franchise()`](https://hoopR.sportsdataverse.org/reference/dot-espn_basketball_franchise.md)
to get full details.

## Usage

``` r
.espn_basketball_franchises(league, ...)
```

## Arguments

- league:

  character.

- ...:

  Unused.

## Value

A `hoopR_data` tibble with one row per franchise, or `NULL` on error.
