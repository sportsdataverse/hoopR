# **CBD Betting Lines**

**Get game betting lines from the CollegeBasketballData API.**

**Get betting line providers from the CollegeBasketballData API.**

## Usage

``` r
cbbd_lines(
  season = most_recent_mbb_season(),
  team = NULL,
  conference = NULL,
  start_date_range = NULL,
  end_date_range = NULL
)

cbbd_lines_providers()
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

- start_date_range:

  (*character* optional): ISO 8601 start of date range.

- end_date_range:

  (*character* optional): ISO 8601 end of date range.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_lines")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per line provider. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_lines_providers")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_lines(season = 2024, team = "Duke"))
#> ✖ 2026-11-13 13:57:01.547573: Invalid arguments or no betting lines available!
#> ✖ Args: season = 2024, team = "Duke", conference = NULL, start_date_range = NULL, end_date_range = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_lines_providers())
#> ✖ 2026-11-13 13:57:01.556252: Invalid arguments or no line providers available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
