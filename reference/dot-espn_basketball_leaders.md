# Internal: ESPN basketball league-wide statistical leaders

Fetches
`site.web.api.espn.com/apis/common/v3/sports/basketball/{league}/statistics/byathlete`
for the given season and season type and returns a flat tibble of
leaders (one row per category-athlete pair).

## Usage

``` r
.espn_basketball_leaders(league, season, season_type = 2, ...)
```

## Arguments

- league:

  character. `"nba"` or `"mens-college-basketball"`.

- season:

  numeric. Season year.

- season_type:

  integer. 1 = preseason, 2 = regular (default), 3 = postseason.

- ...:

  Unused; reserved for forward compatibility.

## Value

A `hoopR_data` tibble, or `NULL` on error.
