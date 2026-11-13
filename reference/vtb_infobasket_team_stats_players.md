# **Get VTB Infobasket Team Stats Players**

Season totals of every player of every team of a season.

Endpoint: `GET https://org.infobasket.su/Comp/GetTeamStats/{season}`

## Usage

``` r
vtb_infobasket_team_stats_players(season, tag = "vtb")
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

A `hoopR_data` tibble with one row per player. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_team_stats_players")`)
and in the searchable [return
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
  try(vtb_infobasket_team_stats_players(season = 2026))
#> ── VTB Infobasket Team Stats Players from org.infobasket.su ───── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 21:19:06 UTC
#> # A tibble: 194 × 60
#>    season team_id person_id player_number display_number is_active active_status
#>     <int>   <int>     <int>         <int> <chr>          <lgl>     <chr>        
#>  1   2026     682    311124             0 0              TRUE      ""           
#>  2   2026     682     51620             1 1              TRUE      ""           
#>  3   2026     682    393046             3 3              TRUE      ""           
#>  4   2026     682     53079             4 4              TRUE      ""           
#>  5   2026     682     43443             6 6              TRUE      ""           
#>  6   2026     682    491383             8 8              TRUE      ""           
#>  7   2026     682     26883             9 9              TRUE      ""           
#>  8   2026     682     33188            12 12             TRUE      ""           
#>  9   2026     682    370815            14 14             TRUE      ""           
#> 10   2026     682    258077            24 24             TRUE      ""           
#> # ℹ 184 more rows
#> # ℹ 53 more variables: points <int>, shot1 <int>, goal1 <int>, shot2 <int>,
#> #   goal2 <int>, shot3 <int>, goal3 <int>, shot23 <int>, goal23 <int>,
#> #   shot1_percent <dbl>, shot2_percent <dbl>, shot3_percent <dbl>,
#> #   shot23_percent <dbl>, assist <int>, blocks <int>, def_rebound <int>,
#> #   off_rebound <int>, rebound <int>, steal <int>, turnover <int>, foul <int>,
#> #   opponent_foul <int>, plus_minus <int>, kpi <int>, avg_points <dbl>, …
# }
```
