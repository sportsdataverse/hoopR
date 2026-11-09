# **B.LEAGUE Shots**

**Field-goal attempts of one B.LEAGUE game with their court position
(play-by-play rows that carry x / y).**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

One row per field-goal attempt (`ActionCD1` 1-6) with a location, oldest
first. `x` is the percent (0-100) of the court LENGTH from the `left`
baseline and `y` the percent of the WIDTH (the baskets sit near x = 5
and 95 at y = 50). Which sideline is y = 0 is unverified, and metres (x
/ 100 x 28, y / 100 x 15) are an inference. `side` (`left` / `right`)
names the basket a shot is charted at, from 2025-26 only; teams change
ends at half-time. `in_paint` is `NA` on the B3 feed. Locations exist
from 2022-23 on the v2 feed only: any other game gives a zero-row
tibble.

## Usage

``` r
bleague_shots(schedule_key, season = NULL)
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

A `hoopR_data` tibble with one row per field-goal attempt. Its columns
are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_shots")`) and in the searchable
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
  try(bleague_shots(schedule_key = 504734))
#> ── B.LEAGUE shots from b-league.s3.amazonaws.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:09:26 UTC
#> # A tibble: 134 × 23
#>    schedule_key season feed  period event_no team_side team_id player_id 
#>           <int>  <int> <chr>  <int>    <int> <chr>     <chr>   <chr>     
#>  1       504734   2026 v2         1     9000 away      703     33085     
#>  2       504734   2026 v2         1    10000 home      706     30348     
#>  3       504734   2026 v2         1    11000 away      703     5100000036
#>  4       504734   2026 v2         1    12000 home      706     26921     
#>  5       504734   2026 v2         1    13000 away      703     8593      
#>  6       504734   2026 v2         1    17000 away      703     8593      
#>  7       504734   2026 v2         1    25000 away      703     8593      
#>  8       504734   2026 v2         1    28000 home      706     26921     
#>  9       504734   2026 v2         1    30000 home      706     9031      
#> 10       504734   2026 v2         1    36000 home      706     30348     
#> # ℹ 124 more rows
#> # ℹ 15 more variables: player_no <chr>, player_name_j <chr>, shot_type <chr>,
#> #   in_paint <lgl>, made <lgl>, qualifier2 <chr>, qualifier3 <chr>, x <dbl>,
#> #   y <dbl>, area_code <int>, area <chr>, side <chr>, rest_time <chr>,
#> #   clock_seconds <int>, score <chr>
# }
```
