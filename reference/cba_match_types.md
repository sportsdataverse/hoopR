# **Get CBA Match Types**

The match types (regular season, playoffs, preseason, all-star,
relegation play-off) with their ids.

Endpoint:
`GET https://data-server.cbaleague.com/api/com-code-tables/getMatchType`

## Usage

``` r
cba_match_types()
```

## Value

A `hoopR_data` tibble with one row per match type. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_match_types")`) and in the
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
  try(cba_match_types())
#> ── CBA Match Types from data-server.cbaleague.com ─────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:09:34 UTC
#> # A tibble: 5 × 3
#>   is_default key    value
#>        <int> <chr>  <chr>
#> 1          1 常规赛 1    
#> 2          2 季后赛 2    
#> 3          2 季前赛 3    
#> 4          2 全明星 4    
#> 5          2 保级赛 9    
# }
```
