# **IBBA Segev Player Box**

**Per-player box score of a finished game, plus a team-credited line per
side.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`

## Usage

``` r
ibba_segev_player_box(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with one row per player in the game. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_segev_player_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md).

## See also

Other IBBA Segev Functions:
[`ibba_segev_game_info()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_game_info.md),
[`ibba_segev_pbp()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_pbp.md),
[`ibba_segev_period_scores()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_period_scores.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md),
[`ibba_segev_team_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_team_box.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_player_box(game_id = 50))
#> ── IBBA Segev player box ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:12:20 UTC
#> # A tibble: 26 × 39
#>    game_id team_side team_id row_type player_id jersey_number starter on_court
#>      <int> <chr>       <int> <chr>        <int>         <int> <lgl>   <lgl>   
#>  1      50 home           11 player        1111             0 FALSE   TRUE    
#>  2      50 home           11 player        1179             5 FALSE   TRUE    
#>  3      50 home           11 player        1266             6 FALSE   FALSE   
#>  4      50 home           11 player        1114            14 FALSE   FALSE   
#>  5      50 home           11 player        1115            16 TRUE    FALSE   
#>  6      50 home           11 player        1249            17 FALSE   TRUE    
#>  7      50 home           11 player        1116            21 TRUE    TRUE    
#>  8      50 home           11 player        1117            22 FALSE   FALSE   
#>  9      50 home           11 player        1118            24 TRUE    TRUE    
#> 10      50 home           11 player        1119            35 TRUE    FALSE   
#> # ℹ 16 more rows
#> # ℹ 31 more variables: minutes <chr>, seconds_played <int>, plus_minus <int>,
#> #   fg2m <int>, fg2_missed <int>, fg3m <int>, fg3_missed <int>, ftm <int>,
#> #   ft_missed <int>, dreb <int>, oreb <int>, fouls <int>, fouls_drawn <int>,
#> #   steals <int>, turnovers <int>, assists <int>, blocks <int>,
#> #   blocks_against <int>, fast_break_pts <int>, second_chance_pts <int>,
#> #   pts <int>, val <int>, deflections <int>, recoveries <int>, dunks <int>, …
# }
```
