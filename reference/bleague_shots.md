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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The {schedule_key} every game wrapper takes and the schedule page's list-item id. |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
| period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
| event_no | integer | Event sequence number, ascending in game order. v2 counts in steps of 1000 (inserted corrections may fall in between); v1 counts 1, 2, 3... |
| team_side | character | Side of the acting team from HomeAway (1 home, 2 away); null on game-level rows and official timeouts. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| player_id | character | Primary actor PlayerID as text (key space: B.LEAGUE persons). On a v1 substitution it is the player going out. Null on team rows and game-level rows. |
| player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
| player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
| shot_type | character | 3pt or 2pt, from ActionCD1 (1-2 three-point, 3-6 two-point). |
| in_paint | logical | True for a two-point shot inside the paint, false outside; null for threes and on the B3 feed, whose 2PT codes do not split by paint. |
| made | logical | True when the shot was made (ActionCD1 odd for threes and 3 / 4), false when missed. |
| qualifier2 | character | English slug for the shot's ActionCD2 (jump_shot, layup, dunk); null when unknown. |
| qualifier3 | character | English slug for the shot's ActionCD3 (fast_break, points_off_turnover, second_chance, ...); null when none. |
| x | double | Event x: percent (0-100) of the court LENGTH from the 'left' baseline (baskets near 5 and 95). Metres (x / 100 x 28) are an inference. 2022-23 onward on v2 only. |
| y | double | Event y: percent (0-100) of the court WIDTH (baskets at 50). Which sideline is y = 0 is unverified; metres (y / 100 x 15) are an inference. 2022-23 onward on v2 only. |
| area_code | integer | Shot-zone code 1-13 read from the site's shot-chart SVG: 1 restricted area, 2 rest of the paint, 3 / 7 baseline mid-range, 4 / 6 wing mid-range, 5 top-of-the-key mid-range, 8 / 12 corner 3, 9 / 11 wing 3, 10 top 3, 13 deep band. Of each pair the first is the side far along the baseline. Also set on turnover and foul rows; 2022-23 onward. |
| area | character | English zone slug for area_code (restricted_area, paint, baseline_mid_range, wing_mid_range, top_of_key_mid_range, corner_3, wing_3, top_3, deep_3); mirrored codes share a slug. |
| side | character | Basket the play is charted at: 'left' (x near 0) or 'right' (x near 100); flips at half-time. Present from 2025-26 only; earlier seasons leave it null and the end must be inferred from x. |
| rest_time | character | Game clock REMAINING in the period as the feed's 'mm:ss' text (counts down from 10:00). |
| clock_seconds | integer | Game clock remaining in the period in whole seconds (8:50 = 530), derived from rest_time. |
| score | character | Running score 'home-away' after the event (e.g. '2-4'); null on player-in rows and v1 substitutions. |

## Details

The B.LEAGUE (Japan Professional Basketball League: B1, B2, B3) wrappers
mirror sdv-py's `sportsdataverse.basketball.bleague` wrappers of the
same names: same arguments, the same snake_case columns and types, one
row per sdv-py row.

**Unofficial and unsupported.** The game contexts are JSON objects in
B.LEAGUE's own public S3 bucket (`b-league.s3.amazonaws.com`, the store
its game pages read), and the schedule, standings and game_detail pages
of `www.bleague.jp` are parsed here. Neither host publishes terms for
this use (the site's /terms/ answers 404; robots.txt sets a Crawl-delay
only for msnbot and bingbot). Requests are spaced at least one second
apart per host; 429 and 5xx answers are retried (three attempts).
SportsDataverse has not ruled on the site's terms, so the data is not
redistributed as release assets.

**Seasons** are END years (`season = 2026` is 2025-26); the site's own
`Year` / `year=` is the START year, so the request sends
`year = season - 1`. Game wrappers take the global `schedule_key` (one
integer sequence across B1, B2, B3 and every season: 1 = the 2016-17
opener, 5856 in 2020-21, 500017 in 2022-23, 504734 / 505508 B1 / B2 and
10693 B3 in 2025-26); list a day's keys with
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md).

**Feeds.** A game is read from the v2 feed (B1/B2 from 2020-21), else
the v1 feed (B3 and B1/B2 2018-2020), else the game page's embedded copy
(the only source of 2016-17 and 2017-18), decided at run time. v2 ids
are strings, v1 ids integers: both become text here. v1 adds leaders and
the score track; the team-rebound codes 18 / 19 are swapped between the
feeds and a v1 substitution is one row where v2 has two. Player and team
names are Japanese (English names only on the box score and header).
Game wrappers serve FINISHED games only. Each game wrapper fetches the
context itself (two requests): fetch once per game per wrapper you need.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (no source holds the game, a schedule day without games,
HTTP 404), `hoopR_bad_request` (a non-integer or out-of-range argument,
HTTP 400 / 422) and `hoopR_asset_fetch` (any other failure: another
status, a transport error, a non-JSON or non-HTML body, an error or
changed body, an unfinished game, a context or page for another game,
season, tab or day, a truncated schedule list, or layout drift). All
inherit `hoopR_error`.

## See also

Other B.LEAGUE Functions:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
[`bleague_leaders()`](https://hoopR.sportsdataverse.org/reference/bleague_leaders.md),
[`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md),
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_clubs()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_clubs.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_schedule_events()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_events.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)

## Examples

``` r
# \donttest{
  try(bleague_shots(schedule_key = 504734))
#> ── B.LEAGUE shots from b-league.s3.amazonaws.com ──────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:34:43 UTC
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
