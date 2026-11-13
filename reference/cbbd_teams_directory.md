# **CBD Team Directory**

**Get the full team directory and conference metadata for a season from
the CollegeBasketballData API.**

## Usage

``` r
cbbd_teams_directory(season = most_recent_mbb_season())
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit format ending-year (e.g.
  `2025` for the 2024-25 season). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

## Value

A named list of `hoopR_data` tibbles: `teams`, `conferences`. Their
column names and types are in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md),
e.g. `subset(return_columns, fn == "cbbd_teams_directory")`, and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other CBD Teams Functions:
[`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md),
[`cbbd_teams_season_overview()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_season_overview.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams_directory(season = 2025))
#> ✖ 2026-11-13 12:49:09.511591: Invalid arguments or no team directory data available!
#> ✖ Args: season = 2025
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> list()
# }
```
