# **Get BBL / DBBL Season Player Statistics**

Season player stat table: totals and per-game values, one row per player
and stat block.

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/player-statistics`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_player_statistics(season, league = "bbl", display_type = "MAIN_ROUND")
```

## Arguments

- season:

  (required) Season END year (2026 = 2025-26, the sdv key). Sent to the
  API as its START-year seasonId (season - 1).

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- display_type:

  (default `"MAIN_ROUND"`) Which games the table covers: MAIN_ROUND
  (regular season), PLAYOFFS, PLAYOFFS_TOTAL, MAIN_ROUND_AND_PLAY_OFFS
  or CUP.

## Value

A `hoopR_data` tibble with one row per player and stat block. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_player_statistics")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`scb_seasons()`](https://hoopR.sportsdataverse.org/reference/scb_seasons.md).

## See also

[family_scb](https://hoopR.sportsdataverse.org/reference/family_scb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(scb_player_statistics(season = 2026))
#> ── BBL/DBBL Season Player Statistics from the SCB API ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:19:15 UTC
#> # A tibble: 316 × 72
#>    league season display_type season_player_id real_player_id first_name 
#>    <chr>   <int> <chr>        <chr>                     <int> <chr>      
#>  1 bbl      2026 MAIN_ROUND   2002018               140181613 Christopher
#>  2 bbl      2026 MAIN_ROUND   2001330                   52879 Jordan     
#>  3 bbl      2026 MAIN_ROUND   2001642               140181412 Alonzo     
#>  4 bbl      2026 MAIN_ROUND   2001591               140181388 Marcus     
#>  5 bbl      2026 MAIN_ROUND   2001861               140181529 Isaiah     
#>  6 bbl      2026 MAIN_ROUND   2001900               140181547 Joe        
#>  7 bbl      2026 MAIN_ROUND   2000735                   59862 Ibi        
#>  8 bbl      2026 MAIN_ROUND   2001687               140181424 Tevin      
#>  9 bbl      2026 MAIN_ROUND   2001520                   56766 TJ         
#> 10 bbl      2026 MAIN_ROUND   2001477               140181343 Davion     
#> # ℹ 306 more rows
#> # ℹ 66 more variables: last_name <chr>, shirt_number <chr>, position <chr>,
#> #   team_id <chr>, season_team_id <chr>, team_name <chr>, team_tlc <chr>,
#> #   season_id <int>, round_code <int>, competition <chr>, seconds_played <int>,
#> #   points <int>, two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, …
# }
```
