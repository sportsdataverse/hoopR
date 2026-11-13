# **Get VTB Infobasket Team Games**

A club's games in one season (the calendar's row shape).

Endpoint: `GET https://org.infobasket.su/Widget/TeamGames/{team_id}`

## Usage

``` r
vtb_infobasket_team_games(team_id, season, tag = "vtb")
```

## Arguments

- team_id:

  Infobasket TeamID (team_id in the calendar, a box score or the v2
  matches), e.g. 2650 (Lokomotiv Kuban).

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
(`subset(return_columns, fn == "vtb_infobasket_team_games")`) and in the
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
  try(vtb_infobasket_team_games(season = 2026, team_id = 2650))
#> ── VTB Infobasket Team Games from org.infobasket.su ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:19:02 UTC
#> # A tibble: 53 × 47
#>    team_id season comp_id game_id game_number game_date  has_time game_time
#>      <int>  <int>   <int>   <int> <chr>       <chr>      <lgl>    <chr>    
#>  1    2650   2026   50714  921391 RS-002      2025-09-28 TRUE     14:00    
#>  2    2650   2026   50714  921395 RS-006      2025-10-02 TRUE     20:00    
#>  3    2650   2026   50714  921399 RS-010      2025-10-05 TRUE     14:00    
#>  4    2650   2026   50714  921407 RS-018      2025-10-12 TRUE     14:00    
#>  5    2650   2026   50714  921415 RS-026      2025-10-19 TRUE     14:30    
#>  6    2650   2026   50714  921420 RS-032      2025-10-25 TRUE     16:00    
#>  7    2650   2026   50714  921428 RS-039      2025-10-29 TRUE     19:00    
#>  8    2650   2026   50714  921429 RS-040      2025-11-01 TRUE     19:30    
#>  9    2650   2026   50714  921437 RS-049      2025-11-09 TRUE     14:00    
#> 10    2650   2026   50714  921443 RS-053      2025-11-12 TRUE     20:00    
#> # ℹ 43 more rows
#> # ℹ 39 more variables: game_time_msk <chr>, game_date_time <chr>,
#> #   game_date_time_moscow <chr>, game_status <int>, team_a_id <int>,
#> #   team_b_id <int>, short_team_name_aru <chr>, short_team_name_bru <chr>,
#> #   team_name_aru <chr>, team_name_bru <chr>, comp_team_name_aru <chr>,
#> #   comp_team_name_bru <chr>, region_team_name_aru <chr>,
#> #   region_team_name_bru <chr>, short_team_name_aen <chr>, …
# }
```
