# **Get BBL / DBBL Game**

One game header: teams, score by period, officials, venue and top
scorer.

Endpoint: `GET https://api.basketball-bundesliga.de/games/{game_id}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_game(game_id, league = "bbl")
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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_game")`) and in the searchable
[return
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
  try(scb_game(game_id = "2006920"))
#> ── BBL/DBBL Game from the SCB API ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:02 UTC
#> # A tibble: 1 × 91
#>   league season season_id game_id competition stage      status   stat_status
#>   <chr>   <int>     <int> <chr>   <chr>       <chr>      <chr>    <chr>      
#> 1 bbl      2027      2026 2006920 BBL         MAIN_ROUND OFFICIAL E          
#> # ℹ 83 more variables: game_progress <chr>, scheduled_time <chr>,
#> #   match_day <int>, is_tbd <lgl>, is_hidden <lgl>, home_team_id <chr>,
#> #   home_season_team_id <chr>, home_team_name <chr>, home_tlc <chr>,
#> #   home_is_foreign <lgl>, home_rank <int>, home_streak <chr>,
#> #   home_streak_count <int>, home_last10_victories <int>,
#> #   home_last10_losses <int>, home_total_games <int>, guest_team_id <chr>,
#> #   guest_season_team_id <chr>, guest_team_name <chr>, guest_tlc <chr>, …
# }
```
