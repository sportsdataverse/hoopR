# **CBD Recruiting Team Rankings**

**Get team recruiting rankings from the CollegeBasketballData API.**

## Usage

``` r
cbbd_recruiting_teams(year = NULL, team = NULL, conference = NULL)
```

## Arguments

- year:

  (*integer* optional): Recruiting class year (e.g. `2024`).

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

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

## See also

Other CBD Recruiting Functions:
[`cbbd_recruiting_players()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_players.md),
[`cbbd_recruiting_portal()`](https://hoopR.sportsdataverse.org/reference/cbbd_recruiting_portal.md)

## Examples

``` r
# \donttest{
  try(cbbd_recruiting_teams(year = 2024))
#> ✖ 2026-06-12 14:38:46.226813: Invalid arguments or no team recruiting rankings available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
