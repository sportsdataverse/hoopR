# **Get KZS Player Box Score**

Box score of a final game (2015/16 on): one row per player of both
teams.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`

## Usage

``` r
kzs_box_score(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per player of both teams. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_box_score")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`kzs_seasons()`](https://hoopR.sportsdataverse.org/reference/kzs_seasons.md).

## See also

[family_kzs](https://hoopR.sportsdataverse.org/reference/family_kzs.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(kzs_box_score(match_id = 101839))
#> ── KZS Player Box Score from api.kzs.si ───────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:14:14 UTC
#> # A tibble: 23 × 61
#>    match_id team_side team_id team_name         minutes two_pm two_pa two_p_perc
#>       <int> <chr>       <int> <chr>               <dbl>  <int>  <int>      <dbl>
#>  1   101839 home        17551 Perspektiva Ilir…   39.7       5      8       62.5
#>  2   101839 home        17551 Perspektiva Ilir…    5.68      0      0        0  
#>  3   101839 home        17551 Perspektiva Ilir…    0         0      0        0  
#>  4   101839 home        17551 Perspektiva Ilir…   24.5       0      3        0  
#>  5   101839 home        17551 Perspektiva Ilir…   36.9       5      9       55.6
#>  6   101839 home        17551 Perspektiva Ilir…   37.4       6      7       85.7
#>  7   101839 home        17551 Perspektiva Ilir…    4.76      3      3      100  
#>  8   101839 home        17551 Perspektiva Ilir…   31.7       5      5      100  
#>  9   101839 home        17551 Perspektiva Ilir…   16.6       1      2       50  
#> 10   101839 home        17551 Perspektiva Ilir…   20.2       1      5       20  
#> # ℹ 13 more rows
#> # ℹ 53 more variables: three_pm <int>, three_pa <int>, three_p_perc <dbl>,
#> #   f_tm <int>, f_ta <int>, f_t_perc <dbl>, fg_m <int>, fg_a <int>,
#> #   fg_perc <dbl>, offensive_rebounds <int>, defensive_rebounds <int>,
#> #   total_rebounds <int>, assists <int>, steals <int>, turnovers <int>,
#> #   blocks_in_favor <int>, blocks_against <int>, foul_commited <int>,
#> #   foul_received <int>, p_ir <int>, plus_minus <int>, …
# }
```
