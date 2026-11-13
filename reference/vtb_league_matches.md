# **Get VTB League Matches**

Every match of one league-season (schedule, scores, quarter points,
venue), in one request.

Endpoint:
`GET https://api.vtb-league.com/v2/leagues/{league_slug}/seasons/{season}/matches`

## Usage

``` r
vtb_league_matches(league_slug, season)
```

## Arguments

- league_slug:

  League slug (league in vtb_league_leagues): vtb (VTB United League),
  vtbyouth (youth league) or wbc (WINLINE Basket Cup).

- season:

  Season END year (2026 = 2025-26). The v2 API holds 2025 onwards (vtb:
  2025-2027; wbc: 2026-2027); earlier years answer no rows.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_league_matches")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

- Source, access, seasons, ids and the error classes: see the notes of
  [`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

- v2 pages: meta.count is the rows returned (not a total), page is
  ignored and the default limit is 20, so the matches wrapper asks for
  1000 and refuses a body whose count reaches its limit. The API lists
  new seasons only (from 2024-25; vtb: 2025-2027, wbc: 2026-2027):
  earlier years answer no rows (`hoopR_no_data`).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_league_matches(league_slug = "vtb", season = 2026))
#> ── VTB League Matches from api.vtb-league.com ─────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:19:08 UTC
#> # A tibble: 273 × 57
#>    match_id league season competition  phase_id phase_name_en  phase_name_ru    
#>       <int> <chr>   <int> <chr>           <int> <chr>          <chr>            
#>  1   932510 vtb      2026 vtb-supercup  1213772 1/2 finals (1) 1/2 финала (1)   
#>  2   932509 vtb      2026 vtb-supercup  1213771 1/2 finals (2) 1/2 финала (2)   
#>  3   932511 vtb      2026 vtb-supercup  1213774 Final for 3    Финал за 3 место 
#>  4   945674 vtb      2026 vtb-supercup  1213774 Final for 3    Финал за 3 место 
#>  5   932512 vtb      2026 vtb-supercup  1213773 Final          Финал            
#>  6   945673 vtb      2026 vtb-supercup  1213773 Final          Финал            
#>  7   921391 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#>  8   921390 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#>  9   921392 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#> 10   921394 vtb      2026 vtb           1202269 Regular Season Регулярный чемпи…
#> # ℹ 263 more rows
#> # ℹ 50 more variables: match_number <chr>, match_type <chr>,
#> #   match_status <chr>, match_time <chr>, match_time_msk <chr>,
#> #   match_time_utc <chr>, is_time_set <lgl>, time_actual <chr>,
#> #   time_end_actual <chr>, duration <int>, periods <int>,
#> #   extra_periods_used <lgl>, attendance <int>, hosting_team_id <int>,
#> #   venue_id <int>, venue_name_en <chr>, venue_name_ru <chr>, …
# }
```
