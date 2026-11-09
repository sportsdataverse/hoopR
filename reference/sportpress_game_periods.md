# **Get BNXT League Game Periods**

Points each side scored in each period of a game (periods 5 and up are
overtimes).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/find/{game_id}`

## Usage

``` r
sportpress_game_periods(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble with one row per side and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_periods")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_game_periods(game_id = 11295))
#> ── BNXT League Game Periods from Sportpress ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:16:55 UTC
#> # A tibble: 12 × 5
#>    game_id team_side competition_team_id period score
#>      <int> <chr>                   <int>  <int> <int>
#>  1   11295 home                      541      1    22
#>  2   11295 home                      541      2    24
#>  3   11295 home                      541      3    19
#>  4   11295 home                      541      4    19
#>  5   11295 home                      541      5     9
#>  6   11295 home                      541      6    20
#>  7   11295 away                      565      1    24
#>  8   11295 away                      565      2    21
#>  9   11295 away                      565      3    16
#> 10   11295 away                      565      4    23
#> 11   11295 away                      565      5     9
#> 12   11295 away                      565      6    13
# }
```
