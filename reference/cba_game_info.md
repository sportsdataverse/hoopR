# **Get CBA Game Info**

Game report header: both teams, score, tip-off time and colours.

Endpoint:
`GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/baseInfo/{schedule_id}`

## Usage

``` r
cba_game_info(schedule_id)
```

## Arguments

- schedule_id:

  (required) Required. CBA game id (integer), the global 9-digit
  sequence 100xxxxxx (100105799 = 2025-26 round 1). Only a finished game
  is served.

## Value

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "cba_game_info")`) and in the searchable
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
  try(cba_game_info(schedule_id = 100105799))
#> ── CBA Game Info from data-server.cbaleague.com ───────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:51:42 UTC
#> # A tibble: 1 × 13
#>   schedule_id count guest_color guest_score guest_team_id guest_team_logo       
#>         <int> <int> <chr>             <int>         <int> <chr>                 
#> 1   100105799    83 #7E040C              74         29132 https://image.cbaleag…
#> # ℹ 7 more variables: guest_team_name <chr>, host_color <chr>,
#> #   host_score <int>, host_team_id <int>, host_team_logo <chr>,
#> #   host_team_name <chr>, schedule_time <chr>
# }
```
