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

A `hoopR_data` tibble: One row per match type (regular season, playoffs,
preseason, all-star, relegation). An empty valid answer is a zero-row
tibble with these columns, in this order (sportsdataverse-py
`cba_match_types`):

|  |  |  |
|----|----|----|
| col_name | type | description |
| is_default | integer | Default-selection flag: 1 = the site's default (the preseason, '3', at capture time: it follows the calendar), 2 = not the default. |
| key | character | Match type name (Chinese): regular season, (Chinese text) playoffs, (Chinese text) preseason, (Chinese text) all-star, (Chinese text) relegation play-off. |
| value | character | Match type id as a string ('1' regular season, '2' playoffs, '3' preseason, '4' all-star, '9' relegation); the matchTypeId of every other route. |

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
#> ℹ Data updated: 2026-11-09 12:02:47 UTC
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
