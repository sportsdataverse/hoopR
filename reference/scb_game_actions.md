# **Get BBL / DBBL Game Play-by-Play**

Play-by-play of a finished game with shot x/y (BBL 2008-09 on, DBBL
2024-25 on).

Endpoint:
`GET https://api.basketball-bundesliga.de/games/{game_id}/stats` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game_actions(game_id, league = "bbl")
```

## Arguments

- game_id:

  (required) Game id (`game_id` in `scb_games`), e.g. 2006920 (BBL) or
  10130 (DBBL). One sequence per league.

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_game_actions")`) and in the
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
  try(scb_game_actions(game_id = "2006920"))
#> ── BBL/DBBL Game Play-by-Play from the SCB API ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:16:58 UTC
#> # A tibble: 516 × 20
#>    league game_id action_id order_id action_identifier period game_time
#>    <chr>  <chr>       <int>    <int> <chr>              <int> <chr>    
#>  1 bbl    2006920  20224750        1 0:0002                 1 00:10:00 
#>  2 bbl    2006920  20224751        2 3:0012                 1 00:10:00 
#>  3 bbl    2006920  20224752        3 3:0013                 1 00:09:47 
#>  4 bbl    2006920  20224753        4 3:0014                 1 00:09:21 
#>  5 bbl    2006920  20224754        5 3:0015                 1 00:09:21 
#>  6 bbl    2006920  20224755        6 3:0016                 1 00:09:17 
#>  7 bbl    2006920  20224756        7 3:0018                 1 00:09:07 
#>  8 bbl    2006920  20224757        8 3:0020                 1 00:08:50 
#>  9 bbl    2006920  20224758        9 3:0021                 1 00:08:50 
#> 10 bbl    2006920  20224759       10 3:0022                 1 00:08:43 
#> # ℹ 506 more rows
#> # ℹ 13 more variables: seconds_left <int>, real_time <chr>, type <chr>,
#> #   qualifiers <chr>, is_successful <lgl>, season_team_id <chr>, side <chr>,
#> #   season_player_id <chr>, assisting_season_player_id <chr>, shot_x <int>,
#> #   shot_y <int>, home_team_points <int>, guest_team_points <int>
# }
```
