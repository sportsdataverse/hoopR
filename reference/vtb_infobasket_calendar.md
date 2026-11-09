# **Get VTB Infobasket Calendar**

Every game of a season (finished, live and planned): teams, scores,
date, venue, attendance.

Endpoint: `GET https://org.infobasket.su/Comp/GetCalendar/`

## Usage

``` r
vtb_infobasket_calendar(season, tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached). Required.

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_calendar")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_calendar(season = 2026))
#> ── VTB Infobasket Calendar from org.infobasket.su ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:58:28 UTC
#> # A tibble: 254 × 46
#>    season comp_id game_id game_number game_date has_time game_time game_time_msk
#>     <int>   <int>   <int> <chr>       <chr>     <lgl>    <chr>     <chr>        
#>  1   2026   50714  921391 RS-002      2025-09-… TRUE     14:00     14:00        
#>  2   2026   50714  921390 RS-001      2025-09-… TRUE     18:00     18:00        
#>  3   2026   50714  921392 RS-003      2025-09-… TRUE     19:00     18:00        
#>  4   2026   50714  921394 RS-005      2025-10-… TRUE     19:00     19:00        
#>  5   2026   50714  921393 RS-004      2025-10-… TRUE     19:30     19:30        
#>  6   2026   50714  921395 RS-006      2025-10-… TRUE     20:00     20:00        
#>  7   2026   50714  921396 RS-007      2025-10-… TRUE     19:30     17:30        
#>  8   2026   50714  921397 RS-008      2025-10-… TRUE     14:00     14:00        
#>  9   2026   50714  921398 RS-009      2025-10-… TRUE     17:00     16:00        
#> 10   2026   50714  921399 RS-010      2025-10-… TRUE     14:00     14:00        
#> # ℹ 244 more rows
#> # ℹ 38 more variables: game_date_time <chr>, game_date_time_moscow <chr>,
#> #   game_status <int>, team_a_id <int>, team_b_id <int>,
#> #   short_team_name_aru <chr>, short_team_name_bru <chr>, team_name_aru <chr>,
#> #   team_name_bru <chr>, comp_team_name_aru <chr>, comp_team_name_bru <chr>,
#> #   region_team_name_aru <chr>, region_team_name_bru <chr>,
#> #   short_team_name_aen <chr>, short_team_name_ben <chr>, …
# }
```
