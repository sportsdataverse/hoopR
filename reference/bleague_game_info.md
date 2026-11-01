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

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| schedule_key | integer | B.LEAGUE ScheduleKey (key space: B.LEAGUE games, ONE global integer sequence across B1, B2, B3 and every season). The {schedule_key} every game wrapper takes and the schedule page's list-item id. |
| season | integer | Season END year (2026 = 2025-26), the feed's Year (the START year) plus one. |
| feed | character | Source feed of the row: v2 (v2_genius_contexts, B1/B2 from 2020-21) or v1 (v1_contexts: B3, B1/B2 2018-2020, and the 2016-17 / 2017-18 game-page embed). The feeds differ in id types, dates and some codes. |
| year | integer | Season START year as the site stores it (2025 = 2025-26); season is the END year. |
| code | integer | Feed/organisation code repeated on every row: 546 on v2, 6 on v1; meaning unverified. |
| event | integer | Competition type (v1 header only): 2 B1 league, 3 B1 Championship, 4 B1 relegation playoffs, 5 all-star, 7 B2 league, 8 B2 playoffs, 11 B1-B2 promotion/relegation, 15 B3 league, 32 B3 playoffs; null on v2. |
| convention_key | character | ConventionKey as text (key space: competition-seasons, taikai): v2 '514' = B1 2025-26, v1 102 = B3 2025-26. Key on (feed, convention_key); the feeds may number independently. |
| convention_class | integer | Competition class code (1 on every sample); meaning unverified. |
| round | integer | Round (setsu) within the competition-season; playoffs use 100+ (101). Integer. |
| game_no | integer | Game number within the competition (v1 header only); null on v2. |
| schedule_state | integer | Schedule state code (v1 header only; 2 on the final-game sample); meaning unverified. |
| schedule_conference | integer | Conference code (v1 header only); meaning unverified. |
| interleague | logical | True for an inter-league game (v1 header only). |
| stadium_cd | character | StadiumCD as text (key space: B.LEAGUE venues; stability unverified). |
| attendance | integer | Announced attendance. |
| game_datetime | POSIXct | Scheduled tip-off as a UTC instant (the feed's JST wall clock minus nine hours). |
| game_start_time | POSIXct | Actual start as a UTC instant (v1 header only; epoch seconds on the 2016-17 embed). |
| game_end_time | POSIXct | Actual end as a UTC instant (v1 header only). |
| max_period | integer | Number of periods the game had (4 plus overtimes). |
| current_period | integer | Period the context was last written in (the last period for a final game). |
| rest_time | integer | Clock remaining when last written (v1 header only; 0 for a final game). |
| game_ended | logical | True when the game has ended; the runtime serves only games where this and record_fixed are true. |
| record_fixed | logical | True when the record is finalised (no more corrections expected). |
| box_exists | logical | True when the box score exists. |
| pbp_exists | logical | True when play-by-play exists. |
| picture_exists | logical | True when photos exist (v1 header only). |
| report_exists | logical | True when a game report text exists (v1 header only). |
| home_win | logical | True when the home team won (v1 header only); null on v2. |
| commissioner_id | character | Commissioner id as text; null when none is assigned. |
| referee_id | character | Crew-chief referee RefereeID as text (key space: officials; stability unverified). |
| sub_referee_id1 | character | Second referee RefereeID as text. |
| sub_referee_id2 | character | Third referee RefereeID as text. |
| temperature | double | Temperature; null in every observed body, so its dtype is an assumption. |
| humidity | double | Humidity; null in every observed body, so its dtype is an assumption. |
| convention_name_j | character | Competition name in Japanese (e.g. the Resona Group B.LEAGUE 2025-26 B1 regular season). |
| convention_name_e | character | Competition name in English; empty (null) on early v1 bodies. |
| convention_title_j | character | Competition title in Japanese (v1 header only). |
| convention_title_e | character | Competition title in English (v1 header only). |
| stadium_name_j | character | Venue name in Japanese (e.g. TOYOTA ARENA TOKYO, AGF Suzuka Gymnasium). |
| stadium_name_e | character | Venue name in English; often empty (null). |
| court | character | Court number at the venue (v1 header only). |
| report | character | Game report text (v1 header only); usually empty (null). |
| weather | character | Weather text (v1 header only); null in every observed body. |
| schedule_class_name_j | character | Schedule class name in Japanese (v1 header only); usually empty. |
| schedule_class_name_e | character | Schedule class name in English (v1 header only); usually empty. |
| schedule_class_short_name_j | character | Schedule class short name in Japanese (v1 header only); usually empty. |
| schedule_class_short_name_e | character | Schedule class short name in English (v1 header only); usually empty. |
| commissioner_name_j | character | Commissioner name in Japanese (names only; no contact data is published). |
| commissioner_name_e | character | Commissioner name in English (v1 header only). |
| referee_name_j | character | Crew-chief referee name in Japanese (name only; no contact data is published). |
| referee_name_e | character | Crew-chief referee name in English (v1 header only). |
| sub_referee_name_j1 | character | Second referee name in Japanese. |
| sub_referee_name_e1 | character | Second referee name in English (v1 header only). |
| sub_referee_name_j2 | character | Third referee name in Japanese. |
| sub_referee_name_e2 | character | Third referee name in English (v1 header only). |
| home_team_id | character | Home team id. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| home_team_name_j | character | Home team name in Japanese (official name). |
| home_team_name_e | character | Home team name in English, uppercase. |
| home_team_short_name_j | character | Home team short name in Japanese (e.g. the short form of Alvark Tokyo). |
| home_team_short_name_e | character | Home team short name in English (e.g. A TOKYO). |
| home_team_sub_name_j | character | Home team sub name in Japanese (v1 header only); usually empty. |
| home_team_sub_name_e | character | Home team sub name in English (v1 header only); usually empty. |
| home_score | integer | Home team final score. |
| home_winning_count | integer | Home team winning streak (v1 header only); null in every observed body. |
| home_losing_count | integer | Home team losing streak (v1 header only); null in every observed body. |
| away_team_id | character | Away team id. B.LEAGUE TeamID as text (key space: B.LEAGUE clubs, stable across seasons AND club renames: 703 = Tochigi Brex in 2016-17 = Utsunomiya Brex in 2025-26). The feed sends a string on v2 and an integer on v1; both are text here. Not a player id. |
| away_team_name_j | character | Away team name in Japanese (official name). |
| away_team_name_e | character | Away team name in English, uppercase. |
| away_team_short_name_j | character | Away team short name in Japanese (e.g. the short form of Alvark Tokyo). |
| away_team_short_name_e | character | Away team short name in English (e.g. A TOKYO). |
| away_team_sub_name_j | character | Away team sub name in Japanese (v1 header only); usually empty. |
| away_team_sub_name_e | character | Away team sub name in English (v1 header only); usually empty. |
| away_score | integer | Away team final score. |
| away_winning_count | integer | Away team winning streak (v1 header only); null in every observed body. |
| away_losing_count | integer | Away team losing streak (v1 header only); null in every observed body. |
| home_score_p1 | integer | Home team points scored IN period 1 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p2 | integer | Home team points scored IN period 2 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p3 | integer | Home team points scored IN period 3 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p4 | integer | Home team points scored IN period 4 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p5 | integer | Home team points scored IN period 5 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p6 | integer | Home team points scored IN period 6 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p7 | integer | Home team points scored IN period 7 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p8 | integer | Home team points scored IN period 8 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p9 | integer | Home team points scored IN period 9 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p10 | integer | Home team points scored IN period 10 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p11 | integer | Home team points scored IN period 11 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p12 | integer | Home team points scored IN period 12 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p13 | integer | Home team points scored IN period 13 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| home_score_p14 | integer | Home team points scored IN period 14 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p1 | integer | Away team points scored IN period 1 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p2 | integer | Away team points scored IN period 2 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p3 | integer | Away team points scored IN period 3 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p4 | integer | Away team points scored IN period 4 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p5 | integer | Away team points scored IN period 5 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p6 | integer | Away team points scored IN period 6 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p7 | integer | Away team points scored IN period 7 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p8 | integer | Away team points scored IN period 8 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p9 | integer | Away team points scored IN period 9 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p10 | integer | Away team points scored IN period 10 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p11 | integer | Away team points scored IN period 11 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p12 | integer | Away team points scored IN period 12 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p13 | integer | Away team points scored IN period 13 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |
| away_score_p14 | integer | Away team points scored IN period 14 (not cumulative). v2 headers carry four slots, v1 fourteen; an unplayed period is 0 on v1 and null on v2. |

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

Other B.LEAGUE Functions:
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
[`bleague_team_box()`](https://hoopR.sportsdataverse.org/reference/bleague_team_box.md),
[`bleague_team_summary()`](https://hoopR.sportsdataverse.org/reference/bleague_team_summary.md)

## Examples

``` r
# \donttest{
  try(bleague_game_info(schedule_key = 504734))
#> ── B.LEAGUE game info from b-league.s3.amazonaws.com ──────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 20:42:13 UTC
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
