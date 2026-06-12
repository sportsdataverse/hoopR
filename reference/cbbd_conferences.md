# **CBD Conferences**

**Get college basketball conferences from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_conferences()
```

## Value

A `hoopR_data` tibble with one row per conference:

|              |           |                                       |
|--------------|-----------|---------------------------------------|
| col_name     | types     | description                           |
| id           | integer   | CollegeBasketballData conference id.  |
| source_id    | character | Source (ESPN) conference id.          |
| name         | character | Conference name (e.g. `Big Ten`).     |
| abbreviation | character | Conference abbreviation (e.g. `B1G`). |
| short_name   | character | Conference short name.                |

## See also

Other CBD Conferences Functions:
[`cbbd_conferences_history()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences_history.md)

## Examples

``` r
# \donttest{
  try(cbbd_conferences())
#> ✖ 2026-06-12 14:38:39.949252: Invalid arguments or no conferences data available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
