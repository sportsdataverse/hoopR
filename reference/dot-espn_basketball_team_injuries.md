# Internal helper: fetch team-scoped ESPN basketball injuries

Fetches the `injuries` array from
`https://site.api.espn.com/apis/site/v2/sports/basketball/{league}/teams/{team_id}/injuries`
and returns a flat tibble.

## Usage

``` r
.espn_basketball_team_injuries(league, team_id, ...)
```

## Arguments

- league:

  character(1). One of `"nba"` or `"mens-college-basketball"`.

- team_id:

  character or numeric. ESPN team identifier (passed as-is; no
  zero-padding applied).

- ...:

  Currently unused. Reserved for future argument threading.

## Value

A `hoopR_data` tibble (or `NULL` on error). Expected columns include
`team_id`, `athlete_id`, `athlete_name`, `position`, `status`, `date`,
`type`, `side`, `returns_at`, `short_comment`, `long_comment`.
