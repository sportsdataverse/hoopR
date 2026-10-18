# **NBL Rosetta Match by Id**

One match's header (the same body as nbl_rosetta_match): status, scores,
venue, season and teams.

Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}`

## Usage

``` r
nbl_rosetta_match_by_id(match_id)
```

## Arguments

- match_id:

  (*character* required): DataCore fixture id of the match (match_id of
  nbl_rosetta_matches), a UUID, e.g.
  b217a699-4bef-11f0-bc08-933162362355.

## Value

A `hoopR_data` tibble (one row):

|  |  |  |
|----|----|----|
| col_name | type | description |
| org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
| match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
| match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
| start_time_datetime | character | Tip-off, UTC; same value as start_time. |
| match_type | character | Match type: regular, final (FINAL upper case seen) |
| attendance | integer | Attendance, a STRING; null when not recorded. |
| clock | character | Game clock of the latest event, HH:MM:SS remaining in the period. |
| current_period | integer | Latest period number as a STRING; null on older matches. |
| clock_running | logical | Game clock is running. |
| home_score | integer | Home final score, a STRING; null before tip-off. |
| away_score | integer | Away final score, a STRING; null before tip-off. |
| round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
| start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
| status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
| external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
| match_slug | character | URL slug of the match page on nbl.com.au. |
| match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
| secondary_external_id | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| live_exclusive | logical | Match is a live-stream exclusive. |
| season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
| rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
| season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
| season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
| season_competition_id | character | Rosetta competition id (UUID v4) |
| season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
| season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
| season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
| season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
| venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
| rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
| venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
| venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
| venue_code | character | Venue code; often null. |
| venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_latitude | numeric | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_longitude | numeric | Unobserved in samples (null in every capture); type and meaning unverified. |
| venue_country | character | Country; often null. |
| home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
| home_team_name | character | Display name of the team. |
| home_team_external_team_name | character | Team name as DataCore spells it. |
| home_team_code | character | Team code of the home team, e.g. PER or SYD. |
| away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
| away_team_name | character | Display name of the team. |
| away_team_external_team_name | character | Team name as DataCore spells it. |
| away_team_code | character | Team code of the away team, e.g. PER or SYD. |
| data_source | character | Backend that built the body: nexus-api or lambda-cache (observed). It varies between requests for the same match (the NBL 2025-26 sample game came back lambda-cache from /live/all and nexus-api from /match/`{match_id}` minutes apart, with identical play-by-play), so it says nothing about the data. |
| match_status_string | character | Status banner text, e.g. FINAL. |
| play_by_play_updated_datetime | character | Last play-by-play update, ISO 8601 UTC. |
| season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |

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

     nbl_rosetta_match_by_id(match_id = "b217a699-4bef-11f0-bc08-933162362355")

## See also

Other NBL Rosetta:
[`nbl_rosetta_match()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match.md),
[`nbl_rosetta_match_pbp()`](https://hoopR.sportsdataverse.org/reference/nbl_rosetta_match_pbp.md),
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
