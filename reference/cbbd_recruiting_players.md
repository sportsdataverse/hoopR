# **CBD Recruiting Players**

**Get player recruiting rankings from the CollegeBasketballData API.**

**Get team recruiting rankings from the CollegeBasketballData API.**

**Get transfer portal data from the CollegeBasketballData API.**

## Usage

``` r
cbbd_recruiting_players(
  year = NULL,
  team = NULL,
  conference = NULL,
  position = NULL
)

cbbd_recruiting_teams(year = NULL, team = NULL, conference = NULL)

cbbd_recruiting_portal(
  year = NULL,
  source_team = NULL,
  destination_team = NULL,
  source_conference = NULL,
  destination_conference = NULL,
  position = NULL
)
```

## Arguments

- year:

  (*integer* optional): Recruiting class year (e.g. `2024`).

- team:

  (*character* optional): Committed team filter.

- conference:

  (*character* optional): Conference abbreviation filter.

- position:

  (*character* optional): Position filter.

- source_team:

  (*character* optional): Origin team filter.

- destination_team:

  (*character* optional): Destination team filter.

- source_conference:

  (*character* optional): Origin conference filter.

- destination_conference:

  (*character* optional): Destination conference filter.

## Value

A `hoopR_data` tibble with one row per recruit. The `hometown` and
`committed_to` objects are flattened into prefixed columns:

|               |           |                             |
|---------------|-----------|-----------------------------|
| col_name      | types     | description                 |
| id            | integer   | Recruit id.                 |
| source_id     | character | Source (ESPN) recruit id.   |
| position      | character | Recruit position.           |
| school_id     | integer   | High school / club id.      |
| school        | character | High school / club name.    |
| athlete_id    | integer   | Athlete id (once enrolled). |
| year          | integer   | Recruiting class year.      |
| name          | character | Recruit name.               |
| height_inches | numeric   | Height in inches.           |
| weight_pounds | integer   | Weight in pounds.           |
| stars         | integer   | Star rating.                |
| rating        | numeric   | Numeric recruit rating.     |
| ranking       | integer   | Overall ranking.            |

A `hoopR_data` tibble with one row per team:

|            |           |                                |
|------------|-----------|--------------------------------|
| col_name   | types     | description                    |
| team_id    | integer   | CollegeBasketballData team id. |
| team       | character | Team name.                     |
| conference | character | Conference name.               |
| year       | integer   | Recruiting class year.         |
| ranking    | integer   | Team recruiting ranking.       |
| rating     | numeric   | Team recruiting rating.        |

A `hoopR_data` tibble with one row per transfer. The `origin` and
`destination` objects are flattened into prefixed columns:

|                 |           |                                 |
|-----------------|-----------|---------------------------------|
| col_name        | types     | description                     |
| id              | integer   | Transfer id.                    |
| source_id       | character | Source (ESPN) athlete id.       |
| year            | integer   | Transfer class year.            |
| first_name      | character | Player first name.              |
| last_name       | character | Player last name.               |
| position        | character | Player position.                |
| eligibility     | character | Eligibility status.             |
| years_remaining | integer   | Years of eligibility remaining. |
| stars           | integer   | Star rating.                    |
| rating          | numeric   | Numeric rating.                 |

## Examples

``` r
# \donttest{
  try(cbbd_recruiting_players(year = 2024))
#> ✖ 2026-08-26 19:54:18.006631: Invalid arguments or no recruiting players available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_recruiting_teams(year = 2024))
#> ✖ 2026-08-26 19:54:18.016387: Invalid arguments or no team recruiting rankings available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_recruiting_portal(year = 2024))
#> ✖ 2026-08-26 19:54:18.025831: Invalid arguments or no transfer portal data available!
#> ✖ Args: year = 2024, source_team = NULL, destination_team = NULL, source_conference = NULL, destination_conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
