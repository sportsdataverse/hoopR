# **CBD Line Providers**

**Get betting line providers from the CollegeBasketballData API.**

## Usage

``` r
cbbd_lines_providers()
```

## Value

A `hoopR_data` tibble with one row per line provider:

|          |           |                     |
|----------|-----------|---------------------|
| col_name | types     | description         |
| id       | integer   | Line provider id.   |
| name     | character | Line provider name. |

## See also

Other CBD Lines Functions:
[`cbbd_lines()`](https://hoopR.sportsdataverse.org/reference/cbbd_lines.md)

## Examples

``` r
# \donttest{
  try(cbbd_lines_providers())
#> ✖ 2026-06-13 05:49:02.717351: Invalid arguments or no line providers available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
