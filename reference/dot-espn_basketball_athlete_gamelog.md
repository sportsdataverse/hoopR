# Internal: ESPN basketball athlete gamelog

Fetches
`site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/athletes/{athlete_id}/gamelog`
and returns a single tidy tibble (one row per game).

## Usage

``` r
.espn_basketball_athlete_gamelog(league, athlete_id, season, ...)
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
