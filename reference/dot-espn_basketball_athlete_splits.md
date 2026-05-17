# Internal: ESPN basketball athlete splits

Fetches
`site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/athletes/{athlete_id}/splits`
and returns a single long-format tibble.

## Usage

``` r
.espn_basketball_athlete_splits(league, athlete_id, season, ...)
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
