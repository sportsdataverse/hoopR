# Internal: ESPN basketball season futures (long format)

Fetches the per-season futures-market index:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/futures`.
Each item is a futures market (e.g. "NBA Championship Winner") with a
single provider and a list of `books` (one entry per team). Returns one
row per (market x team) for direct tabular use.

## Usage

``` r
.espn_basketball_futures(league, season, ...)
```

## Arguments

- league:

  character.

- season:

  numeric. Season year.

- ...:

  Unused.

## Value

A `hoopR_data` tibble in long format, or `NULL` on error.
