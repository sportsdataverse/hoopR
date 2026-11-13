# **IBBA Segev Play-by-Play**

**Play-by-play of a finished game: every action with shot coordinates,
running scores and jersey numbers.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getActions`

## Usage

``` r
ibba_segev_pbp(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with one row per play-by-play event. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_segev_pbp")`) and in the searchable
[return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_pbp(game_id = 50))
#> ── IBBA Segev play-by-play ────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:55:33 UTC
#> # A tibble: 768 × 30
#>    game_id action_id parent_action_id period clock user_time_utc type    subtype
#>      <int>     <int>            <int>  <int> <chr> <chr>         <chr>   <chr>  
#>  1      50    500001               NA      1 10:00 15:21:43      game    start-…
#>  2      50    500002               NA      1 10:00 15:29:07      quarter start-…
#>  3      50    500003               NA      1 10:00 15:29:51      substi… NA     
#>  4      50    500004               NA      1 10:00 15:29:52      substi… NA     
#>  5      50    500005               NA      1 10:00 15:29:53      substi… NA     
#>  6      50    500006               NA      1 10:00 15:29:57      substi… NA     
#>  7      50    500007               NA      1 10:00 15:29:58      substi… NA     
#>  8      50    500008               NA      1 10:00 15:31:26      substi… NA     
#>  9      50    500009               NA      1 10:00 15:31:28      substi… NA     
#> 10      50    500010               NA      1 10:00 15:31:30      substi… NA     
#> # ℹ 758 more rows
#> # ℹ 22 more variables: team_id <int>, player_id <int>, team_side <chr>,
#> #   jersey <chr>, score_away <int>, score_home <int>, player_points <int>,
#> #   points <int>, made <chr>, x <dbl>, y <dbl>, fast_break <lgl>,
#> #   second_chance <lgl>, points_from_turnover <lgl>, free_throw_number <int>,
#> #   free_throws_awarded <int>, foul_kind <chr>, fouled_on_jersey <chr>,
#> #   foul_free_throws <int>, is_coach_foul <lgl>, player_in_jersey <chr>, …
# }
```
