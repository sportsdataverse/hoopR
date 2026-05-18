# Internal: ESPN basketball season awards index

Fetches the paginated award index for a season:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/awards`.
Each item is a `$ref` to `/awards/{award_id}`. Award names + winners are
only available in the per-award detail call.

## Usage

``` r
.espn_basketball_season_awards(league, season, ...)
```

## Arguments

- league:

  character.

- season:

  numeric. Season year.

- ...:

  Unused.

## Value

A `hoopR_data` tibble with one row per award, or `NULL` on error.
