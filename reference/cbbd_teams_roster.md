# **CBD Team Roster**

**Get a college basketball team roster from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_teams_roster(season = most_recent_mbb_season(), team = NULL)
```

## Arguments

- season:

  (*integer* required): Season, in 4-digit format ending-year (e.g.
  `2024`). Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* optional): Team name filter (e.g. `Duke`).

## Value

A `hoopR_data` tibble with one row per team. The `players` column is a
nested list of roster players:

|                |           |                                |
|----------------|-----------|--------------------------------|
| col_name       | types     | description                    |
| team_id        | integer   | CollegeBasketballData team id. |
| team_source_id | character | Source (ESPN) team id.         |
| team           | character | Team name.                     |
| conference     | character | Conference name.               |
| season         | integer   | Season (4-digit ending-year).  |
| players        | list      | Nested list of roster players. |

## See also

Other CBD Teams Functions:
[`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams_roster(season = 2024, team = "Duke"))
#> ✖ 2026-06-09 21:19:39.354453: Invalid arguments or no roster data available!
#> ✖ Args: season = 2024, team = "Duke"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
