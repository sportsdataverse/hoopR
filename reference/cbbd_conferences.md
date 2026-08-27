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

A `hoopR_data` tibble with one row per conference:

|              |           |                                       |
|--------------|-----------|---------------------------------------|
| col_name     | types     | description                           |
| id           | integer   | CollegeBasketballData conference id.  |
| source_id    | character | Source (ESPN) conference id.          |
| name         | character | Conference name (e.g. `Big Ten`).     |
| abbreviation | character | Conference abbreviation (e.g. `B1G`). |
| short_name   | character | Conference short name.                |

A `hoopR_data` tibble with one row per conference. The `teams` column is
a nested list of per-team membership spans:

|              |           |                                              |
|--------------|-----------|----------------------------------------------|
| col_name     | types     | description                                  |
| id           | integer   | CollegeBasketballData conference id.         |
| source_id    | character | Source (ESPN) conference id.                 |
| name         | character | Conference name.                             |
| abbreviation | character | Conference abbreviation.                     |
| short_name   | character | Conference short name.                       |
| teams        | list      | Nested list of member-team membership spans. |

## Examples

``` r
# \donttest{
  try(cbbd_conferences())
#> ✖ 2026-08-27 17:46:32.636837: Invalid arguments or no conferences data available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_conferences_history(conference = "B1G"))
#> ✖ 2026-08-27 17:46:32.645083: Invalid arguments or no conference history available!
#> ✖ Args: conference = "B1G"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
