# Internal: ESPN basketball athlete info

Fetches
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/athletes/{athlete_id}`
and returns a named list of tibbles: `Bio`, `Team`, `Position`,
`Status`, `College`, `Draft`. The legacy
`site.api.espn.com/apis/site/v2/...` path was discontinued and now 404s
for both leagues.

## Usage

``` r
.espn_basketball_athlete_info(league, athlete_id, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- athlete_id:

  character or numeric. ESPN athlete identifier.

- ...:

  Unused; absorbed for forward compatibility.

## Value

Named list of data frames.
