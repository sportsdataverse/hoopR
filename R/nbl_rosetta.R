# nbl_rosetta.R -- NBL / WNBL / NBL1 (Australia) wrappers over Rosetta, the JSON proxy behind
# nbl.com.au. Port of sdv-py sportsdataverse/basketball/nbl_au/nbl_rosetta.py (same names, arguments
# and defaults; sdv-py's return_parsed / return_as_pandas / **kwargs have no R counterpart). The
# transport, refusals and parsers live in nbl_rosetta_utils.R. In wehoop only the `org` default changes.

# The @details of every nbl_rosetta topic that shares the nbl_rosetta_seasons() notes (roxygen @eval .intl_details()).
.nbl_rosetta_seasons_details <- c(
  "* Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL documents or supports). The terms of use were not reviewed; payloads are not redistributed as release assets.",
  "* Gated by a referer, not a key: every request carries Origin / Referer set to nbl.com.au (the runtime sends them); without them the host answers 403 MISSING_API_KEY, which is raised as `hoopR_asset_fetch`.",
  "* Fills a hole in ESPN: ESPN's nbl feed has box scores but no plays for the 2025-26 NBL season (the stats provider changed from Genius Sports to Sportradar DataCore that year). nbl_rosetta_match_pbp has the full event log with shot x/y for 2025-26 and, in the same shape, back to 2011-12 (WNBL about 2014-15). Matches from 1979 have box scores only.",
  "* One host serves three organisations; pass org='nbl' (default), 'wnbl' or 'nbl1'. NBL1 is the second tier (men's and women's conferences, calendar-year seasons).",
  "* Season = the END year (2026 = 2025-26) everywhere. Rosetta's own year is the START year for the NBL and WNBL from 1998-99 and a calendar year for NBL1 and the 1979-1997 winter seasons; the runtime maps it. Year 1998 holds two seasons (calendar 1998 and 1998-99).",
  "* Ids: `<entity>`_id columns are DataCore ids (UUID v1; join on them), rosetta_`<entity>`_id Rosetta's own. match_id is the DataCore fixture id every match route is keyed on.",
  "* Unknown ids, orgs and types answer 200 with no rows (`hoopR_no_data`). Rosetta caches a body per path and serves it whatever the query string, so a page cut by someone else's limit is refused (`hoopR_asset_fetch`); retry after the cache entry expires.",
  "",
  "Errors: `hoopR_no_data` when Rosetta answers 404 or no rows (an unknown match, team, player or",
  "season id, an org or season type with nothing, or no season in progress); `hoopR_asset_fetch`",
  "for the 403 gate body, a stub or error envelope, a page cut by Rosetta's path cache, a body for",
  "another org, season or entity than the one asked for, or any other failed fetch;",
  "`hoopR_bad_request` for an unknown `org` / `season_type`, a malformed id, or HTTP 400 / 422."
)

#' @title
#' **NBL Rosetta Seasons**
#' @description
#' Every season of an organisation: regular, preseason, in-season cups and test seasons, with dates.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/seasons`
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @return A `hoopR_data` tibble (one row per season):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | season_id | character | DataCore season id (UUID v1); accepted as `{season_id}`. |
#'   | rosetta_season_id | character | Rosetta season id (UUID v4; v5 on NBL1); the `{season_id}` route key. |
#'   | name | character | Season name as Rosetta spells it (NBL26, WNBL 2024/25, 2025 South Men); names drift, key on season_year. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | start_date | character | First day of the season, ISO date-time without offset. |
#'   | end_date | character | Last day of the season, ISO date-time without offset; null on older seasons. |
#'   | competition_league_name | character | Name of the league the season's competition belongs to (NBL, WNBL or NBL1). |
#'   | competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_seasons(org = "nbl"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_seasons <- function(org = "nbl", limit = NULL) {
  .nbl_rosetta_call(
    "seasons", "seasons", "/{org}/seasons",
    path_args = list(org = org),
    query = list(limit = limit)
  )
}

