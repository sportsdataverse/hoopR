# **Genius Competition Games**

The recent-games window of a competition, with the global Genius team
ids.

Endpoint:
`GET https://fibalivestats.dcd.shared.geniussports.com/data/competition/{comp_id}.json`

A few recent or upcoming games, not the season. Scores are cast to
integer (NA before tip-off). `match_time` is local (zone not stated),
`match_time_utc` UTC.

## Usage

``` r
genius_competition_games(comp_id, return_parsed = TRUE)
```

## Arguments

- comp_id:

  Genius competition id: one per org competition-season (`comp_id` of
  [`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md)),
  e.g. 49915.

- return_parsed:

  Parse into a tibble (default `TRUE`); `FALSE` returns the parsed body
  or page record (a list): `data.json` as served plus `_request` (the
  ids asked for), or the record parsed from an HTML page.

## Value

A `hoopR_data` tibble (a zero-row tibble with these columns when Genius
answers an empty valid page), or the raw list when
`return_parsed = FALSE`:

|  |  |  |
|----|----|----|
| col_name | type | description |
| league_id | integer | Genius league id of the org (ESAKE = 115); the leagueId column of the hosted chooser |
| competition_id | integer | Genius competition id (compId): one per org competition-season; the {compId} of hosted and data/competition paths |
| match_id | integer | Genius match id: the {matchId} of data.json and /u/; one global sequence across every Genius customer (~0.3 M in 2016, ~2.9 M in Oct 2026) |
| match_status | character | Match status: COMPLETE, SCHEDULED, IN_PROGRESS, ... (upper case) |
| match_time | character | Local tip-off time, 'YYYY-MM-DD HH:MM:SS' (venue time zone, not stated) |
| match_time_utc | character | Tip-off time in UTC, 'YYYY-MM-DD HH:MM:SS' |
| live | integer | 1 while the game is live, else 0 |
| period | integer | Current period of a live or finished game (present on some rows only) |
| period_type | character | Current period type: REGULAR or OVERTIME (present on some rows only) |
| clock | character | Period clock of a live or finished game, 'mm:ss' remaining (present on some rows only) |
| home_team_id | integer | Home team: Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| home_name | character | Home team full name, in the competition's own script when the org enters one. |
| home_name_international | character | Home team name in Latin script |
| home_code | character | Home team short code, in the competition's own script when the org enters one. |
| home_score | integer | Home points: a string on most rows, an integer on some (” before tip-off); cast it |
| away_team_id | integer | Away team: Genius team id (warehouse key space, global across orgs and seasons; the /team/{id} of hosted pages, the tid of the widget, the teamId of data/competition). data.json carries no team id: join on name/code |
| away_name | character | Away team full name, in the competition's own script when the org enters one. |
| away_name_international | character | Away team name in Latin script |
| away_code | character | Away team short code, in the competition's own script when the org enters one. |
| away_score | integer | Away points: a string on most rows, an integer on some (” before tip-off); cast it |

## Details

**Access.** The Genius hosts publish no robots.txt and no terms.
CloudFront refuses datacenter IPs on the LiveStats and hosted hosts:
from a server set `options(hoopR.proxy = ...)` or the `GENIUS_PROXY`
environment variable to an http(s) proxy URL (never printed or logged).
Requests are spaced at least one second apart per host; keep crawls slow
and incremental. Some league sites (the NZ NBL) forbid AI crawlers in
their own robots.txt, which does not cover these hosts. Unofficial use
of a public source.

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
[`genius_competitions()`](https://hoopR.sportsdataverse.org/reference/genius_competitions.md),
[`genius_game()`](https://hoopR.sportsdataverse.org/reference/genius_game.md),
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
  try(genius_competition_games(comp_id = 49915))
#> ── Genius LiveStats competition games ─────────────────────────── hoopR 3.2.0 ──
#> ℹ Data updated: 2026-11-01 23:41:24 UTC
#> # A tibble: 2 × 20
#>   league_id competition_id match_id match_status match_time match_time_utc  live
#>       <int>          <int>    <int> <chr>        <chr>      <chr>          <int>
#> 1       115          49915  2902722 COMPLETE     2026-11-0… 2026-11-01 11…     0
#> 2       115          49915  2902723 COMPLETE     2026-11-0… 2026-11-01 15…     0
#> # ℹ 13 more variables: period <int>, period_type <chr>, clock <chr>,
#> #   home_team_id <int>, home_name <chr>, home_name_international <chr>,
#> #   home_code <chr>, home_score <int>, away_team_id <int>, away_name <chr>,
#> #   away_name_international <chr>, away_code <chr>, away_score <int>
# }
```
