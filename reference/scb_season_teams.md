# **Get BBL / DBBL Season Teams**

Every team of a season: club id, season-team id, name and three-letter
code.

Endpoint: `GET https://api.basketball-bundesliga.de/seasons/{season}`
(DBBL: the same route on `https://api-1.dbbl.scb.world`).

## Usage

``` r
scb_season_teams(season, league = "bbl")
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

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "scb_season_teams")`) and in the
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
  try(scb_season_teams(season = 2026))
#> ── BBL/DBBL Season Teams from the SCB API ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 02:05:01 UTC
#> # A tibble: 18 × 8
#>    league season season_id team_id season_team_id team_name       tlc   logo_url
#>    <chr>   <int>     <int> <chr>   <chr>          <chr>           <chr> <chr>   
#>  1 bbl      2026      2025 488     488            MLP Academics … HDB   https:/…
#>  2 bbl      2026      2025 413     413            ALBA Berlin     BER   https:/…
#>  3 bbl      2026      2025 486     486            FC Bayern Münc… FCB   https:/…
#>  4 bbl      2026      2025 420     420            BMA365 Bamberg… BAM   https:/…
#>  5 bbl      2026      2025 415     415            Telekom Basket… BON   https:/…
#>  6 bbl      2026      2025 540     540            Fitness First … WUE   https:/…
#>  7 bbl      2026      2025 418     418            ratiopharm ulm  ULM   https:/…
#>  8 bbl      2026      2025 541     541            RASTA Vechta    VEC   https:/…
#>  9 bbl      2026      2025 414     414            VET-CONCEPT Gl… TRI   https:/…
#> 10 bbl      2026      2025 551     551            ROSTOCK SEAWOL… HRO   https:/…
#> 11 bbl      2026      2025 433     433            MHP RIESEN Lud… LUD   https:/…
#> 12 bbl      2026      2025 430     430            EWE Baskets Ol… OLD   https:/…
#> 13 bbl      2026      2025 485     485            NINERS Chemnitz CHE   https:/…
#> 14 bbl      2026      2025 428     428            SYNTAINICS MBC  MBC   https:/…
#> 15 bbl      2026      2025 554     554            Veolia Towers … HAM   https:/…
#> 16 bbl      2026      2025 426     426            SKYLINERS       FRS   https:/…
#> 17 bbl      2026      2025 483     483            Science City J… JEN   https:/…
#> 18 bbl      2026      2025 422     422            Basketball Löw… BRA   https:/…
# }
```
