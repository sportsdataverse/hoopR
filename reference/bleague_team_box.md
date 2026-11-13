# **B.LEAGUE Team Box**

**Team rows of the box score of one B.LEAGUE game: the team / coaches
row and the team totals, per period category.**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

Rows with `category` 2 (team-credited stats; on v1 the row names the
head coach in `player_id` and `player_name_*`) and 3 (the team totals,
whose `play_time` is five times the period length: `200:00` for the
game), one per `period_category`. The same columns as
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md).
The v2 totals row carries no `TeamID`; `team_id` is filled from the game
header.

## Usage

``` r
bleague_team_box(schedule_key, season = NULL)
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

A `hoopR_data` tibble with one row per team in the game. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_team_box")`) and in the
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
  try(bleague_team_box(schedule_key = 504734))
#> ── B.LEAGUE team box from b-league.s3.amazonaws.com ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-13 12:48:48 UTC
#> # A tibble: 28 × 50
#>    schedule_key season feed  team_side team_id category period_category
#>           <int>  <int> <chr> <chr>     <chr>      <int>           <int>
#>  1       504734   2026 v2    home      706            2               1
#>  2       504734   2026 v2    home      706            3               1
#>  3       504734   2026 v2    home      706            2               2
#>  4       504734   2026 v2    home      706            3               2
#>  5       504734   2026 v2    home      706            2               3
#>  6       504734   2026 v2    home      706            3               3
#>  7       504734   2026 v2    home      706            2               4
#>  8       504734   2026 v2    home      706            3               4
#>  9       504734   2026 v2    home      706            2              15
#> 10       504734   2026 v2    home      706            3              15
#> # ℹ 18 more rows
#> # ℹ 43 more variables: team_name_j <chr>, team_name_e <chr>, player_id <chr>,
#> #   player_no <chr>, player_name_j <chr>, player_name_e <chr>, play_time <chr>,
#> #   on_court <lgl>, display_order <int>, starter <lgl>, seconds_played <int>,
#> #   points <int>, fg3_made <int>, fg3_attempted <int>, fg2_made <int>,
#> #   fg2_attempted <int>, ft_made <int>, ft_attempted <int>, fouls <int>,
#> #   fouls_drawn <int>, reb_off <int>, reb_def <int>, reb <int>, …
# }
```
