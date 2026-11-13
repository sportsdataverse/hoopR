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

A `hoopR_data` tibble with one row per ranked team per poll. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_rankings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_rankings(season = 2024, poll_type = "ap"))
#> ✖ 2026-11-13 21:11:17.708887: Invalid arguments or no rankings data available!
#> ✖ Args: season = 2024, season_type = NULL, week = NULL, poll_type = "ap", team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
