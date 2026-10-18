# **FEB Overview**

**Today's (or the latest) games of every live FEB competition, with
scores and status.**

Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/overview`

One row per game across the competitions with games in the window. An
off day with no competitions raises `hoopR_no_data`; a game listed under
another competition is refused (`hoopR_asset_fetch`).

## Usage

``` r
feb_overview()
```

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| comp_id | integer | Competition id (constant across seasons): 115 Primera FEB (LEB Oro), 118 Segunda FEB, 210 Liga Femenina Endesa, 214 LF Challenge, 218 LF-2, 111 Tercera FEB. Not the site's menu group. |
| comp_code | integer | Season-specific competition edition code (e.g. 23473 = Primera FEB 2026-27). |
| competition | character | Competition name as printed that season, uppercase ('PRIMERA FEB'; 2020-21 'LIGA LEB ORO'). |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route. |
| round_id | integer | Round id; 0 in every sample (the route does not fill it). |
| stage | character | Stage code as a string; '0' in every sample (meaning unverified). |
| venue | character | Name of the venue (pabellon) where the game is played. |
| start_time | POSIXct | Tip-off in Spanish local time (POSIXct, tz Europe/Madrid; the source has no offset). |
| start_time_utc | POSIXct | Tip-off in UTC (POSIXct, tz UTC). |
| period | integer | Current or last period (4 when finished). |
| clock | character | 'FINAL' once finished, else the game clock ('00:00' before tip-off). |
| status | integer | Game state code: 3 = finished, 1 = scheduled (seen 2026-10-12); the live codes are unverified. |
| home_team_id | integer | Home team-season id (new every season; joins the schedule pages). |
| home_team | character | Home team name for the season. |
| home_team_code | character | Home federation team code, 8 digits as a string. |
| home_club_code | character | Home federation club code, 6 digits as a string. |
| home_abbreviation | character | Home team three-letter abbreviation ('PAL'). |
| home_score | integer | Home points (0 before tip-off). |
| away_team_id | integer | Away team-season id (new every season; joins the schedule pages). |
| away_team | character | Away team name for the season. |
| away_team_code | character | Away federation team code, 8 digits as a string. |
| away_club_code | character | Away federation club code, 6 digits as a string. |
| away_abbreviation | character | Away team three-letter abbreviation. |
| away_score | integer | Away points (0 before tip-off). |
| period_scores | character | Points per period as 'home-away' pairs joined by ';' ('16-16;19-16;10-21;14-14'); null before tip-off. |

## Details

The Spanish Basketball Federation (FEB) wrappers cover Primera FEB,
Segunda FEB and Liga Femenina Endesa (plus the federation's other groups
on the same routes). They mirror sdv-py's
`sportsdataverse.basketball.feb` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per sdv-py
row.

**Legal notice.** The FEB's aviso legal (legal notice) asserts
intellectual-property rights over the site's content and its databases
(the EU database right). It has no explicit scraping clause, and
robots.txt answers 404 on both hosts. Fetching for your own use on your
own machine is how these wrappers are meant to be used; check the notice
before you republish the data.

**Unofficial and unsupported.** The LiveStats API (`intrafeb.feb.es`) is
the federation's own widget backend, not a documented public API. It
needs a bearer token, which is public: it is read from the home page of
`baloncestoenvivo.feb.es` at run time, kept in memory for the R session
(24 h validity, renewed once on an HTTP 401) and never printed, logged
or written. Requests are spaced at least one second apart per host; 429
and 5xx answers are retried (three attempts).

**Coverage.** The game routes answer from 2020-21 (Liga Femenina Endesa
from its first game; Primera FEB from 2021-03-12, so its earlier 2020-21
games and every earlier season answer 404). 2020-21 play-by-play is text
only. The schedule pages go back to 1996-97 (`season = 1997`).

**Seasons** are END years (`season = 2027` is 2026-27); the site's own
`t` key is the START year, so the request sends `t = season - 1`.

**Errors** are classed conditions, never a warning plus an empty frame:
`hoopR_no_data` (HTTP 404, an unknown group, a schedule page with no
games, an empty overview window), `hoopR_bad_request` (HTTP 400 / 422,
or a `game_id`, `group` or `season` that is not a non-negative integer)
and `hoopR_asset_fetch` (any other failure: another status, a transport
error, a token the API still rejects after one renewal, a non-JSON or
non-HTML body, an error or changed envelope, a play-by-play of another
game, a page for another group or season, or layout drift). All inherit
`hoopR_error`.

     feb_overview()

## See also

Other FEB:
[`feb_game_info()`](https://hoopR.sportsdataverse.org/reference/feb_game_info.md),
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)
