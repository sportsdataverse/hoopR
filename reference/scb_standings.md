# **Get BBL / DBBL Standings**

League table of a season: record, home / away split, streaks and
tie-break detail (2005-06 on).

Endpoint: `GET https://api.basketball-bundesliga.de/standings` (DBBL:
the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_standings(league = "bbl", season = NULL, competition = NULL)
```

## Arguments

- league:

  (default `"bbl"`) League: `bbl` (men, easyCredit Basketball
  Bundesliga, api.basketball-bundesliga.de) or `dbbl` (women, Toyota
  Damen-Basketball-Bundesliga, api-1.dbbl.scb.world). The two share one
  API; game ids overlap, so a game is (league, game_id).

- season:

  (default `NULL`) Season END year (2026 = 2025-26, the sdv key). Sent
  to the API as its START-year seasonId (season - 1). Omitted = the
  season in progress. Seasons before about 2000 answer an empty table.

- competition:

  (default `NULL`) Competition: BBL, BBL_CUP, ALLSTAR, CHAMPIONS_CUP
  (BBL host) or DBBL, DBBL_CUP (DBBL host). BBL_CUP answers an empty
  table.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_standings")`) and in the searchable
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
  try(scb_standings())
#> ── BBL/DBBL Standings from the SCB API ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:58:49 UTC
#> # A tibble: 18 × 55
#>    league season standing_id season_team_id team_id team_name           team_tlc
#>    <chr>   <int> <chr>       <chr>          <chr>   <chr>               <chr>   
#>  1 bbl      2027 74719       486            486     FC Bayern München … FCB     
#>  2 bbl      2027 74708       414            414     VET-CONCEPT Gladia… TRI     
#>  3 bbl      2027 74714       428            428     SYNTAINICS MBC      MBC     
#>  4 bbl      2027 74722       551            551     ROSTOCK SEAWOLVES   HRO     
#>  5 bbl      2027 74709       415            415     Telekom Baskets Bo… BON     
#>  6 bbl      2027 74713       426            426     SKYLINERS           FRS     
#>  7 bbl      2027 74720       540            540     Fitness First Würz… WUE     
#>  8 bbl      2027 74711       420            420     BMA365 Bamberg Bas… BAM     
#>  9 bbl      2027 74715       430            430     EWE Baskets Oldenb… OLD     
#> 10 bbl      2027 74716       433            433     MHP RIESEN Ludwigs… LUD     
#> 11 bbl      2027 74707       413            413     ALBA BERLIN         BER     
#> 12 bbl      2027 74712       422            422     Basketball Löwen B… BRA     
#> 13 bbl      2027 74721       541            541     RASTA Vechta        VEC     
#> 14 bbl      2027 74710       418            418     ratiopharm ulm      ULM     
#> 15 bbl      2027 74723       554            554     Veolia Towers Hamb… HAM     
#> 16 bbl      2027 74717       483            483     Science City Jena   JEN     
#> 17 bbl      2027 74718       485            485     NINERS Chemnitz     CHE     
#> 18 bbl      2027 74785       473            473     Phoenix Hagen       HAG     
#> # ℹ 48 more variables: team_name_short <chr>, has_reached_playoffs <lgl>,
#> #   has_reached_playins <lgl>, is_relegation_certain <lgl>, season_id <int>,
#> #   competition <chr>, stage <chr>, rank <int>, streak <chr>,
#> #   streak_count <int>, point_corrections <chr>, home_victories <int>,
#> #   home_losses <int>, home_victory_percentage <dbl>, away_victories <int>,
#> #   away_losses <int>, away_victory_percentage <dbl>, table_points <int>,
#> #   table_points_against <int>, total_victory_percentage <dbl>, …
# }
```
