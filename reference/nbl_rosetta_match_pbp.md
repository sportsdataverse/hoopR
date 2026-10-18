# **NBL Rosetta Match Play-by-Play**

One match's play-by-play with shot x/y, oldest first (NBL 2025-26
included, which ESPN's nbl feed lacks).

Endpoint:
`GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`

## Usage

``` r
nbl_rosetta_match_pbp(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble (one row per event, sorted on action_id):

|  |  |  |
|----|----|----|
| col_name | type | description |
| match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
| rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
| match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
| action_id | integer | Event sequence number within the match (ascending in feed time) |
| period | integer | Period number, an INTEGER here (1-4 = quarters) |
| period_type | character | Period type: regular (overtime unobserved) |
| clock | character | Game clock at the event, MM:SS remaining in the period; null on some feed-control events. |
| clock_seconds | numeric | Game clock at the event as seconds (parsed from clock, MM:SS); null for events without a clock. |
| shot_clock | character | Shot clock at the event, MM:SS; in Genius-era matches it repeats the game clock (no shot-clock data) |
| shot_clock_seconds | numeric | Shot clock at the event as seconds (parsed from shot_clock); in Genius-era backfills it repeats the game clock. |
| score_home | integer | Home team's running score after the event (score_1 in the body). |
| score_away | integer | Away team's running score after the event (score_2 in the body). |
| action_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, possession, possessionArrow, period, fixture, main (clock start/stop) |
| sub_type | character | Event detail (shot type, foul type, "1Of2" free throw, In/Out...); absent when the event has none. Two vocabularies: Title Case ("Jump Shot") in NBL/WNBL 2025-26 feeds (events carry fixtureId), camelCase ("jumpShot") in older backfills and NBL1. |
| sub_type_key | character | sub_type folded to snake_case, so the Title Case 2025-26 spelling and the camelCase backfill spelling match. |
| success | logical | Shot or free throw made (true) or missed (false). DataCore-era feeds (events with fixtureId) and NBL1 carry it only on shots and free throws (absent elsewhere); older backfills carry it on every event, true on non-shot events. |
| team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
| team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
| team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
| is_home | logical | True when the event's team is the match's home team; null when the event has no team. |
| player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
| player_name | character | Full name of the player the event belongs to; null for events no player owns (team rebounds, period starts). |
| jersey_number | character | Jersey number of the player at the event, as text (a WNBL backfill writes 6.0). |
| x | numeric | Shot or event position along the court length, percent 0-100, in game orientation (each team's shots sit at x \> 50 for two periods and x \< 50 for the others). Unverified: which end is x = 0; DataCore-era free-throw, foul and turnover coordinates are not at the free-throw line. Null where none was recorded. |
| y | numeric | Shot or event position across the court width, percent 0-100 (free throws and close shots cluster near 50). Unverified: which sideline is y = 0. Null where none was recorded. |
| readable_action_type | character | Human-readable event label, e.g. "Game - Game completed". |
| system_action_type | character | Machine event label, e.g. game_game_completed. |
| timestamp | character | Wall-clock time of the event, ISO 8601 without offset (UTC) |
| feed | character | Feed shape: datacore (NBL and WNBL 2025-26: events carry fixtureId, arrive newest first, Title Case sub_type, a real shot clock) or backfill (older seasons and NBL1 2025: no fixtureId, oldest first, camelCase sub_type, shot_clock repeating the game clock). |

Columns the body adds beyond these follow, in body order (sdv-py keeps
them too).

## Details

- Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL
  documents or supports). The terms of use were not reviewed; payloads
  are not redistributed as release assets.

- Gated by a referer, not a key: every request carries Origin / Referer
  set to nbl.com.au (the runtime sends them); without them the host
  answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.

- Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for
  the 2025-26 NBL season (the stats provider changed from Genius Sports
  to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full
  event log with shot x/y for 2025-26 and, in the same shape, back to
  2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.

- One host serves three organisations; pass org='nbl' (default), 'wnbl'
  or 'nbl1'. NBL1 is the second tier (men's and women's conferences,
  calendar-year seasons).

- Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year
  is the START year for the NBL and WNBL from 1998-99 and a calendar
  year for NBL1 and the 1979-1997 winter seasons; the runtime maps it.
  Year 1998 holds two seasons (calendar 1998 and 1998-99).

- Ids: `<entity>`*id columns are DataCore ids (UUID v1; join on them),
  rosetta*`<entity>`\_id Rosetta's own. match_id is the DataCore fixture
  id every match route is keyed on.

- Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`).
  Rosetta caches a body per path and serves it whatever the query
  string, so a page cut by someone else's limit is refused
  (`hoopR_asset_fetch`); retry after the cache entry expires.

Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown
match, team, player or season id, an org or season type with nothing, or
no season in progress); `hoopR_asset_fetch` for the 403 gate body, a
stub or error envelope, a page cut by Rosetta's path cache, a body for
another org, season or entity than the one asked for, or any other
failed fetch; `hoopR_bad_request` for an unknown `org` / `season_type`,
a malformed id, or HTTP 400 / 422.

