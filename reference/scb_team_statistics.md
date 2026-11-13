# **Get BBL / DBBL Season Team Statistics**

Season team stat table: totals and per-game values, one row per team and
stat block.

Endpoint:
`GET https://api.basketball-bundesliga.de/seasons/{season}/team-statistics`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_team_statistics(season, league = "bbl", display_type = "MAIN_ROUND")
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

A `hoopR_data` tibble with one row per team and stat block. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_team_statistics")`) and in the
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
  try(scb_team_statistics(season = 2026))
#> ── BBL/DBBL Season Team Statistics from the SCB API ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:58:50 UTC
#> # A tibble: 18 × 59
#>    league season display_type team_id season_team_id team_name          team_tlc
#>    <chr>   <int> <chr>        <chr>   <chr>          <chr>              <chr>   
#>  1 bbl      2026 MAIN_ROUND   486     486            FC Bayern München… FCB     
#>  2 bbl      2026 MAIN_ROUND   483     483            Science City Jena  JEN     
#>  3 bbl      2026 MAIN_ROUND   422     422            Basketball Löwen … BRA     
#>  4 bbl      2026 MAIN_ROUND   420     420            BMA365 Bamberg Ba… BAM     
#>  5 bbl      2026 MAIN_ROUND   541     541            RASTA Vechta       VEC     
#>  6 bbl      2026 MAIN_ROUND   488     488            MLP Academics Hei… HDB     
#>  7 bbl      2026 MAIN_ROUND   415     415            Telekom Baskets B… BON     
#>  8 bbl      2026 MAIN_ROUND   540     540            Fitness First Wür… WUE     
#>  9 bbl      2026 MAIN_ROUND   554     554            Veolia Towers Ham… HAM     
#> 10 bbl      2026 MAIN_ROUND   428     428            SYNTAINICS MBC     MBC     
#> 11 bbl      2026 MAIN_ROUND   414     414            VET-CONCEPT Gladi… TRI     
#> 12 bbl      2026 MAIN_ROUND   551     551            ROSTOCK SEAWOLVES  HRO     
#> 13 bbl      2026 MAIN_ROUND   418     418            ratiopharm ulm     ULM     
#> 14 bbl      2026 MAIN_ROUND   485     485            NINERS Chemnitz    CHE     
#> 15 bbl      2026 MAIN_ROUND   430     430            EWE Baskets Olden… OLD     
#> 16 bbl      2026 MAIN_ROUND   426     426            SKYLINERS          FRS     
#> 17 bbl      2026 MAIN_ROUND   433     433            MHP RIESEN Ludwig… LUD     
#> 18 bbl      2026 MAIN_ROUND   413     413            ALBA Berlin        BER     
#> # ℹ 52 more variables: season_id <int>, round_code <int>, competition <chr>,
#> #   aggregation <chr>, seconds_played <int>, points <int>,
#> #   two_point_shots_made <int>, two_point_shots_attempted <int>,
#> #   two_point_shot_success_percent <dbl>, three_point_shots_made <int>,
#> #   three_point_shots_attempted <int>, three_point_shot_success_percent <dbl>,
#> #   field_goals_made <int>, field_goals_attempted <int>,
#> #   field_goals_success_percent <dbl>, free_throws_made <int>, …
# }
```
