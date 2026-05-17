# Internal: ESPN basketball team roster

Fetches
`site.api.espn.com/apis/site/v2/sports/basketball/{league}/teams/{team_id}/roster`
and returns a single tidy tibble of athlete rows.

## Usage

``` r
.espn_basketball_team_roster(league, team_id, season, ...)
```

## Arguments

- league:

  character.

- team_id:

  character or numeric.

- season:

  numeric.

- ...:

  Unused.

## Value

A tibble.
