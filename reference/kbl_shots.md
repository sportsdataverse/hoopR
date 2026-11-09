# **Get KBL Shots**

Shot chart of a final game (2006-07 on): every charted shot with x/y
pixels on the full-court image.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}/match-chart`

## Usage

``` r
kbl_shots(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per shot. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_shots")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kbl_seasons()`](https://hoopR.sportsdataverse.org/reference/kbl_seasons.md).

## See also

[family_kbl](https://hoopR.sportsdataverse.org/reference/family_kbl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kbl_shots(gmkey = "S47G01N49"))
#> ── KBL Shots from api.kbl.or.kr ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:14:07 UTC
#> # A tibble: 127 × 15
#>    gmkey   season_code season game_code game_no pcode player_name player_name_en
#>    <chr>         <int>  <int> <chr>       <int> <chr> <chr>       <chr>         
#>  1 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  2 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  3 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  4 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  5 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  6 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  7 S47G01…          47   2026 01             49 2902… 허일영      HEO ILYOUNG   
#>  8 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#>  9 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#> 10 S47G01…          47   2026 01             49 2904… 장민국      JANG M K      
#> # ℹ 117 more rows
#> # ℹ 7 more variables: team_code <chr>, period <int>, period_label <chr>,
#> #   x <int>, y <int>, made <lgl>, basket <chr>
# }
```
