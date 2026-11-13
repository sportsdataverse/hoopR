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

A `hoopR_data` tibble with one row per team-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_ratings_srs")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_ratings_adjusted")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team-season. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_ratings_elo")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_ratings_srs(season = 2024))
#> ✖ 2026-11-13 12:49:08.174954: Invalid arguments or no SRS ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_ratings_adjusted(season = 2024))
#> ✖ 2026-11-13 12:49:08.186927: Invalid arguments or no adjusted ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_ratings_elo(season = 2024))
#> ✖ 2026-11-13 12:49:08.19884: Invalid arguments or no Elo ratings available!
#> ✖ Args: season = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
