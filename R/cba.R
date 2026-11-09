# cba.R -- CBA (Chinese Basketball Association) wrappers over data-server.cbaleague.com, at parity
# with sportsdataverse-py sportsdataverse/basketball/cba (origin/main e3d232e). 27 wrappers: 12 GET routes and 15
# POST routes sent with a JSON body, exactly as sportsdataverse-py sends them. Transport, decryption and refusals:
# R/cba_runtime.R; frames: R/cba_parsers.R. Generated from tools/codegen/endpoints/cba.yaml and
# manual_column_descriptions.yaml of that sportsdataverse-py commit (ASCII only: Chinese text is glossed or elided).

# The @details of every cba topic that shares the cba_seasons() notes (roxygen @eval .intl_details()).
.cba_seasons_details <- c(
  "* Unofficial and unsupported: these wrappers read the routes that cbaleague.com's own data site (a Vue",
  "  single-page app) calls. The site's terms were not reviewed; check them before you",
  "  republish the data. Requests are spaced at least 1 s apart per host; keep use small.",
  "* Access: every response body is AES-128-ECB encrypted with a public key shipped in the site's front-end bundle;",
  "  the runtime decrypts it with `digest::AES()` (digest is a suggested package: install it to use these wrappers)",
  "  and refuses anything that does not decrypt. The host blocks",
  "  datacenter IPs at TCP: set the environment variable `CBA_PROXY` (or `options(hoopR.proxy = ...)`) to a",
  "  residential proxy URL; it is never printed or put in a condition. Without a proxy the request goes direct and,",
  "  from a datacenter, fails within seconds (a 5 s connect timeout, no retry of a refused or timed-out connect).",
  "  Where direct access works (a residential IP), set `CBA_DIRECT=1` for the full 60 s timeout and retries.",
  "* Seasons: the API's season is the START year; every `season` argument here is the END year (2026 = 2025-26) and",
  "  is sent as `season - 1`. Columns named `season` keep the wire value (the START year, so the sdv END year is",
  "  `season + 1`). The season list reaches 1995-96; box data before 2009-10 is unverified.",
  "* Coverage: game wrappers serve FINISHED games only. Each first reads the game report header (cached per",
  "  session), and an unfinished game raises `hoopR_asset_fetch`. Box, period, roster and best-player bodies are",
  "  checked against that header (points sum to the score, team ids match, advanced rows are box players).",
  "  Play-by-play is served one period per request: every period is fetched, and a partial set, an unordered clock",
  "  or a final score the plays do not reach is refused. Play-by-play is verified on 2017-18 and 2025-26 only and is",
  "  absent for 2009-10 (`hoopR_no_data`). There are NO shot x/y coordinates in this API (shot location exists only",
  "  as team and player zone splits), and play-by-play has no player or team ids (Chinese sentence text plus",
  "  surnames). Box data has 12-minute quarters in 2009-10 and 2017-18 and 10-minute quarters in 2025-26. The",
  "  women's CBA is not covered (no official source).",
  "* Not game data: `cba_game_team_shots()` and `cba_game_team_four()` answer the two teams' SEASON tables (the shot",
  "  zones are the teams' current profile; the four factors are the previous season), whichever game is asked for.",
  "  The reference lists (`cba_team_options()`, `cba_team_counts()`) and `cba_report_status()` are not echoed by the",
  "  API, so their scope is unchecked.",
  "* Duplicate rows: in some games (2025-26 game 100105799) the advanced-box and extras routes repeat player rows",
  "  (26 rows for 12 players), and the repeats are not always copies. `cba_player_advanced()` and",
  "  `cba_player_extras()` keep the FIRST row per `player_id`.",
  "* Text fields are Chinese (names, play-by-play sentences, position and nationality labels). The column",
  "  descriptions here are ASCII; sportsdataverse-py keeps the full English glossaries of the codes.",
  "* Personal data: the operator ids (`createdBy` / `lastModifiedBy`, one holds a mobile number) and any bare",
  "  mobile-number string are removed from every body. Players' public bio fields (birth date, height, weight) are",
  "  kept.",
  "* Ids: `schedule_id` (games, one global 9-digit sequence 100xxxxxx), `team_id` (clubs, stable across sponsor",
  "  renames), `player_id` (persons) and `match_type_id` are integers. The roster registration `id` of",
  "  `cba_rosters()` is a 19-digit integer that an R integer or double cannot hold exactly, so it is kept as its",
  "  exact digits (character).",
  "* Errors are classed conditions: `hoopR_no_data` (HTTP 404, a game without play-by-play), `hoopR_bad_request` (a",
  "  non-integer id or season, HTTP 400 / 422) and `hoopR_asset_fetch` (any other non-200, including HTTP 500, which",
  "  this API answers for a body it dislikes and which is not retried; a dead connection; an empty or undecryptable",
  "  body; an unfinished game; a body for another game, team, season or day), all inheriting `hoopR_error`. HTTP 429",
  "  / 502 / 503 / 504 are retried, up to three attempts. Wrappers raise; they never warn and return empty."
)

