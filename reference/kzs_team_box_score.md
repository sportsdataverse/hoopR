# **Get KZS Team Box Score**

Team totals of a final game's box score, one row per side.

Endpoint:
`GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`

## Usage

``` r
kzs_team_box_score(match_id)
```

## Arguments

- match_id:

  (required) Match id (match_id in kzs_matches), e.g. 101839. Global
  across seasons.

## Value

A `hoopR_data` tibble with one row per side. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "kzs_team_box_score")`) and in the
searchable [return
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
  try(kzs_team_box_score(match_id = 101839))
#> ── KZS Team Box Score from api.kzs.si ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:16:54 UTC
#> # A tibble: 2 × 77
#>   match_id team_side team_id team_name minutes two_pm two_pa two_p_perc three_pm
#>      <int> <chr>       <int> <chr>       <dbl>  <int>  <int>      <dbl>    <int>
#> 1   101839 home        17551 Perspekt…     225     26     43       60.5        7
#> 2   101839 away        17555 Terme Ol…     225     23     45       51.1       12
#> # ℹ 68 more variables: three_pa <int>, three_p_perc <dbl>, f_tm <int>,
#> #   f_ta <int>, f_t_perc <dbl>, fg_m <int>, fg_a <int>, fg_perc <dbl>,
#> #   offensive_rebounds <int>, defensive_rebounds <int>, total_rebounds <int>,
#> #   assists <int>, steals <int>, turnovers <int>, blocks_in_favor <int>,
#> #   blocks_against <int>, foul_commited <int>, foul_received <int>, p_ir <int>,
#> #   plus_minus <int>, assists_turnover_ratio <dbl>, defensive_rating <dbl>,
#> #   efficiency <int>, points <int>, efficiency_custom <dbl>, …
# }
```