#' @title
#' **NBL Rosetta Seasons Current**
#' @description
#' The season in progress (empty between seasons: `hoopR_no_data`).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/seasons/current`
#' @inherit nbl_rosetta_seasons details
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row: the season in progress):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | season_id | character | DataCore season id (UUID v1); accepted as `{season_id}`. |
#'   | rosetta_season_id | character | Rosetta season id (UUID v4; v5 on NBL1); the `{season_id}` route key. |
#'   | name | character | Season name as Rosetta spells it (NBL26, WNBL 2024/25); names drift, key on season_year. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | start_date | character | First day of the season, ISO date-time without offset. |
#'   | end_date | character | Last day of the season, ISO date-time without offset; null on older seasons. |
#'   | competition_name | character | Name of the competition the season belongs to (e.g. NBL). |
#'   | competition_age_group | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | next_match_start_datetime | character | Tip-off of the season's next match, UTC; null when none. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_seasons_current(org = "nbl"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_seasons_current <- function(org = "nbl") {
  .nbl_rosetta_call(
    "seasons_current", "seasons_current", "/{org}/seasons/current",
    path_args = list(org = org),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Matches**
#' @description
#' Matches of a season: ids, teams, venue, status, scores and start time (UTC).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/matches/in/season/{season}/{season_type}`
#' @inherit nbl_rosetta_seasons details
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param season_type (*character* default `"all"`): Season type: all (every type of the year), regular (includes finals), preseason, in_season (cups, Blitz, NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`, `"preseason"`, `"in_season"`, `"test"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @param offset (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer one large limit.
#' @return A `hoopR_data` tibble (one row per match):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
#'   | external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
#'   | date_updated | character | Record last-edit time, ISO 8601 UTC. |
#'   | start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
#'   | start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
#'   | match_type | character | Match type: regular, final (FINAL upper case seen) |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
#'   | home_score | integer | Home final score, a STRING; null before tip-off. |
#'   | away_score | integer | Away final score, a STRING; null before tip-off. |
#'   | attendance | integer | Attendance, a STRING; null when not recorded. |
#'   | match_slug | character | URL slug of the match page on nbl.com.au. |
#'   | match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
#'   | venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
#'   | rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Country; often null. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_code | character | Venue code; often null. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
#'   | rosetta_home_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the home team; routes that take this entity accept it as well as the DataCore id. |
#'   | home_team_name | character | Display name of the team. |
#'   | home_team_external_team_name | character | Team name as DataCore spells it. |
#'   | home_team_code | character | Team code of the home team, e.g. PER or SYD. |
#'   | home_team_division_abbreviation | character | Division code, e.g. EM (East Men) |
#'   | home_team_division_name | character | Division name (NBL1 conference + gender) |
#'   | home_team_conference_name | character | Name of the NBL1 conference of the home team; null outside NBL1. |
#'   | away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
#'   | rosetta_away_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the away team; routes that take this entity accept it as well as the DataCore id. |
#'   | away_team_name | character | Display name of the team. |
#'   | away_team_external_team_name | character | Team name as DataCore spells it. |
#'   | away_team_code | character | Team code of the away team, e.g. PER or SYD. |
#'   | away_team_division_abbreviation | character | Division code, e.g. EM (East Men) |
#'   | away_team_division_name | character | Division name (NBL1 conference + gender) |
#'   | away_team_conference_name | character | Name of the NBL1 conference of the away team; null outside NBL1. |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_name | character | Season name (NBL26, WNBL 2024/25, 2025 South Men) |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_id | character | Rosetta competition id (UUID v4) |
#'   | season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
#'   | season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'   | home_team_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | home_team_conference | character | Conference of the division. |
#'   | away_team_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | away_team_conference | character | Conference of the division. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_matches(org = "nbl", season = 2026, season_type = "regular"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_matches <- function(season, org = "nbl", season_type = "all", limit = NULL, offset = NULL) {
  .nbl_rosetta_call(
    "matches", "matches", "/{org}/matches/in/season/{season}/{season_type}",
    path_args = list(season = season, org = org, season_type = season_type),
    query = list(limit = limit, offset = offset)
  )
}

#' @title
#' **NBL Rosetta Teams**
#' @description
#' Every team record of an organisation: current, defunct, exhibition and development sides.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/teams`
#' @inherit nbl_rosetta_seasons details
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @return A `hoopR_data` tibble (one row per team record):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | team_id | character | DataCore team id (UUID v1); stable across seasons. |
#'   | rosetta_team_id | character | Rosetta team id (UUID v4; v5 on NBL1); stable across seasons; accepted as `{team_id}`. |
#'   | name | character | Team name as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | established | character | Year the club was founded; often null. |
#'   | head_coach | character | Head coach; often null. |
#'   | championships | character | Championships won; often null. |
#'   | website | character | Club website URL. |
#'   | external_media_competitor_id | character | Team id on the media/OTT service; often null. |
#'   | conference | character | NBL1 conference of the team (name); null for NBL and WNBL teams. |
#'   | division | character | NBL1 division of the team (name); null for NBL and WNBL teams. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | conference_name | character | Name of the NBL1 conference the team plays in (e.g. North, South); null outside NBL1. |
#'   | division_name | character | Division name (NBL1 conference + gender) |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_teams(org = "nbl"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_teams <- function(org = "nbl", limit = NULL) {
  .nbl_rosetta_call(
    "teams", "teams", "/{org}/teams",
    path_args = list(org = org),
    query = list(limit = limit)
  )
}

#' @title
#' **NBL Rosetta Match by Id**
#' @description
#' One match's header (the same body as nbl_rosetta_match): status, scores, venue, season and teams.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_match_by_id(match_id = "b217a699-4bef-11f0-bc08-933162362355")')
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | match_type | character | Match type: regular, final (FINAL upper case seen) |
#'   | attendance | integer | Attendance, a STRING; null when not recorded. |
#'   | clock | character | Game clock of the latest event, HH:MM:SS remaining in the period. |
#'   | current_period | integer | Latest period number as a STRING; null on older matches. |
#'   | clock_running | logical | Game clock is running. |
#'   | home_score | integer | Home final score, a STRING; null before tip-off. |
#'   | away_score | integer | Away final score, a STRING; null before tip-off. |
#'   | round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
#'   | start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
#'   | status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
#'   | external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
#'   | match_slug | character | URL slug of the match page on nbl.com.au. |
#'   | match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
#'   | secondary_external_id | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | live_exclusive | logical | Match is a live-stream exclusive. |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_id | character | Rosetta competition id (UUID v4) |
#'   | season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
#'   | season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
#'   | rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_code | character | Venue code; often null. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Country; often null. |
#'   | home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
#'   | home_team_name | character | Display name of the team. |
#'   | home_team_external_team_name | character | Team name as DataCore spells it. |
#'   | home_team_code | character | Team code of the home team, e.g. PER or SYD. |
#'   | away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
#'   | away_team_name | character | Display name of the team. |
#'   | away_team_external_team_name | character | Team name as DataCore spells it. |
#'   | away_team_code | character | Team code of the away team, e.g. PER or SYD. |
#'   | data_source | character | Backend that built the body: nexus-api or lambda-cache (observed). It varies between requests for the same match (the NBL 2025-26 sample game came back lambda-cache from /live/all and nexus-api from /match/`{match_id}` minutes apart, with identical play-by-play), so it says nothing about the data. |
#'   | match_status_string | character | Status banner text, e.g. FINAL. |
#'   | play_by_play_updated_datetime | character | Last play-by-play update, ISO 8601 UTC. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match_by_id <- function(match_id) {
  .nbl_rosetta_call(
    "match_by_id", "match", "/match/{match_id}",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Match**
#' @description
#' One match's header: status, scores, clock, venue, season and teams. Box score and play-by-play: the `match_*` frames.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`
#' @inherit nbl_rosetta_seasons details
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | match_type | character | Match type: regular, final (FINAL upper case seen) |
#'   | attendance | integer | Attendance, a STRING; null when not recorded. |
#'   | clock | character | Game clock of the latest event, HH:MM:SS remaining in the period. |
#'   | current_period | integer | Latest period number as a STRING; null on older matches. |
#'   | clock_running | logical | Game clock is running. |
#'   | home_score | integer | Home final score, a STRING; null before tip-off. |
#'   | away_score | integer | Away final score, a STRING; null before tip-off. |
#'   | round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
#'   | start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
#'   | status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
#'   | external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
#'   | match_slug | character | URL slug of the match page on nbl.com.au. |
#'   | match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
#'   | secondary_external_id | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | live_exclusive | logical | Match is a live-stream exclusive. |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_id | character | Rosetta competition id (UUID v4) |
#'   | season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
#'   | season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
#'   | rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_code | character | Venue code; often null. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Country; often null. |
#'   | home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
#'   | home_team_name | character | Display name of the team. |
#'   | home_team_external_team_name | character | Team name as DataCore spells it. |
#'   | home_team_code | character | Team code of the home team, e.g. PER or SYD. |
#'   | away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
#'   | away_team_name | character | Display name of the team. |
#'   | away_team_external_team_name | character | Team name as DataCore spells it. |
#'   | away_team_code | character | Team code of the away team, e.g. PER or SYD. |
#'   | data_source | character | Backend that built the body: nexus-api or lambda-cache (observed). It varies between requests for the same match (the NBL 2025-26 sample game came back lambda-cache from /live/all and nexus-api from /match/`{match_id}` minutes apart, with identical play-by-play), so it says nothing about the data. |
#'   | match_status_string | character | Status banner text, e.g. FINAL. |
#'   | play_by_play_updated_datetime | character | Last play-by-play update, ISO 8601 UTC. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match <- function(match_id) {
  .nbl_rosetta_call(
    "match", "match", "/match/{match_id}/live/all",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Match Player Box Score**
#' @description
#' One match's official player box score, one row per player line (period 0 = whole game).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`
#' @inherit nbl_rosetta_seasons details
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row per player line):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | stat_line_id | character | Provider record hash of this statistics row (64 hex characters) |
#'   | rosetta_stat_line_id | character | Rosetta id of this statistics row (UUID v4) |
#'   | assists | integer | Assists in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | blocks | integer | Blocks in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | defensive_rebounds | integer | Defensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | jersey_number | character | Jersey number, a STRING. |
#'   | minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
#'   | minutes_string | character | Minutes played as an ISO 8601 duration (PT30M32S); null on NBL1. |
#'   | offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | participated | logical | Player took part in the game. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | period_type | character | Period type: regular (overtime unobserved) |
#'   | personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | plus_minus | integer | Point differential while on court in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | starter | logical | Player started the game. |
#'   | steals | integer | Steals in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | technical_fouls | integer | Technical fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_attempted | integer | Three-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_made | integer | Three-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers | integer | Turnovers in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_attempted | integer | Two-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_made | integer | Two-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_full_name | character | Given and family name. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | sc | integer | NBL SuperCoach fantasy score for the game. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_player_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match_player_box <- function(match_id) {
  .nbl_rosetta_call(
    "match_player_box", "match", "/match/{match_id}/live/all",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Match Team Box Score**
#' @description
#' One match's team box score by period, one row per team and period (0 = whole game).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`
#' @inherit nbl_rosetta_seasons details
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row per team and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | stat_line_id | character | Provider record hash of this statistics row (64 hex characters) |
#'   | rosetta_stat_line_id | character | Rosetta id of this statistics row (UUID v4) |
#'   | assists | integer | Assists in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | blocks | integer | Blocks in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | defensive_rebounds | integer | Defensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
#'   | offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | period_type | character | Period type: regular (overtime unobserved) |
#'   | personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | steals | integer | Steals in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | technical_fouls | integer | Technical fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_attempted | integer | Three-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_made | integer | Three-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers | integer | Turnovers in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_attempted | integer | Two-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_made | integer | Two-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | timeouts | integer | Timeouts taken in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_team_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match_team_box <- function(match_id) {
  .nbl_rosetta_call(
    "match_team_box", "match", "/match/{match_id}/live/all",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Match Player Box Score by Period**
#' @description
#' One match's player box score by period (Rosetta-computed from the event log), one row per player and period.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_match_player_period_box(match_id = "b217a699-4bef-11f0-bc08-933162362355")')
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row per player and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | period_type | character | Period type: regular (overtime unobserved) |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | assists | integer | Assists in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | blocks | integer | Blocks in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | defensive_rebounds | integer | Defensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_attempted | integer | Field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_made | integer | Field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls | integer | Fouls committed (personal + technical + others) in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_attempted | integer | Free throws attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_made | integer | Free throws made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played: "MM:SS" string in player_match_statistics, decimal minutes in calculated_player_statistics, player-minutes (integer, 5 x period length) in team rows; "00:00" or 0 where not recorded. |
#'   | offensive_rebounds | integer | Offensive rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | personal_fouls | integer | Personal fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | points | integer | Points in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | rebounds | integer | Total rebounds in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | steals | integer | Steals in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | technical_fouls | integer | Technical fouls in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_attempted | integer | Three-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_made | integer | Three-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers | integer | Turnovers in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_attempted | integer | Two-point field goals attempted in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_made | integer | Two-point field goals made in the match, or in the period on period rows; 0 where the era did not record it (results-only seasons before pbp) |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | jersey_number | character | Jersey number, a STRING. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match_player_period_box <- function(match_id) {
  .nbl_rosetta_call(
    "match_player_period_box", "match", "/match/{match_id}/live/all",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Match Play-by-Play**
#' @description
#' One match's play-by-play with shot x/y, oldest first (NBL 2025-26 included, which ESPN's nbl feed lacks).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/{match_id}/live/all`
#' @inherit nbl_rosetta_seasons details
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @return A `hoopR_data` tibble (one row per event, sorted on action_id):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | action_id | integer | Event sequence number within the match (ascending in feed time) |
#'   | period | integer | Period number, an INTEGER here (1-4 = quarters) |
#'   | period_type | character | Period type: regular (overtime unobserved) |
#'   | clock | character | Game clock at the event, MM:SS remaining in the period; null on some feed-control events. |
#'   | clock_seconds | double | Game clock at the event as seconds (parsed from clock, MM:SS); null for events without a clock. |
#'   | shot_clock | character | Shot clock at the event, MM:SS; in Genius-era matches it repeats the game clock (no shot-clock data) |
#'   | shot_clock_seconds | double | Shot clock at the event as seconds (parsed from shot_clock); in Genius-era backfills it repeats the game clock. |
#'   | score_home | integer | Home team's running score after the event (score_1 in the body). |
#'   | score_away | integer | Away team's running score after the event (score_2 in the body). |
#'   | action_type | character | Event type: 2pt, 3pt, freeThrow, rebound, assist, steal, block, turnover, foul, substitution, timeOut, jumpBall, possession, possessionArrow, period, fixture, main (clock start/stop) |
#'   | sub_type | character | Event detail (shot type, foul type, "1Of2" free throw, In/Out...); absent when the event has none. Two vocabularies: Title Case ("Jump Shot") in NBL/WNBL 2025-26 feeds (events carry fixtureId), camelCase ("jumpShot") in older backfills and NBL1. |
#'   | sub_type_key | character | sub_type folded to snake_case, so the Title Case 2025-26 spelling and the camelCase backfill spelling match. |
#'   | success | logical | Shot or free throw made (true) or missed (false). DataCore-era feeds (events with fixtureId) and NBL1 carry it only on shots and free throws (absent elsewhere); older backfills carry it on every event, true on non-shot events. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | is_home | logical | True when the event's team is the match's home team; null when the event has no team. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | player_name | character | Full name of the player the event belongs to; null for events no player owns (team rebounds, period starts). |
#'   | jersey_number | character | Jersey number of the player at the event, as text (a WNBL backfill writes 6.0). |
#'   | x | double | Shot or event position along the court length, percent 0-100, in game orientation (each team's shots sit at x > 50 for two periods and x < 50 for the others). Unverified: which end is x = 0; DataCore-era free-throw, foul and turnover coordinates are not at the free-throw line. Null where none was recorded. |
#'   | y | double | Shot or event position across the court width, percent 0-100 (free throws and close shots cluster near 50). Unverified: which sideline is y = 0. Null where none was recorded. |
#'   | readable_action_type | character | Human-readable event label, e.g. "Game - Game completed". |
#'   | system_action_type | character | Machine event label, e.g. game_game_completed. |
#'   | timestamp | character | Wall-clock time of the event, ISO 8601 without offset (UTC) |
#'   | feed | character | Feed shape: datacore (NBL and WNBL 2025-26: events carry fixtureId, arrive newest first, Title Case sub_type, a real shot clock) or backfill (older seasons and NBL1 2025: no fixtureId, oldest first, camelCase sub_type, shot_clock repeating the game clock). |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_pbp(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_match_pbp <- function(match_id) {
  .nbl_rosetta_call(
    "match_pbp", "match", "/match/{match_id}/live/all",
    path_args = list(match_id = match_id),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Standings**
#' @description
#' Regular-season ladder: position, record, points for and against, home and away splits and form.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/standings/{season}/regular`
#' @inherit nbl_rosetta_seasons details
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @return A `hoopR_data` tibble (one row per ladder entry):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | rosetta_standing_id | character | Rosetta's id of this ladder row (UUID v4); not an entity id. |
#'   | position | integer | Ladder position (1 = top) |
#'   | won | integer | Wins in the season. |
#'   | lost | integer | Losses in the season. |
#'   | played | integer | Games played in the season (wins plus losses). |
#'   | points_percentage | double | points_for / points_against, a RATIO (1.1379 = 113.79 %) |
#'   | win_percentage | double | Won / played, a 0-1 FRACTION. |
#'   | last_5 | character | Results string, W/L oldest first. Despite the name it can hold the whole season (33 characters in NBL 2025-26) |
#'   | streak | integer | Current streak length (the type is the last letter of last_5) |
#'   | points_for | integer | Points scored by the team in the season. |
#'   | points_against | integer | Points conceded. |
#'   | away_losses | integer | Away losses in the season. |
#'   | away_wins | integer | Away wins in the season. |
#'   | home_losses | integer | Home losses in the season. |
#'   | home_wins | integer | Home wins in the season. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_standings(org = "nbl", season = 2026))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_standings <- function(season, org = "nbl", limit = NULL) {
  .nbl_rosetta_call(
    "standings", "standings", "/{org}/standings/{season}/regular",
    path_args = list(season = season, org = org),
    query = list(limit = limit)
  )
}

#' @title
#' **NBL Rosetta Players**
#' @description
#' Roster rows of every team in a season: player bio, jersey, position and team.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/players/in/season/{season}`
#' @inherit nbl_rosetta_seasons details
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @param offset (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer one large limit.
#' @return A `hoopR_data` tibble (one row per roster entry):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | jersey_number | character | Jersey number, a STRING. |
#'   | playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_date_updated | character | Record last-edit time, ISO 8601 UTC. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_date_of_birth | character | Date of birth, ISO date. |
#'   | player_height | double | Height in centimetres. |
#'   | player_weight | double | Weight in kilograms. |
#'   | player_dominant_hand | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | player_nationality | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_nationality_code | character | Nationality, ISO 3166-1 alpha-3 code. |
#'   | player_dominant_foot | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | player_active | logical | Player record is active. |
#'   | player_league | character | Rosetta league record id, UUID v4. |
#'   | player_birthplace | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_rookie_year | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_person | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_latest_jersey_number | character | Player's most recent jersey number, a STRING. |
#'   | player_full_name | character | Given and family name. |
#'   | player_source_updated_at | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_source_provider | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_players(org = "nbl", season = 2026))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_players <- function(season, org = "nbl", limit = NULL, offset = NULL) {
  .nbl_rosetta_call(
    "players", "players", "/{org}/players/in/season/{season}",
    path_args = list(season = season, org = org),
    query = list(limit = limit, offset = offset)
  )
}

#' @title
#' **NBL Rosetta Team Players**
#' @description
#' Roster of one team in a season: player bio, jersey and position.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/players/for/team/{team_id}/in/season/{season}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, c(
#'   'nbl_rosetta_team_players(',
#'   '  org = "nbl", season = 2026, team_id = "befee10a-410c-11f0-b3f4-1b3c55488bbb"',
#'   ')'
#' ))
#' @param team_id (*character* required): Team id: the DataCore id (team_id of nbl_rosetta_teams) or Rosetta's own id; either is accepted.
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row per roster entry):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | jersey_number | character | Jersey number, a STRING. |
#'   | playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | team_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_full_name | character | Given and family name. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | player_active | logical | Player record is active. |
#'   | player_date_of_birth | character | Date of birth, ISO date. |
#'   | player_nationality | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_height | double | Height in centimetres. |
#'   | player_weight | double | Weight in kilograms. |
#'   | player_dominant_hand | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | player_nationality_code | character | Nationality, ISO 3166-1 alpha-3 code. |
#'   | player_birthplace | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_rookie_year | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_team_players <- function(team_id, season, org = "nbl") {
  .nbl_rosetta_call(
    "team_players", "team_players", "/{org}/players/for/team/{team_id}/in/season/{season}",
    path_args = list(team_id = team_id, season = season, org = org),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Outcomes**
#' @description
#' Win-loss record and last 10, 5 and 3 results per team, keyed by team name.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/match/outcomes/for/{org}/teams/in/season/{season}/{season_type}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_outcomes(org = "nbl", season = 2026, season_type = "regular")')
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param season_type (*character* default `"regular"`): Season type: all (every type of the year), regular (includes finals), preseason, in_season (cups, Blitz, NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`, `"preseason"`, `"in_season"`, `"test"`.
#' @return A `hoopR_data` tibble (one row per team name):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | team_name | character | Name of the team, the key of Rosetta's outcomes map (the body carries no team id). |
#'   | wins | integer | Wins of the team in the season type asked for. |
#'   | losses | integer | Losses of the team in the season type asked for. |
#'   | last10 | character | Results of the team's last 10 games as a W/L string, oldest first. |
#'   | last5 | character | Results of the team's last 5 games as a W/L string, oldest first. |
#'   | last3 | character | Results of the team's last 3 games as a W/L string, oldest first. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_outcomes <- function(season, org = "nbl", season_type = "regular") {
  .nbl_rosetta_call(
    "outcomes", "outcomes", "/match/outcomes/for/{org}/teams/in/season/{season}/{season_type}",
    path_args = list(season = season, org = org, season_type = season_type),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Player Game Log**
#' @description
#' A player's game log for a season: the box-score line of each game (period 0 = whole game) and the game.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/player_boxscores/for/{player_id}/in/season/{season}/regular`
#' @eval .intl_details(.nbl_rosetta_seasons_details, c(
#'   'nbl_rosetta_player_game_log(',
#'   '  org = "nbl", participated = 1, player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f",',
#'   '  season = 2026',
#'   ')'
#' ))
#' @param player_id (*character* required): Player id: the DataCore person id (player_id of nbl_rosetta_players) or Rosetta's own id; either is accepted.
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param participated (*integer* default `NULL`): 1 = only games the player played in (without it, games on the roster that he sat out too). Sent as `filter[participated]`.
#' @return A `hoopR_data` tibble (one row per game):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | points | integer | Points in the game. |
#'   | rebounds | integer | Total rebounds in the game. |
#'   | assists | integer | Assists in the game. |
#'   | blocks | integer | Blocks in the game. |
#'   | steals | integer | Steals in the game. |
#'   | turnovers | integer | Turnovers in the game. |
#'   | offensive_rebounds | integer | Offensive rebounds in the game. |
#'   | defensive_rebounds | integer | Defensive rebounds in the game. |
#'   | personal_fouls | integer | Personal fouls in the game. |
#'   | three_points_attempted | integer | Three-point field goals attempted in the game. |
#'   | three_points_made | integer | Three-point field goals made in the game. |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | two_points_attempted | integer | Two-point field goals attempted in the game. |
#'   | two_points_made | integer | Two-point field goals made in the game. |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | field_goals_attempted | integer | Field goals attempted in the game. |
#'   | field_goals_made | integer | Field goals made in the game. |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | free_throws_attempted | integer | Free throws attempted in the game. |
#'   | free_throws_made | integer | Free throws made in the game. |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played, decimal minutes. |
#'   | participated | logical | Player took part in the game. |
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | match_start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | match_season_id | character | DataCore id (UUID v1, Sportradar) of the match's season; stable across seasons and the id to join on across routes. |
#'   | rosetta_match_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the match's season; routes that take this entity accept it as well as the DataCore id. |
#'   | match_season_year | integer | Season year as a STRING. NBL and WNBL from 1998-99: the START year ("2025" = 2025-26, sdv END = year + 1). NBL and WNBL 1979-1997 and every NBL1 season: the calendar year the season was played (END = year). Year 1998 holds two NBL and two WNBL seasons (calendar 1998 and 1998-99): tell them apart by start_date. |
#'   | match_season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | rosetta_match_home_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the match's home team; routes that take this entity accept it as well as the DataCore id. |
#'   | match_home_team_name | character | Display name of the team. |
#'   | match_home_team_code | character | Team code of the match's home team, e.g. PER or SYD. |
#'   | rosetta_match_away_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the match's away team; routes that take this entity accept it as well as the DataCore id. |
#'   | match_away_team_name | character | Display name of the team. |
#'   | match_away_team_code | character | Team code of the match's away team, e.g. PER or SYD. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | sc_total_score | integer | SuperCoach score including double-double / triple-double bonuses. |
#'   | sc_total_score_without_dd_and_td | integer | SuperCoach score without those bonuses. |
#'   | sc_breakdown_points_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_points_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_rebounds_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_rebounds_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_assists_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_assists_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_blocks_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_blocks_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_steals_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_steals_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_turnovers_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_turnovers_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_double_figure_count | integer | Stats in double figures (for the double-double / triple-double bonus) |
#'   | sc_season_total | integer | Player's SuperCoach total for the season so far. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_player_game_log <- function(player_id, season, org = "nbl", participated = NULL) {
  .nbl_rosetta_call(
    "player_game_log", "player_boxscores", "/{org}/player_boxscores/for/{player_id}/in/season/{season}/regular",
    path_args = list(player_id = player_id, season = season, org = org),
    query = list(`filter[participated]` = participated)
  )
}

#' @title
#' **NBL Rosetta Player Stats**
#' @description
#' A player's season totals and averages for every season, by period.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/statistics/for/player/{player_id}`
#' @inherit nbl_rosetta_seasons details
#' @param player_id (*character* required): Player id: the DataCore person id (player_id of nbl_rosetta_players) or Rosetta's own id; either is accepted.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row per season and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | assists_average | double | Assists per game. |
#'   | blocks_average | double | Blocks per game. |
#'   | field_goals_attempted | integer | Field goals attempted, season total. |
#'   | field_goals_made | integer | Field goals made, season total. |
#'   | field_goals_attempted_average | double | Field goals attempted per game. |
#'   | field_goals_made_average | double | Field goals made per game. |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls_average | double | Fouls committed (personal + technical + others) per game. |
#'   | free_throws_attempted | integer | Free throws attempted, season total. |
#'   | free_throws_made | integer | Free throws made, season total. |
#'   | free_throws_attempted_average | double | Free throws attempted per game. |
#'   | free_throws_made_average | double | Free throws made per game. |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | games | integer | Games played in the season (in the period rows, by the player or team). |
#'   | games_started | integer | Games in the starting five. |
#'   | offensive_rebounds | integer | Offensive rebounds, season total. |
#'   | fouls | integer | Fouls committed (personal + technical + others), season total. |
#'   | personal_fouls | integer | Personal fouls, season total. |
#'   | technical_fouls | integer | Technical fouls, season total. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | three_points_attempted | integer | Three-point field goals attempted, season total. |
#'   | three_points_attempted_average | double | Three-point field goals attempted per game. |
#'   | three_points_made | integer | Three-point field goals made, season total. |
#'   | three_points_made_average | double | Three-point field goals made per game. |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers_average | double | Turnovers per game. |
#'   | turnovers | integer | Turnovers, season total. |
#'   | two_points_attempted | integer | Two-point field goals attempted, season total. |
#'   | two_points_attempted_average | double | Two-point field goals attempted per game. |
#'   | two_points_made | integer | Two-point field goals made, season total. |
#'   | two_points_made_average | double | Two-point field goals made per game. |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played, decimal minutes. |
#'   | minutes_average | double | Minutes per game, decimal minutes. |
#'   | points | integer | Points, season total. |
#'   | rebounds | integer | Total rebounds, season total. |
#'   | assists | integer | Assists, season total. |
#'   | blocks | integer | Blocks, season total. |
#'   | steals | integer | Steals, season total. |
#'   | plus_minus | integer | Point differential while on court, season total. |
#'   | plus_minus_average | double | Point differential while on court per game. |
#'   | efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV), season total. |
#'   | efficiency_average | double | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) per game. |
#'   | points_average | double | Points per game. |
#'   | rebounds_average | double | Total rebounds per game. |
#'   | steals_average | double | Steals per game. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | sc_total_score | integer | SuperCoach score including double-double / triple-double bonuses. |
#'   | sc_total_score_without_dd_and_td | integer | SuperCoach score without those bonuses. |
#'   | sc_breakdown_points_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_points_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_rebounds_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_rebounds_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_assists_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_assists_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_blocks_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_blocks_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_steals_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_steals_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_turnovers_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_turnovers_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_triple_double_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_triple_double_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_double_figure_count | integer | Stats in double figures (for the double-double / triple-double bonus) |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'   | sc_breakdown_double_double_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_double_double_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | season_start_date | character | First day of the season, ISO date-time without offset. |
#'   | player_full_name | character | Given and family name. |
#'   | player_active | logical | Player record is active. |
#'   | player_date_of_birth | character | Date of birth, ISO date. |
#'   | player_nationality | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | player_height | double | Height in centimetres. |
#'   | player_weight | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | team_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | synthetic_from_roster | logical | Row built from the roster because the player has no season statistics (all stats 0) |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @examples
#' \donttest{
#'   try(nbl_rosetta_player_stats(org = "nbl", player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f"))
#' }
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_player_stats <- function(player_id, org = "nbl") {
  .nbl_rosetta_call(
    "player_stats", "player_statistics", "/{org}/statistics/for/player/{player_id}",
    path_args = list(player_id = player_id, org = org),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Stats Leaders**
#' @description
#' Player season totals and averages of a season (the leaderboard), one row per player and period.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/stats/leaders/for/season/id/{season_id}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_stats_leaders(org = "nbl", season_id = "1f8e4a79-e98b-457b-85a5-e4b898c6c0bd")')
#' @param season_id (*character* required): Season id: the DataCore season id (season_id of nbl_rosetta_seasons) or Rosetta's own id (rosetta_season_id); either is accepted. Not the year.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @return A `hoopR_data` tibble (one row per player and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | assists_average | double | Assists per game. |
#'   | blocks_average | double | Blocks per game. |
#'   | field_goals_attempted | integer | Field goals attempted, season total. |
#'   | field_goals_made | integer | Field goals made, season total. |
#'   | field_goals_attempted_average | double | Field goals attempted per game. |
#'   | field_goals_made_average | double | Field goals made per game. |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls_average | double | Fouls committed (personal + technical + others) per game. |
#'   | free_throws_attempted | integer | Free throws attempted, season total. |
#'   | free_throws_made | integer | Free throws made, season total. |
#'   | free_throws_attempted_average | double | Free throws attempted per game. |
#'   | free_throws_made_average | double | Free throws made per game. |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | games | integer | Games played in the season (in the period rows, by the player or team). |
#'   | games_started | integer | Games in the starting five. |
#'   | offensive_rebounds | integer | Offensive rebounds, season total. |
#'   | fouls | integer | Fouls committed (personal + technical + others), season total. |
#'   | personal_fouls | integer | Personal fouls, season total. |
#'   | technical_fouls | integer | Technical fouls, season total. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | three_points_attempted | integer | Three-point field goals attempted, season total. |
#'   | three_points_attempted_average | double | Three-point field goals attempted per game. |
#'   | three_points_made | integer | Three-point field goals made, season total. |
#'   | three_points_made_average | double | Three-point field goals made per game. |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers_average | double | Turnovers per game. |
#'   | turnovers | integer | Turnovers, season total. |
#'   | two_points_attempted | integer | Two-point field goals attempted, season total. |
#'   | two_points_attempted_average | double | Two-point field goals attempted per game. |
#'   | two_points_made | integer | Two-point field goals made, season total. |
#'   | two_points_made_average | double | Two-point field goals made per game. |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played, decimal minutes. |
#'   | minutes_average | double | Minutes per game, decimal minutes. |
#'   | points | integer | Points, season total. |
#'   | rebounds | integer | Total rebounds, season total. |
#'   | assists | integer | Assists, season total. |
#'   | blocks | integer | Blocks, season total. |
#'   | steals | integer | Steals, season total. |
#'   | plus_minus | integer | Point differential while on court, season total. |
#'   | plus_minus_average | double | Point differential while on court per game. |
#'   | efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV), season total. |
#'   | efficiency_average | double | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) per game. |
#'   | points_average | double | Points per game. |
#'   | rebounds_average | double | Total rebounds per game. |
#'   | steals_average | double | Steals per game. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | sc_total_score | integer | SuperCoach score including double-double / triple-double bonuses. |
#'   | sc_total_score_without_dd_and_td | integer | SuperCoach score without those bonuses. |
#'   | sc_breakdown_points_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_points_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_rebounds_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_rebounds_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_assists_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_assists_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_blocks_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_blocks_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_steals_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_steals_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_turnovers_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_turnovers_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_breakdown_triple_double_value | integer | The stat's value for the game or season. |
#'   | sc_breakdown_triple_double_points | integer | SuperCoach points this stat earns (e.g. 3 per steal or block, -2 per turnover) |
#'   | sc_double_figure_count | integer | Stats in double figures (for the double-double / triple-double bonus) |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_stats_leaders <- function(season_id, org = "nbl", limit = NULL) {
  .nbl_rosetta_call(
    "stats_leaders", "leaders", "/{org}/stats/leaders/for/season/id/{season_id}",
    path_args = list(season_id = season_id, org = org),
    query = list(limit = limit)
  )
}

#' @title
#' **NBL Rosetta Team Stats Leaders**
#' @description
#' Player season totals of one team in a season, optionally one period and sorted.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/stats/leaders/for/season/id/{season_id}/team/{team_code}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, c(
#'   'nbl_rosetta_team_stats_leaders(',
#'   '  org = "nbl", period = 0, season_id = "1f8e4a79-e98b-457b-85a5-e4b898c6c0bd",',
#'   '  sort = "-points", team_code = "PER"',
#'   ')'
#' ))
#' @param season_id (*character* required): Season id: the DataCore season id (season_id of nbl_rosetta_seasons) or Rosetta's own id (rosetta_season_id); either is accepted. Not the year.
#' @param team_code (*character* required): Team code (team_code of nbl_rosetta_teams), e.g. PER for the Perth Wildcats.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @param period (*integer* default `NULL`): Period to keep: 0 = whole game, 1-4 quarters, 5 and up overtime. Sent as `filter[period]`.
#' @param sort (*character* default `NULL`): Sort key; a leading minus sorts descending, e.g. -points.
#' @return A `hoopR_data` tibble (one row per player and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | assists_average | double | Assists per game. |
#'   | blocks_average | double | Blocks per game. |
#'   | field_goals_attempted | integer | Field goals attempted, season total. |
#'   | field_goals_made | integer | Field goals made, season total. |
#'   | field_goals_attempted_average | double | Field goals attempted per game. |
#'   | field_goals_made_average | double | Field goals made per game. |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls_average | double | Fouls committed (personal + technical + others) per game. |
#'   | free_throws_attempted | integer | Free throws attempted, season total. |
#'   | free_throws_made | integer | Free throws made, season total. |
#'   | free_throws_attempted_average | double | Free throws attempted per game. |
#'   | free_throws_made_average | double | Free throws made per game. |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | games | integer | Games played in the season (in the period rows, by the player or team). |
#'   | games_started | integer | Games in the starting five. |
#'   | offensive_rebounds | integer | Offensive rebounds, season total. |
#'   | fouls | integer | Fouls committed (personal + technical + others), season total. |
#'   | personal_fouls | integer | Personal fouls, season total. |
#'   | technical_fouls | integer | Technical fouls, season total. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | three_points_attempted | integer | Three-point field goals attempted, season total. |
#'   | three_points_attempted_average | double | Three-point field goals attempted per game. |
#'   | three_points_made | integer | Three-point field goals made, season total. |
#'   | three_points_made_average | double | Three-point field goals made per game. |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers_average | double | Turnovers per game. |
#'   | turnovers | integer | Turnovers, season total. |
#'   | two_points_attempted | integer | Two-point field goals attempted, season total. |
#'   | two_points_attempted_average | double | Two-point field goals attempted per game. |
#'   | two_points_made | integer | Two-point field goals made, season total. |
#'   | two_points_made_average | double | Two-point field goals made per game. |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | minutes | double | Minutes played, decimal minutes. |
#'   | minutes_average | double | Minutes per game, decimal minutes. |
#'   | points | integer | Points, season total. |
#'   | rebounds | integer | Total rebounds, season total. |
#'   | assists | integer | Assists, season total. |
#'   | blocks | integer | Blocks, season total. |
#'   | steals | integer | Steals, season total. |
#'   | plus_minus | integer | Point differential while on court, season total. |
#'   | plus_minus_average | double | Point differential while on court per game. |
#'   | efficiency | integer | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV), season total. |
#'   | efficiency_average | double | Efficiency rating (PTS + REB + AST + STL + BLK - missed FG - missed FT - TOV) per game. |
#'   | points_average | double | Points per game. |
#'   | rebounds_average | double | Total rebounds per game. |
#'   | steals_average | double | Steals per game. |
#'   | player_id | character | DataCore id (UUID v1, Sportradar) of the player; stable across seasons and the id to join on across routes. |
#'   | rosetta_player_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the player; routes that take this entity accept it as well as the DataCore id. |
#'   | player_first_name | character | The player's given name, e.g. Elijah. |
#'   | player_jersey_number | character | Jersey number, a STRING. |
#'   | player_last_name | character | The player's family name, e.g. Pepper. |
#'   | player_playing_position | character | Playing position code (G, F, C, PG, SF, FC, ...); null when not recorded. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_division | character | Always an empty array in samples; element shape and meaning unverified. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_team_stats_leaders <- function(season_id, team_code, org = "nbl", limit = NULL, period = NULL, sort = NULL) {
  .nbl_rosetta_call(
    "team_stats_leaders", "team_leaders", "/{org}/stats/leaders/for/season/id/{season_id}/team/{team_code}",
    path_args = list(season_id = season_id, team_code = team_code, org = org),
    query = list(limit = limit, `filter[period]` = period, sort = sort)
  )
}

#' @title
#' **NBL Rosetta Team Stats**
#' @description
#' Team season totals and averages by period (0 = whole game, 1-4 quarters, 5 and up overtime).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/{org}/team/stats/for/season/{season}/regular`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_team_stats(org = "nbl", season = 2026)')
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @return A `hoopR_data` tibble (one row per team and period):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | assists | integer | Assists, team season total (in that period on period rows) |
#'   | assists_average | double | Assists per game. |
#'   | blocks | integer | Blocks, team season total (in that period on period rows) |
#'   | blocks_average | double | Blocks per game. |
#'   | defensive_rebounds | integer | Defensive rebounds, team season total (in that period on period rows) |
#'   | field_goals_attempted | integer | Field goals attempted, team season total (in that period on period rows) |
#'   | field_goals_attempted_average | double | Field goals attempted per game. |
#'   | field_goals_made | integer | Field goals made, team season total (in that period on period rows) |
#'   | field_goals_made_average | double | Field goals made per game. |
#'   | field_goals_percentage | double | Field goals made / attempted, a 0-1 FRACTION. |
#'   | fouls | integer | Fouls committed (personal + technical + others), team season total (in that period on period rows) |
#'   | fouls_average | double | Fouls committed (personal + technical + others) per game. |
#'   | free_throws_attempted | integer | Free throws attempted, team season total (in that period on period rows) |
#'   | free_throws_attempted_average | double | Free throws attempted per game. |
#'   | free_throws_made | integer | Free throws made, team season total (in that period on period rows) |
#'   | free_throws_made_average | double | Free throws made per game. |
#'   | free_throws_percentage | double | Free throws made / attempted, a 0-1 FRACTION. |
#'   | games | integer | Games played in the season (in the period rows, by the player or team). |
#'   | minutes | double | Player-minutes played (5 x game minutes) |
#'   | offensive_rebounds | integer | Offensive rebounds, team season total (in that period on period rows) |
#'   | offensive_rebounds_average | double | Offensive rebounds per game. |
#'   | period | integer | Period as a STRING: 0 = game or season total, 1-4 = quarters, 11/12/13 = first/second/third overtime (inferred: fewer teams have each) |
#'   | personal_fouls_average | double | Personal fouls per game. |
#'   | points | integer | Points, team season total (in that period on period rows) |
#'   | points_average | double | Points per game. |
#'   | rebounds | integer | Total rebounds, team season total (in that period on period rows) |
#'   | rebounds_average | double | Total rebounds per game. |
#'   | results_string | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | steals | integer | Steals, team season total (in that period on period rows) |
#'   | steals_average | double | Steals per game. |
#'   | three_points_attempted | integer | Three-point field goals attempted, team season total (in that period on period rows) |
#'   | three_points_attempted_average | double | Three-point field goals attempted per game. |
#'   | three_points_made | integer | Three-point field goals made, team season total (in that period on period rows) |
#'   | three_points_made_average | double | Three-point field goals made per game. |
#'   | three_points_percentage | double | Three-point field goals made / attempted, a 0-1 FRACTION. |
#'   | turnovers | integer | Turnovers, team season total (in that period on period rows) |
#'   | turnovers_average | double | Turnovers per game. |
#'   | two_points_attempted | integer | Two-point field goals attempted, team season total (in that period on period rows) |
#'   | two_points_attempted_average | double | Two-point field goals attempted per game. |
#'   | two_points_made | integer | Two-point field goals made, team season total (in that period on period rows) |
#'   | two_points_made_average | double | Two-point field goals made per game. |
#'   | two_points_percentage | double | Two-point field goals made / attempted, a 0-1 FRACTION. |
#'   | team_id | character | DataCore id (UUID v1, Sportradar) of the team; stable across seasons and the id to join on across routes. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_competition_division | character | NBL1 divisions (conference x gender); empty for NBL and WNBL. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_team_stats <- function(season, org = "nbl", limit = NULL) {
  .nbl_rosetta_call(
    "team_stats", "team_stats", "/{org}/team/stats/for/season/{season}/regular",
    path_args = list(season = season, org = org),
    query = list(limit = limit)
  )
}

#' @title
#' **NBL Rosetta Next Match**
#' @description
#' The organisation's next scheduled match (empty between seasons).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/next/match/for/{org}/{season}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_next_match(org = "nbl", season = 2027)')
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row: the next match):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
#'   | external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
#'   | date_updated | character | Record last-edit time, ISO 8601 UTC. |
#'   | start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
#'   | start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
#'   | match_type | character | Match type: regular, final (FINAL upper case seen) |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
#'   | home_score | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_score | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | attendance | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | match_slug | character | URL slug of the match page on nbl.com.au. |
#'   | match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
#'   | venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
#'   | rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_code | character | Venue code; often null. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
#'   | rosetta_home_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the home team; routes that take this entity accept it as well as the DataCore id. |
#'   | home_team_name | character | Display name of the team. |
#'   | home_team_external_team_name | character | Team name as DataCore spells it. |
#'   | home_team_code | character | Team code of the home team, e.g. PER or SYD. |
#'   | home_team_division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | home_team_conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
#'   | rosetta_away_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the away team; routes that take this entity accept it as well as the DataCore id. |
#'   | away_team_name | character | Display name of the team. |
#'   | away_team_external_team_name | character | Team name as DataCore spells it. |
#'   | away_team_code | character | Team code of the away team, e.g. PER or SYD. |
#'   | away_team_division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_team_conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_name | character | Season name (NBL26, WNBL 2024/25, 2025 South Men) |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_id | character | Rosetta competition id (UUID v4) |
#'   | season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
#'   | season_competition_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
#'   | season_competition_division | character | Always an empty array in samples; element shape and meaning unverified. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_next_match <- function(season, org = "nbl") {
  .nbl_rosetta_call(
    "next_match", "next_match", "/next/match/for/{org}/{season}",
    path_args = list(season = season, org = org),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Next Match Team**
#' @description
#' Next match; the team segment is ignored by Rosetta (the body is the organisation's next match).
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/next/match/for/team/{team_code}/{org}/{season}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_next_match_team(org = "nbl", season = 2027, team_code = "PER")')
#' @param team_code (*character* required): Team code (team_code of nbl_rosetta_teams), e.g. PER for the Perth Wildcats.
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row: the next match):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | match_id | character | DataCore fixture id (UUID v1); equal to `id`. |
#'   | external_media_id | character | Media id. Through NBL25 (2024-25): the Genius Sports match id (7 digits, e.g. 2636769; 6 or fewer in older seasons). From NBL26: mostly an 8-digit number of unverified origin (e.g. 61386925), date-like codes on some games (05042026 = DDMMYYYY on the 2026 Championship game, 1409252 = DDMMYY + n on the Blitz), null on many preseason games. NBL1 and WNBL 2025 carry 8-digit numbers. |
#'   | date_updated | character | Record last-edit time, ISO 8601 UTC. |
#'   | start_time | character | Tip-off, UTC, with no offset or a Z suffix (ESPN dates the same Perth v SE Melbourne game 2025-12-18T10:30Z; Rosetta says 2025-12-18T10:30:00) |
#'   | start_time_datetime | character | Tip-off, UTC; same value as start_time. |
#'   | round | character | Round label: a number as a string in the regular season ("13"), words in the finals ("SEMI FINAL SERIES 1", "CHAMPIONSHIP") |
#'   | match_type | character | Match type: regular, final (FINAL upper case seen) |
#'   | match_status | character | Status of the match in Rosetta's words (complete for a finished game): box score and play-by-play of any other status are partial. |
#'   | status | character | Provider fixture status: CONFIRMED, SCHEDULED. |
#'   | home_score | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_score | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | attendance | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | match_slug | character | URL slug of the match page on nbl.com.au. |
#'   | match_title | character | Match title ("`<home>` v `<away>` `<men/women>` DD-MM-YYYY") |
#'   | venue_id | character | DataCore id (UUID v1, Sportradar) of the venue; stable across seasons and the id to join on across routes. |
#'   | rosetta_venue_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the venue; routes that take this entity accept it as well as the DataCore id. |
#'   | venue_name | character | Name of the venue (arena), e.g. RAC Arena. |
#'   | venue_address | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_suburb | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_state | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_country | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_capacity | integer | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_timezone | character | IANA time zone of the venue, e.g. Australia/Sydney. |
#'   | venue_code | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_latitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | venue_longitude | double | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | home_team_id | character | DataCore id (UUID v1, Sportradar) of the home team; stable across seasons and the id to join on across routes. |
#'   | rosetta_home_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the home team; routes that take this entity accept it as well as the DataCore id. |
#'   | home_team_name | character | Display name of the team. |
#'   | home_team_external_team_name | character | Team name as DataCore spells it. |
#'   | home_team_code | character | Team code of the home team, e.g. PER or SYD. |
#'   | home_team_division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | home_team_conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_team_id | character | DataCore id (UUID v1, Sportradar) of the away team; stable across seasons and the id to join on across routes. |
#'   | rosetta_away_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the away team; routes that take this entity accept it as well as the DataCore id. |
#'   | away_team_name | character | Display name of the team. |
#'   | away_team_external_team_name | character | Team name as DataCore spells it. |
#'   | away_team_code | character | Team code of the away team, e.g. PER or SYD. |
#'   | away_team_division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | away_team_conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | season_id | character | DataCore id (UUID v1, Sportradar) of the season; stable across seasons and the id to join on across routes. |
#'   | rosetta_season_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the season; routes that take this entity accept it as well as the DataCore id. |
#'   | season_name | character | Season name (NBL26, WNBL 2024/25, 2025 South Men) |
#'   | season_year | integer | Rosetta's year of the season: the START year for the NBL and WNBL from 1998-99 (2025 = 2025-26), the calendar year for NBL1 and the 1979-1997 winter seasons. See season_end_year for the sdv key. |
#'   | season_type | character | Season type: regular (includes finals), preseason, in_season (cups, blitz, exhibition), test. |
#'   | season_gender | character | Gender (MALE/FEMALE upper case on seasons and players, male/female lower case on competitions and divisions; UNKNOWN seen) |
#'   | season_competition_id | character | Rosetta competition id (UUID v4) |
#'   | season_competition_name | character | Name of the competition the season belongs to (e.g. NBL, WNBL, NBL1 North Men). |
#'   | season_competition_gender | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | season_competition_league_name | character | Name of the league the competition belongs to (NBL, WNBL or NBL1). |
#'   | season_competition_division | character | Always an empty array in samples; element shape and meaning unverified. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_next_match_team <- function(team_code, season, org = "nbl") {
  .nbl_rosetta_call(
    "next_match_team", "next_match_team", "/next/match/for/team/{team_code}/{org}/{season}",
    path_args = list(team_code = team_code, season = season, org = org),
    query = list()
  )
}

#' @title
#' **NBL Rosetta Next Matches**
#' @description
#' Each team's next matches: opponent, venue and start time.
#'
#' Endpoint: `GET https://prod.rosetta.nbl.com.au/get/next/matches/for/teams/in/{org}/{season}`
#' @eval .intl_details(.nbl_rosetta_seasons_details, 'nbl_rosetta_next_matches(org = "nbl", season = 2027)')
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @return A `hoopR_data` tibble (one row per team and upcoming match):
#'
#'   | col_name | type | description |
#'   |:---|:---|:---|
#'   | org | character | Organisation the row belongs to: nbl, wnbl or nbl1. From the row's competition, else from the request. |
#'   | rosetta_team_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the team; routes that take this entity accept it as well as the DataCore id. |
#'   | team_name | character | Name of the team as Rosetta spells it, e.g. Perth Wildcats. |
#'   | team_code | character | Team code, e.g. PER (the `{team_code}` path value) |
#'   | division | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | conference | character | Unobserved in samples (null in every capture); type and meaning unverified. |
#'   | match_slug | character | URL slug of the upcoming match, e.g. sydney-kings-v-nz-breakers-men-14-10-2026. |
#'   | match_title | character | Title of the upcoming match, e.g. Sydney Kings v NZ Breakers men 14-10-2026. |
#'   | start_time_datetime | character | Start of the upcoming match, UTC, ISO 8601 text without an offset. |
#'   | is_home | logical | True when the row's team is the home team of the upcoming match. |
#'   | opponent_name | character | Name of the opponent in the upcoming match. |
#'   | venue | character | Name of the venue (arena) of the upcoming match. |
#'   | match_id | character | DataCore fixture id of the match (UUID v1): the `{match_id}` route key and fixtureId in play-by-play. Join on it. |
#'   | rosetta_match_id | character | Rosetta's match RECORD id (UUID v4) as carried by box-score and play-by-play rows; no route accepts it. Join on match_id. |
#'   | rosetta_opponent_id | character | Rosetta's own id (UUID v4; v5 on NBL1) of the opponent; routes that take this entity accept it as well as the DataCore id. |
#'   | season_end_year | integer | sdv season key: the END year of the season (2026 = 2025-26), derived from season_year (a START year for the NBL and WNBL from 1998-99, a calendar year for NBL1 and the 1979-1997 winter seasons; year 1998 is split on the start date). Where the body carries no year it is the season asked for. |
#'
#'   Columns the body adds beyond these follow, in body order (sdv-py keeps them too).
#' @family NBL Rosetta Functions
#' @export
nbl_rosetta_next_matches <- function(season, org = "nbl") {
  .nbl_rosetta_call(
    "next_matches", "next_matches", "/next/matches/for/teams/in/{org}/{season}",
    path_args = list(season = season, org = org),
    query = list()
  )
}
