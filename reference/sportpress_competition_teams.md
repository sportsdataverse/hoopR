# **Get BNXT League Competition Teams**

Every competition team of one competition: ids, names and country.

Endpoint: `GET https://bnxt.sportpress.info/api/v1/competition-team/all`

## Usage

``` r
sportpress_competition_teams(competition_id)
```

## Arguments

- competition_id:

  (required) Competition id (integer), ONE per season of the league: 24
  = 2025-26, 25 = 2026-27
  ([`sportpress_phases()`](https://hoopR.sportsdataverse.org/reference/sportpress_phases.md)
  maps a season to it).

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportpress_competition_teams")`) and in
the searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportpress_ui_strings()`](https://hoopR.sportsdataverse.org/reference/sportpress_ui_strings.md).

## See also

[family_bnxt_league](https://hoopR.sportsdataverse.org/reference/family_bnxt_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportpress_competition_teams(competition_id = 24))
#> ── BNXT League Competition Teams from Sportpress ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:39:32 UTC
#> # A tibble: 18 × 8
#>    competition_id season uu_team_id competition_team_id team     team_short_name
#>             <int>  <int>      <int>               <int> <chr>    <chr>          
#>  1             24   2026          1                 502 Val-Die… CHA            
#>  2             24   2026          2                 504 Filou O… OOS            
#>  3             24   2026          3                 506 Windros… ANT            
#>  4             24   2026          4                 508 Union M… MON            
#>  5             24   2026          5                 510 Hubo Li… LIM            
#>  6             24   2026          7                 512 Donar G… GRO            
#>  7             24   2026          8                 514 PrismaW… BAL            
#>  8             24   2026          9                 516 Landste… ZWO            
#>  9             24   2026         10                 518 Zeeuw &… RCB            
#> 10             24   2026         11                 520 LWD Bas… LWD            
#> 11             24   2026         12                 522 Zorg en… LEI            
#> 12             24   2026         14                 524 Den Hel… DHE            
#> 13             24   2026         18                 526 Heroes … DBO            
#> 14             24   2026         19                 528 Partena… AAL            
#> 15             24   2026         20                 530 AB InBe… LEU            
#> 16             24   2026         21                 532 Brussel… BRU            
#> 17             24   2026         22                 534 Kangoer… MEC            
#> 18             24   2026         32                 536 House o… KOR            
#> # ℹ 2 more variables: club_id <int>, club_name <chr>
# }
```
