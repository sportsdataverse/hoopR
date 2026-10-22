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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The {schedule_key} every game wrapper takes and the schedule page's list-item id. |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
| period | integer | Period number: 1-4 regulation; overtime numbering is unverified (no overtime sample). |
| event_no | integer | Event sequence number, ascending in game order. v2 counts in steps of 1000 (inserted corrections may fall in between); v1 counts 1, 2, 3... |
| action_code | integer | ActionCD1, the primary action code: 1 / 2 3PT made / missed, 3 / 5 2PT outside the paint made / missed, 4 / 6 inside the paint, 7 / 8 free throw, 9 / 10 defensive / offensive rebound, 11 block, 12 assist, 13 turnover, 14 steal, 15 foul drawn, 16 and-one, 17 team turnover, 18 / 19 team rebounds (SWAPPED between feeds), 22-25 fouls, 80-85 game and clock events, 86 / 87 player in / out, 88 timeout, 89 substitution (v1). |
| action | character | English slug for action_code (fg3_made, ft_missed, rebound_def, foul_personal, player_in, ...). The team-rebound codes 18 / 19 follow the feed column; null for a code no sample contains. |
| qualifier_code2 | integer | ActionCD2, a secondary qualifier (shot type, free throws awarded on a fouls, scoring context, 24 s violation); one code space shared with qualifier_code3. Null when the row has none. |
| qualifier2 | character | English slug for qualifier_code2 (jump_shot, layup, dunk, free_throws_awarded_N, fast_break, second_chance, shooting_foul, ...); null when unknown. |
| qualifier_code3 | integer | ActionCD3, a tertiary qualifier (scoring context on made shots, shooting foul / foul-out on fouls); same code space as qualifier_code2. |
| qualifier3 | character | English slug for qualifier_code3; null when unknown. |
| team_side | character | Side of the acting team from HomeAway (1 home, 2 away); null on game-level rows and official timeouts. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| team_name_j | character | Acting team name in Japanese; null on game-level rows and official timeouts. |
| player_id | character | Primary actor PlayerID as text (key space: B.LEAGUE persons). On a v1 substitution it is the player going out. Null on team rows and game-level rows. |
| player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
| player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
| player2_id | character | Second actor PlayerID as text; on a v1 substitution the player coming in. v1 / embed only. |
| player2_no | character | Shirt number of the second actor (v1 / embed only). |
| player2_name_j | character | Second actor's name in Japanese (v1 / embed only). |
| rest_time | character | Game clock REMAINING in the period as the feed's 'mm:ss' text (counts down from 10:00). |
| clock_seconds | integer | Game clock remaining in the period in whole seconds (8:50 = 530), derived from rest_time. |
| score | character | Running score 'home-away' after the event (e.g. '2-4'); null on player-in rows and v1 substitutions. |
| home_score | integer | Home running score after the event, split from score. |
| away_score | integer | Away running score after the event, split from score. |
| period_end | logical | True on the closing row of a period (ActionCD1 83). |
| game_end | logical | True on the game-end row on v1 and the embed; false on EVERY v2 row, the game-end row (81) included, so use action instead. |
| x | double | Event x: percent (0-100) of the court LENGTH from the 'left' baseline (baskets near 5 and 95). Metres (x / 100 x 28) are an inference. 2022-23 onward on v2 only. |
| y | double | Event y: percent (0-100) of the court WIDTH (baskets at 50). Which sideline is y = 0 is unverified; metres (y / 100 x 15) are an inference. 2022-23 onward on v2 only. |
| area_code | integer | Shot-zone code 1-13 read from the site's shot-chart SVG: 1 restricted area, 2 rest of the paint, 3 / 7 baseline mid-range, 4 / 6 wing mid-range, 5 top-of-the-key mid-range, 8 / 12 corner 3, 9 / 11 wing 3, 10 top 3, 13 deep band. Of each pair the first is the side far along the baseline. Also set on turnover and foul rows; 2022-23 onward. |
| area | character | English zone slug for area_code (restricted_area, paint, baseline_mid_range, wing_mid_range, top_of_key_mid_range, corner_3, wing_3, top_3, deep_3); mirrored codes share a slug. |
| success | logical | Outcome flag: true = made / successful, false = missed; true on non-shot rows. v2 from 2022-23 only. |
| side | character | Basket the play is charted at: 'left' (x near 0) or 'right' (x near 100); flips at half-time. Present from 2025-26 only; earlier seasons leave it null and the end must be inferred from x. |
| play_text | character | Play description in Japanese: '#{shirt} {surname} {action} ({running count})'; a circle marks a make, a cross a miss, and an arrow a v1 substitution (out to in). |
| recorded_at | POSIXct | When the event was logged, as a UTC instant (v2 stores UTC text, v1 a JST-offset .NET date, the embed epoch seconds). |
| edited_at | POSIXct | When the event was last edited, as a UTC instant; null when never edited. |
| code | integer | Feed/organisation code repeated on every row: 546 on v2, 6 on v1; meaning unverified. |

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
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_clubs()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_clubs.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_schedule_events()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_events.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)

## Examples

``` r
# \donttest{
  try(bleague_pbp(schedule_key = 504734))
#> ── B.LEAGUE pbp from b-league.s3.amazonaws.com ────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:34:37 UTC
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
