# **Get CBA Play-by-Play**

Play-by-play of a finished game, every period merged, oldest first
(Chinese text; no player or team ids).

Endpoint:
`POST https://data-server.cbaleague.com/api/schedule-eventses/filterPage`
(JSON body)

## Usage

``` r
cba_pbp(schedule_id, quarter_num = NULL)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

- quarter_num:

  (optional) Optional period number. Omitted = every period (the API
  serves one period per request; the runtime fetches them all and checks
  the set).

## Value

A `hoopR_data` tibble with one row per play. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_pbp")`) and in the searchable
[return
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
  # First quarter only; omit quarter_num for the whole game.
  try(cba_pbp(schedule_id = 100105799, quarter_num = 1))
#> ── CBA Play-by-Play from data-server.cbaleague.com ────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:51:46 UTC
#> # A tibble: 74 × 19
#>    schedule_id bt_textual_format    color distance home_color home_score minutes
#>          <int> <chr>                <chr> <chr>    <chr>           <int>   <int>
#>  1   100105799 刘传兴和卡尔顿跳球，山西汾酒队得到球权… #7E0… NA       #E0B71B             0      10
#>  2   100105799 刘传兴勾手投篮不中，卡尔顿获得防守篮板… #7E0… NA       #E0B71B             0       9
#>  3   100105799 布朗三分跳投不中，刘传兴获得防守篮板…… #E0B… NA       #E0B71B             0       9
#>  4   100105799 焦海龙接到迪亚洛的助攻，跳投，三分入网… #7E0… NA       #E0B71B             0       9
#>  5   100105799 卡尔顿接到布朗的助攻，带球上篮得分…… #E0B… NA       #E0B71B             2       9
#>  6   100105799 刘传兴在对方投篮时犯规 (卡尔顿造成了… #7E0… NA       #E0B71B             2       9
#>  7   100105799 卡尔顿罚球不中，刘传兴获得防守篮板…… #E0B… NA       #E0B71B             2       9
#>  8   100105799 黑根斯失误，被卡尔顿断下…… #7E0… NA       #E0B71B             2       8
#>  9   100105799 卡尔顿跳投，被刘传兴盖掉，刘传兴获得防… #E0B… NA       #E0B71B             2       8
#> 10   100105799 迪亚洛失误，被布朗断下…… #7E0… NA       #E0B71B             2       8
#> # ℹ 64 more rows
#> # ℹ 12 more variables: player_cn_names <chr>, player_fouls <chr>,
#> #   player_score <chr>, quarter_num <int>, seconds <int>, team_cn_alias1 <chr>,
#> #   team_cn_alias2 <chr>, team_cn_alias3 <chr>, textual_format <chr>,
#> #   type <int>, visiting_color <chr>, visitor_score <int>
# }
```
