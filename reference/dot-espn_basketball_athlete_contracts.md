# Internal: ESPN basketball athlete contracts index

Fetches the paginated contract-year index for one athlete:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}/contracts`.
ESPN currently populates contract data only for NBA athletes.

## Usage

``` r
.espn_basketball_athlete_contracts(league, athlete_id, ...)
```

## Arguments

- league:

  character.

- athlete_id:

  character or numeric. ESPN athlete identifier.

- ...:

  Unused.

## Value

A `hoopR_data` tibble with one row per contract year, or `NULL` on
error.
