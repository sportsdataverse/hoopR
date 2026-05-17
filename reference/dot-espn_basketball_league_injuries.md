# Internal helper: fetch league-wide ESPN basketball injuries

Fetches the `injuries` array from
`https://site.api.espn.com/apis/site/v2/sports/basketball/{league}/injuries`
and returns a flat tibble. The `season` parameter is informational only
(ESPN's injury endpoint does not accept a `?season=` query parameter)
but is attached as a constant column on the output for downstream joins.

## Usage

``` r
.espn_basketball_league_injuries(league, season, ...)
```

## Arguments

- league:

  character(1). One of `"nba"` or `"mens-college-basketball"`.

- season:

  numeric or character. The season year (e.g. `2025`). Attached as a
  constant column; not sent as a query parameter.

- ...:

  Currently unused. Reserved for future argument threading.

## Value

A `hoopR_data` tibble (or `NULL` on error). Columns depend on the ESPN
response; expected columns include `team_id`, `athlete_id`,
`athlete_name`, `position`, `status`, `date`, `type`, `side`,
`returns_at`, `short_comment`, `long_comment`. Returns an empty tibble
when ESPN's `injuries` array is empty (common for MBB).