## See also

Other NBL Rosetta:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_by_id()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_by_id.md),
[`nbl_rosetta_match_player_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_box.md),
[`nbl_rosetta_match_player_period_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_player_period_box.md),
[`nbl_rosetta_match_team_box()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_team_box.md),
[`nbl_rosetta_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_matches.md),
[`nbl_rosetta_next_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match.md),
[`nbl_rosetta_next_match_team()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_match_team.md),
[`nbl_rosetta_next_matches()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_next_matches.md),
[`nbl_rosetta_outcomes()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_outcomes.md),
[`nbl_rosetta_player_game_log()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_game_log.md),
[`nbl_rosetta_player_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_player_stats.md),
[`nbl_rosetta_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_players.md),
[`nbl_rosetta_seasons()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons.md),
[`nbl_rosetta_seasons_current()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_seasons_current.md),
[`nbl_rosetta_standings()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_standings.md),
[`nbl_rosetta_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_stats_leaders.md),
[`nbl_rosetta_team_players()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_players.md),
[`nbl_rosetta_team_stats()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats.md),
[`nbl_rosetta_team_stats_leaders()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_team_stats_leaders.md),
[`nbl_rosetta_teams()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_teams.md)

## Examples

``` r
# \donttest{
  try(nbl_rosetta_match_pbp(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#> ── NBL Rosetta match_pbp from prod.rosetta.nbl.com.au ────── hoopR 3.1.0.9000 ──
#> ℹ Data updated: 2026-10-18 17:42:17 UTC
#> # A tibble: 982 × 29
#>    match_id     rosetta_match_id match_status action_id period period_type clock
#>    <chr>        <chr>            <chr>            <int>  <int> <chr>       <chr>
#>  1 b217a699-4b… 08bccaee-57ee-4… complete             1      1 regular     NA   
#>  2 b217a699-4b… 08bccaee-57ee-4… complete             1      1 regular     NA   
#>  3 b217a699-4b… 08bccaee-57ee-4… complete             2      1 regular     10:00
#>  4 b217a699-4b… 08bccaee-57ee-4… complete             2      1 regular     NA   
#>  5 b217a699-4b… 08bccaee-57ee-4… complete             3      1 regular     10:00
#>  6 b217a699-4b… 08bccaee-57ee-4… complete             4      1 regular     09:59
#>  7 b217a699-4b… 08bccaee-57ee-4… complete             5      1 regular     10:00
#>  8 b217a699-4b… 08bccaee-57ee-4… complete             6      1 regular     09:59
#>  9 b217a699-4b… 08bccaee-57ee-4… complete             7      1 regular     10:00
#> 10 b217a699-4b… 08bccaee-57ee-4… complete             9      1 regular     09:38
#> # ℹ 972 more rows
#> # ℹ 22 more variables: clock_seconds <dbl>, shot_clock <chr>,
#> #   shot_clock_seconds <dbl>, score_home <int>, score_away <int>,
#> #   action_type <chr>, sub_type <chr>, sub_type_key <chr>, success <lgl>,
#> #   team_id <chr>, team_code <chr>, team_name <chr>, is_home <lgl>,
#> #   player_id <chr>, player_name <chr>, jersey_number <chr>, x <dbl>, y <dbl>,
#> #   readable_action_type <chr>, system_action_type <chr>, timestamp <chr>, …
# }
```
