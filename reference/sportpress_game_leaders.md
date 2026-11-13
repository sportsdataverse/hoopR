# **Get BNXT League Game Leaders**

The game leader of each side in every statistic (one row per side and
statistic).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`

## Usage

``` r
sportpress_game_leaders(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble with one row per side and statistic. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_leaders")`) and in the
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
  try(sportpress_game_leaders(game_id = 11295))
#> ── BNXT League Game Leaders from Sportpress ───────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:36 UTC
#> # A tibble: 56 × 12
#>    game_id team_side competition_team_id team    team_short_name stat  player_id
#>      <int> <chr>                   <int> <chr>   <chr>           <chr>     <int>
#>  1   11295 home                      541 Windro… ANT             minu…      5325
#>  2   11295 home                      541 Windro… ANT             foul        228
#>  3   11295 home                      541 Windro… ANT             defe…      5325
#>  4   11295 home                      541 Windro… ANT             dunk…      5683
#>  5   11295 home                      541 Windro… ANT             dunk…      5683
#>  6   11295 home                      541 Windro… ANT             dunk…      5683
#>  7   11295 home                      541 Windro… ANT             two_…       202
#>  8   11295 home                      541 Windro… ANT             two_…       202
#>  9   11295 home                      541 Windro… ANT             two_…      5683
#> 10   11295 home                      541 Windro… ANT             thre…      5325
#> # ℹ 46 more rows
#> # ℹ 5 more variables: first_name <chr>, last_name <chr>,
#> #   nationality_code <chr>, birth_date <date>, value <dbl>
# }
```
