# **CBD Transfer Portal**

**Get transfer portal data from the CollegeBasketballData API.**

## Usage

``` r
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

  (*integer* optional): Transfer class year (e.g. `2024`).

- source_team:

  (*character* optional): Origin team filter.

- destination_team:

  (*character* optional): Destination team filter.

- source_conference:

  (*character* optional): Origin conference filter.

- destination_conference:

  (*character* optional): Destination conference filter.

- position:

  (*character* optional): Position filter.

## Value

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

## See also

Other CBD Recruiting Functions:
[`cbbd_recruiting_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_players.md),
[`cbbd_recruiting_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_teams.md)

## Examples

``` r
# \donttest{
  try(cbbd_recruiting_portal(year = 2024))
#> ✖ 2026-06-13 07:17:46.243792: Invalid arguments or no transfer portal data available!
#> ✖ Args: year = 2024, source_team = NULL, destination_team = NULL, source_conference = NULL, destination_conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
