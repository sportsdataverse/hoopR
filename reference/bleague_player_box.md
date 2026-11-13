# **B.LEAGUE Player Box**

**Player box score of one B.LEAGUE game: one row per (player, period
category), both teams.**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

Rows with `category` 1 (a player), one per `period_category` (1-4
quarters, 15 / 16 halves, 18 the whole game; overtime categories are
unverified). `seconds_played` is `play_time` in seconds (`DNP` = `NA`).
The v2 feed sends `""` as a placeholder (not 0) in some cells; those are
`NA` here. The efficiency definition differs by feed, the advanced
columns (`plus_minus`, `ast_to`, `efg`, `ts`, `usg`) exist from 2022-23
on v2 only, and `dunks` / `ptpft` exist on v1 only.

## Usage

``` r
bleague_player_box(schedule_key, season = NULL)
```

## Arguments

- schedule_key:

  (*integer* required): B.LEAGUE ScheduleKey, one global sequence across
  B1, B2, B3 and every season, e.g. `504734` (B1 2025-26 sec 1, Alvark
  Tokyo v Utsunomiya Brex); the `schedule_key` column of
  [`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md).

- season:

  (*integer* optional): a guard, the season END year the game must
  belong to; a context whose `Year` differs raises `hoopR_asset_fetch`.
  `NULL` (default) = no check (the key alone selects the game).

## Value

A `hoopR_data` tibble with one row per player, period and category. Its
columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_player_box")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

Source, terms of use, request pacing, seasons, ids, coverage and error
classes of this family: see the notes in
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md).

## See also

[family_b_league](https://hoopR.sportsdataverse.org/reference/family_b_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(bleague_player_box(schedule_key = 504734))
#> ── B.LEAGUE player box from b-league.s3.amazonaws.com ─────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 18:13:01 UTC
#> # A tibble: 175 × 50
#>    schedule_key season feed  team_side team_id category period_category
#>           <int>  <int> <chr> <chr>     <chr>      <int>           <int>
#>  1       504734   2026 v2    home      706            1               1
#>  2       504734   2026 v2    home      706            1               1
#>  3       504734   2026 v2    home      706            1               1
#>  4       504734   2026 v2    home      706            1               1
#>  5       504734   2026 v2    home      706            1               1
#>  6       504734   2026 v2    home      706            1               1
#>  7       504734   2026 v2    home      706            1               1
#>  8       504734   2026 v2    home      706            1               1
#>  9       504734   2026 v2    home      706            1               1
#> 10       504734   2026 v2    home      706            1               1
#> # ℹ 165 more rows
#> # ℹ 43 more variables: team_name_j <chr>, team_name_e <chr>, player_id <chr>,
#> #   player_no <chr>, player_name_j <chr>, player_name_e <chr>, play_time <chr>,
#> #   on_court <lgl>, display_order <int>, starter <lgl>, seconds_played <int>,
#> #   points <int>, fg3_made <int>, fg3_attempted <int>, fg2_made <int>,
#> #   fg2_attempted <int>, ft_made <int>, ft_attempted <int>, fouls <int>,
#> #   fouls_drawn <int>, reb_off <int>, reb_def <int>, reb <int>, …
# }
```
