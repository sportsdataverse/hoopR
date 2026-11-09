# **Get CBA Team Options**

The teams of one season as a select list: team id and the season's
display name.

Endpoint:
`GET https://data-server.cbaleague.com/api/com-code-tables/getTeam`

## Usage

``` r
cba_team_options(season)
```

## Arguments

- season:

  (required) Required. Season END year (2026 = the 2025-26 season). The
  API takes the START year (2025), so cba_runtime sends season - 1.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_team_options")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`cba_seasons()`](https://hoopR.sportsdataverse.org/reference/cba_seasons.md).

## See also

[family_cba](https://hoopR.sportsdataverse.org/reference/family_cba.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(cba_team_options(season = 2026))
#> ── CBA Team Options from data-server.cbaleague.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:51:55 UTC
#> # A tibble: 20 × 3
#>    is_default key          value    
#>         <int> <chr>        <chr>    
#>  1          2 北京控股     29136    
#>  2          2 北京首钢     29115    
#>  3          2 福建晋江文旅 29134    
#>  4          2 广东东阳光   29124    
#>  5          2 广州朗肽海本 29139    
#>  6          2 江苏肯帝亚   29118    
#>  7          2 辽宁本钢     29129    
#>  8          2 南京天之蓝   29133    
#>  9          2 宁波町渥     100074683
#> 10          2 青岛崂山啤酒 29135    
#> 11          2 山东高速     29130    
#> 12          2 上海久事     29125    
#> 13          2 山西汾酒     29132    
#> 14          2 深圳马可波罗 29131    
#> 15          2 四川丰谷酒业 29127    
#> 16          2 天津先行者   29138    
#> 17          2 新疆伊力特   29117    
#> 18          2 长白山恩都里 29137    
#> 19          2 浙江稠州金租 29140    
#> 20          2 浙江浙商证券 29128    
# }
```
