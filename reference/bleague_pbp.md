# **B.LEAGUE Play-by-Play**

**Play-by-play of one finished B.LEAGUE game, in game order, every feed
in one shape.**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

One row per logged event, oldest first (`event_no` ascends; v2 counts in
steps of 1000). `action`, `qualifier2` and `qualifier3` are English
slugs for the numeric codes (`NA` for a code no sample contains); the
team-rebound codes 18 / 19 mean opposite things on the two feeds and
`action` follows the `feed` column. A v1 substitution is ONE row
(`action` `substitution`, `player_id` out, `player2_id` in), a v2 one is
two rows (`player_out` / `player_in`). `home_score` / `away_score` split
the running `score`. `x` / `y` / `area_code` / `success` exist on v2
from 2022-23 and `side` from 2025-26 (see
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md)).
`recorded_at` / `edited_at` are UTC instants (POSIXct, tz UTC).
Game-level rows (start, period, clock) carry `NA` team and player
columns.

## Usage

``` r
bleague_pbp(schedule_key, season = NULL)
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

A `hoopR_data` tibble with one row per logged event. Its columns are
listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_pbp")`) and in the searchable
[return
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
  try(bleague_pbp(schedule_key = 504734))
#> ── B.LEAGUE pbp from b-league.s3.amazonaws.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-10 01:58:42 UTC
#> # A tibble: 809 × 37
#>    schedule_key season feed  period event_no action_code action  qualifier_code2
#>           <int>  <int> <chr>  <int>    <int>       <int> <chr>             <int>
#>  1       504734   2026 v2         1     1000          80 game_s…              NA
#>  2       504734   2026 v2         1     2000          86 player…              NA
#>  3       504734   2026 v2         1     2000          86 player…              NA
#>  4       504734   2026 v2         1     2000          86 player…              NA
#>  5       504734   2026 v2         1     2000          86 player…              NA
#>  6       504734   2026 v2         1     2000          86 player…              NA
#>  7       504734   2026 v2         1     2000          86 player…              NA
#>  8       504734   2026 v2         1     2000          86 player…              NA
#>  9       504734   2026 v2         1     2000          86 player…              NA
#> 10       504734   2026 v2         1     2000          86 player…              NA
#> # ℹ 799 more rows
#> # ℹ 29 more variables: qualifier2 <chr>, qualifier_code3 <int>,
#> #   qualifier3 <chr>, team_side <chr>, team_id <chr>, team_name_j <chr>,
#> #   player_id <chr>, player_no <chr>, player_name_j <chr>, player2_id <chr>,
#> #   player2_no <chr>, player2_name_j <chr>, rest_time <chr>,
#> #   clock_seconds <int>, score <chr>, home_score <int>, away_score <int>,
#> #   period_end <lgl>, game_end <lgl>, x <dbl>, y <dbl>, area_code <int>, …
# }
```
