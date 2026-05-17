# Internal: ESPN basketball athlete awards

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}/awards`
and returns a single tidy tibble. This endpoint is sparse; many athletes
return no data, in which case an empty tibble with canonical columns is
returned.

## Usage

``` r
.espn_basketball_athlete_awards(league, athlete_id, ...)
```

## Arguments

- league:

  character.

- athlete_id:

  character or numeric.

- ...:

  Unused.

## Value

A tibble with columns `season`, `award_id`, `name`, `description`,
`date`, `type`.
