# nbl_rosetta.R -- NBL / WNBL / NBL1 (Australia) wrappers over Rosetta, the JSON proxy behind
# nbl.com.au. Port of sportsdataverse-py sportsdataverse/basketball/nbl_au/nbl_rosetta.py (same names, arguments
# and defaults; sportsdataverse-py's return_parsed / return_as_pandas / **kwargs have no R counterpart). The
# transport, refusals and parsers live in nbl_rosetta_utils.R. In wehoop only the `org` default changes.

# The @details of every nbl_rosetta topic that shares the nbl_rosetta_seasons() notes (roxygen @eval .intl_details()).
.nbl_rosetta_seasons_details <- c(
  "* Unofficial: the JSON proxy behind nbl.com.au (not an API the NBL documents or supports). The terms of use were not reviewed; check them before you republish the data.",
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
#' @eval .intl_details(.nbl_rosetta_seasons_details, full = TRUE)
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @eval .returns_rd("nbl_rosetta_seasons", inline = FALSE, unit = "season")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_seasons(org = "nbl"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @eval .returns_rd("nbl_rosetta_seasons_current", inline = FALSE, unit = "season")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_seasons_current(org = "nbl"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param season_type (*character* default `"all"`): Season type: all (every type of the year), regular (includes finals), preseason, in_season (cups, Blitz, NBAxNBL, All-Star) or test. One of `"all"`, `"regular"`, `"preseason"`, `"in_season"`, `"test"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @param offset (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer one large limit.
#' @eval .returns_rd("nbl_rosetta_matches", inline = FALSE, unit = "match")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_matches(org = "nbl", season = 2026, season_type = "regular"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @eval .returns_rd("nbl_rosetta_teams", inline = FALSE, unit = "team record")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_teams(org = "nbl"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_match_by_id", inline = FALSE, unit = "match")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @eval .returns_rd("nbl_rosetta_match", inline = FALSE, unit = "match")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @eval .returns_rd("nbl_rosetta_match_player_box", inline = FALSE, unit = "player line")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_player_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @eval .returns_rd("nbl_rosetta_match_team_box", inline = FALSE, unit = "team and period")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_team_box(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_match_player_period_box", inline = FALSE, unit = "player and period")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param match_id (*character* required): DataCore fixture id of the match (match_id of nbl_rosetta_matches), a UUID, e.g. b217a699-4bef-11f0-bc08-933162362355.
#' @eval .returns_rd("nbl_rosetta_match_pbp", inline = FALSE, unit = "event")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_match_pbp(match_id = "b217a699-4bef-11f0-bc08-933162362355"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @eval .returns_rd("nbl_rosetta_standings", inline = FALSE, unit = "ladder entry")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_standings(org = "nbl", season = 2026))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param season (*integer* required): Season END year (2026 = 2025-26). The runtime maps it to Rosetta's year: the START year for the NBL and WNBL from 1998-99, the calendar year for NBL1 and the NBL / WNBL winter seasons up to 1998. END 1998 and 1999 both read Rosetta year 1998, which holds two seasons; the matches frame keeps the one asked for.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @param limit (*integer* default `NULL`): Rows to return. Omitted = a page large enough for the whole list (a short page cut by Rosetta's path cache is refused).
#' @param offset (*integer* default `NULL`): Rows to skip. Pages can overlap, so prefer one large limit.
#' @eval .returns_rd("nbl_rosetta_players", inline = FALSE, unit = "roster entry")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_players(org = "nbl", season = 2026))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_team_players", inline = FALSE, unit = "roster entry")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_outcomes", inline = FALSE, unit = "team name")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_player_game_log", inline = FALSE, unit = "game")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .intl_details(.nbl_rosetta_seasons_details)
#' @param player_id (*character* required): Player id: the DataCore person id (player_id of nbl_rosetta_players) or Rosetta's own id; either is accepted.
#' @param org (*character* default `"nbl"`): Organisation: nbl (men's NBL), wnbl (women's) or nbl1 (the second tier, men's and women's conferences). One of `"nbl"`, `"wnbl"`, `"nbl1"`.
#' @eval .returns_rd("nbl_rosetta_player_stats", inline = FALSE, unit = "season and period")
#' @examples
#' \donttest{
#'   try(nbl_rosetta_player_stats(org = "nbl", player_id = "7619d3ea-410d-11f0-9235-2902fc2f936f"))
#' }
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_stats_leaders", inline = FALSE, unit = "player and period")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_team_stats_leaders", inline = FALSE, unit = "player and period")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_team_stats", inline = FALSE, unit = "team and period")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_next_match", inline = FALSE, unit = "match")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_next_match_team", inline = FALSE, unit = "match")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
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
#' @eval .returns_rd("nbl_rosetta_next_matches", inline = FALSE, unit = "team and upcoming match")
#' @concept NBL Rosetta Functions
#' @seealso [family_nbl_rosetta] lists every function in this family.
#' @export
nbl_rosetta_next_matches <- function(season, org = "nbl") {
  .nbl_rosetta_call(
    "next_matches", "next_matches", "/next/matches/for/teams/in/{org}/{season}",
    path_args = list(season = season, org = org),
    query = list()
  )
}
