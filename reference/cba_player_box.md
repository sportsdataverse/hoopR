# **Get CBA Player Box**

Player box score of a finished game, both sides, plus a team
rebounds/turnovers row per side (null player_id).

Endpoint:
`POST https://data-server.cbaleague.com/api/player-match-datas/data-count`
(JSON body)

## Usage

``` r
cba_player_box(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per player, plus a team row per side.
Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_player_box")`) and in the searchable
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
  try(cba_player_box(schedule_id = 100105799))
#> ── CBA Player Box from data-server.cbaleague.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 21:11:13 UTC
#> # A tibble: 26 × 26
#>    schedule_id side  assists blocked cn_alias field_goals field_goals_attempted
#>          <int> <chr>   <int>   <int> <chr>          <int>                 <int>
#>  1   100105799 home        4       2 朱俊龙             3                     5
#>  2   100105799 home        2       0 胡金秋             6                    10
#>  3   100105799 home        3       0 布朗               4                    13
#>  4   100105799 home        3       0 孙铭徽             2                     5
#>  5   100105799 home        2       0 卡尔顿             3                     5
#>  6   100105799 home        3       1 林秉圣             3                     5
#>  7   100105799 home        1       1 桑普森             3                     5
#>  8   100105799 home        2       1 塔克               4                    11
#>  9   100105799 home        1       0 赵嘉仁             0                     2
#> 10   100105799 home        1       0 吴骁               0                     0
#> # ℹ 16 more rows
#> # ℹ 19 more variables: field_goals_percentage <dbl>, fouls <int>,
#> #   free_throws <int>, free_throws_attempted <int>,
#> #   free_throws_percentage <dbl>, game_start <int>, number <chr>,
#> #   player_id <int>, plus_minus <int>, points <int>, rebounds <int>,
#> #   rebounds_defensive <int>, rebounds_offensive <int>, steals <int>,
#> #   three_point_attempted <int>, three_point_goals <int>, …
# }
```
