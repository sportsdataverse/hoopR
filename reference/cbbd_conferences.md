# **CBD Conferences**

**Get college basketball conferences from the CollegeBasketballData
API.**

**Get historical conference membership from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_conferences()

cbbd_conferences_history(conference = NULL)
```

## Arguments

- conference:

  (*character* optional): Conference abbreviation filter (e.g. `B1G`).
  See `cbbd_conferences()` for valid values.

## Value

A `hoopR_data` tibble with one row per conference. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_conferences")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per conference. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_conferences_history")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_conferences())
#> ✖ 2026-11-13 18:13:25.460255: Invalid arguments or no conferences data available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_conferences_history(conference = "B1G"))
#> ✖ 2026-11-13 18:13:25.503481: Invalid arguments or no conference history available!
#> ✖ Args: conference = "B1G"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
