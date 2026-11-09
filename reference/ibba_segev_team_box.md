# **IBBA Segev Team Box**

**Team totals of both sides: final score, timeouts, lead stats,
shooting, rebounds and team game stats.**

Endpoint:
`GET https://stats.segevstats.com/realtimestat_heb/api/?method=getBoxScore`

## Usage

``` r
ibba_segev_team_box(game_id)
```

## Arguments

- game_id:

  (*integer* required): Segev game id (e.g. 50 = Hapoel Be'er Sheva vs
  Maccabi Tel Aviv, 2025-26 round 1): `segev_game_id` in ibba_games.

## Value

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "ibba_segev_team_box")`) and in the
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
[`ibba_segev_player_box()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_player_box.md),
[`ibba_segev_rosters()`](https://hoopR.sportsdataverse.org/reference/ibba_segev_rosters.md)

## Examples

``` r
# \donttest{
  try(ibba_segev_team_box(game_id = 50))
#> ── IBBA Segev team box ────────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:12:21 UTC
#> # A tibble: 2 × 44
#>   game_id team_side team_id score timeouts time_leading biggest_lead times_tied
#>     <int> <chr>       <int> <int>    <int> <chr>               <int>      <int>
#> 1      50 home           11    92        1 01:37                   2          6
#> 2      50 away            2   104        2 34:32                  17          6
#> # ℹ 36 more variables: lead_changes <int>, fg2m <int>, fg2_missed <int>,
#> #   fg3m <int>, fg3_missed <int>, ftm <int>, ft_missed <int>, dreb <int>,
#> #   oreb <int>, fouls <int>, fouls_drawn <int>, steals <int>, turnovers <int>,
#> #   assists <int>, blocks <int>, blocks_against <int>, fast_break_pts <int>,
#> #   second_chance_pts <int>, pts <int>, val <int>, deflections <int>,
#> #   recoveries <int>, dunks <int>, offensive_fouls_drawn <int>, and_ones <int>,
#> #   vps <dbl>, fg2a <int>, fg3a <int>, fta <int>, pts_from_turnovers <int>, …
# }
```
