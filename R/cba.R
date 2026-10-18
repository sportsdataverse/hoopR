# cba.R -- CBA (Chinese Basketball Association) wrappers over data-server.cbaleague.com, at parity
# with sdv-py sportsdataverse/basketball/cba (origin/main e3d232e). 27 wrappers: 12 GET routes and 15
# POST routes sent with a JSON body, exactly as sdv-py sends them. Transport, decryption and refusals:
# R/cba_runtime.R; frames: R/cba_parsers.R. Generated from tools/codegen/endpoints/cba.yaml and
# manual_column_descriptions.yaml of that sdv-py commit (ASCII only: Chinese text is glossed or elided).

# The @details of every cba topic that shares the cba_seasons() notes (roxygen @eval .intl_details()).
.cba_seasons_details <- c(
  "* Unofficial and unsupported: these wrappers read the routes that cbaleague.com's own data site (a Vue",
  "  single-page app) calls. SportsDataverse has not ruled on the site's terms, so payloads are not redistributed as",
  "  release assets. Requests are spaced at least 1 s apart per host; keep use small.",
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
  "  descriptions here are ASCII; sdv-py's `tools/codegen/notes/cba_glossary.yaml` holds the full English",
  "  glossaries.",
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
#' @return
#' A `hoopR_data` tibble: One row per season: label, START year, default flag. An empty valid answer is a zero-row
#'   tibble with these columns, in this order (sdv-py `cba_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | is_default | integer | Default-selection flag: 1 = the site's default season (exactly one row: the season in progress or next), 2 = not the default. |
#' | key | character | Season label 'YYYY-YYYY' (START year - END year), e.g. '2025-2026'; the sdv season key is the second year. The list runs from the upcoming season (2026-2027, 32 rows) down to 1995-1996 with no gap. |
#' | value | character | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. String of digits ('2025'); the value every season parameter takes. |
#' @eval .intl_details(.cba_seasons_details)
#' @examples
#' \donttest{
#'   try(cba_seasons())
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per match type (regular season, playoffs, preseason, all-star, relegation). An
#'   empty valid answer is a zero-row tibble with these columns, in this order (sdv-py `cba_match_types`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | is_default | integer | Default-selection flag: 1 = the site's default (the preseason, '3', at capture time: it follows the calendar), 2 = not the default. |
#' | key | character | Match type name (Chinese): regular season, (Chinese text) playoffs, (Chinese text) preseason, (Chinese text) all-star, (Chinese text) relegation play-off. |
#' | value | character | Match type id as a string ('1' regular season, '2' playoffs, '3' preseason, '4' all-star, '9' relegation); the matchTypeId of every other route. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_match_types())
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per team: id (key) and display name. An empty valid answer is a zero-row tibble
#'   with these columns, in this order (sdv-py `cba_team_options`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | is_default | integer | Default-selection flag: 2 = not the default on every row (the site prepends its own 'all teams' row, which this route does not send). |
#' | key | character | Team display name (Chinese) in the requested season; names change with the sponsor, the teamId does not. |
#' | value | character | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Here a string of digits. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_team_options(season = 2026))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per club: logo, id, club name and display name. An empty valid answer is a
#'   zero-row tibble with these columns, in this order (sdv-py `cba_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | club | character | Empty string on every row; meaning unverified (a club-code slot the site leaves unused). |
#' | team_cn_alias | character | Current team name (Chinese short name, e.g. 'Beijing Holdings'). Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_logo | character | Protocol-relative URL of the 300x300 team logo (`//image.cbaleague.com/cbaleague/teamlogo/300x300/<teamId>_300.png`). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_teams())
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per day with games: date and game count. An empty valid answer is a zero-row
#'   tibble with these columns, in this order (sdv-py `cba_schedule_month`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_num | integer | Number of games scheduled on that day (0 = none). |
#' | schedule_time | character | The day as 'YYYY-MM-DD 00:00:00' (China local time, no zone); one row per calendar day of the month. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_schedule_month(month = 12, year = 2025))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per game: ids, teams, status, score, round and the data flags. An empty valid
#'   answer is a zero-row tibble with these columns, in this order (sdv-py `cba_schedule_day`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | home_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | home_team_logo | character | Absolute URL of the home team logo (300x300 png). |
#' | home_team_lose | integer | Home team's cumulative losses after this game. An integer (the API sends it as digit text). |
#' | home_team_name | character | Home team name (Chinese) as of the game's season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | home_team_score | integer | Home team final points (a game not yet played has no score; a scheduled 2026-27 game outside the samples showed null). |
#' | home_team_win | integer | Home team's cumulative wins after this game in the match type. An integer (the API sends it as digit text). |
#' | is_events | integer | Play-by-play flag: 1 = play-by-play exists (2017-18 and later in the samples), 2 = none (the 2009-10 sample answers empty pages). |
#' | is_report | integer | Game-report flag: 1 = a game report page exists (every sample). |
#' | match_order | integer | Sequence number of the game within its season and match type (1-based). |
#' | match_type_id | integer | Match type id (1 regular season, 2 playoffs, 3 preseason, 4 all-star, 9 relegation; see getMatchType). |
#' | minutes | integer | Regulation length of the game in minutes: 40 (4 x 10) in the 2025-26 sample, 48 (4 x 12) in the 2009-10 and 2017-18 samples. |
#' | quarter | integer | Number of periods played (4 = no overtime; 5 and up would be overtime periods). |
#' | round | integer | Round number within the match type (1-based). |
#' | round_desc | character | Unobserved: null in every sample, so no meaning is claimed beyond its name (round description). |
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | schedule_num | integer | Unobserved: null in every sample on this route (the game count is filled on schedules/month). Typed Int64 like the family's other routes. |
#' | schedule_time | character | Tip-off as 'YYYY-MM-DD HH:MM:SS' (China local time, no zone). |
#' | schedule_type_name | character | Round label (Chinese), e.g. (Chinese text)1regular season, round 1. |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | seconds | double | Unobserved: null in every sample (the clock seconds of a live game, by its name). Typed Float64 like the family's other routes. |
#' | status | integer | Game status: 4 = finished (every sampled game). 1 = not started and 2 = in progress are inferred from the site's polling logic; 3 is unobserved. See the code table. |
#' | visiting_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | visiting_team_logo | character | Absolute URL of the visiting team logo (300x300 png). |
#' | visiting_team_lose | integer | Visiting team's cumulative losses after this game. An integer (the API sends it as digit text). |
#' | visiting_team_name | character | Visiting team name (Chinese) as of the game's season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | visiting_team_score | integer | Visiting team final points. |
#' | visiting_team_win | integer | Visiting team's cumulative wins after this game. An integer (the API sends it as digit text). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_schedule_day(day = "2025-12-12"))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row: both teams, score, tip-off time and colours. An empty valid answer is a zero-row
#'   tibble with these columns, in this order (sdv-py `cba_game_info`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | count | integer | Unverified: an integer shown in the report header (83 in the 2025-26 sample, 99 in 2017-18). Not the play-by-play row count; plausibly possessions per team, which the bundle does not confirm. |
#' | guest_color | character | Visiting team colour as a '#RRGGBB' hex string. |
#' | guest_score | integer | Visiting team final points. |
#' | guest_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Visiting team. |
#' | guest_team_logo | character | Absolute URL of the visiting team logo. |
#' | guest_team_name | character | Visiting team name (Chinese) at the time of the game. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | host_color | character | Home team colour as a '#RRGGBB' hex string (the game report's theme colour). |
#' | host_score | integer | Home team final points. |
#' | host_team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. Home team. |
#' | host_team_logo | character | Absolute URL of the home team logo. |
#' | host_team_name | character | Home team name (Chinese) at the time of the game (e.g. in 2017-18). Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | schedule_time | character | Tip-off as 'YYYY-MM-DD HH:MM:SS' (China local time); equals schedules/day scheduleTime. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_game_info(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player and a team rebounds/turnovers row per side (null player_id). An empty
#'   valid answer is a zero-row tibble with these columns, in this order (sdv-py `cba_player_box`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | assists | integer | Assists in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | blocked | integer | Blocks in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | cn_alias | character | Player name (Chinese). The team row reads 'team rebounds / turnovers' (rebounds and turnovers not credited to a player; that row does not exist in the 2009-10 sample). |
#' | field_goals | integer | Field goals made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | field_goals_attempted | integer | Field goals attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | field_goals_percentage | double | Field-goal percentage as a FRACTION 0-1 (0.308), null when no attempt (0/0) as well as on the team row. |
#' | fouls | integer | Personal fouls in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | free_throws | integer | Free throws made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | free_throws_attempted | integer | Free throws attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | free_throws_percentage | double | Free-throw percentage as a FRACTION 0-1, null on the team row. |
#' | game_start | integer | Starter flag: 1 = started the game. Null on the team row. |
#' | number | character | Jersey number as a string. Null on the team row. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. Null on the team row. |
#' | plus_minus | integer | Plus-minus while on court. Null on the team row and on every row of the 2009-10 sample (not tracked then). |
#' | points | integer | Points in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | rebounds | integer | Total rebounds in this game (integer). The team row carries the team's own total here. |
#' | rebounds_defensive | integer | Defensive rebounds in this game (integer). The team row carries the team's own total here. |
#' | rebounds_offensive | integer | Offensive rebounds in this game (integer). The team row carries the team's own total here. |
#' | steals | integer | Steals in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | three_point_attempted | integer | Three-pointers attempted in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | three_point_goals | integer | Three-pointers made in this game (integer). Null on the team row (the (Chinese text) rebounds/turnovers row). |
#' | three_point_percentage | double | Three-point percentage as a FRACTION 0-1, null on the team row. |
#' | turnovers | integer | Turnovers in this game (integer). The team row carries the team's own total here. |
#' | up_time | integer | Time on court in SECONDS (1692 = 28:12). Null on the team row. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_player_box(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per side and played period (overtime included). An empty valid answer is a
#'   zero-row tibble with these columns, in this order (sdv-py `cba_period_scores`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | period | integer | Period number: 1-4 regulation, 5 and up overtime (the API holds up to seven periods). |
#' | points | integer | Points the side scored IN this period (not cumulative); overtime periods included. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_period_scores(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per team (and averages); a team-season table, not game data. An empty valid answer
#'   is a zero-row tibble with these columns, in this order (sdv-py `cba_game_team_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points allowed per 100 possessions). Typed Float64 like the family's other routes. |
#' | bout_point_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points per 100 possessions). Typed Float64 like the family's other routes. |
#' | bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) net points per 100 possessions). Typed Float64 like the family's other routes. |
#' | guard_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_hit_at_rim_made_rate | double | at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_hit_middle_rate | double | mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_goals_rate | double | three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | is_avg | integer | Row kind: 2 on every sampled row = a team's own row; 1 is presumed to mark a league-average row but is unobserved. |
#' | num | double | Games the profile covers (the site's 'games'), e.g. 42.0; a number typed as float. |
#' | offensive_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). |
#' | offensive_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). |
#' | offensive_hit_at_rim_made_rate | double | at-rim shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_hit_middle_rate | double | mid-range shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). |
#' | offensive_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). |
#' | offensive_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
#' | offensive_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
#' | offensive_three_goals_rate | double | three-point shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in that season; changes with the sponsor. |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_game_team_shots(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player (deduplicated on player_id, first row kept). An empty valid answer is a
#'   zero-row tibble with these columns, in this order (sdv-py `cba_player_advanced`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | assists_percentage | double | assist rate: the share of teammates' made field goals the player assisted while on the court. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | assists_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: assist rate: the share of teammates' made field goals the player assisted while on the court. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | assists_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: assist rate: the share of teammates' made field goals the player assisted while on the court. |
#' | blocked_percentage | double | block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | blocked_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | blocked_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: block rate: blocks as a share of the opponent's two-point attempts while the player is on the court (site definition). |
#' | cn_alias | character | Player name (Chinese). |
#' | field_goals_at_rim_percentage | character | At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | field_goals_at_rim_percentage_rank | character | Unobserved: null in every sample. When filled: colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. |
#' | field_goals_at_rim_percentage_sort | character | Unobserved: null in every sample. When filled: unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: At-the-rim ((Chinese text), inside the restricted area (Chinese text)) field goals as the string 'made/attempted'. |
#' | field_goals_mid_percentage | character | Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | field_goals_mid_percentage_rank | character | Unobserved: null in every sample. When filled: colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. |
#' | field_goals_mid_percentage_sort | character | Unobserved: null in every sample. When filled: unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: Mid-range ((Chinese text), two-point shots outside the restricted area) field goals as the string 'made/attempted'. |
#' | game_start | integer | Starter flag: 1 = started the game. |
#' | is_color | integer | Highlight flag, 1 on every sampled row (unverified meaning; the site uses it to colour the row). |
#' | number | character | Jersey number as a string. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_times | integer | 0 on every sampled row; meaning unverified (a games-played slot the game route does not fill). |
#' | position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | rebounds_defensive_percentage | double | defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | rebounds_defensive_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | rebounds_defensive_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: defensive-rebound rate: the player's defensive rebounds as a share of the defensive rebounds available while he is on the court (site definition). |
#' | rebounds_offensive_percentage | double | offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | rebounds_offensive_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | rebounds_offensive_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: offensive-rebound rate: the player's offensive rebounds as a share of the offensive rebounds available while he is on the court (site definition). |
#' | steals_percentage | double | steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | steals_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | steals_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: steal rate: steals as a share of the opponent's possessions while the player is on the court (site definition). |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | true_shooting_percentage | double | true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | true_shooting_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | true_shooting_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: true-shooting percentage: scoring efficiency counting field goals and free throws, all attempts converted to two-point attempts. |
#' | turn_share | double | 'possession share': the share of the team's possessions the player ends while on the court. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | turn_share_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: 'possession share': the share of the team's possessions the player ends while on the court. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | turn_share_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: 'possession share': the share of the team's possessions the player ends while on the court. |
#' | turnovers_percentage | double | turnover rate: the share of the player's possession-ending plays that are turnovers. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | turnovers_percentage_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: turnover rate: the share of the player's possession-ending plays that are turnovers. Null on every row of some eras: the 2017-18 and 2009-10 samples have no Rank values, and the at-rim / mid-range strings are null in 2009-10 and '0/0' strings in 2025-26. |
#' | turnovers_percentage_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: turnover rate: the share of the player's possession-ending plays that are turnovers. |
#' | type | integer | Side flag: 0 on every home row, 1 on every visiting row (differs from best_quota, where the visiting side is 2). |
#' | up_time | integer | Time on court in SECONDS (1692 = 28:12). |
#' @eval .intl_details(.cba_seasons_details, "cba_player_advanced(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player (deduplicated on player_id, first row kept). An empty valid answer is a
#'   zero-row tibble with these columns, in this order (sdv-py `cba_player_extras`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | cn_alias | character | Player name (Chinese). |
#' | dunks_points | integer | points scored on dunks. |
#' | fast_break_points | integer | fast-break points scored by the player. |
#' | field_goals_at_rim_made | integer | points scored in the paint (the site's own column title). The field name says 'made' but the value is a POINTS count: it exceeds field goals made for 15 of 65 sampled players (e.g. 10 against 9 field goals made, 28 points). |
#' | game_start | integer | Starter flag: 1 = started the game. |
#' | number | character | Jersey number as a string. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | up_time | integer | Time on court in SECONDS. |
#' @eval .intl_details(.cba_seasons_details, "cba_player_extras(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per team; a team-season table of the previous season, not game data. An empty
#'   valid answer is a zero-row tibble with these columns, in this order (sdv-py `cba_game_team_four`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | effective_hit_rate | double | effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | free_throw_rate | double | free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | loss_average | double | League-average losses; 0.0 in every sample. |
#' | loss_num | integer | Losses of the team in the table's season. |
#' | offensive_rebound_rate | double | offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_effective_hit_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_free_throw_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_offensive_rebound_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_points_hundred_round | double | points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_points_hundred_round_average | double | League average of the metric. Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_turnovers_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | other_turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | other_turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | points_hundred_round | double | points scored per 100 possessions (offensive rating). |
#' | points_hundred_round_average | double | League average of the metric. Metric: points scored per 100 possessions (offensive rating). |
#' | points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points scored per 100 possessions (offensive rating). |
#' | rhythm | double | pace: possessions per 48 minutes. |
#' | rhythm_num | double | Pace; same value as rhythm. A number (the API sends it as display text). |
#' | rhythm_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: pace: possessions per 48 minutes. |
#' | schedule_season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. The season of this table: one before the game's season (2025 game -> 2024). |
#' | season | integer | Season of the table ('2024' = the START year of 2024-25; sdv END year = value + 1); equals scheduleSeason. NOT the season of the game: the table is the PREVIOUS season's. An integer (the API sends it as digit text). |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in the table's season (can differ from the game's: in the 2016 table of a 2017 Sichuan game). |
#' | turnovers_rate | double | turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | win_num | integer | Wins of the team in the table's season (regular season). |
#' | win_points_hundred_round | double | net points per 100 possessions. |
#' | win_points_hundred_round_average | double | League average of the metric. Metric: net points per 100 possessions. |
#' | wine_average | double | League-average wins (field name sic); 0.0 in every sample. |
#' @eval .intl_details(.cba_seasons_details, "cba_game_team_four(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per side with the star player's line. An empty valid answer is a zero-row tibble
#'   with these columns, in this order (sdv-py `cba_best_player`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | assists | integer | Assists by the player in this game. |
#' | blocked | integer | Blocks by the player in this game. |
#' | fouls | integer | Personal fouls by the player in this game. |
#' | free_throw_str | character | Free throws as the string 'made/attempted'. |
#' | minutes | integer | Minutes played (whole minutes). |
#' | number | character | Jersey number as a string. |
#' | player_img | character | Absolute URL of the player's photo; null when there is none. |
#' | player_name | character | Full player name (Chinese, may include the first name: (Chinese text)). Null on some rows (the short name is in playerNameStr). |
#' | player_name_str | character | Short display name (Chinese surname form: (Chinese text)). |
#' | points | integer | Points scored by the player in this game. |
#' | real_point_rate | double | true-shooting percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' | rebounds | integer | Total rebounds by the player in this game. |
#' | steals | integer | Steals by the player in this game. |
#' | three_points_str | character | Three-point field goals as the string 'made/attempted'. |
#' | turn_share | double | possession share (see advance-count turnShare). A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' | turnovers | integer | Turnovers by the player in this game. |
#' | two_points_str | character | Two-point field goals as the string 'made/attempted' ('3/5'). |
#' @eval .intl_details(.cba_seasons_details, "cba_best_player(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per side and category. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_best_stats`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | ctype | character | Statistic the row leads: points, assists, steals, rebounds, blocked (five rows per side in every sample). See the code table. |
#' | cvalue | character | The leader's value of ctype, as a STRING ('16'). |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. A STRING here ('100005271'), an integer on every box route. |
#' | player_name | character | Player name (Chinese). Null on rows whose name the report does not repeat (the same player's earlier row carries it). |
#' | player_no | character | Jersey number as a string. Null where playerName is null. |
#' | seconds | integer | The leader's time on court in SECONDS. |
#' | team_id | integer | Unobserved: null in every sample (the side is the enclosing list). |
#' | type | integer | Side flag: 0 on home rows, 2 on visiting rows (differs from advance-count, where the visiting side is 1). |
#' @eval .intl_details(.cba_seasons_details, "cba_best_stats(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per registered player (season registration, not the game box). An empty valid
#'   answer is a zero-row tibble with these columns, in this order (sdv-py `cba_rosters`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | side | character | Side of the game the row belongs to: home (the API's host / home block) or away (guest / visiting block). |
#' | age | integer | Age in years as registered (0 on every sampled row: not maintained). |
#' | birth_date | character | Date of birth 'YYYY-MM-DD'. A public player bio field of the roster (kept; officials' and coaches' dates would be redacted by the capture). |
#' | body_data | character | JSON string of physical-testing results as the league stores it (wingspan, standing reach, vertical reach, hand size); null where not tested. |
#' | cn_alias | character | Player short name (Chinese). |
#' | cn_alias_show | character | Display name (Chinese); '---' for a placeholder row. |
#' | cn_name | character | Player full name (Chinese; may include a first-name form for foreigners). |
#' | created_date | character | Audit field: row creation time 'YYYY-MM-DD HH:MM:SS'. |
#' | first_name | character | Given name in Latin letters as registered, in capitals (e.g. 'CAI S.L.S.'). |
#' | height | integer | Height in cm (integer). |
#' | id | character | Internal row id of the (player, team, season) registration, a 19-digit integer beyond 2^53: read it as a string/int64, never as a JS number. Not the playerId. |
#' | is_captain | logical | Team captain flag (false on every sampled row). |
#' | is_delete | logical | Soft-delete flag (false on every sampled row). |
#' | is_injury | logical | Injury flag (false on every sampled row). |
#' | is_three | integer | Flag, 2 on every sampled row; meaning unverified. |
#' | last_modified_date | character | Audit field: last modification time; null on rows never modified. |
#' | last_name | character | Family name in Latin letters; '' when none, and null on some older rows. |
#' | match_type_id | integer | Match type id (1 = regular season) of the registration. |
#' | nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
#' | number | character | Jersey number as a string. |
#' | player_cba_id | integer | A registration id from the league's own system (e.g. 502672); 0 when unset (27 of 101 sampled rows). Not the playerId (unverified beyond that). |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_pic | character | Absolute URL of the player's photo; null when there is none. |
#' | position | character | Position code as registered: SG, SF, PG, PF, C and their '/' pairs, or the coarse G (guard) / F (forward) on older rows (see positionDescription). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_description | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_string | character | Unobserved: null in every sample. |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | season_id | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. Same value as season. |
#' | season_name | character | Unobserved: null in every sample. |
#' | season_year | character | Unobserved: null in every sample. |
#' | team_cba_id | integer | teamId again as an integer (29128); meaning unverified beyond equalling team_id in the sample. |
#' | team_cn_alias | character | Team short name (Chinese) in that season. |
#' | team_cn_name | character | Team full legal name (Chinese), e.g. 'Zhejiang Guangsha Lions Club Zheshang Securities basketball team'. |
#' | team_en_alias | character | Team code or English city name as registered: a three-letter code on recent rows ('ZGL', 'SBW'), an English city name on older ones ('Guangdong', 'Sichuan'), '' when none. |
#' | team_en_name | character | Team English name as the league registers it (the sample reads 'GUANG SHA'). |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | weight | integer | Weight in kg (integer). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_rosters(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row with the is_report flag. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_report_status`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | is_report | logical | True when the game report page exists (equals schedules/day isReport == 1 in every sample). |
#' @eval .intl_details(.cba_seasons_details, "cba_report_status(schedule_id = 100105799)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per play, oldest first, all periods. An empty valid answer is a zero-row tibble
#'   with these columns, in this order (sdv-py `cba_pbp`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | bt_textual_format | character | Second copy of the description; equal to textualFormat on every sampled row (unverified difference). |
#' | color | character | Hex colour of the acting team (homeColor or visitingColor). |
#' | distance | character | Unobserved: null in every sample (a shot distance slot). The API has NO shot x/y coordinates. |
#' | home_color | character | Home team colour '#RRGGBB'. |
#' | home_score | integer | Home team points after the play. NOT monotone row by row: a substitution row can carry a stale score (2017 game, Q1 0:40); the game's final score is the maximum. |
#' | minutes | integer | Game clock, minutes REMAINING in the period (counts down: 10 or 12 at the start, depending on the era). |
#' | player_cn_names | character | Names (Chinese surnames/short names) of the players in textualFormat, in order of mention (shooter or fouler first, then assister, rebounder or fouled player). 0-3 names. There are NO player ids in the play-by-play. |
#' | player_fouls | character | Unobserved: null in every sample (a player's fouls slot). |
#' | player_score | character | Unobserved: null in every sample (a player's points slot). |
#' | quarter_num | integer | Period of the row (1-4; 5+ would be overtime). Equals the request's quarterNum on every row. |
#' | seconds | integer | Game clock, seconds remaining within the minute. |
#' | team_cn_alias1 | character | Unobserved: null in every sample (a team-name slot). |
#' | team_cn_alias2 | character | Unobserved: null in every sample (a team-name slot). |
#' | team_cn_alias3 | character | Unobserved: null in every sample (a team-name slot). |
#' | textual_format | character | Play description sentence (Chinese) naming the players; the phrase glossary translates every form seen. Team names inside it can be a different era's name than the game header (a 2025-26 text reads (Chinese text)). Sentence forms (`{P}` a player, `{T}` a team): `{T}``{T}` substitution, `{P}` replaces `{P}`; `{P}` three-point jump shot, misses, `{P}` gets the defensive rebound; `{P}` layup (driving), scores; `{P}` takes two free throws, free throw 2 made; (Chinese text) (Chinese text) = `{P}` shooting foul on the opponent's shot (drawn by an unnamed player); `{P}` receives an assist from `{P}`, jump shot, three-pointer made; the full glossary is in cba_glossary.yaml. |
#' | type | integer | Team the play belongs to: 1 = home, 2 = visiting (checked on all 667 rows of two games: color equals homeColor when 1 and visitingColor when 2). See the code table. |
#' | visiting_color | character | Visiting team colour '#RRGGBB'. |
#' | visitor_score | integer | Visiting team points after the play (same caveat as homeScore). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_pbp(schedule_id = 100105799))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per match type. An empty valid answer is a zero-row tibble with these columns, in
#'   this order (sdv-py `cba_team_counts`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | key | character | Match type id as a string ('1' regular season, '2' playoffs); see getMatchType. |
#' | value | integer | Number of teams in that match type in the requested season (inferred: 20 for key '1' in 2025, equal to the 2025 getTeam list length; the playoff count is smaller). |
#' @eval .intl_details(.cba_seasons_details, "cba_team_counts(season = 2026)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per season of the team. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_team_basic`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | assists | double | Assists, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | blocked | double | Blocks, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | cba_rank | character | Unobserved: null in every sample (a league-rank slot). |
#' | field_goals | double | Field goals made, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | field_goals_attempted | double | Field goals attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | field_goals_percentage_rate | double | Field-goal percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' | fouls | double | Personal fouls, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | free_throws | double | Free throws made, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | free_throws_attempted | double | Free throws attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | free_throws_percentage_rate | double | Free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' | losses_number | integer | Losses (Chinese text). (as the API names it) |
#' | points | double | Points, formatted by statisticalDimension (1 per-game average, 2 season total, 3 and 4 per 100 possessions: both give the same values, 120.1 = boutPoints). A number (the API sends it as display text). |
#' | real_player_times | integer | Games counted for the averages ((Chinese text) by its name); equals scheduleNumber in the sample except in short seasons (unverified). |
#' | rebounds | double | Total rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | rebounds_defensive | double | Defensive rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | rebounds_offensive | double | Offensive rebounds, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | round | double | Possessions in the season (Chinese text) as a float (4074.09); identical for statisticalDimension 1-4. |
#' | schedule_number | integer | Games played in that season and match type (Chinese text). |
#' | schedule_season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
#' | season | character | Season label 'YYYY-YYYY' as a string ('2024-2025' = start year - end year; the sdv END year is the second one); scheduleSeason is the numeric START year. |
#' | steals | double | Steals, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in that season; changes with the sponsor (the sampled team 29128 has 9 different names across 20 seasons). Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | three_point_attempted | double | Three-pointers attempted, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | three_point_goals | double | Three-pointers made, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | three_point_percentage_rate | double | Three-point percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' | time | double | Team minutes per game (statisticalDimension 1) or in total (2). A number (the API sends it as display text). |
#' | turnovers | double | Turnovers, formatted by statisticalDimension. A number (the API sends it as display text). |
#' | win_number | integer | Wins (Chinese text). (as the API names it) |
#' | win_rate | double | Win rate (Chinese text). A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_team_basic(team_id = 29128))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per season of the team. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_team_four`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | effective_hit_rate | double | effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | effective_hit_sort | double | Unformatted fraction 0-1 behind effectiveHitRate. |
#' | field_goals | integer | Field goals made in the season (sum). |
#' | field_goals_attempted | integer | Field goals attempted in the season (sum). |
#' | free_throw_rate | double | free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | free_throw_sort | double | Unformatted fraction 0-1 behind freeThrowRate. |
#' | free_throws | integer | Free throws made in the season (sum). |
#' | loss_average | double | League-average losses; 0.0 in every sample. |
#' | loss_num | integer | Losses in that season. |
#' | offensive_rebound_rate | double | offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | offensive_rebound_sort | double | Unformatted fraction 0-1 behind offensiveReboundRate. |
#' | other_effective_hit_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_effective_hit_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_effective_hit_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): effective field-goal percentage, in PERCENT as a number (53.6 = 53.6%). |
#' | other_effective_hit_sort | double | Unformatted fraction 0-1 behind otherEffectiveHitRate. |
#' | other_field_goals | integer | Field goals made by the team's opponents (sum). |
#' | other_field_goals_attempted | integer | Field goals attempted by the opponents (sum). |
#' | other_free_throw_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_free_throw_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_free_throw_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): free-throw rate: free throws made relative to field-goal attempts, in percent as a number. |
#' | other_free_throw_sort | double | Unformatted fraction 0-1 behind otherFreeThrowRate. |
#' | other_free_throws | integer | Free throws made by the opponents (sum). |
#' | other_offensive_rebound_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_offensive_rebound_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_offensive_rebound_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): offensive-rebound rate: the team's offensive rebounds as a share of all offensive-rebound chances, in percent as a number (site definition). |
#' | other_offensive_rebound_sort | double | Unformatted fraction 0-1 behind otherOffensiveReboundRate. |
#' | other_points_hundred_round | double | points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_points_hundred_round_average | double | League average of the metric. Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points allowed per 100 possessions (defensive rating): the opponents' points per 100 possessions. |
#' | other_rebounds_defensive | integer | Defensive rebounds by the opponents (sum). |
#' | other_rebounds_offensive | integer | Offensive rebounds by the opponents (sum). |
#' | other_three_point_goals | integer | Three-pointers made by the opponents (sum). |
#' | other_turnovers | integer | Turnovers by the opponents (sum). |
#' | other_turnovers_rate | double | The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | other_turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | other_turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: The same measure for the team's OPPONENTS (the site's 'other' block): turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | other_turnovers_sort | double | Unformatted fraction 0-1 behind otherTurnoversRate. |
#' | other_win_points_hundred_round | double | Net points per 100 possessions as seen from the opponents' side (the site's 'other' block). |
#' | points_hundred_round | double | points scored per 100 possessions (offensive rating). |
#' | points_hundred_round_average | double | League average of the metric. Metric: points scored per 100 possessions (offensive rating). |
#' | points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: points scored per 100 possessions (offensive rating). |
#' | rhythm | double | pace: possessions per 48 minutes. A number (the API sends it as display text). |
#' | rhythm_num | double | Unobserved: null in every sample (a numeric form of the pace; the schedule-four-elements route fills it). Typed Float64 like the family's other routes. |
#' | rhythm_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: pace: possessions per 48 minutes. |
#' | round | double | Possessions in the season (Chinese text), a float such as 2606.36. |
#' | round_jingque | double | Possessions in the season computed 'precisely' ((Chinese text) by its name); equals round in the sample (unverified difference). |
#' | schedule_season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
#' | season | integer | Season of the row ('2025' = the START year of 2025-26; sdv END year = value + 1); equals scheduleSeason. An integer (the API sends it as digit text). |
#' | self_rebounds_defensive | integer | Defensive rebounds by the team in the season (sum). |
#' | self_rebounds_offensive | integer | Offensive rebounds by the team in the season (sum). |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | three_point_goals | integer | Three-pointers made in the season (sum). |
#' | total_minute | integer | Team minutes played in the season (sum, 1440 = 30 games x 48). |
#' | total_other_points | integer | Points the team's opponents scored in the season (sum). |
#' | total_points | integer | Points the team scored in the season (sum). |
#' | turnovers | integer | Turnovers in the season (sum). |
#' | turnovers_rate | double | turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | turnovers_rate_average | character | Unobserved: null in every sample. When filled: league average of the metric. Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | turnovers_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: turnover rate: the share of the team's possessions ending in a turnover, in percent as a number (site definition). |
#' | turnovers_sort | double | Unformatted fraction 0-1 behind turnoversRate. |
#' | win_num | integer | Wins in that season (regular season for matchTypeId 1). |
#' | win_points_hundred_round | double | net points per 100 possessions. |
#' | win_points_hundred_round_average | double | League average of the metric. Metric: net points per 100 possessions. |
#' | win_points_hundred_round_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: net points per 100 possessions. |
#' | wine_average | double | League-average wins (field name sic); 0.0 in every sample. |
#' @eval .intl_details(.cba_seasons_details, "cba_team_four(team_id = 29128)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per season of the team. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_team_overview`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | bout_no_points | double | points allowed per 100 possessions (defensive rating), a float. |
#' | bout_no_points_rank | double | Rank among the teams of that season for boutNoPoints (integer-valued float; direction undocumented). |
#' | bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind boutNoPoints). |
#' | bout_point_sort | double | Unobserved: null in every sample (numeric value behind boutPoints). |
#' | bout_points | double | points scored per 100 possessions (offensive rating), a float (120.1). |
#' | bout_points_rank | double | Rank among the teams of that season for boutPoints (integer-valued float; direction undocumented). |
#' | bout_subtract_points | double | net points per 100 possessions (boutPoints - boutNoPoints), a float. |
#' | bout_subtract_points_rank | double | Rank among the teams of that season for boutSubtractPoints (integer-valued float). |
#' | bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind boutSubtractPoints). |
#' | is_avg | integer | Row kind: 2 on every sampled row = a team's own row (1 presumed league average, unobserved). |
#' | loss_num | double | Losses in that season, a float. |
#' | player_times | double | Games played, a float (42.0). |
#' | rhythm | double | pace: possessions per 48 minutes ('75.7'; site definition: (Chinese text)48(Chinese text)). A number (the API sends it as display text). |
#' | rhythm_rank | double | Unobserved: null in every sample (a rank slot for pace). Typed Float64 like the family's other routes. |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. One row per season of the team. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | win_num | double | Wins in that season (match type of the request), a number typed as float (33.0). |
#' | win_rate | double | Win rate. A FRACTION 0-1 (the API sends a percent string such as '39.4%'). |
#' @eval .intl_details(.cba_seasons_details, "cba_team_overview(team_id = 29128)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per season of the team. An empty valid answer is a zero-row tibble with these
#'   columns, in this order (sdv-py `cba_team_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | bout_no_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points allowed per 100 possessions). Typed Float64 like the family's other routes. |
#' | bout_point_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) points per 100 possessions). Typed Float64 like the family's other routes. |
#' | bout_subtract_points_sort | double | Unobserved: null in every sample (numeric value behind (Chinese text) net points per 100 possessions). Typed Float64 like the family's other routes. |
#' | guard_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_hit_at_rim_made_rate | double | at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_hit_middle_rate | double | mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | guard_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_goals_rate | double | three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | guard_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | guard_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the shots of the OPPONENTS against this team ((Chinese text), defence; the 'guard' prefix is inferred from the site's (Chinese text) offence/defence toggle). |
#' | is_avg | integer | Row kind: 2 on every sampled row = a team's own row; 1 is presumed to mark a league-average row but is unobserved. |
#' | num | double | Games the profile covers (the site's 'games'), e.g. 42.0; a number typed as float. |
#' | offensive_field_goals_at_rim | double | at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_field_goals_at_rim_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_field_goals_at_rim_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim share: the share of field-goal attempts taken at the rim (inside the restricted area (Chinese text)), for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_hit_at_rim_made_rate | double | at-rim shooting percentage, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_hit_at_rim_made_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_hit_at_rim_made_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: at-rim shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_hit_middle_rate | double | mid-range shooting percentage, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_hit_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_hit_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range shooting percentage, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_middle_rate | double | mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence).. Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_middle_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_middle_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: mid-range share: the share of field-goal attempts that are two-pointers outside the restricted area, for the team's own shots ((Chinese text), offence). Null for the seasons 2006-2016 (sampled team 29128): the at-rim and mid-range zone splits start with 2017-18. |
#' | offensive_real_point | double | effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_real_point_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
#' | offensive_real_point_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: effective field-goal percentage (all field goals counted as two-point attempts), for the team's own shots ((Chinese text), offence). |
#' | offensive_three_goals_rate | double | three-point shooting percentage, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_three_goals_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_goals_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point shooting percentage, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_rate | double | three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | offensive_three_rate_rank | double | Rank among the teams of that season (integer-valued number; direction per metric undocumented). Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
#' | offensive_three_rate_sort | double | Unformatted fraction 0-1 behind the formatted string of the metric. Metric: three-point share: the share of field-goal attempts that are three-pointers, for the team's own shots ((Chinese text), offence). |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | team_name | character | Team name (Chinese) in that season; changes with the sponsor. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' @eval .intl_details(.cba_seasons_details, "cba_team_shots(team_id = 29128)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player of the requested page. An empty valid answer is a zero-row tibble with
#'   these columns, in this order (sdv-py `cba_player_base`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | age | integer | Age in years in that season. |
#' | assists | double | Assists per game when countRanger is 1. A number (the API sends it as display text). |
#' | birth_date | character | Date of birth 'YYYY-MM-DD' (a public player bio field; midnight-suffixed 'YYYY-MM-DD 00:00:00' on player-base-list). |
#' | blocked | double | Blocks per game when countRanger is 1. A number (the API sends it as display text). |
#' | cn_alias | character | Player name (Chinese). Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | field_goals | double | Field goals made per game when countRanger is 1. A number (the API sends it as display text). |
#' | field_goals_at_rim_attempted | double | At-the-rim (inside the restricted area) field goals attempted in the season (total), a float. |
#' | field_goals_at_rim_made | double | At-the-rim field goals made in the season (total), a float. |
#' | field_goals_attempted | double | Field goals attempted per game when countRanger is 1. A number (the API sends it as display text). |
#' | field_goals_mid_range_attempted | double | Mid-range (two-point shots outside the restricted area) field goals attempted in the season (total), a float. |
#' | field_goals_mid_range_made | double | Mid-range field goals made in the season (total), a float. |
#' | field_goals_percentage | double | Field-goal percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | field_goals_percentage_sort | double | Field-goal percentage as a FRACTION 0-1 for sorting. |
#' | fouls | double | Personal fouls per game when countRanger is 1. A number (the API sends it as display text). |
#' | fouls_defensive | double | Defensive personal fouls in the season (total), a float. |
#' | free_throws | double | Free throws made per game when countRanger is 1. A number (the API sends it as display text). |
#' | free_throws_attempted | double | Free throws attempted per game when countRanger is 1. A number (the API sends it as display text). |
#' | free_throws_percentage | double | Free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | free_throws_percentage_sort | double | Free-throw percentage as a FRACTION 0-1 for sorting. |
#' | game_start_num | integer | Games started (Chinese text). |
#' | minutes | double | Minutes: per game; a whole-season total integer on the offensive/defensive/shot lists (827). A number (the API sends it as display text). |
#' | nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
#' | number | character | Jersey number as a string. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_times | double | Games played (Chinese text), a float (39.0). |
#' | player_times2 | character | Unobserved: null in every sample. |
#' | points | double | Points per game when countRanger is 1 (the request value); other countRanger values change the unit (2 total, 3 per 36 minutes, 4 per 100 possessions). A number (the API sends it as display text). |
#' | position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
#' | rank_sort | character | Unobserved: null in every sample. |
#' | rebounds | double | Total rebounds per game when countRanger is 1. A number (the API sends it as display text). |
#' | rebounds_defensive | double | Defensive rebounds per game when countRanger is 1. A number (the API sends it as display text). |
#' | rebounds_offensive | double | Offensive rebounds per game when countRanger is 1. A number (the API sends it as display text). |
#' | schedule_id | integer | CBA game id (key space: CBA games, ONE global 9-digit sequence 100xxxxxx across seasons and match types; the `{scheduleId}` of every game route). Stamped by the runtime from the request; null on a body parsed without it. |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | seconds | double | Seconds: per-game average; a whole-season total integer elsewhere. A number (the API sends it as display text). |
#' | steals | double | Steals per game when countRanger is 1. A number (the API sends it as display text). |
#' | team_cn_alias | character | Team short name (Chinese) in that season. Names change with the sponsor, the id does not; teamId -> English glossary in cba_glossary.yaml. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | three_point_attempted | double | Three-pointers attempted per game when countRanger is 1. A number (the API sends it as display text). |
#' | three_point_goals | double | Three-pointers made per game when countRanger is 1. A number (the API sends it as display text). |
#' | three_point_percentage | double | Three-point percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | three_point_percentage_sort | double | Three-point percentage as a FRACTION 0-1 for sorting. |
#' | turnovers | double | Turnovers per game when countRanger is 1. A number (the API sends it as display text). |
#' @inherit cba_seasons details
#' @examples
#' \donttest{
#'   try(cba_player_base(season = 2026, team_id = 29128))
#' }
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player of the requested page. An empty valid answer is a zero-row tibble with
#'   these columns, in this order (sdv-py `cba_player_offensive`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | age | integer | Age in years in that season. |
#' | assists | integer | Assists in the season (total, integer). |
#' | assists_rate | double | assist rate (site definition, as assistsPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | assists_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: assist rate (site definition, as assistsPercentage). |
#' | assists_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: assist rate (site definition, as assistsPercentage). |
#' | assists_round_rate | double | assist rate divided by possession share. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | assists_round_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: assist rate divided by possession share. |
#' | assists_round_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: assist rate divided by possession share. |
#' | birth_date | character | Date of birth 'YYYY-MM-DD' (a public player bio field; midnight-suffixed 'YYYY-MM-DD 00:00:00' on player-base-list). |
#' | field_goals_attempted | integer | Field goals attempted in the season (total, integer). |
#' | first_position | character | Primary position label (Chinese; see position for the label set). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | free_throws | integer | Free throws made in the season (total, integer). |
#' | is_color | integer | Highlight flag, 1 or 2 (unverified meaning). |
#' | minutes | integer | Minutes played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
#' | number | character | Jersey number as a string. |
#' | play_times | integer | Games played (Chinese text), integer. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_name | character | Player name (Chinese). |
#' | position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
#' | rank | character | Unobserved: null in every sample (a row-rank slot; the site numbers rows itself). |
#' | real_rate | double | true-shooting percentage (site definition, as trueShootingPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | real_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: true-shooting percentage (site definition, as trueShootingPercentage). |
#' | real_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: true-shooting percentage (site definition, as trueShootingPercentage). |
#' | round_rate | double | 'possession share': the share of the team's possessions the player ends while on the court (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | round_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: 'possession share': the share of the team's possessions the player ends while on the court (site definition). |
#' | round_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: 'possession share': the share of the team's possessions the player ends while on the court (site definition). |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | seconds | integer | Seconds played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | team_cn_alias | character | Team short name (Chinese) in that season. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | turnovers | integer | Turnovers in the season (total, integer). |
#' | turnovers_rate | double | turnover rate: for a player, the share of his possession-ending plays that are turnovers; for a team, the share of the team's possessions ending in a turnover (site definitions). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | turnovers_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: turnover rate: for a player, the share of his possession-ending plays that are turnovers; for a team, the share of the team's possessions ending in a turnover (site definitions). |
#' | turnovers_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: turnover rate: for a player, the share of his possession-ending plays that are turnovers; for a team, the share of the team's possessions ending in a turnover (site definitions). |
#' @eval .intl_details(.cba_seasons_details, "cba_player_offensive(season = 2026, team_id = 29128)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player of the requested page. An empty valid answer is a zero-row tibble with
#'   these columns, in this order (sdv-py `cba_player_defensive`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | age | integer | Age in years in that season. |
#' | blocked_rate | double | block rate (site definition, as blockedPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | blocked_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: block rate (site definition, as blockedPercentage). |
#' | blocked_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: block rate (site definition, as blockedPercentage). |
#' | first_position | character | Primary position label (Chinese; see position for the label set). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | fouls_rate | double | foul rate: defensive fouls per 100 possessions. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | fouls_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: foul rate: defensive fouls per 100 possessions. |
#' | fouls_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: foul rate: defensive fouls per 100 possessions. |
#' | is_color | integer | Highlight flag, 1 or 2 (unverified meaning; the site uses it to colour the row). |
#' | minutes | integer | Minutes played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
#' | number | character | Jersey number as a string. |
#' | play_times | integer | Games played (Chinese text), integer. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_name | character | Player name (Chinese). |
#' | position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
#' | rank | character | Unobserved: null in every sample (a row-rank slot; the site numbers rows itself). |
#' | rebounds_defensive_rate | double | defensive-rebound rate (site definition, as reboundsDefensivePercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | rebounds_defensive_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: defensive-rebound rate (site definition, as reboundsDefensivePercentage). |
#' | rebounds_defensive_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: defensive-rebound rate (site definition, as reboundsDefensivePercentage). |
#' | rebounds_offensive_rate | double | offensive-rebound rate (site definition, as reboundsOffensivePercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | rebounds_offensive_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: offensive-rebound rate (site definition, as reboundsOffensivePercentage). |
#' | rebounds_offensive_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: offensive-rebound rate (site definition, as reboundsOffensivePercentage). |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | seconds | integer | Seconds played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | steals_rate | double | steal rate (site definition, as stealsPercentage). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | steals_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: steal rate (site definition, as stealsPercentage). |
#' | steals_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: steal rate (site definition, as stealsPercentage). |
#' | team_cn_alias | character | Team short name (Chinese) in that season. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' @eval .intl_details(.cba_seasons_details, "cba_player_defensive(season = 2026, team_id = 29128)")
#' @export
#' @family CBA Functions
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
#' @return
#' A `hoopR_data` tibble: One row per player of the requested page. An empty valid answer is a zero-row tibble with
#'   these columns, in this order (sdv-py `cba_player_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | age | integer | Age in years in that season. |
#' | at_rim_made_rate | double | at-rim frequency: restricted-area attempts per 100 possessions. A number (the API sends it as display text). |
#' | at_rim_made_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: at-rim frequency: restricted-area attempts per 100 possessions. |
#' | at_rim_made_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: at-rim frequency: restricted-area attempts per 100 possessions. |
#' | first_position | character | Primary position label (Chinese; see position for the label set). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | free_rate | double | free-throw frequency: free-throw attempts per 100 possessions (site definition). A number (the API sends it as display text). |
#' | free_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: free-throw frequency: free-throw attempts per 100 possessions (site definition). |
#' | free_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: free-throw frequency: free-throw attempts per 100 possessions (site definition). |
#' | hit_at_rim_made_rate | double | at-rim shooting percentage: restricted-area field-goal percentage (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | hit_at_rim_made_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: at-rim shooting percentage: restricted-area field-goal percentage (site definition). |
#' | hit_at_rim_made_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: at-rim shooting percentage: restricted-area field-goal percentage (site definition). |
#' | hit_free_rate | double | free-throw percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | hit_free_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: free-throw percentage. |
#' | hit_free_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: free-throw percentage. |
#' | hit_middle_rate | double | mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | hit_middle_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). |
#' | hit_middle_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: mid-range shooting percentage: percentage on two-point attempts outside the restricted area (site definition). |
#' | hit_rate | double | effective field-goal percentage: all field-goal attempts converted to two-point attempts. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | hit_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: effective field-goal percentage: all field-goal attempts converted to two-point attempts. |
#' | hit_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: effective field-goal percentage: all field-goal attempts converted to two-point attempts. |
#' | hit_three_rate | double | three-point shooting percentage. A FRACTION 0-1 (the API sends a percent string such as '39.4%'; the _sort column holds the same fraction). |
#' | hit_three_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: three-point shooting percentage. |
#' | hit_three_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: three-point shooting percentage. |
#' | is_color | integer | Highlight flag, 1 or 2 (unverified meaning; the site uses it to colour the row). |
#' | middle_rate | double | mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). A number (the API sends it as display text). |
#' | middle_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). |
#' | middle_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: mid-range frequency: two-point attempts outside the restricted area per 100 possessions (site definition). |
#' | minutes | integer | Minutes played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | nationality | character | Nationality (Chinese country name; see the nationality code table for every value seen and its English name). Chinese country names seen: China; United States; Canada; France; Chinese Taipei; Iran; Nigeria; Jordan. |
#' | number | character | Jersey number as a string. |
#' | play_times | integer | Games played (Chinese text), integer. |
#' | player_id | integer | playerId (key space: CBA persons, stable across seasons and clubs; 3-9 digits, older players have short ids (393433) and newer ones 100xxxxxx). Joins the player box routes, the season player lists and getPlayersByScheduleId. Not a team id. |
#' | player_name | character | Player name (Chinese). |
#' | position | character | Position label (Chinese). Eras differ: coarse (Chinese text) (guard) / (Chinese text) (forward) / (Chinese text) (center) in older seasons, five-way (Chinese text) (point guard) / (Chinese text) (shooting guard) / (Chinese text) (small forward) / (Chinese text) (power forward) / (Chinese text) (center) in newer ones; dual positions are joined with '/' (e.g. (Chinese text)). Label glosses: C = (Chinese text); C/PF = (Chinese text); F = (Chinese text); G = (Chinese text); PF = (Chinese text); PF/C = (Chinese text); PF/SF = (Chinese text); PG = (Chinese text); PG/SG = (Chinese text); SF = (Chinese text); SF/PF = (Chinese text); SF/SG = (Chinese text); SG = (Chinese text); SG/PG = (Chinese text); SG/SF = (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text); (Chinese text). |
#' | position_num | double | Position as a number 1-5 (1 point guard, 2 shooting guard, 3 small forward, 4 power forward, 5 center); a fraction such as 4.5 averages a dual position; typed as float. |
#' | rank | character | Unobserved: null in every sample (a row-rank slot; the site numbers rows itself). |
#' | season | integer | Season START year (2025 = the 2025-26 season). The sdv season key is the END year = season + 1; map at the boundary. |
#' | seconds | integer | Seconds played in the season (whole-season total, integer; cba_player_base gives the per-game average). |
#' | team_cn_alias | character | Team short name (Chinese) in that season. |
#' | team_id | integer | teamId (key space: CBA clubs; 5 digits 29115-29140 for the long-standing clubs, 9 digits for newer ones (100074683 = Ningbo); stable across seasons and club renames, but the display name changes with the sponsor: 29128 = 'Zhejiang Guangsha' under many sponsor names, (Chinese text) in 2025-26). Joins getTeam / teamList and the team and player routes. Not a player or schedule id. |
#' | three_rate | double | three-point frequency: three-point attempts per 100 possessions (site definition). A number (the API sends it as display text). |
#' | three_rate_rank | double | Colour rank for the metric, a fraction 0-1 (1 = best, inverted for 'bad' statistics such as turnovers) that the site uses to colour the cell (inferred from the sample values; the base population is not documented). Metric: three-point frequency: three-point attempts per 100 possessions (site definition). |
#' | three_rate_sort | double | Unformatted numeric value behind the formatted string of the same metric (a fraction 0-1 for percentages), used by the site to sort the table. Metric: three-point frequency: three-point attempts per 100 possessions (site definition). |
#' @eval .intl_details(.cba_seasons_details, "cba_player_shots(season = 2026, team_id = 29128)")
#' @export
#' @family CBA Functions
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
