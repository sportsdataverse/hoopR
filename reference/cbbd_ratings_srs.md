# **CBD SRS Ratings**

**Get Simple Rating System (SRS) ratings from the CollegeBasketballData
API.**

**Get adjusted efficiency ratings from the CollegeBasketballData API.**

**Get Elo ratings from the CollegeBasketballData API.**

## Usage

``` r
cbbd_ratings_srs(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL
)

cbbd_ratings_adjusted(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL
)

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

  (*character* optional): Team name filter (e.g. `Duke`).

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per team-season:

|            |           |                                   |
|------------|-----------|-----------------------------------|
| col_name   | types     | description                       |
| season     | integer   | Season (4-digit ending-year).     |
| team_id    | integer   | CollegeBasketballData team id.    |
| team       | character | Team name.                        |
| conference | character | Conference name.                  |
| rating     | numeric   | Simple Rating System (SRS) value. |

A `hoopR_data` tibble with one row per team-season. `rankings_*` columns
are flattened from the nested `rankings` object:

|                  |           |                                       |
|------------------|-----------|---------------------------------------|
| col_name         | types     | description                           |
| season           | integer   | Season (4-digit ending-year).         |
| team_id          | integer   | CollegeBasketballData team id.        |
| team             | character | Team name.                            |
| conference       | character | Conference name.                      |
| offensive_rating | numeric   | Adjusted offensive efficiency rating. |
| defensive_rating | numeric   | Adjusted defensive efficiency rating. |
| net_rating       | numeric   | Adjusted net efficiency rating.       |

A `hoopR_data` tibble with one row per team-season:

|            |           |                                |
|------------|-----------|--------------------------------|
| col_name   | types     | description                    |
| season     | integer   | Season (4-digit ending-year).  |
| team_id    | integer   | CollegeBasketballData team id. |
| team       | character | Team name.                     |
| conference | character | Conference name.               |
| elo        | integer   | End-of-season Elo rating.      |

## Examples

``` r
# \donttest{
  try(cbbd_ratings_srs(season = 2024))
#> ✖ 2026-08-27 17:46:34.333403: Invalid arguments or no SRS ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_ratings_adjusted(season = 2024))
#> ✖ 2026-08-27 17:46:34.343843: Invalid arguments or no adjusted ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_ratings_elo(season = 2024))
#> ✖ 2026-08-27 17:46:34.354132: Invalid arguments or no Elo ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
