# **CBD Conference Membership History**

**Get historical conference membership from the CollegeBasketballData
API.**

## Usage

``` r
cbbd_conferences_history(conference = NULL)
```

## Arguments

- conference:

  (*character* optional): Conference abbreviation filter (e.g. `B1G`).
  See
  [`cbbd_conferences()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences.md)
  for valid values.

## Value

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

## See also

Other CBD Conferences Functions:
[`cbbd_conferences()`](https://hoopR.sportsdataverse.org/reference/cbbd_conferences.md)

## Examples

``` r
# \donttest{
  try(cbbd_conferences_history(conference = "B1G"))
#> ✖ 2026-08-24 19:09:58.577086: Invalid arguments or no conference history available!
#> ✖ Args: conference = "B1G"
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
