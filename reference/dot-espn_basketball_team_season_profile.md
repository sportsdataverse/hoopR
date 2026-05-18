# Internal: ESPN basketball team-in-season profile

Fetches the core-v2 per-season team profile
`sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/teams/{team_id}`
and returns a single-row tibble of the team's era-correct identity
scalars plus the available `$ref` URLs for deeper resources (record,
statistics, leaders, coaches, etc.). Older seasons return fewer `$ref`
keys; missing refs become `NA_character_`.

## Usage

``` r
.espn_basketball_team_season_profile(league, team_id, season, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- team_id:

  character or numeric. ESPN team identifier.

- season:

  numeric. Season year (e.g. 2025).

- ...:

  Unused; absorbed for forward compatibility.

## Value

A single-row `hoopR_data` tibble, or `NULL` on error.
