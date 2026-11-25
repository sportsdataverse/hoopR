# **CBD API Key Info**

**Get the tier, monthly call allowance and remaining calls of your
CollegeBasketballData API key.**

CollegeBasketballData and CollegeFootballData draw on one shared monthly
allowance. This request consumes no calls.

## Usage

``` r
cbbd_api_key_info()
```

## Value

A `hoopR_data` tibble with one row per API key. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_api_key_info")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## See also

[register_cbbd](https://hoopR.sportsdataverse.org/reference/register_cbbd.md)
for saving the key.

## Examples

``` r
# \donttest{
  try(cbbd_api_key_info())
#> ✖ 2026-11-25 06:54:13.430311: Invalid API key or no API key info available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
