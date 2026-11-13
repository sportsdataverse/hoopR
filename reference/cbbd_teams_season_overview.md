# **CBD Team Season Overview**

**Get a stored full-season overview of one team from the
CollegeBasketballData API.**

## Usage

``` r
cbbd_teams_season_overview(team_id, season = most_recent_mbb_season())
```

## Arguments

- team_id:

  (*integer* required): CollegeBasketballData team id. See
  [`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md)
  or
  [`cbbd_teams_directory()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_directory.md)
  for valid values.

- season:

  (*integer* required): Season, in 4-digit format ending-year (e.g.
  `2025` for the 2024-25 season). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A named list of `hoopR_data` tibbles: `team`, `record`, `ratings`,
`efficiency`, `shooting`, `players`, `schedule`, `sources`. Their column
names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "cbbd_teams_season_overview")`, and
in the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other CBD Teams Functions:
[`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md),
[`cbbd_teams_directory()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_directory.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams_season_overview(team_id = 72, season = 2025))
#> ✖ 2026-11-13 18:52:40.636838: Invalid arguments or no team season overview data available!
#> ✖ Args: team_id = 72, season = 2025
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> list()
# }
```
