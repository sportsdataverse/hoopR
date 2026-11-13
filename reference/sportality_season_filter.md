# **Get Basketligaen Season Filter**

Series, the 25 seasons (2002/03 on), game types and the default ssgt.

Endpoint:
`GET https://www.basketligaen.dk/api/sports-v2/season-series-game-types-filter`

## Usage

``` r
sportality_season_filter()
```

## Value

A `hoopR_data` tibble with one row per filter option. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "sportality_season_filter")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`sportality_schedule()`](https://hoopR.sportsdataverse.org/reference/sportality_schedule.md).

## See also

[family_basketligaen](https://hoopR.sportsdataverse.org/reference/family_basketligaen.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(sportality_season_filter())
#> ── Basketligaen Season Filter from basketligaen.dk ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:59:01 UTC
#> # A tibble: 27 × 5
#>    kind   code  name         uuid       deleted
#>    <chr>  <chr> <chr>        <chr>      <lgl>  
#>  1 series DBL   Basketligaen m1ay3mpa4t FALSE  
#>  2 season 2026  2026/2027    fg7gxxmm0w FALSE  
#>  3 season 2025  2025/2026    ggp2aapun2 FALSE  
#>  4 season 2024  2024/2025    df8tvo9vtv FALSE  
#>  5 season 2023  2023/2024    kh3bu2clwh FALSE  
#>  6 season 2022  2022/2023    lbi799ptgn FALSE  
#>  7 season 2021  2021/2022    s3vxi2twqh FALSE  
#>  8 season 2020  2020/2021    qk3us0seqa FALSE  
#>  9 season 2019  2019/2020    la8qbr7i9j FALSE  
#> 10 season 2018  2018/2019    yfny9300wf FALSE  
#> # ℹ 17 more rows
# }
```
