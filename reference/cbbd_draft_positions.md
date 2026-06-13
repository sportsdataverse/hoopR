# **CBD Draft Positions**

**Get NBA draft positions from the CollegeBasketballData API.**

## Usage

``` r
cbbd_draft_positions()
```

## Value

A `hoopR_data` tibble with one row per draft position:

|              |           |                        |
|--------------|-----------|------------------------|
| col_name     | types     | description            |
| name         | character | Position name.         |
| abbreviation | character | Position abbreviation. |

## See also

Other CBD Draft Functions:
[`cbbd_draft_picks()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_picks.md),
[`cbbd_draft_teams()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_teams.md)

## Examples

``` r
# \donttest{
  try(cbbd_draft_positions())
#> ✖ 2026-06-13 03:22:42.566463: Invalid arguments or no draft positions available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
