# **CBD Teams**

**Get college basketball teams from the CollegeBasketballData API.**

## Usage

``` r
cbbd_teams(conference = NULL, season = most_recent_mbb_season())
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

## Value

A `hoopR_data` tibble with one row per team:

|                    |           |                                |
|--------------------|-----------|--------------------------------|
| col_name           | types     | description                    |
| id                 | integer   | CollegeBasketballData team id. |
| source_id          | character | Source (ESPN) team id.         |
| school             | character | School name.                   |
| mascot             | character | Team mascot.                   |
| abbreviation       | character | Team abbreviation.             |
| display_name       | character | Full team display name.        |
| short_display_name | character | Short team display name.       |
| primary_color      | character | Primary team color (hex).      |
| secondary_color    | character | Secondary team color (hex).    |
| current_venue_id   | integer   | Current home venue id.         |
| current_venue      | character | Current home venue name.       |
| current_city       | character | Current home venue city.       |
| current_state      | character | Current home venue state.      |
| conference_id      | integer   | Conference id.                 |
| conference         | character | Conference name.               |

## See also

Other CBD Teams Functions:
[`cbbd_teams_roster()`](https://hoopR.sportsdataverse.org/reference/cbbd_teams_roster.md)

## Examples

``` r
# \donttest{
  try(cbbd_teams(conference = "ACC"))
#> ✖ 2026-06-09 13:47:00.2915: Invalid arguments or no teams data available!
#> ✖ Args: conference = "ACC", season = 2026
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
