# **Get BNXT League Game Box Score**

Per-player box score of a finished game (one row per player line).

Endpoint:
`GET https://bnxt.sportpress.info/api/v1/boxscore/game/{competition_id}/{game_id}`

## Usage

``` r
sportpress_game_box(competition_id, game_id)
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

A `hoopR_data` tibble with one row per player line. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_game_box")`) and in the
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
  try(sportpress_game_box(competition_id = 25, game_id = 11295))
#> ── BNXT League Game Box Score from Sportpress ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:57:40 UTC
#> # A tibble: 21 × 45
#>    game_id competition_id team_side competition_team_id team     team_short_name
#>      <int>          <int> <chr>                   <int> <chr>    <chr>          
#>  1   11295             25 home                      541 Windros… ANT            
#>  2   11295             25 home                      541 Windros… ANT            
#>  3   11295             25 home                      541 Windros… ANT            
#>  4   11295             25 home                      541 Windros… ANT            
#>  5   11295             25 home                      541 Windros… ANT            
#>  6   11295             25 home                      541 Windros… ANT            
#>  7   11295             25 home                      541 Windros… ANT            
#>  8   11295             25 home                      541 Windros… ANT            
#>  9   11295             25 home                      541 Windros… ANT            
#> 10   11295             25 home                      541 Windros… ANT            
#> # ℹ 11 more rows
#> # ℹ 39 more variables: roster_id <int>, player_id <int>, first_name <chr>,
#> #   last_name <chr>, nationality_code <chr>, birth_date <date>,
#> #   position_id <int>, position <chr>, starter <lgl>, jersey <chr>,
#> #   minute <int>, foul <int>, defensive_foul <int>, dunk_made <int>,
#> #   dunk_all <int>, dunk_percent <dbl>, two_point_made <int>,
#> #   two_point_all <int>, two_point_percent <dbl>, three_point_made <int>, …
# }
```
