# **CBD Venues**

**Get college basketball venues from the CollegeBasketballData API.**

## Usage

``` r
cbbd_venues()
```

## Value

A `hoopR_data` tibble with one row per venue:

|           |           |                                 |
|-----------|-----------|---------------------------------|
| col_name  | types     | description                     |
| id        | integer   | CollegeBasketballData venue id. |
| source_id | character | Source (ESPN) venue id.         |
| name      | character | Venue name.                     |
| city      | character | Venue city.                     |
| state     | character | Venue state.                    |
| country   | character | Venue country.                  |

## Examples

``` r
# \donttest{
  try(cbbd_venues())
#> ✖ 2026-06-13 02:22:20.816065: Invalid arguments or no venues data available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
