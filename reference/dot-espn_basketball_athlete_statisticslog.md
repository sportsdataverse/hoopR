# Internal: ESPN basketball athlete statisticslog

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}/statisticslog`
and returns a single tidy tibble.

## Usage

``` r
.espn_basketball_athlete_statisticslog(league, athlete_id, season, ...)
```

## Arguments

- league:

  character.

- athlete_id:

  character or numeric.

- season:

  numeric.

- ...:

  Unused.

## Value

A tibble.
