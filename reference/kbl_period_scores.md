# **Get KBL Period Scores**

Points by period (quarters and overtimes) and side of a final game, from
the game header.

Endpoint: `GET https://api.kbl.or.kr/match/{gmkey}`

## Usage

``` r
kbl_period_scores(gmkey)
```

## Arguments

- gmkey:

  Game key `S{seasonCode}G{gameCode}N{gameNo}`, e.g. 'S47G01N49' (the
  2025-26 regular season's game 49): season_code, game_code and game_no
  of kbl_schedule. Only final games are served; a malformed key is a
  `hoopR_bad_request`.

## Value

A `hoopR_data` tibble with one row per team and period. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_period_scores")`) and in the
searchable [return
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
  try(kbl_period_scores(gmkey = "S47G01N49"))
#> ── KBL Period Scores from api.kbl.or.kr ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:13:59 UTC
#> # A tibble: 8 × 10
#>   gmkey season_code season game_code game_no side  team_code period period_label
#>   <chr>       <int>  <int> <chr>       <int> <chr> <chr>      <int> <chr>       
#> 1 S47G…          47   2026 01             49 home  66             1 Q1          
#> 2 S47G…          47   2026 01             49 home  66             2 Q2          
#> 3 S47G…          47   2026 01             49 home  66             3 Q3          
#> 4 S47G…          47   2026 01             49 home  66             4 Q4          
#> 5 S47G…          47   2026 01             49 away  50             1 Q1          
#> 6 S47G…          47   2026 01             49 away  50             2 Q2          
#> 7 S47G…          47   2026 01             49 away  50             3 Q3          
#> 8 S47G…          47   2026 01             49 away  50             4 Q4          
#> # ℹ 1 more variable: score <int>
# }
```
