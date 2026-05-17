# Internal: ESPN basketball team detail

Fetches
`site.api.espn.com/apis/site/v2/sports/basketball/{league}/teams/{team_id}`
and parses the response into a named list of tibbles: `Info`, `Record`,
`NextEvent`, `StandingSummary`, `Coaches`.

## Usage

``` r
.espn_basketball_team(league, team_id, season, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- team_id:

  character or numeric. ESPN team identifier.

- season:

  numeric. Season year.

- ...:

  Unused; absorbed for forward compatibility.

## Value

Named list of data frames.
