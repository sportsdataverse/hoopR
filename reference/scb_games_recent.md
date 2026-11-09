# **Get BBL / DBBL Recent Games**

Recent, live and upcoming games, one row per game with its past /
present / future bucket.

Endpoint: `GET https://api.basketball-bundesliga.de/games/recent` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_games_recent(league = "bbl", slot_size = NULL)
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- slot_size:

  (default `NULL`) Games per bucket (past, present, future); the API's
  default is 9.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_games_recent")`) and in the
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
  try(scb_games_recent())
#> ── BBL/DBBL Recent Games from the SCB API ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:57:10 UTC
#> # A tibble: 27 × 91
#>    league season season_id game_id competition stage status bucket game_progress
#>    <chr>   <int>     <int> <chr>   <chr>       <chr> <chr>  <chr>  <chr>        
#>  1 bbl      2027      2026 2007035 BBL         MAIN… OFFIC… past   E            
#>  2 bbl      2027      2026 2006857 BBL         MAIN… OFFIC… past   E            
#>  3 bbl      2027      2026 2006858 BBL         MAIN… OFFIC… past   E            
#>  4 bbl      2027      2026 2006860 BBL         MAIN… OFFIC… past   E            
#>  5 bbl      2027      2026 2006856 BBL         MAIN… OFFIC… past   E            
#>  6 bbl      2027      2026 2006859 BBL         MAIN… OFFIC… past   E            
#>  7 bbl      2027      2026 2006861 BBL         MAIN… OFFIC… past   E            
#>  8 bbl      2027      2026 2006863 BBL         MAIN… OFFIC… past   E            
#>  9 bbl      2027      2026 2006862 BBL         MAIN… OFFIC… past   E            
#> 10 bbl      2027      2026 2006864 BBL         MAIN… LIVE   prese… Q2_BREAK     
#> # ℹ 17 more rows
#> # ℹ 82 more variables: scheduled_time <chr>, match_day <int>, is_tbd <lgl>,
#> #   is_hidden <lgl>, home_team_id <chr>, home_season_team_id <chr>,
#> #   home_team_name <chr>, home_tlc <chr>, home_is_foreign <lgl>,
#> #   home_rank <int>, home_streak <chr>, home_streak_count <int>,
#> #   home_last10_victories <int>, home_last10_losses <int>,
#> #   home_total_games <int>, guest_team_id <chr>, guest_season_team_id <chr>, …
# }
```
