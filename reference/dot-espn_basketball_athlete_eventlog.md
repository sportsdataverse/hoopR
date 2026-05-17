# Internal: ESPN basketball athlete eventlog

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}/eventlog`
and returns a single tidy tibble. Per-event `statistics.$ref` URLs are
returned as a character column `statistics_ref` – they are NOT resolved.

## Usage

``` r
.espn_basketball_athlete_eventlog(league, athlete_id, season, ...)
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
