# **Get BNXT League Game Overview**

Team totals of both sides of a finished game.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/schedule/overview/{game_id}`

## Usage

``` r
sportpress_game_overview(game_id)
```

## Arguments

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_overview")`) and in the
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
  try(sportpress_game_overview(game_id = 11295))
#> ── BNXT League Game Overview from Sportpress ──────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:55:06 UTC
#> # A tibble: 2 × 35
#>   game_id team_side competition_team_id team  team_short_name score minute  foul
#>     <int> <chr>                   <int> <chr> <chr>           <int>  <int> <int>
#> 1   11295 home                      541 Wind… ANT               113    250    30
#> 2   11295 away                      565 Hous… KOR               106    250    26
#> # ℹ 27 more variables: defensive_foul <int>, dunk_made <int>, dunk_all <int>,
#> #   dunk_percent <dbl>, two_point_made <int>, two_point_all <int>,
#> #   two_point_percent <dbl>, three_point_made <int>, three_point_all <int>,
#> #   three_point_percent <dbl>, throw_made <int>, throw_all <int>,
#> #   throw_percent <dbl>, free_throw_made <int>, free_throw_all <int>,
#> #   free_throw_percent <dbl>, offensive_rebound <int>, defensive_rebound <int>,
#> #   total_rebound <int>, block <int>, block_against <int>, turnover <int>, …
# }
```
