# **CBD Elo Ratings**

**Get Elo ratings from the CollegeBasketballData API.**

## Usage

``` r
cbbd_ratings_elo(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- team:

  (*character* optional): Team name filter.

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per team-season:

|            |           |                                |
|------------|-----------|--------------------------------|
| col_name   | types     | description                    |
| season     | integer   | Season (4-digit ending-year).  |
| team_id    | integer   | CollegeBasketballData team id. |
| team       | character | Team name.                     |
| conference | character | Conference name.               |
| elo        | integer   | End-of-season Elo rating.      |

## See also

Other CBD Ratings Functions:
[`cbbd_ratings_adjusted()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_adjusted.md),
[`cbbd_ratings_srs()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_srs.md)

## Examples

``` r
# \donttest{
  try(cbbd_ratings_elo(season = 2024))
#> ✖ 2026-08-24 19:10:01.704958: Invalid arguments or no Elo ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
