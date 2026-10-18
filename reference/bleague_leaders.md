# **B.LEAGUE Leaders**

**Team leaders of one B.LEAGUE game per statistic and period category
(v1 feed only).**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

One row per (period category, category, team, player), ranked within the
team (`rank` 1 = best; ties share a rank and `tie_order` orders them).
`category` 1 points, 2 assists, 3 steals, 4 blocks, 5 rebounds, 8 shots
blocked (other codes are unnamed). Only the v1 feed (B3, B1/B2
2018-2020, the 2016-17 embed) publishes leaders: a v2 game gives a
zero-row tibble.

## Usage

``` r
bleague_leaders(schedule_key, season = NULL)
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
| period_category | integer | Period category: 1-4 = quarters 1-4, 15 = first half, 16 = second half, 18 = whole game. Overtime codes are unverified. |
| category | integer | Leader category code, decoded by matching count to the box score: 1 points, 2 assists, 3 steals, 4 blocks, 5 rebounds, 8 shots blocked. |
| category_name | character | English name of category (points, assists, steals, blocks, rebounds, blocks_received); null for an unknown code. |
| rank | integer | Rank within the team for the category (1 = best; ties share a rank). |
| tie_order | integer | Order within a tied rank (1 = first listed). |
| team_side | character | Side of the game the row belongs to: home or away. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| team_name_j | character | Team name in Japanese (official name, e.g. Alvark Tokyo). |
| player_id | character | B.LEAGUE PlayerID as text (key space: B.LEAGUE persons, stable across seasons and clubs: Makoto Hiejima = '8589'). A string on v2, an integer on v1; both are text here. Null where the row names no player. |
| player_no | character | Shirt number as text, so '00' and '0' stay distinct; null on team and game-level rows. |
| player_name_j | character | Player name in Japanese (katakana for foreign players); null on team and game-level rows. |
| count | integer | The player's value in the category for the period category. |
| reb_off_count | integer | Offensive-rebound count carried on the row (filled for the rebounds category). |
| reb_def_count | integer | Defensive-rebound count carried on the row (filled for the rebounds category). |

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

     bleague_leaders(schedule_key = 10693)

## See also

Other B.LEAGUE:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
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
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)
