# Internal: ESPN basketball single-year athlete contract

Fetches one season's contract for one athlete:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}/contracts/{season}`.
Returns a single-row tibble with salary + cap-rule flags + trade
protections + the `$ref` URLs for the season and team.

## Usage

``` r
.espn_basketball_athlete_contract(league, athlete_id, season, ...)
```

## Arguments

- league:

  character.

- athlete_id:

  character or numeric. ESPN athlete identifier.

- season:

  numeric. Season year (e.g. 2025).

- ...:

  Unused.

## Value

A single-row `hoopR_data` tibble, or `NULL` on error.
