# **B.LEAGUE Game Info**

**Game header of one B.LEAGUE game: competition, round, venue,
officials, tip-off, both teams and the scores.**

Endpoint:
`GET https://b-league.s3.amazonaws.com/web_json/v2_genius_contexts/{schedule_key}/{latest}.json`
(the v1 feed, or the game page's embed, when v2 does not hold the game).

One row. `year` is the season START year and `season` the END year
(`year + 1`). Team ids are text (the v1 feed sends integers, v2
strings). `home_score_p1` ... `p14` are the points scored IN each period
(the v1 header carries 14 slots, v2 four; use
[`bleague_period_scores()`](https://hoopR.sportsdataverse.org/reference/bleague_period_scores.md)
for the played periods). The v1 header has many columns v2 lacks
(`game_no`, `event`, winning / losing streaks, weather, report text);
they are `NA` on v2. `temperature` and `humidity` were `NA` in every
observed body, so their type is an assumption.

## Usage

``` r
bleague_game_info(schedule_key, season = NULL)
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

A `hoopR_data` tibble with one row per game. Its columns are listed in
[return_columns](https://hoopR.sportsdataverse.org/reference/return_columns.md)
(`subset(return_columns, fn == "bleague_game_info")`) and in the
searchable [return
columns](https://hoopR.sportsdataverse.org/articles/return-columns.html)
article.

## Details

The B.LEAGUE (Japan Professional Basketball League: B1, B2, B3) wrappers
mirror sportsdataverse-py's `sportsdataverse.basketball.bleague`
wrappers of the same names: same arguments, the same snake_case columns
and types, one row per sportsdataverse-py row.

**Unofficial and unsupported.** The game contexts are JSON objects in
B.LEAGUE's own public S3 bucket (`b-league.s3.amazonaws.com`, the store
its game pages read), and the schedule, standings and game_detail pages
of `www.bleague.jp` are parsed here. Neither host publishes terms for
this use (the site's /terms/ answers 404; robots.txt sets a Crawl-delay
only for msnbot and bingbot). Requests are spaced at least one second
apart per host; 429 and 5xx answers are retried (three attempts). The
site's terms were not reviewed; check them before you republish the
data.

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

[family_b_league](https://hoopR.sportsdataverse.org/reference/family_b_league.md)
lists every function in this family.

## Examples

``` r
# \donttest{
  try(bleague_game_info(schedule_key = 504734))
#> ── B.LEAGUE game info from b-league.s3.amazonaws.com ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-09 19:51:30 UTC
#> # A tibble: 1 × 103
#>   schedule_key season feed   year  code event convention_key convention_class
#>          <int>  <int> <chr> <int> <int> <int> <chr>                     <int>
#> 1       504734   2026 v2     2025   546    NA 514                           1
#> # ℹ 95 more variables: round <int>, game_no <int>, schedule_state <int>,
#> #   schedule_conference <int>, interleague <lgl>, stadium_cd <chr>,
#> #   attendance <int>, game_datetime <dttm>, game_start_time <dttm>,
#> #   game_end_time <dttm>, max_period <int>, current_period <int>,
#> #   rest_time <int>, game_ended <lgl>, record_fixed <lgl>, box_exists <lgl>,
#> #   pbp_exists <lgl>, picture_exists <lgl>, report_exists <lgl>,
#> #   home_win <lgl>, commissioner_id <chr>, referee_id <chr>, …
# }
```
