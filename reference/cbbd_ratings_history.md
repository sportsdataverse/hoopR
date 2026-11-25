# **CBD Rating History**

**Get daily snapshots of adjusted efficiency and SRS ratings from the
CollegeBasketballData API.**

Give at least one of `date` or `team`. The endpoint needs a Patreon Tier
2 API key or higher, and seasons before the current one need Tier 3 or
higher.

## Usage

``` r
cbbd_ratings_history(
  season = most_recent_mbb_season(),
  date = NULL,
  team = NULL,
  conference = NULL
)
```

## Arguments

- season:

  (*integer* optional): Season, 4-digit ending-year (e.g. `2025`).
  Defaults to
  [`most_recent_mbb_season()`](https://hoopR.sportsdataverse.org/reference/most_recent_mbb_season.md).

- date:

  (*character* optional): UTC rating date, `YYYY-MM-DD` (e.g.
  `"2025-02-01"`). Required when `team` is not given.

- team:

  (*character* optional): Team name filter (e.g. `Duke`). Required when
  `date` is not given.

- conference:

  (*character* optional): Conference abbreviation filter.

## Value

A `hoopR_data` tibble with one row per team-date. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_ratings_history")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

Other CBD Ratings Functions:
[`cbbd_ratings_srs()`](https://hoopR.sportsdataverse.org/reference/cbbd_ratings_srs.md)

## Examples

``` r
# \donttest{
  try(cbbd_ratings_history(season = 2025, team = "Duke"))
#> ✖ 2026-11-25 06:54:14.864479: Invalid arguments or no rating history available!
#> ✖ Args: season = 2025, date = NULL, team = "Duke", conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
