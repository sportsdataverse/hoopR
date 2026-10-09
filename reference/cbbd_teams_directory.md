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

A named list of two `hoopR_data` tibbles, `teams` and `conferences`.
Both carry the season as attributes: `season` (integer) and
`season_label` (character, the upstream season label).

**teams: one row per team**

|  |  |  |
|----|----|----|
| col_name | type | description |
| id | integer | CollegeBasketballData team id. |
| source_id | character | Source (ESPN) team id. |
| school | character | School name. |
| mascot | character | Team mascot. |
| abbreviation | character | Team abbreviation. |
| display_name | character | Full display name (school and mascot). |
| short_display_name | character | Short display name. |
| conference_id | integer | Conference id for the season; joins to `id` in `conferences`. |

**conferences: one row per conference**

|              |           |                          |
|--------------|-----------|--------------------------|
| col_name     | type      | description              |
| id           | integer   | Conference id.           |
| name         | character | Conference name.         |
| abbreviation | character | Conference abbreviation. |

## See also

Other CBD Teams Functions:
[`cbbd_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams.md),
[`cbbd_teams_season_overview()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_season_overview.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams_directory(season = 2025))
#> ✖ 2026-10-09 04:31:35.006421: Invalid arguments or no team directory data available!
#> ✖ Args: season = 2025
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> list()
# }
```
