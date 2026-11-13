# **Get VTB Infobasket Team Stats**

Season totals of every team of a season (all stages).

Endpoint: `GET https://org.infobasket.su/Comp/GetTeamStats/{season}`

## Usage

``` r
vtb_infobasket_team_stats(season, tag = "vtb")
```

## Arguments

- season:

  Season END year (2026 = 2025-26); the wrapper maps it to the
  season-level Infobasket CompID with vtb_infobasket_seasons (one extra
  request per tag, cached).

- tag:

  Competition tag scoping the profile: vtb (VTB United League, default),
  vtbyouth, wbc, wpremier or rfb. The season table is read for this tag.

## Value

A `hoopR_data` tibble with one row per team. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_team_stats")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`vtb_infobasket_seasons()`](https://hoopR.sportsdataverse.org/reference/vtb_infobasket_seasons.md).

## See also

[family_vtb](https://hoopR.sportsdataverse.org/reference/family_vtb.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(vtb_infobasket_team_stats(season = 2026))
#> ── VTB Infobasket Team Stats from org.infobasket.su ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:56:06 UTC
#> # A tibble: 11 × 57
#>    season team_id game_count points shot1 goal1 shot2 goal2 shot3 goal3 shot23
#>     <int>   <int>      <int>  <int> <int> <int> <int> <int> <int> <int>  <int>
#>  1   2026     682         40   2860   669   501  1632   761   926   279   2558
#>  2   2026     688         43   3327   773   578  1767   881   995   329   2762
#>  3   2026    2994         56   4779  1144   889  2049  1123  1454   548   3503
#>  4   2026    2650         53   4521  1317   992  2407  1256  1032   339   3439
#>  5   2026    2747         43   3400   943   699  1649   791  1119   373   2768
#>  6   2026     468         40   3045   685   536  1419   728  1072   351   2491
#>  7   2026    3059         43   3522   699   538  1728   919  1084   382   2812
#>  8   2026    2792         40   2870   665   494  1416   693  1023   330   2439
#>  9   2026     697         54   4569  1036   808  1849  1015  1582   577   3431
#> 10   2026    1390         44   3463   871   677  1611   829  1060   376   2671
#> 11   2026      15         52   4847  1152   919  1887  1040  1530   616   3417
#> # ℹ 46 more variables: goal23 <int>, shot1_percent <dbl>, shot2_percent <dbl>,
#> #   shot3_percent <dbl>, shot23_percent <dbl>, assist <int>, blocks <int>,
#> #   def_rebound <int>, off_rebound <int>, rebound <int>, steal <int>,
#> #   turnover <int>, team_def_rebound <int>, team_off_rebound <int>,
#> #   team_rebound <int>, team_steal <int>, team_turnover <int>, kpi <int>,
#> #   avg_points <dbl>, avg_assist <dbl>, avg_blocks <dbl>,
#> #   avg_def_rebound <dbl>, avg_off_rebound <dbl>, avg_rebound <dbl>, …
# }
```
