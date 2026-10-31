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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The {schedule_key} every game wrapper takes and the schedule page's list-item id. |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
| team_side | character | Side of the game the row belongs to: home or away. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| category | integer | Row category: 1 = player, 2 = team / coaches row (team-credited stats; on v1 it names the head coach), 3 = team totals. One row per (category, player, period category). |
| period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
| team_name_j | character | Team name in Japanese (official name, e.g. Alvark Tokyo). |
| team_name_e | character | Team name in English, uppercase ('ALVARK TOKYO'). |
| player_id | character | B.LEAGUE PlayerID as text (key space: B.LEAGUE persons, stable across seasons and clubs: Makoto Hiejima = '8589'). A string on v2, an integer on v1; both are text here. Null where the row names no player. |
| player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
| player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
| player_name_e | character | Player name in English ('Makoto Hiejima'); null on team and totals rows. |
| play_time | character | Minutes played as the feed's 'mm:ss'; 'DNP' = did not play. Totals rows hold 5 x the period length ('200:00' for the game). |
| on_court | logical | True for the five players on court when the context was last written (for a final game, at the final buzzer); the same value on every period row of the player. Null on v2 team and totals rows. |
| display_order | integer | Display order of the row (v1 only), integer; null on v2. |
| starter | logical | True when the player started; false for the bench; null on team and totals rows. (The feed sends 1 / null on v2 and a boolean on v1.) |
| seconds_played | integer | Time on court in seconds, parsed from play_time (50:00 = 3000); null for DNP and blank. |
| points | integer | Points scored. The v2 feed sends ” (a placeholder, not 0) on the team row of quarters; null here. |
| fg3_made | integer | Three-point field goals made (v2 placeholder ” on quarter team rows becomes null). |
| fg3_attempted | integer | Three-point field goals attempted. |
| fg2_made | integer | Two-point field goals made. |
| fg2_attempted | integer | Two-point field goals attempted. |
| ft_made | integer | Free throws made. |
| ft_attempted | integer | Free throws attempted. |
| fouls | integer | Personal fouls committed (F). |
| fouls_drawn | integer | Fouls drawn (FD). |
| reb_off | integer | Offensive rebounds (OR). |
| reb_def | integer | Defensive rebounds (DR). |
| reb | integer | Total rebounds. |
| turnovers | integer | Turnovers (TO). |
| assists | integer | Assists credited to the player or team (AS). |
| steals | integer | Steals credited to the player or team (ST). |
| blocks | integer | Blocks made (BS). |
| blocks_received | integer | Shots of this player or team that were blocked (BSON). |
| ptfb | integer | Fast-break figure; equals the summary's fast-break points on the one game checked, but whether it counts points or baskets is unverified. |
| pt2in | integer | Inside-the-paint figure: on v2 a COUNT of made inside-the-paint 2PT (the summary holds 2x that in points); on v1 points in the paint (0 on B3, whose 2PT shots are never split by paint). |
| pt2nd | integer | Second-chance figure; smaller than the summary's second-chance points, so likely made baskets; unverified. |
| ptpft | integer | Points off turnovers; v1 box rows only, null on v2. |
| dunks | integer | Dunks made (PT2DUNK); v1 box rows only, null on v2. |
| efficiency | integer | Efficiency rating (kokendo), era-dependent: v2 = points + rebounds + assists + steals + blocks + fouls drawn - missed FG - missed FT - turnovers - fouls - shots blocked (PIR); v1 omits fouls drawn, fouls and shots blocked. |
| plus_minus | integer | Plus/minus: team point difference while on court. v2 from 2022-23 only; null on totals and half rows. |
| ast_to | double | Assist-to-turnover ratio (0 when no turnovers). v2 from 2022-23 only; null on half rows. |
| efg | double | Effective field-goal percentage as a FRACTION 0-1 (3PT weighted 1.5x); the site multiplies by 100. v2 from 2022-23 only. |
| ts | double | True-shooting percentage as a FRACTION 0-1; the site multiplies by 100. v2 from 2022-23 only. |
| usg | double | Usage rate in PERCENT 0-100. v2 from 2022-23 only; absent on totals rows. |
| off_rtg | double | Offensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
| def_rtg | double | Defensive rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
| net_rtg | double | Net rating. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |
| poss | double | Possessions. v2 from 2022-23 only; on team and totals rows 0 in every sample, never filled. |

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
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)

## Examples

``` r
# \donttest{
  try(bleague_team_box(schedule_key = 504734))
#> ── B.LEAGUE team box from b-league.s3.amazonaws.com ───────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 20:10:25 UTC
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
