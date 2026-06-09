# **CBD Recruiting Players**

**Get player recruiting rankings from the CollegeBasketballData API.**

## Usage

``` r
cbbd_recruiting_players(
  year = NULL,
  team = NULL,
  conference = NULL,
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

## See also

Other CBD Recruiting Functions:
[`cbbd_recruiting_portal()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_portal.md),
[`cbbd_recruiting_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_teams.md)

## Examples

``` r
# \donttest{
  try(cbbd_recruiting_players(year = 2024))
#> ✖ 2026-06-09 09:57:44.474411: Invalid arguments or no recruiting players available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
