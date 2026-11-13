# **Get BNXT League Game Team Box Score**

Team totals of both sides from the box score of a finished game.

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`

## Usage

``` r
sportpress_game_team_box(competition_id, game_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

- game_id:

  (required) Game id (integer), unique across seasons; from
  [`sportpress_schedule()`](https://hoopR.sportsdataverse.org/reference/sportpress_schedule.md)
  (`game_id`).

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_team_box")`) and in the
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
  try(sportpress_game_team_box(competition_id = 25, game_id = 11295))
#> ── BNXT League Game Team Box Score from Sportpress ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:39 UTC
#> # A tibble: 2 × 35
#>   game_id competition_id team_side competition_team_id team      team_short_name
#>     <int>          <int> <chr>                   <int> <chr>     <chr>          
#> 1   11295             25 home                      541 Windrose… ANT            
#> 2   11295             25 away                      565 House of… KOR            
#> # ℹ 29 more variables: minute <int>, foul <int>, defensive_foul <int>,
#> #   dunk_made <int>, dunk_all <int>, dunk_percent <dbl>, two_point_made <int>,
#> #   two_point_all <int>, two_point_percent <dbl>, three_point_made <int>,
#> #   three_point_all <int>, three_point_percent <dbl>, throw_made <int>,
#> #   throw_all <int>, throw_percent <dbl>, free_throw_made <int>,
#> #   free_throw_all <int>, free_throw_percent <dbl>, offensive_rebound <int>,
#> #   defensive_rebound <int>, total_rebound <int>, block <int>, …
# }
```
