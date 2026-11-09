# **CBD Teams**

**Get college basketball teams from the CollegeBasketballData API.**

**Get a college basketball team roster from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_teams(conference = NULL, season = most_recent_mbb_season())

cbbd_teams_roster(season = most_recent_mbb_season(), team = NULL)
```

## Arguments

- conference:

  (*character* optional): Conference abbreviation filter (e.g. `ACC`).
  See
  [`cbbd_conferences()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences.md)
  for valid values.

- season:

  (*integer* optional): Season, in 4-digit format ending-year (e.g.
  `2024` for the 2023-24 season). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* optional): Team name filter (e.g. `Duke`).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_teams")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_teams_roster")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other CBD Teams Functions:
[`cbbd_teams_directory()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_directory.md),
[`cbbd_teams_season_overview()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_season_overview.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams(conference = "ACC"))
#> ✖ 2026-11-09 19:09:49.253348: Invalid arguments or no teams data available!
#> ✖ Args: conference = "ACC", season = 2027
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_teams_roster(season = 2024, team = "Duke"))
#> ✖ 2026-11-09 19:09:49.263889: Invalid arguments or no roster data available!
#> ✖ Args: season = 2024, team = "Duke"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
