# **FEB Player Box Score**

**Per-player box score of one FEB game: minutes, points, shooting
splits, rebounds, assists, fouls and plus/minus.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/BoxScore/{game_id}`

One row per player and team. `p1` / `p2` / `p3` are free throws, two-
and three-point field goals (`m` made, `a` attempted, `p` percentage
0-100); `seconds_played` is the provider's `min` (seconds, not minutes);
`player_id` is the FEB person id (stable across seasons) and
`shirt_number` stays a string (`"00"` is not `"0"`).

## Usage

``` r
feb_player_box(game_id)
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

A `hoopR_data` tibble with one row per player and team. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "feb_player_box")`) and in the searchable
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
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_player_box(game_id = 2535725))
#> ── FEB player box from intrafeb.feb.es ────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:51:00 UTC
#> # A tibble: 24 × 38
#>    game_id team_side team_id team  player_id shirt_number player starter captain
#>      <int> <chr>       <int> <chr>     <int> <chr>        <chr>  <lgl>   <lgl>  
#>  1 2535725 home      1009716 BUEN…   1371559 3            V. AG… TRUE    FALSE  
#>  2 2535725 home      1009716 BUEN…   2813013 5            N. RE… TRUE    FALSE  
#>  3 2535725 home      1009716 BUEN…   2880241 6            J. ZE… TRUE    FALSE  
#>  4 2535725 home      1009716 BUEN…   2432962 10           S. ME… FALSE   TRUE   
#>  5 2535725 home      1009716 BUEN…   1603635 11           J. GO… FALSE   FALSE  
#>  6 2535725 home      1009716 BUEN…   2880232 16           A. MA… FALSE   FALSE  
#>  7 2535725 home      1009716 BUEN…   2500822 22           M. VO… TRUE    FALSE  
#>  8 2535725 home      1009716 BUEN…   2162563 25           A. LA… FALSE   FALSE  
#>  9 2535725 home      1009716 BUEN…   2117867 42           S. SA… FALSE   FALSE  
#> 10 2535725 home      1009716 BUEN…   1981843 44           B. VA… TRUE    FALSE  
#> # ℹ 14 more rows
#> # ℹ 29 more variables: seconds_played <int>, min_formatted <chr>, pts <int>,
#> #   p1m <int>, p1a <int>, p1p <dbl>, p2m <int>, p2a <int>, p2p <dbl>,
#> #   p3m <int>, p3a <int>, p3p <dbl>, fgm <int>, fga <int>, fgp <dbl>, ro <int>,
#> #   rd <int>, rt <int>, reb <int>, assist <int>, st <int>, to <int>, bs <int>,
#> #   tc <int>, mt <int>, pf <int>, rf <int>, pllss <int>, val <int>
# }
```
