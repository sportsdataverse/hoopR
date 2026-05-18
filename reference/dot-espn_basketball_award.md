# Internal: ESPN basketball single award detail (with winners)

Fetches one season-award detail:
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/awards/{award_id}`.
Returns a tibble with one row per winner (most awards have a single
winner; All-League teams have 5 each).

## Usage

``` r
.espn_basketball_award(league, season, award_id, ...)
```

## Arguments

- league:

  character.

- season:

  numeric.

- award_id:

  character or numeric.

- ...:

  Unused.

## Value

A `hoopR_data` tibble with one row per winner, or `NULL` on error.