#' @title
#' **Get CBA Seasons**
#' @description
#' Every season of the CBA data site, newest first (the upcoming season is the default), 1995-96 on.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/com-code-tables/getSeason`
#' @eval .returns_rd("cba_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.cba_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(cba_seasons())
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "com-code-tables/getSeason",
    call = rlang::current_env()
  )
  .cba_out("seasons", raw, "CBA Seasons from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Match Types**
#' @description
#' The match types (regular season, playoffs, preseason, all-star, relegation play-off) with their ids.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/com-code-tables/getMatchType`
#' @eval .returns_rd("cba_match_types", inline = FALSE, unit = "match type")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_match_types())
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_match_types <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "com-code-tables/getMatchType",
    call = rlang::current_env()
  )
  .cba_out("match_types", raw, "CBA Match Types from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Options**
#' @description
#' The teams of one season as a select list: team id and the season's display name.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/com-code-tables/getTeam`
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @eval .returns_rd("cba_team_options", inline = FALSE, unit = "team")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_team_options(season = 2026))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_options <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "com-code-tables/getTeam",
    params = list(type = 2, season = season),
    call = rlang::current_env()
  )
  .cba_out("team_options", raw, "CBA Team Options from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Teams**
#' @description
#' The current team list: logo, team id, club name and display name.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/teams/teamList`
#' @eval .returns_rd("cba_teams", inline = FALSE, unit = "club")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_teams())
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_teams <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "teams/teamList",
    call = rlang::current_env()
  )
  .cba_out("teams", raw, "CBA Teams from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Schedule Month**
#' @description
#' Game count per day of one calendar month.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/schedules/month`
#' @param year (required) Required. CALENDAR year (not the season).
#' @param month (required) Required. Calendar month, 1-12.
#' @eval .returns_rd("cba_schedule_month", inline = FALSE, unit = "day with games")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_schedule_month(month = 12, year = 2025))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_schedule_month <- function(year, month) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "schedules/month",
    params = list(year = year, month = month),
    call = rlang::current_env()
  )
  .cba_out("schedule_month", raw, "CBA Schedule Month from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Schedule Day**
#' @description
#' The games of one day: ids, teams, status, score, round and the data flags.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/schedules/day`
#' @param day (required) Required. Date 'YYYY-MM-DD'. The runtime always sends auto=0 (the site's auto mode jumps to
#'   the next game day) and refuses rows on another date.
#' @eval .returns_rd("cba_schedule_day", inline = FALSE, unit = "game")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_schedule_day(day = "2025-12-12"))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_schedule_day <- function(day) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "schedules/day",
    params = list(auto = 0, day = day),
    call = rlang::current_env()
  )
  .cba_out("schedule_day", raw, "CBA Schedule Day from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Game Info**
#' @description
#' Game report header: both teams, score, tip-off time and colours.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/baseInfo/{schedule_id}`
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_game_info", inline = FALSE, unit = "game")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_game_info(schedule_id = 100105799))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_game_info <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/getMatchDataReport/baseInfo",
    path_id = schedule_id,
    call = rlang::current_env()
  )
  .cba_out("game_info", raw, "CBA Game Info from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Box**
#' @description
#' Player box score of a finished game, both sides, plus a team rebounds/turnovers row per side (null player_id).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-match-datas/data-count` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_player_box", inline = FALSE, unit = "player, plus a team row per side")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_player_box(schedule_id = 100105799))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_box <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-match-datas/data-count",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("player_box", raw, "CBA Player Box from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Period Scores**
#' @description
#' Points each side scored in each period of a finished game (up to seven periods).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/schedule-quarters/getQuarterInfo` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_period_scores", inline = FALSE, unit = "side and played period")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_period_scores(schedule_id = 100105799))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_period_scores <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "schedule-quarters/getQuarterInfo",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("period_scores", raw, "CBA Period Scores from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Game Team Shots**
#' @description
#' Shot-zone profile of the two teams of a game. NOT game data: the teams' current season table.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/team-match-datas/schedule-shoot-list` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_game_team_shots", inline = FALSE, unit = "team")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_game_team_shots(schedule_id = 100105799))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_game_team_shots <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/schedule-shoot-list",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("game_team_shots", raw, "CBA Game Team Shots from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Advanced**
#' @description
#' Advanced player box of a finished game (usage, true shooting, rebound/steal/block rates, zone splits), one row
#' per player.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-match-datas/advance-count` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_player_advanced", inline = FALSE, unit = "player")
#' @eval .intl_details(.cba_seasons_details, "cba_player_advanced(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_advanced <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-match-datas/advance-count",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("player_advanced", raw, "CBA Player Advanced from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Extras**
#' @description
#' Fast-break points, dunk points and paint points per player of a finished game, one row per player.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-match-datas/schedule-other-data` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_player_extras", inline = FALSE, unit = "player")
#' @eval .intl_details(.cba_seasons_details, "cba_player_extras(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_extras <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-match-datas/schedule-other-data",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("player_extras", raw, "CBA Player Extras from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Game Team Four**
#' @description
#' Four-factors table of the two teams of a game. NOT game data: the teams' previous season table.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/teams/schedule-four-elements` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_game_team_four", inline = FALSE, unit = "team")
#' @eval .intl_details(.cba_seasons_details, "cba_game_team_four(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_game_team_four <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "teams/schedule-four-elements",
    json = list(scheduleId = schedule_id),
    call = rlang::current_env()
  )
  .cba_out("game_team_four", raw, "CBA Game Team Four from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Best Player**
#' @description
#' The best player of each side in the game report.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/bestPlayer/{schedule_id}`
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_best_player", inline = FALSE, unit = "side with the star player's line")
#' @eval .intl_details(.cba_seasons_details, "cba_best_player(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_best_player <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/getMatchDataReport/bestPlayer",
    path_id = schedule_id,
    call = rlang::current_env()
  )
  .cba_out("best_player", raw, "CBA Best Player from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Best Stats**
#' @description
#' Single-category leaders of each side in the game report.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReport/bestDataQuota/{schedule_id}`
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_best_stats", inline = FALSE, unit = "side and category")
#' @eval .intl_details(.cba_seasons_details, "cba_best_stats(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_best_stats <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/getMatchDataReport/bestDataQuota",
    path_id = schedule_id,
    call = rlang::current_env()
  )
  .cba_out("best_stats", raw, "CBA Best Stats from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Rosters**
#' @description
#' Registered rosters of both sides with player bio fields (the season registration, not the game box).
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/schedules/getPlayersByScheduleId/{schedule_id}`
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_rosters", inline = FALSE, unit = "registered player")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_rosters(schedule_id = 100105799))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_rosters <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "schedules/getPlayersByScheduleId",
    path_id = schedule_id,
    call = rlang::current_env()
  )
  .cba_out("rosters", raw, "CBA Rosters from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Report Status**
#' @description
#' Whether the game report page exists for the game.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/team-match-datas/getMatchDataReportStatues/{schedule_id}`
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @eval .returns_rd("cba_report_status", inline = FALSE, unit = "game")
#' @eval .intl_details(.cba_seasons_details, "cba_report_status(schedule_id = 100105799)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_report_status <- function(schedule_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/getMatchDataReportStatues",
    path_id = schedule_id,
    call = rlang::current_env()
  )
  .cba_out("report_status", raw, "CBA Report Status from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Play-by-Play**
#' @description
#' Play-by-play of a finished game, every period merged, oldest first (Chinese text; no player or team ids).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/schedule-eventses/filterPage` (JSON body)
#' @param schedule_id (required) Required. CBA game id (integer), the global 9-digit sequence 100xxxxxx (100105799 =
#'   2025-26 round 1). Only a finished game is served.
#' @param quarter_num (optional) Optional period number. Omitted = every period (the API serves one period per
#'   request; the runtime fetches them all and checks the set).
#' @eval .returns_rd("cba_pbp", inline = FALSE, unit = "play")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   # First quarter only; omit quarter_num for the whole game.
#'   try(cba_pbp(schedule_id = 100105799, quarter_num = 1))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_pbp <- function(schedule_id, quarter_num = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "schedule-eventses/filterPage",
    params = list(startNum = 0),
    json = list(scheduleId = schedule_id, quarterNum = quarter_num),
    call = rlang::current_env()
  )
  .cba_out("pbp", raw, "CBA Play-by-Play from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Counts**
#' @description
#' Team counts of one season, keyed by match type.
#'
#' Endpoint: `GET https://data-server.cbaleague.com/api/team-count/season`
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @eval .returns_rd("cba_team_counts", inline = FALSE, unit = "match type")
#' @eval .intl_details(.cba_seasons_details, "cba_team_counts(season = 2026)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_counts <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-count/season",
    params = list(season = season),
    call = rlang::current_env()
  )
  .cba_out("team_counts", raw, "CBA Team Counts from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Basic**
#' @description
#' A team's per-game averages or totals, one row per season of the team.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/teams/basic-data` (JSON body)
#' @param team_id (required) Required. CBA team id (clubs, stable across seasons and renames).
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param statistical_dimension (default `1`) How counting columns are formatted: 1 per game (default), 2 season
#'   total, 3 and 4 per 100 possessions.
#' @param self_or_other (default `1`) Whose statistics: 1 the team's own (default), 2 its opponents'.
#' @eval .returns_rd("cba_team_basic", inline = FALSE, unit = "season of the team")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_team_basic(team_id = 29128))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_basic <- function(team_id, match_type_id = 1, statistical_dimension = 1, self_or_other = 1) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "teams/basic-data",
    json = list(
      targetId = team_id,
      matchTypeId = match_type_id,
      statisticalDimension = statistical_dimension,
      selfOrOther = self_or_other
    ),
    call = rlang::current_env()
  )
  .cba_out("team_basic", raw, "CBA Team Basic from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Four**
#' @description
#' A team's four-factors table, one row per season of the team.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/teams/four-elements` (JSON body)
#' @param team_id (required) Required. CBA team id (clubs, stable across seasons and renames).
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @eval .returns_rd("cba_team_four", inline = FALSE, unit = "season of the team")
#' @eval .intl_details(.cba_seasons_details, "cba_team_four(team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_four <- function(team_id, match_type_id = 1) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "teams/four-elements",
    json = list(targetId = team_id, matchTypeId = match_type_id),
    call = rlang::current_env()
  )
  .cba_out("team_four", raw, "CBA Team Four from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Overview**
#' @description
#' A team's overview table (record, pace, per-100 ratings), one row per season of the team.
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/team-match-datas/team-entirety-list` (JSON body)
#' @param team_id (required) Required. CBA team id (clubs, stable across seasons and renames).
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_team_overview", inline = FALSE, unit = "season of the team")
#' @eval .intl_details(.cba_seasons_details, "cba_team_overview(team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_overview <- function(team_id, match_type_id = 1, page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/team-entirety-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(teamId = team_id, matchTypeId = match_type_id),
    call = rlang::current_env()
  )
  .cba_out("team_overview", raw, "CBA Team Overview from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Team Shots**
#' @description
#' A team's shot-zone profile, one row per season of the team (zone splits from 2017-18).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/team-match-datas/team-shoot-list` (JSON body)
#' @param team_id (required) Required. CBA team id (clubs, stable across seasons and renames).
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_team_shots", inline = FALSE, unit = "season of the team")
#' @eval .intl_details(.cba_seasons_details, "cba_team_shots(team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_team_shots <- function(team_id, match_type_id = 1, page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "team-match-datas/team-shoot-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(teamId = team_id, matchTypeId = match_type_id),
    call = rlang::current_env()
  )
  .cba_out("team_shots", raw, "CBA Team Shots from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Base**
#' @description
#' Season player box (one page of the season player table).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-base-list` (JSON body)
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param count_ranger (default `1`) How counting statistics scale: 1 per game (default), 2 season total, 3 per 36
#'   minutes, 4 per 100 possessions.
#' @param player_ranger (default `1`) Which players: 1 all (default), 2 domestic (Chinese) only, 4 foreign only.
#' @param team_id (optional) Optional CBA team id (clubs, stable across seasons and renames) to list one team's
#'   players.
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_player_base", inline = FALSE, unit = "player of the requested page")
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_player_base(season = 2026, team_id = 29128))
#' }
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_base <- function(season, match_type_id = 1, count_ranger = 1, player_ranger = 1, team_id = NULL,
                             page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-base-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(
      season = season,
      matchTypeId = match_type_id,
      countRanger = count_ranger,
      playerRanger = player_ranger,
      teamId = team_id
    ),
    call = rlang::current_env()
  )
  .cba_out("player_base", raw, "CBA Player Base from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Offensive**
#' @description
#' Season player offensive rates (one page).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-offensive-list` (JSON body)
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param count_ranger (default `1`) How counting statistics scale: 1 per game (default), 2 season total, 3 per 36
#'   minutes, 4 per 100 possessions.
#' @param player_ranger (default `1`) Which players: 1 all (default), 2 domestic (Chinese) only, 4 foreign only.
#' @param team_id (optional) Optional CBA team id (clubs, stable across seasons and renames) to list one team's
#'   players.
#' @param sort (default `3`) Sort column code the site sends (3 is the default order); the API answers an empty body
#'   without it.
#' @param rank (default `1`) Sort direction code the site sends (1 default); the API answers an empty body without
#'   it.
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_player_offensive", inline = FALSE, unit = "player of the requested page")
#' @eval .intl_details(.cba_seasons_details, "cba_player_offensive(season = 2026, team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_offensive <- function(season, match_type_id = 1, count_ranger = 1, player_ranger = 1, team_id =
                                  NULL, sort = 3, rank = 1, page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-offensive-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(
      season = season,
      matchTypeId = match_type_id,
      countRanger = count_ranger,
      playerRanger = player_ranger,
      teamId = team_id,
      sort = sort,
      rank = rank
    ),
    call = rlang::current_env()
  )
  .cba_out("player_offensive", raw, "CBA Player Offensive from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Defensive**
#' @description
#' Season player defensive rates (one page).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-defensive-list` (JSON body)
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param count_ranger (default `1`) How counting statistics scale: 1 per game (default), 2 season total, 3 per 36
#'   minutes, 4 per 100 possessions.
#' @param player_ranger (default `1`) Which players: 1 all (default), 2 domestic (Chinese) only, 4 foreign only.
#' @param team_id (optional) Optional CBA team id (clubs, stable across seasons and renames) to list one team's
#'   players.
#' @param sort (default `3`) Sort column code the site sends (3 is the default order); the API answers an empty body
#'   without it.
#' @param rank (default `1`) Sort direction code the site sends (1 default); the API answers an empty body without
#'   it.
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_player_defensive", inline = FALSE, unit = "player of the requested page")
#' @eval .intl_details(.cba_seasons_details, "cba_player_defensive(season = 2026, team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_defensive <- function(season, match_type_id = 1, count_ranger = 1, player_ranger = 1, team_id =
                                  NULL, sort = 3, rank = 1, page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-defensive-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(
      season = season,
      matchTypeId = match_type_id,
      countRanger = count_ranger,
      playerRanger = player_ranger,
      teamId = team_id,
      sort = sort,
      rank = rank
    ),
    call = rlang::current_env()
  )
  .cba_out("player_defensive", raw, "CBA Player Defensive from data-server.cbaleague.com")
}

