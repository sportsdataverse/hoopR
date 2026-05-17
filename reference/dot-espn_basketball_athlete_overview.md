# Internal: ESPN basketball athlete overview

Fetches
`site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/athletes/{athlete_id}/overview`
and returns a named list of tibbles.

## Usage

``` r
.espn_basketball_athlete_overview(league, athlete_id, season, ...)
```

## Arguments

- league:

  character.

- athlete_id:

  character or numeric.

- season:

  numeric. Season year.

- ...:

  Unused.

## Value

Named list of data frames.
