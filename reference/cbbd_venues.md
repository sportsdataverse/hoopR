# **CBD Venues**

**Get college basketball venues from the CollegeBasketballData API.**

## Usage

``` r
cbbd_venues()
```

## Value

A `hoopR_data` tibble with one row per venue. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_venues")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_venues())
#> ✖ 2026-11-13 18:52:40.81775: Invalid arguments or no venues data available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
