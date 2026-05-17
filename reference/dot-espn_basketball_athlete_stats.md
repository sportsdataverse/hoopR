# Internal: ESPN basketball athlete stats

Fetches
`site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/athletes/{athlete_id}/stats`
and returns a named list of per-category tibbles.

## Usage

``` r
.espn_basketball_athlete_stats(league, athlete_id, season, ...)
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

Named list of data frames, one per stats category.
