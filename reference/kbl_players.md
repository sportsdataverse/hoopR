# **Get KBL Players**

The site's player directory (current and former players) with their
current or last team.

Endpoint: `GET https://api.kbl.or.kr/players`

## Usage

``` r
kbl_players()
```

## Value

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_players")`) and in the searchable
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
  try(kbl_players())
#> ── KBL Players from api.kbl.or.kr ─────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:51:58 UTC
#> # A tibble: 1,500 × 10
#>    pcode  player_name player_name_en   team_code team_name team_name_en back_num
#>    <chr>  <chr>       <chr>            <chr>     <chr>     <chr>        <chr>   
#>  1 290801 CJ 레슬리   CJ 레슬리        70        안양 KGC  JUNG KWAN J… "15"    
#>  2 235041 G.J 헌터    Gray Hunter      35        수원삼성  SAMSUNG      "7"     
#>  3 210070 R.F. 바셋   R.F. Bassette    60        전주KCC   KCC          "5"     
#>  4 290237 가넷 톰슨   Garnett Thompson 30        대구오리온스…… KBL          "5"     
#>  5 650016 가이 루커   Guy Terrance. R… 70        안양KT&G  JUNG KWAN J… "22"    
#>  6 290414 강권희      강권희           06        부산KT    KT           "35"    
#>  7 225032 강기중      Kang Ki Joong    16        원주동부  DB           "2"     
#>  8 245042 강대협      Kang Dae Hyup    65        인천전자랜드…… KBL          "10"    
#>  9 250058 강동희      Kang Dong Hee    16        원주동부  DB           ""      
#> 10 291192 강바일      KANG B I         35        서울 삼성 SAMSUNG      "19"    
#> # ℹ 1,490 more rows
#> # ℹ 3 more variables: pos <chr>, player_flag <chr>, last_career <chr>
# }
```
