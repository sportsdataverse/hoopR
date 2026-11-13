# **Get KBL Teams**

The current ten clubs with Korean and English names and the code of each
club's D-League side.

Endpoint: `GET https://api.kbl.or.kr/common/teamList`

## Usage

``` r
kbl_teams()
```

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kbl_teams")`) and in the searchable
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
  try(kbl_teams())
#> ── KBL Teams from api.kbl.or.kr ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:55:50 UTC
#> # A tibble: 10 × 6
#>    team_code team_code_d team_name team_name_full team_name_en team_name_full_en
#>    <chr>     <chr>       <chr>     <chr>          <chr>        <chr>            
#>  1 16        28          원주DB    원주 DB 프로미 DB           WONJU DB PROMY   
#>  2 35        26          서울삼성  서울 삼성 썬더스…… SAMSUNG      SEOUL SAMSUNG TH…
#>  3 66        67          고양소노  고양 소노 스카이거너스…… SONO         GOYANG SONO SKY …
#>  4 55        19          서울SK    서울 SK 나이츠 SK           SEOUL SK KNIGHTS 
#>  5 50        36          창원LG    창원 LG 세이커스…… LG           CHANGWON LG SAKE…
#>  6 70        57          안양정관장…… 안양 정관장 레드부스터스… JUNG KWAN J… ANYANG JUNG KWAN…
#>  7 60        24          부산KCC   부산 KCC 이지스…… KCC          BUSAN KCC EGIS   
#>  8 06        18          수원KT    수원 KT 소닉붐 KT           SUWON KT SONICBO…
#>  9 64        68          대구한국가스공사… 대구 한국가스공사 페가수… KOREA GAS C… DAEGU KOREAGASCO…
#> 10 10        31          울산현대모비스…… 울산 현대모비스 피버스…… HYUNDAI      ULSAN HYUNDAI MO…
# }
```
