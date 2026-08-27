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

## Examples

``` r
# \donttest{
  try(cbbd_teams(conference = "ACC"))
#> ✖ 2026-08-27 17:46:35.680084: Invalid arguments or no teams data available!
#> ✖ Args: conference = "ACC", season = 2026
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_teams_roster(season = 2024, team = "Duke"))
#> ✖ 2026-08-27 17:46:35.689951: Invalid arguments or no roster data available!
#> ✖ Args: season = 2024, team = "Duke"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