#' @title
#' **Get CBA Player Shots**
#' @description
#' Season player shot-zone profile (one page).
#'
#' Endpoint: `POST https://data-server.cbaleague.com/api/player-shoot-list` (JSON body)
#' @param season (required) Required. Season END year (2026 = the 2025-26 season). The API takes the START year
#'   (2025), so cba_runtime sends season - 1.
#' @param match_type_id (default `1`) Match type id: 1 regular season (default), 2 playoffs, 3 preseason, 4
#'   all-star, 9 relegation play-off (cba_match_types).
#' @param count_ranger (default `1`) How counting statistics scale: 1 per game (default), 2 season total, 3 per 36
#'   minutes, 4 per 100 possessions.
#' @param player_ranger (default `1`) Which players: 1 all (default), 2 domestic (Chinese) only, 4 foreign only.
#' @param team_id (optional) Optional CBA team id (clubs, stable across seasons and renames) to list one team's
#'   players.
#' @param sort (default `3`) Sort column code the site sends (3 is the default order); the API answers an empty body
#'   without it.
#' @param rank (default `1`) Sort direction code the site sends (1 default); the API answers an empty body without
#'   it.
#' @param page_number (default `1`) Page number of the paged list, from 1.
#' @param page_size (default `100`) Rows per page (the site uses 100).
#' @eval .returns_rd("cba_player_shots", inline = FALSE, unit = "player of the requested page")
#' @eval .intl_details(.cba_seasons_details, "cba_player_shots(season = 2026, team_id = 29128)")
#' @export
#' @concept CBA Functions
#' @seealso [family_cba] lists every function in this family.
cba_player_shots <- function(season, match_type_id = 1, count_ranger = 1, player_ranger = 1, team_id = NULL,
                              sort = 3, rank = 1, page_number = 1, page_size = 100) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .cba_get(
    "player-shoot-list",
    params = list(pageNumber = page_number, pageSize = page_size),
    json = list(
      season = season,
      matchTypeId = match_type_id,
      countRanger = count_ranger,
      playerRanger = player_ranger,
      teamId = team_id,
      sort = sort,
      rank = rank
    ),
    call = rlang::current_env()
  )
  .cba_out("player_shots", raw, "CBA Player Shots from data-server.cbaleague.com")
}
