# **Genius Game**

One row per finished game: period and clock state, both teams' names,
codes and scores, officials.

Endpoint:
`GET https://fibalivestats.dcd.shared.geniussports.com/data/{match_id}/data.json`

`team1` is the team listed first. `referee1` ... `commissioner` read
`officials.<role>` (current feeds) or the flat `officials_refereeN`
strings (older feeds); NA when absent.

## Usage

``` r
genius_game(match_id, return_parsed = TRUE)
```

## Arguments

- match_id:

  Genius match id (`match_id` of
  [`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
  [`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md)
  or
  [`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md)),
  e.g. 2902690.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the sdv-internal-refs capture shape of a page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | integer | Genius match id of the game. data.json does not carry it: it is the match_id asked for, stamped by the runtime (the global match sequence shared by every Genius customer). |
| period | integer | Current (or last) period number; restarts at 1 in overtime |
| period_type | character | Current period type: REGULAR or OVERTIME |
| in_ot | integer | 1 when the game is (or ended) in overtime, else 0 |
| clock | character | Clock of the current period at capture time, 'mm:ss' remaining ('00:00' once the game is over) |
| periods_max | integer | Number of regulation periods (4) |
| period_length_regular | integer | Length of a regulation period, minutes (10 under FIBA rules, 12 in some leagues) |
| period_length_overtime | integer | Length of an overtime period, minutes |
| attendance | integer | Attendance as entered by the org; 0 when not entered |
| disable_match | integer | 1 when the org disabled the public feed for this game, else 0 |
| total_time_added | integer | Clock time added by corrections, seconds (unverified; 0 in every sample) |
| team1_name | character | Full name of team 1, the team listed first (the home team on the hosted schedule and widget). |
| team1_code | character | Short code of team 1, in the competition's own script when the org enters one. |
| team1_score | integer | Final points of team 1 (cast to an integer; the 2014-15 feed sends a string). |
| team2_name | character | Full name of team 2, the team listed second. |
| team2_code | character | Short code of team 2, in the competition's own script when the org enters one. |
| team2_score | integer | Final points of team 2 (cast to an integer; the 2014-15 feed sends a string). |
| referee1 | character | First referee's name, from officials.referee1 (international form) or the flat officials_referee1 text. |
| referee2 | character | Second referee's name, from officials.referee2 (international form) or the flat officials_referee2 text. |
| referee3 | character | Third referee's name when the feed lists one; null otherwise. |
| commissioner | character | Commissioner (game supervisor) name when the feed lists one; null otherwise. |

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source: payloads are not redistributed as release assets.

**Org and season.** Every competition is an ORG code plus a competition
id (`comp_id`):
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)
lists an org's competitions with the sdv END-year `season` (a START-year
org lists 2025-26 as season 2026),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md)
maps a game to its competition, and `data.json` itself names no date,
competition or season. The hosted ORG can differ from the LiveStats ORG
of `/u/` (NZNBL vs NZN). Match ids are one global sequence across every
Genius customer. `data.json` carries no global team or player id: `tno`
(1 or 2) and `pno` are in-game numbers; only finished games are read.

**Errors** (classed conditions, all inheriting `hoopR_error`):
`hoopR_no_data` when Genius has nothing for the request (HTTP 404, the
S3 `AccessDenied` 403, an empty 200 from the hosted host, an empty
recent-games window, a schedule or widget with no matches);
`hoopR_bad_request` for HTTP 400 / 422 or a URL that is not a Genius
route (e.g. a non-numeric id); `hoopR_asset_fetch` when the answer is
unknown: the CloudFront "Request blocked" 403, a rate limit or 5xx, the
intermittent HTTP 500 "A website error has occurred" page
(`transient = TRUE`: retry later), a dead connection, an error envelope,
a cut-off page, an unfinished game, or a body for another match,
competition or ORG.

## See also

Other Genius Functions:
[`bal_competition`](https://hoopR.sportsdataverse.org/reference/bal_competition.md),
[`esake_competition`](https://hoopR.sportsdataverse.org/reference/esake_competition.md),
[`genius_competition_games()`](https://hoopR.sportsdataverse.org/reference/genius_competition_games.md),
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_game_crosswalk.md),
[`genius_match_competition()`](https://hoopR.sportsdataverse.org/reference/genius_match_competition.md),
[`genius_pbp()`](https://hoopR.sportsdataverse.org/reference/genius_pbp.md),
[`genius_player_box()`](https://hoopR.sportsdataverse.org/reference/genius_player_box.md),
[`genius_schedule()`](https://hoopR.sportsdataverse.org/reference/genius_schedule.md),
[`genius_schedule_embed()`](https://hoopR.sportsdataverse.org/reference/genius_schedule_embed.md),
[`genius_shots()`](https://hoopR.sportsdataverse.org/reference/genius_shots.md),
[`genius_team_box()`](https://hoopR.sportsdataverse.org/reference/genius_team_box.md),
[`genius_team_crosswalk()`](https://hoopR.sportsdataverse.org/reference/genius_team_crosswalk.md),
[`genius_widget_games()`](https://hoopR.sportsdataverse.org/reference/genius_widget_games.md),
[`lnbm_competition`](https://hoopR.sportsdataverse.org/reference/lnbm_competition.md),
[`lub_competition`](https://hoopR.sportsdataverse.org/reference/lub_competition.md),
[`nznbl_competition`](https://hoopR.sportsdataverse.org/reference/nznbl_competition.md),
[`slb_competition`](https://hoopR.sportsdataverse.org/reference/slb_competition.md)

## Examples

``` r
# \donttest{
  try(genius_game(match_id = 2902690))
#> ── Genius LiveStats game ──────────────────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-10-22 02:38:16 UTC
#> # A tibble: 1 × 21
#>   match_id period period_type in_ot clock periods_max period_length_regular
#>      <int>  <int> <chr>       <int> <chr>       <int>                 <int>
#> 1  2902690      1 OVERTIME        1 00:00           4                    10
#> # ℹ 14 more variables: period_length_overtime <int>, attendance <int>,
#> #   disable_match <int>, total_time_added <int>, team1_name <chr>,
#> #   team1_code <chr>, team1_score <int>, team2_name <chr>, team2_code <chr>,
#> #   team2_score <int>, referee1 <chr>, referee2 <chr>, referee3 <chr>,
#> #   commissioner <chr>
# }
```
