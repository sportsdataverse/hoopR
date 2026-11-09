# **Get VTB Infobasket Team Box Score**

Team box score of a finished game, with the head coach's technical
fouls.

Endpoint: `GET https://org.infobasket.su/Widget/GetOnline/{game_id}`

## Usage

``` r
vtb_infobasket_team_box_score(game_id)
```

## Arguments

- game_id:

  Infobasket GameID (game_id in vtb_infobasket_calendar; the v2 matches'
  match_id), e.g. 921391. Global across seasons.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "vtb_infobasket_team_box_score")`) and in
the searchable [return
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
  try(vtb_infobasket_team_box_score(game_id = 921391))
#> ── VTB Infobasket Team Box Score from org.infobasket.su ───────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:17:48 UTC
#> # A tibble: 2 × 45
#>   game_id is_home team_number team_id score points shot1 goal1 shot2 goal2 shot3
#>     <int> <lgl>         <int>   <int> <int>  <int> <int> <int> <int> <int> <int>
#> 1  921391 TRUE              1    2650    85     85    22    15    46    26    17
#> 2  921391 FALSE             2    1390    86     86    10     8    40    21    27
#> # ℹ 34 more variables: goal3 <int>, shot1_percent <dbl>, shot2_percent <dbl>,
#> #   shot3_percent <dbl>, assist <int>, blocks <int>, def_rebound <int>,
#> #   off_rebound <int>, rebound <int>, steal <int>, turnover <int>,
#> #   team_def_rebound <int>, team_off_rebound <int>, team_rebound <int>,
#> #   team_steal <int>, team_turnover <int>, foul <int>, opponent_foul <int>,
#> #   seconds <int>, played_time <chr>, plus_minus <int>,
#> #   team_short_name_ru <chr>, team_short_name_en <chr>, team_name_ru <chr>, …
# }
```
