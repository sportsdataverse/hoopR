# **Get EASL Standings**

Group-stage standings of one season: rank within the pool, record,
splits, points and the last five results.

Endpoint: `GET https://easl.joshricha.com/api/v1/standings`

## Usage

``` r
easl_standings(season = NULL)
```

## Arguments

- season:

  Season END year (2026 = EASL 25-26; the four editions are 2024 to
  2027). The runtime reads easl_seasons and maps it to the DataCore
  seasonId. Default `NULL`: the ACTIVE season.

## Value

A `hoopR_data` tibble with one row per team in the standings. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "easl_standings")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`easl_health()`](https://hoopR.sportsdataverse.org/reference/easl_health.md).

## See also

[family_easl](https://hoopR.sportsdataverse.org/reference/family_easl.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(easl_standings(season = 2026))
#> ── EASL Standings from easl.joshricha.com ─────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:13:57 UTC
#> # A tibble: 12 × 36
#>    season season_id     standing_id position team_id team_name team_code pool_id
#>     <int> <chr>         <chr>          <int> <chr>   <chr>     <chr>     <chr>  
#>  1   2026 77441bb3-975… e9e5c9db-3…        1 865489… Utsunomi… "BRE"     284a47…
#>  2   2026 77441bb3-975… e9e721a6-3…        2 864e19… Seoul SK… "SK"      284a47…
#>  3   2026 77441bb3-975… e9e88480-3…        3 865159… Taipei F… "TFB"     284a47…
#>  4   2026 77441bb3-975… e9ea3acb-3…        4 27492b… Hong Kon… "HKE"     284a47…
#>  5   2026 77441bb3-975… e9f2cec7-3…        1 865db3… Ryukyu G… ""        47dffb…
#>  6   2026 77441bb3-975… e9f42fd7-3…        2 f17004… Taoyuan … ""        47dffb…
#>  7   2026 77441bb3-975… e9f58794-3…        3 c6b127… Meralco … "MRB"     47dffb…
#>  8   2026 77441bb3-975… e9f6d87f-3…        4 4458de… Macau Bl… ""        47dffb…
#>  9   2026 77441bb3-975… e9ff758c-3…        1 0548e9… Alvark T…  NA       963b9a…
#> 10   2026 77441bb3-975… ea019506-3…        2 b18c0d… New Taip… "NTK"     963b9a…
#> 11   2026 77441bb3-975… ea03473d-3…        3 cbf7cf… South Go… "BRO"     963b9a…
#> 12   2026 77441bb3-975… ea04aedf-3…        4 d311c0… Changwon…  NA       963b9a…
#> # ℹ 28 more variables: pool_name <chr>, pool_abb <chr>, live <lgl>,
#> #   latest <lgl>, game_played <int>, game_played_home <int>,
#> #   game_played_away <int>, wins <int>, wins_home <int>, wins_away <int>,
#> #   losses <int>, losses_home <int>, losses_away <int>, draws <int>,
#> #   draws_home <int>, draws_away <int>, win_percentage <dbl>,
#> #   win_percentage_home <dbl>, win_percentage_away <dbl>, points_for <int>,
#> #   points_against <int>, point_difference <int>, …
# }
```
