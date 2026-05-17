# Internal: ESPN basketball team schedule

Fetches
`site.api.espn.com/apis/site/v2/sports/basketball/{league}/teams/{team_id}/schedule`
and returns a single tidy tibble (one row per event).

## Usage

``` r
.espn_basketball_team_schedule(league, team_id, season, season_type, ...)
```

## Arguments

- league:

  character.

- team_id:

  character or numeric.

- season:

  numeric.

- season_type:

  integer. 1 = preseason, 2 = regular, 3 = postseason.

- ...:

  Unused.

## Value

A tibble.
