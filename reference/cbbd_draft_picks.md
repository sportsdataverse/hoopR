# **CBD Draft Teams**

**Get NBA draft teams from the CollegeBasketballData API.**

**Get NBA draft positions from the CollegeBasketballData API.**

**Get NBA draft picks from the CollegeBasketballData API.**

## Usage

``` r
cbbd_draft_teams()

cbbd_draft_positions()

cbbd_draft_picks(
  year = NULL,
  draft_team = NULL,
  source_team = NULL,
  position = NULL
)
```

## Arguments

- year:

  (*integer* optional): Draft year (e.g. `2024`).

- draft_team:

  (*character* optional): NBA team filter.

- source_team:

  (*character* optional): College team filter.

- position:

  (*character* optional): Position filter.

## Value

A `hoopR_data` tibble with one row per NBA team. Its columns are listed
in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_draft_teams")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per draft position. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_draft_positions")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

A `hoopR_data` tibble with one row per draft pick. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cbbd_draft_picks")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Examples

``` r
# \donttest{
  try(cbbd_draft_teams())
#> ✖ 2026-11-09 19:51:56.552406: Invalid arguments or no draft teams available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_draft_positions())
#> ✖ 2026-11-09 19:51:56.559313: Invalid arguments or no draft positions available!
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
# \donttest{
  try(cbbd_draft_picks(year = 2024))
#> ✖ 2026-11-09 19:51:56.566402: Invalid arguments or no draft picks available!
#> ✖ Args: year = 2024, draft_team = NULL, source_team = NULL, position = NULL
#> ✖ Error: api.collegebasketballdata.com requires an API key.        See ?register_cbbd for details.
#> data frame with 0 columns and 0 rows
# }
```
