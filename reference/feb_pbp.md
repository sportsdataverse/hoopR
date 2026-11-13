# **FEB Play-by-Play**

**Play-by-play of one FEB game (KeyFacts): every shot, rebound, foul,
substitution and timeout, in Spanish text with coded actions, oldest
play first.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/KeyFacts/{game_id}`

A body whose plays name another game is refused (`hoopR_asset_fetch`),
not returned. 2020-21 games are text only: `action`, the ids, the
parameters, the position and the log times are `NA` there.

## Usage

``` r
feb_pbp(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "feb_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md).

## See also

Other FEB Functions:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_pbp(game_id = 2535725))
#> ── FEB pbp from intrafeb.feb.es ───────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 17:35:43 UTC
#> # A tibble: 570 × 27
#>    game_id play_num period clock clock_seconds team_side team_id player_id
#>      <int>    <int>  <int> <chr>         <int> <chr>       <int>     <int>
#>  1 2535725        1      1 10:00           600 home      1009716   1981843
#>  2 2535725        2      1 10:00           600 home      1009716   2500822
#>  3 2535725        3      1 10:00           600 away      1010207   2650859
#>  4 2535725        4      1 10:00           600 home      1009716   1371559
#>  5 2535725        5      1 10:00           600 away      1010207   2217440
#>  6 2535725        6      1 10:00           600 home      1009716   2813013
#>  7 2535725        7      1 10:00           600 home      1009716   2880241
#>  8 2535725        8      1 10:00           600 away      1010207   1890908
#>  9 2535725        9      1 10:00           600 away      1010207   2533871
#> 10 2535725       10      1 10:00           600 away      1010207   2640789
#> # ℹ 560 more rows
#> # ℹ 19 more variables: license_id <int>, action <chr>, text <chr>,
#> #   score_home <int>, score_away <int>, x <dbl>, y <dbl>, log_param1 <chr>,
#> #   log_param2 <chr>, log_param3 <chr>, log_param4 <chr>, log_param5 <chr>,
#> #   log_param6 <chr>, log_param7 <chr>, log_param8 <chr>, log_param9 <chr>,
#> #   log_param10 <chr>, log_time <dttm>, log_time_utc <dttm>
# }
```
