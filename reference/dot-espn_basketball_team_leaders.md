# Internal: ESPN basketball team leaders

Fetches
`site.api.espn.com/apis/site/v2/sports/basketball/{league}/teams/{team_id}/leaders`
and returns a long-format tibble (one row per category-rank-athlete
triple).

## Usage

``` r
.espn_basketball_team_leaders(league, team_id, season, ...)
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
