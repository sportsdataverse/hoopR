# **CBD Draft Teams**

**Get NBA draft teams from the CollegeBasketballData API.**

## Usage

``` r
cbbd_draft_teams()
```

## Value

A `hoopR_data` tibble with one row per NBA team:

|              |           |                         |
|--------------|-----------|-------------------------|
| col_name     | types     | description             |
| id           | integer   | NBA team id.            |
| source_id    | character | Source (ESPN) team id.  |
| location     | character | Team location (city).   |
| name         | character | Team name.              |
| display_name | character | Full team display name. |
| abbreviation | character | Team abbreviation.      |

## See also

Other CBD Draft Functions:
[`cbbd_draft_picks()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_picks.md),
[`cbbd_draft_positions()`](https://hoopR.sportsdataverse.org/reference/cbbd_draft_positions.md)

## Examples

``` r
# \donttest{
  try(cbbd_draft_teams())
#> ✖ 2026-06-09 22:48:19.966144: Invalid arguments or no draft teams available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
