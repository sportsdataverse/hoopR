# **CBD Recruiting Players**

**Get player recruiting rankings from the CollegeBasketballData API.**

**Get team recruiting rankings from the CollegeBasketballData API.**

**Get transfer portal data from the CollegeBasketballData API.**

## Usage

``` r
cbbd_recruiting_players(
  year = NULL,
  team = NULL,
  conference = NULL,
  position = NULL
)

cbbd_recruiting_teams(year = NULL, team = NULL, conference = NULL)

cbbd_recruiting_portal(
  year = NULL,
  source_team = NULL,
  destination_team = NULL,
  source_conference = NULL,
  destination_conference = NULL,
  position = NULL
)
```

## Arguments

- year:

  (*integer* optional): Recruiting class year (e.g. `2024`).

- team:

  (*character* optional): Committed team filter.

- conference:

  (*character* optional): Conference abbreviation filter.

- position:

  (*character* optional): Position filter.

- source_team:

  (*character* optional): Origin team filter.

- destination_team:

  (*character* optional): Destination team filter.

- source_conference:

  (*character* optional): Origin conference filter.

- destination_conference:

  (*character* optional): Destination conference filter.

## Value

A `hoopR_data` tibble with one row per recruit. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_recruiting_players")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_recruiting_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per transfer. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_recruiting_portal")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_recruiting_players(year = 2024))
#> ✖ 2026-11-09 19:51:57.980328: Invalid arguments or no recruiting players available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_recruiting_teams(year = 2024))
#> ✖ 2026-11-09 19:51:57.989775: Invalid arguments or no team recruiting rankings available!
#> ✖ Args: year = 2024, team = NULL, conference = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_recruiting_portal(year = 2024))
#> ✖ 2026-11-09 19:51:57.998718: Invalid arguments or no transfer portal data available!
#> ✖ Args: year = 2024, source_team = NULL, destination_team = NULL, source_conference = NULL, destination_conference = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
