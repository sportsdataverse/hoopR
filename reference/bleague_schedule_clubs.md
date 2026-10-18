# **B.LEAGUE Schedule Clubs**

**The club filter of the B.LEAGUE schedule page: every club of the
season and division with its team id.**

Endpoint: `GET https://www.bleague.jp/schedule/`

One row per club the page's filter lists, which maps a team id to the
short Japanese name the schedule uses. Reads the same page as
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md)
(one request).

## Usage

``` r
bleague_schedule_clubs(season, tab, month, day, event = NULL)
```

## Arguments

- season:

  (*integer* required): season END year (`2026` = 2025-26); the site's
  own year is the START year, so the request sends `season - 1`.

- tab:

  (*integer* required): division tab: 1 = B1, 2 = B2, 3 = B3.

- month:

  (*integer* required): calendar month 1-12 of the game day (seasons run
  September to June).

- day:

  (*integer* required): day of month of the game day.

- event:

  (*integer* optional): competition type: 2 B1 league, 3 B1
  Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2
  playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs.
  `NULL` (default) = the league competition of the tab (2 / 7 / 15).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| tab | integer | Division tab: 1 = B1, 2 = B2, 3 = B3. |
| event | integer | Competition type of the page: 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs. |
| team_id | character | B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| name | character | Club short name in Japanese as the schedule page prints it (e.g. Hokkaido). |

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

     bleague_schedule_clubs(season = 2026, tab = 1, month = 10, day = 4)

## See also

Other B.LEAGUE:
[`bleague_game_info()`](https://hoopR.sportsdataverse.org/reference/bleague_game_info.md),
[`bleague_leaders()`](https://hoopR.sportsdataverse.org/reference/bleague_leaders.md),
[`bleague_pbp()`](https://hoopR.sportsdataverse.org/reference/bleague_pbp.md),
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md),
[`bleague_player_box()`](https://hoopR.sportsdataverse.org/reference/bleague_player_box.md),
[`bleague_schedule()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule.md),
[`bleague_schedule_days()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_days.md),
[`bleague_schedule_events()`](https://hoopR.sportsdataverse.org/reference/bleague_schedule_events.md),
[`bleague_score_track()`](https://hoopR.sportsdataverse.org/reference/bleague_score_track.md),
[`bleague_shots()`](https://hoopR.sportsdataverse.org/reference/bleague_shots.md),
[`bleague_standings()`](https://hoopR.sportsdataverse.org/reference/bleague_standings.md),
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)
