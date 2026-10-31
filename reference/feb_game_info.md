# **FEB Game Info**

**Game header of one FEB game: competition, tip-off, venue, officials,
status, both teams and the score.**

Endpoint:
`GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
(every game route carries the header; this reads the lightest one).

## Usage

``` r
feb_game_info(game_id)
```

## Arguments

- game_id:

  (*integer* required): FEB game id, e.g. `2535725`; the `game_id`
  column of
  [`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
  [`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md)
  and
  [`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md).

## Value

A `hoopR_data` tibble with these columns:

|  |  |  |
|----|----|----|
| col_name | type | description |
| game_id | integer | FEB game id (one global sequence): the {gameId} of every LiveStats route and the p= of Partido.aspx. Game bodies do not print it, so it comes from the request. |
| comp_id | integer | Competition id (constant across seasons): 115 Primera FEB (LEB Oro), 118 Segunda FEB, 210 Liga Femenina Endesa, 214 LF Challenge, 218 LF-2, 111 Tercera FEB. Not the site's menu group. |
| competition | character | Competition name as printed that season, uppercase ('PRIMERA FEB'; 2020-21 'LIGA LEB ORO'). |
| group_label | character | The game's group (grupo) label, trimmed: 'Unico' = the single group, '"A"' = group A. It is the page's group label, not the site's menu group number. |
| period | integer | Current or last period number; 4 for a finished regulation game. |
| clock | character | 'FINAL' once the game is over, else the game clock 'mm:ss' remaining in the period. |
| start_time | POSIXct | Tip-off in Spanish local time (POSIXct, tz Europe/Madrid): the source carries no offset, so the zone is assumed. |
| venue | character | Venue (pabellon) name. |
| address | character | Venue street address, free text. |
| referee1 | character | Crew chief (arbitro principal), 'SURNAMES, NAME'. |
| referee2 | character | First umpire (arbitro auxiliar 1), 'SURNAMES, NAME'. |
| referee3 | character | Second umpire (arbitro auxiliar 2), 'SURNAMES, NAME'; null when the game had two referees. |
| status | integer | Game state code: 3 = finished (status_text FINISHED). Null on 2020-21 games. |
| status_text | character | Game state label in English ('FINISHED'). Null on 2020-21 games. |
| home_team_id | integer | Home team-season id (key space: FEB team registrations, new every season). |
| home_team | character | Home team name for the season (sponsor name, uppercase). |
| home_team_code | character | Home federation team code, 8 digits as a string. Null on 2020-21 games. |
| home_club_code | character | Home federation club code, 6 digits as a string. Null on 2020-21 games. |
| home_score | integer | Home points: the final score when clock is FINAL, else the live score. |
| away_team_id | integer | Away team-season id (key space: FEB team registrations, new every season). |
| away_team | character | Away team name for the season (sponsor name, uppercase). |
| away_team_code | character | Away federation team code, 8 digits as a string. Null on 2020-21 games. |
| away_club_code | character | Away federation club code, 6 digits as a string. Null on 2020-21 games. |
| away_score | integer | Away points: the final score when clock is FINAL, else the live score. |

## Details

The Spanish Basketball Federation (FEB) wrappers cover Primera FEB,
Segunda FEB and Liga Femenina Endesa (plus the federation's other groups
on the same routes). They mirror sportsdataverse-py's
`sportsdataverse.basketball.feb` wrappers of the same names: same
arguments, the same snake_case columns and types, one row per
sportsdataverse-py row.

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

## See also

Other FEB Functions:
[`feb_leaders()`](https://hoopR.sportsdataverse.org/reference/feb_leaders.md),
[`feb_overview()`](https://hoopR.sportsdataverse.org/reference/feb_overview.md),
[`feb_pbp()`](https://hoopR.sportsdataverse.org/reference/feb_pbp.md),
[`feb_period_scores()`](https://hoopR.sportsdataverse.org/reference/feb_period_scores.md),
[`feb_player_box()`](https://hoopR.sportsdataverse.org/reference/feb_player_box.md),
[`feb_results()`](https://hoopR.sportsdataverse.org/reference/feb_results.md),
[`feb_schedule()`](https://hoopR.sportsdataverse.org/reference/feb_schedule.md),
[`feb_shots()`](https://hoopR.sportsdataverse.org/reference/feb_shots.md),
[`feb_standings()`](https://hoopR.sportsdataverse.org/reference/feb_standings.md),
[`feb_team_stats()`](https://hoopR.sportsdataverse.org/reference/feb_team_stats.md)

## Examples

``` r
# \donttest{
  try(feb_game_info(game_id = 2535725))
#> ── FEB game info from intrafeb.feb.es ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-31 21:29:51 UTC
#> # A tibble: 1 × 24
#>   game_id comp_id competition group_label period clock start_time          venue
#>     <int>   <int> <chr>       <chr>        <int> <chr> <dttm>              <chr>
#> 1 2535725     115 PRIMERA FEB Único            4 FINAL 2026-09-26 19:00:00 PABE…
#> # ℹ 16 more variables: address <chr>, referee1 <chr>, referee2 <chr>,
#> #   referee3 <chr>, status <int>, status_text <chr>, home_team_id <int>,
#> #   home_team <chr>, home_team_code <chr>, home_club_code <chr>,
#> #   home_score <int>, away_team_id <int>, away_team <chr>,
#> #   away_team_code <chr>, away_club_code <chr>, away_score <int>
# }
```
