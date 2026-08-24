# **CBD Rankings**

**Get poll rankings (AP / Coaches) from the CollegeBasketballData API.**

## Usage

``` r
cbbd_rankings(
  season = most_recent_mbb_season(),
  season_type = NULL,
  week = NULL,
  poll_type = NULL,
  team = NULL,
  conference = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- season_type:

  (*character* optional): One of `regular`, `postseason`, `preseason`.

- week:

  (*integer* optional): Poll week filter.

- poll_type:

  (*character* optional): One of `ap`, `coaches`.

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per ranked team per poll:

|                   |           |                                |
|-------------------|-----------|--------------------------------|
| col_name          | types     | description                    |
| season            | integer   | Season (4-digit ending-year).  |
| season_type       | character | Season type.                   |
| week              | integer   | Poll week.                     |
| poll_date         | character | Date the poll was released.    |
| poll_type         | character | Poll type (`ap` or `coaches`). |
| team_id           | integer   | CollegeBasketballData team id. |
| team              | character | Team name.                     |
| conference        | character | Conference name.               |
| ranking           | integer   | Poll rank.                     |
| points            | numeric   | Poll points received.          |
| first_place_votes | numeric   | Number of first-place votes.   |

## Examples

``` r
# \donttest{
  try(cbbd_rankings(season = 2024, poll_type = "ap"))
#> ✖ 2026-08-24 20:39:06.794024: Invalid arguments or no rankings data available!
#> ✖ Args: season = 2024, season_type = NULL, week = NULL, poll_type = "ap", team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
