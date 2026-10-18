# tpbl.R -- TPBL (Taiwan Professional Basketball League) wrappers over api.tpbl.basketball, the Laravel
# JSON API behind tpbl.basketball, at parity with sdv-py sportsdataverse/basketball/tpbl (origin/main
# e3d232ebc9). Transport, season mapping and refusals: R/tpbl_runtime.R; frames and columns:
# R/tpbl_parsers.R. Roxygen generated from sdv-py's endpoint YAML and column descriptions.

# The @details of every tpbl topic that shares the tpbl_seasons() notes (roxygen @eval .intl_details()).
.tpbl_seasons_details <- c(
  "* Unofficial and unsupported: these are the routes the tpbl.basketball site's own front end calls on",
  "  api.tpbl.basketball (read from its JavaScript bundle). The API is keyless and needs no headers;",
  "  tpbl.basketball/robots.txt answers 200 with an empty body. The runtime waits at least 1 s before every request,",
  "  retries included. Payloads are not redistributed as release assets.",
  "* Coverage: three seasons so far (2024-25 = season 2025 to 2026-27 = season 2027). There is NO play-by-play",
  "  route; the two shot lists carry court coordinates only, with no shooter, game, quarter or time. Names (teams",
  "  with their sponsor, venues, players, referees) are Traditional Chinese; the column descriptions translate the",
  "  codes.",
  "* Seasons are END years (2026 = 2025-26). The API keys a season by its own small integer (1, 2, 3 = 2024-25,",
  "  2025-26, 2026-27); the runtime reads tpbl_seasons once per session and sends that id. A year the list lacks is",
  "  `hoopR_no_data`.",
  "* Ids: every route takes TPBL's own ids (season, division, team, game, player); the `gohoops_*` ids belong to",
  "  GoHoops, the stats platform behind the league, and are echoed beside them. The box score keys its players by",
  "  gohoops_roster_id (a person registered with one squad in one season), not by the TPBL player id: join",
  "  tpbl_box_players to tpbl_roster on gohoops_roster_id. Every id is an integer. tipoff is a POSIXct in",
  "  Asia/Taipei (the API sends naive Taiwan-local times).",
  "* Finished games only: the game wrappers first read the game detail (cached per session) and refuse",
  "  (`hoopR_asset_fetch`) a game that is not COMPLETED or still live; the box-score wrappers also refuse a stats",
  "  body whose teams (in home / away order), final scores, quarter count or player points disagree with it. The",
  "  season game list, the roster and the player game log are checked against the object asked for; the two shot",
  "  lists name no team, player or division in the body, so only their shape and court bounds are checked.",
  "  tpbl_games(verify = TRUE) also checks every division's completed games against its standings (falling back to",
  "  the team-filtered lists for a division whose standings answer empty, as the 2024-25 playoffs do).",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, a season the API does",
  "  not list, an empty list such as the standings of a playoff division), `hoopR_bad_request` (a non-integer id or",
  "  season, HTTP 400 / 422, an invalid verify or rounds, raised before the request where it can be) and",
  "  `hoopR_asset_fetch` (any other failure: a non-2xx after retries, a non-JSON body, an error envelope, an",
  "  unfinished game, a body that disagrees with the object asked for). HTTP 500 is retried on every route except",
  "  the player game log, where an unknown division_id answers 500 deterministically: it fails after one request.",
  "  Wrappers raise; they never warn and return an empty frame."
)

#' @title
#' **Get TPBL Seasons**
#' @description
#' Every TPBL season with its TPBL and GoHoops ids, label, status and date window.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/seasons`
#' @return
#' A `hoopR_data` tibble: Every TPBL season with its TPBL and GoHoops ids, label, status and date window. An empty
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_seasons`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year, read from the label '2024-2025' plus the Chinese word for season: 2025 for 2024-25. |
#' | season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. |
#' | gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. |
#' | name | character | Season label in Traditional Chinese: '2024-2025' plus the Chinese word for season. |
#' | status | character | Season status: COMPLETED or IN_PROGRESS. |
#' | started_at | character | Season start, 'YYYY-MM-DD 00:00:00' text. Preseason games can be played before it (the 2026-27 start is 2026-10-17, its first games were played 2026-10-09). |
#' | ended_at | character | Season end, 'YYYY-MM-DD 00:00:00' text (the planned end for a season in progress). |
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_seasons())
#' }
#' @export
#' @family TPBL Functions
tpbl_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  body <- .tpbl_seasons_body(call)
  .tpbl_out(.tpbl_parse_seasons(body), "Seasons")
}

#' @title
#' **Get TPBL Divisions**
#' @description
#' The divisions (preseason, regular season, play-in, playoffs, finals) of one season.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/events/{season}/divisions`
#' @param season Required. Season END year (2026 = the 2025-26 season; 2025 is the first). The API keys a season by
#'   its own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the same
#'   number): the runtime reads /seasons once and sends that id, so the example URL shows the year. A year the list
#'   lacks raises `hoopR_no_data`.
#' @return
#' A `hoopR_data` tibble: The divisions (preseason, regular season, play-in, playoffs, finals) of one season. An
#'   empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_divisions`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
#' | season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
#' | gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. |
#' | name | character | Division name (Traditional Chinese: preseason (warm-up games), regular season, postseason challenge (play-in round), playoffs, finals). |
#' | status | character | Division status: COMPLETED or IN_PROGRESS. |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_divisions(season = 2026)")
#' @export
#' @family TPBL Functions
tpbl_divisions <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_season_route(season, "divisions", call = call)
  .tpbl_out(.tpbl_parse_divisions(res$body, res$req), "Divisions")
}

#' @title
#' **Get TPBL Teams**
#' @description
#' The teams of one season (bracket placeholders flagged).
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/events/{season}/teams`
#' @param season Required. Season END year (2026 = the 2025-26 season; 2025 is the first). The API keys a season by
#'   its own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the same
#'   number): the runtime reads /seasons once and sends that id, so the example URL shows the year. A year the list
#'   lacks raises `hoopR_no_data`.
#' @return
#' A `hoopR_data` tibble: The teams of one season (bracket placeholders flagged). An empty answer raises
#'   `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
#' | season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | name | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | is_real_team | logical | True for a real club; false for a bracket placeholder (67 higher-seed team, 68 lower-seed team in 2025-26). |
#' | status | character | Team status. 'ACTIVE' is the only value seen in every sampled route; the full set of statuses is unknown. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_teams(season = 2026))
#' }
#' @export
#' @family TPBL Functions
tpbl_teams <- function(season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_season_route(season, "teams", call = call)
  .tpbl_out(.tpbl_parse_teams(res$body, res$req), "Teams")
}

#' @title
#' **Get TPBL Games**
#' @description
#' Every game of one season, all divisions, played and scheduled, with teams, venue, status and score.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/seasons/{season}/games`
#' @param season Required. Season END year (2026 = the 2025-26 season; 2025 is the first). The API keys a season by
#'   its own small integer (1, 2, 3 = 2024-25, 2025-26, 2026-27; the event id of `/events/{id}/*` is the same
#'   number): the runtime reads /seasons once and sends that id, so the example URL shows the year. A year the list
#'   lacks raises `hoopR_no_data`.
#' @param team_id TPBL team id (2-8): keep only that team's games (the API's own filter). Cannot be combined with
#'   `verify`. Default `NULL`: every team.
#' @param verify Default `NULL` (off). Cross-check the list for completeness: every division's completed games must
#'   equal the matches of its own standings (one extra request per division; a division whose standings are empty is
#'   checked against the team-filtered lists instead). A mismatch raises `hoopR_asset_fetch`.
#' @return
#' A `hoopR_data` tibble: Every game of one season, all divisions, played and scheduled, with teams, venue, status
#'   and score. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
#' | season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | gohoops_game_id | integer | GoHoops game id (key space: GoHoops games; 1242 for TPBL game 6). Not the TPBL game id. |
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
#' | gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. Read from the home team. |
#' | gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. Read from the home team. |
#' | code | character | Game code inside the division: the game number as text in the regular season ('1' ... '42'), a series label in the playoffs ('AG1' = series A game 1, 'G7' = finals game 7), '' for preseason games. |
#' | status | character | Game status. Observed: COMPLETED (finished) and NOT_STARTED (scheduled). A game in progress has is_live true. |
#' | is_live | logical | True while the game is being played; false for finished and scheduled games. |
#' | periods | integer | Number of quarters played: 4 for a regulation game, 5 for one overtime, 6 for two; 0 before tip-off. |
#' | game_date | Date | Game date (Taiwan local date). |
#' | game_day_of_week | character | Traditional Chinese weekday in parentheses: Mon, Tue, Wed, Thu, Fri, Sat, Sun. |
#' | game_time | character | Scheduled tip-off 'HH:MM:SS'. Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
#' | tipoff | POSIXct | Scheduled tip-off as a naive timestamp (no zone). Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
#' | venue | character | Venue name in Traditional Chinese (Xinzhuang Gymnasium, Heping Basketball Gymnasium, Taichung Intercontinental Mini Dome, Hsinchu County Gymnasium, Kaohsiung Arena, Taoyuan Arena). |
#' | attendance | integer | Attendance as an integer, parsed from the API's visitors string; null before the game, when the API sends none or on a postponed game. |
#' | home_team_id | integer | Home TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | home_gohoops_team_id | integer | Home GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | home_gohoops_squad_id | integer | Home GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | home_team | character | Home team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | home_alt_name | character | Home team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
#' | home_score | integer | Home team final score (points scored); null before tip-off. |
#' | away_team_id | integer | Away TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | away_gohoops_team_id | integer | Away GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | away_gohoops_squad_id | integer | Away GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | away_team | character | Away team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | away_alt_name | character | Away team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
#' | away_score | integer | Away team final score (points scored); null before tip-off. |
#' | recap_url | character | YouTube recap URL; null when the game has none (the list can omit it, the game detail carries it). |
#' | live_stream_url | character | YouTube live-stream URL of the game; null when the API omits it. |
#' | judgement_report_url | character | URL of the referees' judgement report (a Google Drive file); null when none. |
#' | ticket_url | character | URL of the ticket page; null on most rows. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_games(season = 2026))
#' }
#' @export
#' @family TPBL Functions
tpbl_games <- function(season, team_id = NULL, verify = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_season_route(season, "games", team_id = team_id, verify = verify, call = call)
  .tpbl_out(.tpbl_parse_games(res$body, res$req), "Games")
}

#' @title
#' **Get TPBL Standings**
#' @description
#' League table of one division: rank, record, games behind and streak.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id.
#' @return
#' A `hoopR_data` tibble: League table of one division: rank, record, games behind and streak. An empty answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_standings`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | rank | integer | Rank in the division, 1-based. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | alt_name | character | Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
#' | won | integer | Games won in the division so far. |
#' | lost | integer | Games lost in the division so far. |
#' | drawn | integer | Games drawn (always 0 in basketball). |
#' | games_behind | double | Games behind the leader (0 for the leader); a whole number in every captured division, read as a float so half games cannot break the dtype. |
#' | streak | character | Current streak: 'W' + count for wins, 'L' + count for losses (W2 = two straight wins). |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_standings(division_id = 2))
#' }
#' @export
#' @family TPBL Functions
tpbl_standings <- function(division_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_standings_route(division_id, call)
  .tpbl_out(.tpbl_parse_standings(res$body, res$req), "Standings")
}

#' @title
#' **Get TPBL Head-to-Head Standings**
#' @description
#' Head-to-head record of every team against every other team in one division.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/divisions/{division_id}/games/standings`
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id.
#' @return
#' A `hoopR_data` tibble: Head-to-head record of every team against every other team in one division. An empty
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_standings_against`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. The ranked team. |
#' | opponent_team_id | integer | TPBL team id of the opponent (franchise, 2-8). Joins team_id. |
#' | opponent_gohoops_team_id | integer | GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). The opponent. |
#' | opponent | character | Opponent name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | won | integer | Games the ranked team won against this opponent in the division. |
#' | lost | integer | Games the ranked team lost against this opponent in the division. |
#' | drawn | integer | Games drawn against this opponent (always 0). |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_standings_against(division_id = 2)")
#' @export
#' @family TPBL Functions
tpbl_standings_against <- function(division_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_standings_route(division_id, call)
  .tpbl_out(.tpbl_parse_standings_against(res$body, res$req), "Head-to-Head Standings")
}

#' @title
#' **Get TPBL Game**
#' @description
#' Header of one finished game: teams with scores, venue, status, quarters, tip-off, attendance and links.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: Header of one finished game: teams with scores, venue, status, quarters, tip-off,
#'   attendance and links. the columns are always these, in this order (sdv-py `tpbl_game`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | season | integer | Season END year (2026 = the 2025-26 season), the year asked for. Null when the body was parsed without the request stamp. |
#' | season_id | integer | TPBL season id (key space: TPBL seasons on api.tpbl.basketball; 1 = 2024-25, 2 = 2025-26, 3 = 2026-27): the `{season_id}` of the season game list and, equal to it, the `{event_id}` of `/events/{event_id}/*`. Not the GoHoops season id. Null when the body was parsed without the request stamp. |
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | gohoops_game_id | integer | GoHoops game id (key space: GoHoops games; 1242 for TPBL game 6). Not the TPBL game id. |
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
#' | gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. Read from the home team. |
#' | gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. Read from the home team. |
#' | code | character | Game code inside the division: the game number as text in the regular season ('1' ... '42'), a series label in the playoffs ('AG1' = series A game 1, 'G7' = finals game 7), '' for preseason games. |
#' | status | character | Game status. Observed: COMPLETED (finished) and NOT_STARTED (scheduled). A game in progress has is_live true. |
#' | is_live | logical | True while the game is being played; false for finished and scheduled games. |
#' | periods | integer | Number of quarters played: 4 for a regulation game, 5 for one overtime, 6 for two; 0 before tip-off. |
#' | game_date | Date | Game date (Taiwan local date). |
#' | game_day_of_week | character | Traditional Chinese weekday in parentheses: Mon, Tue, Wed, Thu, Fri, Sat, Sun. |
#' | game_time | character | Scheduled tip-off 'HH:MM:SS'. Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
#' | tipoff | POSIXct | Scheduled tip-off as a naive timestamp (no zone). Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
#' | venue | character | Venue name in Traditional Chinese (Xinzhuang Gymnasium, Heping Basketball Gymnasium, Taichung Intercontinental Mini Dome, Hsinchu County Gymnasium, Kaohsiung Arena, Taoyuan Arena). |
#' | attendance | integer | Attendance as an integer, parsed from the API's visitors string; null before the game, when the API sends none or on a postponed game. |
#' | home_team_id | integer | Home TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | home_gohoops_team_id | integer | Home GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | home_gohoops_squad_id | integer | Home GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | home_team | character | Home team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | home_alt_name | character | Home team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
#' | home_score | integer | Home team final score (points scored); null before tip-off. |
#' | away_team_id | integer | Away TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | away_gohoops_team_id | integer | Away GoHoops franchise id (key space: GoHoops franchises, 940-946; stable across seasons; = the TPBL team id + 938). |
#' | away_gohoops_squad_id | integer | Away GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | away_team | character | Away team name. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | away_alt_name | character | Away team slug. Lowercase English slug of the team: aquas, dreamers, lioneers, leopards, dea, kings, mars. |
#' | away_score | integer | Away team final score (points scored); null before tip-off. |
#' | recap_url | character | YouTube recap URL; null when the game has none (the list can omit it, the game detail carries it). |
#' | live_stream_url | character | YouTube live-stream URL of the game; null when the API omits it. |
#' | judgement_report_url | character | URL of the referees' judgement report (a Google Drive file); null when none. |
#' | ticket_url | character | URL of the ticket page; null on most rows. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_game(game_id = 6))
#' }
#' @export
#' @family TPBL Functions
tpbl_game <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = FALSE, call)
  .tpbl_out(.tpbl_parse_game(res$body, res$req), "Game")
}

#' @title
#' **Get TPBL Referees**
#' @description
#' The officiating crew of one finished game, chief referee first (names only).
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: The officiating crew of one finished game, chief referee first (names only). An empty
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_referees`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | sequence | integer | Position in the crew as the API lists it: 1 = the chief referee. |
#' | referee_id | integer | TPBL referee id (key space: TPBL referees on api.tpbl.basketball). Not the GoHoops referee id. |
#' | gohoops_referee_id | integer | GoHoops referee id (key space: GoHoops referees). Not the TPBL referee id. |
#' | name | character | Referee name in Traditional Chinese. Names only: no contact or birth data is published. |
#' | role | character | Crew role enum: BASKETBALL_CHIEF_REFEREE = crew chief, BASKETBALL_FIRST_ASSISTANT_REFEREE = first assistant (umpire 1), BASKETBALL_SECOND_ASSISTANT_REFEREE = second assistant (umpire 2). |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_referees(game_id = 6)")
#' @export
#' @family TPBL Functions
tpbl_referees <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = FALSE, call)
  .tpbl_out(.tpbl_parse_referees(res$body, res$req), "Referees")
}

#' @title
#' **Get TPBL Player Box Score**
#' @description
#' Whole-game box score lines of every player on either team sheet, keyed by GoHoops roster id.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: Whole-game box score lines of every player on either team sheet, keyed by GoHoops roster
#'   id. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_box_players`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
#' | gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
#' | gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). The key of the box score players: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
#' | player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
#' | number | character | Jersey number as text (so '0' and '00' stay distinct). |
#' | position | character | Playing position as a PascalCase enum: PointGuard, ShootingGuard, SmallForward, PowerForward, Center, and the combinations PointGuardAndShootingGuard, ShootingGuardAndSmallForward, SmallForwardAndPowerForward and PowerForwardAndCenter; '' when unset. |
#' | status | character | Registration status of the player on the squad as of the request, not at game time: 'official', or 'withdrawn' / 'WITHDRAWN' (one state in two spellings: the player left the squad later; most withdrawn players still played). |
#' | roster_status | character | Roster registration status as an upper-case enum: 'OFFICIAL' in the 2026-27 preseason game; null in the 2024-25 and 2025-26 box scores (an era difference in the feed). |
#' | is_starting | logical | True when the player was in the starting five. |
#' | entered | logical | True when the player has a stat line (he entered the game; a few such players have 0 seconds on court); false for a registered player who did not play, whose stats are all null. |
#' | time_on_court | integer | Seconds on court by the player over the whole game (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
#' | score | integer | Points scored by the player over the whole game. The stat keys are absent for a player who did not enter the game (11 keys in all); a few players who did not play carry them with time_on_court 0. |
#' | plus_minus | integer | Plus/minus: the team's point differential while the player was on court (standard definition; not independently checked). |
#' | field_goals_made | integer | Field goals made by the player over the whole game. |
#' | field_goals_missed | integer | Field goals missed by the player over the whole game. |
#' | field_goals_attempted | integer | Field goals attempted by the player over the whole game. |
#' | field_goals_percentage | double | Field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | two_pointers_made | integer | 2-point field goals made by the player over the whole game. |
#' | two_pointers_missed | integer | 2-point field goals missed by the player over the whole game. |
#' | two_pointers_attempted | integer | 2-point field goals attempted by the player over the whole game. |
#' | two_pointers_percentage | double | 2-point field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | three_pointers_made | integer | 3-point field goals made by the player over the whole game. |
#' | three_pointers_missed | integer | 3-point field goals missed by the player over the whole game. |
#' | three_pointers_attempted | integer | 3-point field goals attempted by the player over the whole game. |
#' | three_pointers_percentage | double | 3-point field goals percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | free_throws_made | integer | Free throws made by the player over the whole game. |
#' | free_throws_missed | integer | Free throws missed by the player over the whole game. |
#' | free_throws_attempted | integer | Free throws attempted by the player over the whole game. |
#' | free_throws_percentage | double | Free throws percentage by the player over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | rebounds | integer | Total rebounds by the player over the whole game (offensive + defensive). |
#' | defensive_rebounds | integer | Defensive rebounds by the player over the whole game. |
#' | offensive_rebounds | integer | Offensive rebounds by the player over the whole game. |
#' | defensive_fouls | integer | Fouls committed on defense by the player over the whole game. |
#' | offensive_fouls | integer | Fouls committed on offense by the player over the whole game. |
#' | personal_fouls | integer | Personal fouls by the player over the whole game (excludes technical, unsportsmanlike and disqualifying fouls). |
#' | fouls | integer | Fouls charged by the player over the whole game: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
#' | assists | integer | Assists by the player over the whole game. |
#' | steals | integer | Steals by the player over the whole game. |
#' | blocks | integer | Blocked shots by the player over the whole game. |
#' | turnovers | integer | Turnovers committed by the player over the whole game; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
#' | points_in_paint | integer | Points scored in the paint by the player over the whole game. |
#' | second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the player over the whole game. |
#' | fast_break_points | integer | Points scored on the fast break by the player over the whole game. |
#' | efficiency | integer | Efficiency rating by the player over the whole game: (points + rebounds + assists + steals + blocks) - (missed field goals + missed free throws + turnovers); verified on all 4,237 played player lines of 189 games. |
#' | efg | double | Effective field-goal percentage by the player over the whole game, 0-100 as a string with one decimal rounded half up: (FGM + 0.5 x 3PM) / FGA; '0.0' without attempts. |
#' | tsp | double | True shooting percentage by the player over the whole game, 0-100 as a string with one decimal rounded half up: points / (2 x (FGA + 0.44 x FTA)); '0.0' without attempts. |
#' | pir | integer | Performance Index Rating by the player over the whole game: efficiency - fouls (verified on all 4,237 played player lines of 189 games). |
#' | field_goals_made_in_the_paint | integer | Field goals made in the paint by the player over the whole game. |
#' | field_goals_missed_in_the_paint | integer | Field goals missed in the paint by the player over the whole game. |
#' | field_goals_attempted_in_the_paint | integer | Field goals attempted in the paint by the player over the whole game. |
#' | field_goals_made_on_fast_break | integer | Field goals made on the fast break by the player over the whole game. |
#' | field_goals_missed_on_fast_break | integer | Field goals missed on the fast break by the player over the whole game. |
#' | field_goals_attempted_on_fast_break | integer | Field goals attempted on the fast break by the player over the whole game. |
#' | field_goals_made_on_second_chance | integer | Field goals made on a second chance (after an offensive rebound) by the player over the whole game. |
#' | field_goals_missed_on_second_chance | integer | Field goals missed on a second chance (after an offensive rebound) by the player over the whole game. |
#' | field_goals_attempted_on_second_chance | integer | Field goals attempted on a second chance (after an offensive rebound) by the player over the whole game. |
#' | technical_fouls | integer | Technical fouls by the player over the whole game. |
#' | unsportsmanlike_fouls | integer | Unsportsmanlike fouls by the player over the whole game. |
#' | disqualifying_fouls | integer | Disqualifying fouls by the player over the whole game. |
#' | bad_pass_turnovers | integer | Turnovers of type 'bad pass' by the player over the whole game. |
#' | ball_handling_turnovers | integer | Turnovers of type 'ball-handling error' by the player over the whole game. |
#' | out_of_bounds_turnovers | integer | Turnovers of type 'out of bounds' by the player over the whole game. |
#' | travel_turnovers | integer | Turnovers of type 'traveling' by the player over the whole game. |
#' | three_seconds_turnovers | integer | Turnovers of type 'three-second violation' by the player over the whole game. |
#' | five_seconds_turnovers | integer | Turnovers of type 'five-second violation' by the player over the whole game. |
#' | back_court_turnovers | integer | Turnovers of type 'back-court violation' by the player over the whole game. |
#' | offensive_goal_tending_turnovers | integer | Turnovers of type 'offensive goaltending' by the player over the whole game. |
#' | double_dribble_turnovers | integer | Turnovers of type 'double dribble' by the player over the whole game. |
#' | carry_turnovers | integer | Turnovers of type 'carrying' by the player over the whole game. |
#' | offensive_foul_turnovers | integer | Turnovers of type 'offensive foul' by the player over the whole game. |
#' | other_turnovers | integer | Turnovers of type 'other' by the player over the whole game. |
#' | points_off_turnovers | integer | Points scored off opponent turnovers by the player over the whole game. |
#' | two_pointers_jump_shot_made | integer | 2-point field goals made that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | two_pointers_jump_shot_missed | integer | 2-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | two_pointers_jump_shot_attempted | integer | 2-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | three_pointers_jump_shot_made | integer | 3-point field goals made that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | three_pointers_jump_shot_missed | integer | 3-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | three_pointers_jump_shot_attempted | integer | 3-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player over the whole game. |
#' | two_pointers_layup_made | integer | 2-point field goals made that were a layup by the player over the whole game. |
#' | two_pointers_layup_missed | integer | 2-point field goals missed that were a layup by the player over the whole game. |
#' | two_pointers_layup_attempted | integer | 2-point field goals attempted that were a layup by the player over the whole game. |
#' | two_pointers_driving_layup_made | integer | 2-point field goals made that were a driving layup by the player over the whole game. |
#' | two_pointers_driving_layup_missed | integer | 2-point field goals missed that were a driving layup by the player over the whole game. |
#' | two_pointers_driving_layup_attempted | integer | 2-point field goals attempted that were a driving layup by the player over the whole game. |
#' | two_pointers_dunk_made | integer | 2-point field goals made that were a dunk by the player over the whole game. |
#' | two_pointers_dunk_missed | integer | 2-point field goals missed that were a dunk by the player over the whole game. |
#' | two_pointers_dunk_attempted | integer | 2-point field goals attempted that were a dunk by the player over the whole game. |
#' | two_pointers_putback_dunk_made | integer | 2-point field goals made that were a putback dunk (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_putback_dunk_missed | integer | 2-point field goals missed that were a putback dunk (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_putback_dunk_attempted | integer | 2-point field goals attempted that were a putback dunk (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_putback_tip_in_made | integer | 2-point field goals made that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_putback_tip_in_missed | integer | 2-point field goals missed that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_putback_tip_in_attempted | integer | 2-point field goals attempted that were a putback tip-in (off an offensive rebound) by the player over the whole game. |
#' | two_pointers_alley_oop_made | integer | 2-point field goals made that were a alley-oop by the player over the whole game. |
#' | two_pointers_alley_oop_missed | integer | 2-point field goals missed that were a alley-oop by the player over the whole game. |
#' | two_pointers_alley_oop_attempted | integer | 2-point field goals attempted that were a alley-oop by the player over the whole game. |
#' | two_pointers_hook_shot_made | integer | 2-point field goals made that were a hook shot by the player over the whole game. |
#' | two_pointers_hook_shot_missed | integer | 2-point field goals missed that were a hook shot by the player over the whole game. |
#' | two_pointers_hook_shot_attempted | integer | 2-point field goals attempted that were a hook shot by the player over the whole game. |
#' | three_pointers_hook_shot_made | integer | 3-point field goals made that were a hook shot by the player over the whole game. |
#' | three_pointers_hook_shot_missed | integer | 3-point field goals missed that were a hook shot by the player over the whole game. |
#' | three_pointers_hook_shot_attempted | integer | 3-point field goals attempted that were a hook shot by the player over the whole game. |
#' | two_pointers_floating_jump_shot_made | integer | 2-point field goals made that were a floating jump shot (floater) by the player over the whole game. |
#' | two_pointers_floating_jump_shot_missed | integer | 2-point field goals missed that were a floating jump shot (floater) by the player over the whole game. |
#' | two_pointers_floating_jump_shot_attempted | integer | 2-point field goals attempted that were a floating jump shot (floater) by the player over the whole game. |
#' | three_pointers_floating_jump_shot_made | integer | 3-point field goals made that were a floating jump shot (floater) by the player over the whole game. |
#' | three_pointers_floating_jump_shot_missed | integer | 3-point field goals missed that were a floating jump shot (floater) by the player over the whole game. |
#' | three_pointers_floating_jump_shot_attempted | integer | 3-point field goals attempted that were a floating jump shot (floater) by the player over the whole game. |
#' | two_pointers_fadeaway_jump_shot_made | integer | 2-point field goals made that were a fadeaway jump shot by the player over the whole game. |
#' | two_pointers_fadeaway_jump_shot_missed | integer | 2-point field goals missed that were a fadeaway jump shot by the player over the whole game. |
#' | two_pointers_fadeaway_jump_shot_attempted | integer | 2-point field goals attempted that were a fadeaway jump shot by the player over the whole game. |
#' | three_pointers_fadeaway_jump_shot_made | integer | 3-point field goals made that were a fadeaway jump shot by the player over the whole game. |
#' | three_pointers_fadeaway_jump_shot_missed | integer | 3-point field goals missed that were a fadeaway jump shot by the player over the whole game. |
#' | three_pointers_fadeaway_jump_shot_attempted | integer | 3-point field goals attempted that were a fadeaway jump shot by the player over the whole game. |
#' | two_pointers_turnaround_jump_shot_made | integer | 2-point field goals made that were a turnaround jump shot by the player over the whole game. |
#' | two_pointers_turnaround_jump_shot_missed | integer | 2-point field goals missed that were a turnaround jump shot by the player over the whole game. |
#' | two_pointers_turnaround_jump_shot_attempted | integer | 2-point field goals attempted that were a turnaround jump shot by the player over the whole game. |
#' | three_pointers_turnaround_jump_shot_made | integer | 3-point field goals made that were a turnaround jump shot by the player over the whole game. |
#' | three_pointers_turnaround_jump_shot_missed | integer | 3-point field goals missed that were a turnaround jump shot by the player over the whole game. |
#' | three_pointers_turnaround_jump_shot_attempted | integer | 3-point field goals attempted that were a turnaround jump shot by the player over the whole game. |
#' | two_pointers_step_back_jump_shot_made | integer | 2-point field goals made that were a step-back jump shot by the player over the whole game. |
#' | two_pointers_step_back_jump_shot_missed | integer | 2-point field goals missed that were a step-back jump shot by the player over the whole game. |
#' | two_pointers_step_back_jump_shot_attempted | integer | 2-point field goals attempted that were a step-back jump shot by the player over the whole game. |
#' | three_pointers_step_back_jump_shot_made | integer | 3-point field goals made that were a step-back jump shot by the player over the whole game. |
#' | three_pointers_step_back_jump_shot_missed | integer | 3-point field goals missed that were a step-back jump shot by the player over the whole game. |
#' | three_pointers_step_back_jump_shot_attempted | integer | 3-point field goals attempted that were a step-back jump shot by the player over the whole game. |
#' | two_pointers_pull_up_jump_shot_made | integer | 2-point field goals made that were a pull-up jump shot by the player over the whole game. |
#' | two_pointers_pull_up_jump_shot_missed | integer | 2-point field goals missed that were a pull-up jump shot by the player over the whole game. |
#' | two_pointers_pull_up_jump_shot_attempted | integer | 2-point field goals attempted that were a pull-up jump shot by the player over the whole game. |
#' | three_pointers_pull_up_jump_shot_made | integer | 3-point field goals made that were a pull-up jump shot by the player over the whole game. |
#' | three_pointers_pull_up_jump_shot_missed | integer | 3-point field goals missed that were a pull-up jump shot by the player over the whole game. |
#' | three_pointers_pull_up_jump_shot_attempted | integer | 3-point field goals attempted that were a pull-up jump shot by the player over the whole game. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_box_players(game_id = 6))
#' }
#' @export
#' @family TPBL Functions
tpbl_box_players <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = TRUE, call)
  .tpbl_out(.tpbl_parse_box_players(res$body, res$req), "Player Box Score")
}

#' @title
#' **Get TPBL Player Box Score by Quarter**
#' @description
#' Per-quarter box score lines of the players who were on court, overtimes included.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: Per-quarter box score lines of the players who were on court, overtimes included. An empty
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_box_player_periods`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | period | integer | Quarter number of the row: 1-4 regulation, 5 = the first overtime, 6 = the second. |
#' | player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
#' | gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
#' | gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). The key of the box score players: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
#' | player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
#' | number | character | Jersey number as text (so '0' and '00' stay distinct). |
#' | position | character | Playing position as a PascalCase enum: PointGuard, ShootingGuard, SmallForward, PowerForward, Center, and the combinations PointGuardAndShootingGuard, ShootingGuardAndSmallForward, SmallForwardAndPowerForward and PowerForwardAndCenter; '' when unset. |
#' | status | character | Registration status of the player on the squad as of the request, not at game time: 'official', or 'withdrawn' / 'WITHDRAWN' (one state in two spellings: the player left the squad later; most withdrawn players still played). |
#' | roster_status | character | Roster registration status as an upper-case enum: 'OFFICIAL' in the 2026-27 preseason game; null in the 2024-25 and 2025-26 box scores (an era difference in the feed). |
#' | is_starting | logical | True when the player was in the starting five of the game. |
#' | entered | logical | Always true here: only quarters in which the player was on court are rows. |
#' | time_on_court | integer | Seconds on court by the player in this quarter (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
#' | score | integer | Points scored by the player in this quarter. The stat keys are absent for a player who did not enter the game (11 keys in all); a few players who did not play carry them with time_on_court 0. |
#' | plus_minus | integer | Plus/minus: the team's point differential while the player was on court (standard definition; not independently checked). |
#' | field_goals_made | integer | Field goals made by the player in this quarter. |
#' | field_goals_missed | integer | Field goals missed by the player in this quarter. |
#' | field_goals_attempted | integer | Field goals attempted by the player in this quarter. |
#' | field_goals_percentage | double | Field goals percentage by the player in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | two_pointers_made | integer | 2-point field goals made by the player in this quarter. |
#' | two_pointers_missed | integer | 2-point field goals missed by the player in this quarter. |
#' | two_pointers_attempted | integer | 2-point field goals attempted by the player in this quarter. |
#' | two_pointers_percentage | double | 2-point field goals percentage by the player in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | three_pointers_made | integer | 3-point field goals made by the player in this quarter. |
#' | three_pointers_missed | integer | 3-point field goals missed by the player in this quarter. |
#' | three_pointers_attempted | integer | 3-point field goals attempted by the player in this quarter. |
#' | three_pointers_percentage | double | 3-point field goals percentage by the player in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | free_throws_made | integer | Free throws made by the player in this quarter. |
#' | free_throws_missed | integer | Free throws missed by the player in this quarter. |
#' | free_throws_attempted | integer | Free throws attempted by the player in this quarter. |
#' | free_throws_percentage | double | Free throws percentage by the player in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | rebounds | integer | Total rebounds by the player in this quarter (offensive + defensive). |
#' | defensive_rebounds | integer | Defensive rebounds by the player in this quarter. |
#' | offensive_rebounds | integer | Offensive rebounds by the player in this quarter. |
#' | defensive_fouls | integer | Fouls committed on defense by the player in this quarter. |
#' | offensive_fouls | integer | Fouls committed on offense by the player in this quarter. |
#' | personal_fouls | integer | Personal fouls by the player in this quarter (excludes technical, unsportsmanlike and disqualifying fouls). |
#' | fouls | integer | Fouls charged by the player in this quarter: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
#' | assists | integer | Assists by the player in this quarter. |
#' | steals | integer | Steals by the player in this quarter. |
#' | blocks | integer | Blocked shots by the player in this quarter. |
#' | turnovers | integer | Turnovers committed by the player in this quarter; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
#' | points_in_paint | integer | Points scored in the paint by the player in this quarter. |
#' | second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the player in this quarter. |
#' | fast_break_points | integer | Points scored on the fast break by the player in this quarter. |
#' | efg | double | Effective field-goal percentage by the player in this quarter, 0-100 as a string with one decimal rounded half up: (FGM + 0.5 x 3PM) / FGA; '0.0' without attempts. |
#' | tsp | double | True shooting percentage by the player in this quarter, 0-100 as a string with one decimal rounded half up: points / (2 x (FGA + 0.44 x FTA)); '0.0' without attempts. |
#' | pir | integer | Performance Index Rating by the player in this quarter: efficiency - fouls (verified on all 4,237 played player lines of 189 games). |
#' | field_goals_made_in_the_paint | integer | Field goals made in the paint by the player in this quarter. |
#' | field_goals_missed_in_the_paint | integer | Field goals missed in the paint by the player in this quarter. |
#' | field_goals_attempted_in_the_paint | integer | Field goals attempted in the paint by the player in this quarter. |
#' | field_goals_made_on_fast_break | integer | Field goals made on the fast break by the player in this quarter. |
#' | field_goals_missed_on_fast_break | integer | Field goals missed on the fast break by the player in this quarter. |
#' | field_goals_attempted_on_fast_break | integer | Field goals attempted on the fast break by the player in this quarter. |
#' | field_goals_made_on_second_chance | integer | Field goals made on a second chance (after an offensive rebound) by the player in this quarter. |
#' | field_goals_missed_on_second_chance | integer | Field goals missed on a second chance (after an offensive rebound) by the player in this quarter. |
#' | field_goals_attempted_on_second_chance | integer | Field goals attempted on a second chance (after an offensive rebound) by the player in this quarter. |
#' | technical_fouls | integer | Technical fouls by the player in this quarter. |
#' | unsportsmanlike_fouls | integer | Unsportsmanlike fouls by the player in this quarter. |
#' | disqualifying_fouls | integer | Disqualifying fouls by the player in this quarter. |
#' | bad_pass_turnovers | integer | Turnovers of type 'bad pass' by the player in this quarter. |
#' | ball_handling_turnovers | integer | Turnovers of type 'ball-handling error' by the player in this quarter. |
#' | out_of_bounds_turnovers | integer | Turnovers of type 'out of bounds' by the player in this quarter. |
#' | travel_turnovers | integer | Turnovers of type 'traveling' by the player in this quarter. |
#' | three_seconds_turnovers | integer | Turnovers of type 'three-second violation' by the player in this quarter. |
#' | five_seconds_turnovers | integer | Turnovers of type 'five-second violation' by the player in this quarter. |
#' | back_court_turnovers | integer | Turnovers of type 'back-court violation' by the player in this quarter. |
#' | offensive_goal_tending_turnovers | integer | Turnovers of type 'offensive goaltending' by the player in this quarter. |
#' | double_dribble_turnovers | integer | Turnovers of type 'double dribble' by the player in this quarter. |
#' | carry_turnovers | integer | Turnovers of type 'carrying' by the player in this quarter. |
#' | offensive_foul_turnovers | integer | Turnovers of type 'offensive foul' by the player in this quarter. |
#' | other_turnovers | integer | Turnovers of type 'other' by the player in this quarter. |
#' | points_off_turnovers | integer | Points scored off opponent turnovers by the player in this quarter. |
#' | two_pointers_jump_shot_made | integer | 2-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | two_pointers_jump_shot_missed | integer | 2-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | two_pointers_jump_shot_attempted | integer | 2-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | three_pointers_jump_shot_made | integer | 3-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | three_pointers_jump_shot_missed | integer | 3-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | three_pointers_jump_shot_attempted | integer | 3-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in this quarter. |
#' | two_pointers_layup_made | integer | 2-point field goals made that were a layup by the player in this quarter. |
#' | two_pointers_layup_missed | integer | 2-point field goals missed that were a layup by the player in this quarter. |
#' | two_pointers_layup_attempted | integer | 2-point field goals attempted that were a layup by the player in this quarter. |
#' | two_pointers_driving_layup_made | integer | 2-point field goals made that were a driving layup by the player in this quarter. |
#' | two_pointers_driving_layup_missed | integer | 2-point field goals missed that were a driving layup by the player in this quarter. |
#' | two_pointers_driving_layup_attempted | integer | 2-point field goals attempted that were a driving layup by the player in this quarter. |
#' | two_pointers_dunk_made | integer | 2-point field goals made that were a dunk by the player in this quarter. |
#' | two_pointers_dunk_missed | integer | 2-point field goals missed that were a dunk by the player in this quarter. |
#' | two_pointers_dunk_attempted | integer | 2-point field goals attempted that were a dunk by the player in this quarter. |
#' | two_pointers_putback_dunk_made | integer | 2-point field goals made that were a putback dunk (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_putback_dunk_missed | integer | 2-point field goals missed that were a putback dunk (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_putback_dunk_attempted | integer | 2-point field goals attempted that were a putback dunk (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_putback_tip_in_made | integer | 2-point field goals made that were a putback tip-in (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_putback_tip_in_missed | integer | 2-point field goals missed that were a putback tip-in (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_putback_tip_in_attempted | integer | 2-point field goals attempted that were a putback tip-in (off an offensive rebound) by the player in this quarter. |
#' | two_pointers_alley_oop_made | integer | 2-point field goals made that were a alley-oop by the player in this quarter. |
#' | two_pointers_alley_oop_missed | integer | 2-point field goals missed that were a alley-oop by the player in this quarter. |
#' | two_pointers_alley_oop_attempted | integer | 2-point field goals attempted that were a alley-oop by the player in this quarter. |
#' | two_pointers_hook_shot_made | integer | 2-point field goals made that were a hook shot by the player in this quarter. |
#' | two_pointers_hook_shot_missed | integer | 2-point field goals missed that were a hook shot by the player in this quarter. |
#' | two_pointers_hook_shot_attempted | integer | 2-point field goals attempted that were a hook shot by the player in this quarter. |
#' | three_pointers_hook_shot_made | integer | 3-point field goals made that were a hook shot by the player in this quarter. |
#' | three_pointers_hook_shot_missed | integer | 3-point field goals missed that were a hook shot by the player in this quarter. |
#' | three_pointers_hook_shot_attempted | integer | 3-point field goals attempted that were a hook shot by the player in this quarter. |
#' | two_pointers_floating_jump_shot_made | integer | 2-point field goals made that were a floating jump shot (floater) by the player in this quarter. |
#' | two_pointers_floating_jump_shot_missed | integer | 2-point field goals missed that were a floating jump shot (floater) by the player in this quarter. |
#' | two_pointers_floating_jump_shot_attempted | integer | 2-point field goals attempted that were a floating jump shot (floater) by the player in this quarter. |
#' | three_pointers_floating_jump_shot_made | integer | 3-point field goals made that were a floating jump shot (floater) by the player in this quarter. |
#' | three_pointers_floating_jump_shot_missed | integer | 3-point field goals missed that were a floating jump shot (floater) by the player in this quarter. |
#' | three_pointers_floating_jump_shot_attempted | integer | 3-point field goals attempted that were a floating jump shot (floater) by the player in this quarter. |
#' | two_pointers_fadeaway_jump_shot_made | integer | 2-point field goals made that were a fadeaway jump shot by the player in this quarter. |
#' | two_pointers_fadeaway_jump_shot_missed | integer | 2-point field goals missed that were a fadeaway jump shot by the player in this quarter. |
#' | two_pointers_fadeaway_jump_shot_attempted | integer | 2-point field goals attempted that were a fadeaway jump shot by the player in this quarter. |
#' | three_pointers_fadeaway_jump_shot_made | integer | 3-point field goals made that were a fadeaway jump shot by the player in this quarter. |
#' | three_pointers_fadeaway_jump_shot_missed | integer | 3-point field goals missed that were a fadeaway jump shot by the player in this quarter. |
#' | three_pointers_fadeaway_jump_shot_attempted | integer | 3-point field goals attempted that were a fadeaway jump shot by the player in this quarter. |
#' | two_pointers_turnaround_jump_shot_made | integer | 2-point field goals made that were a turnaround jump shot by the player in this quarter. |
#' | two_pointers_turnaround_jump_shot_missed | integer | 2-point field goals missed that were a turnaround jump shot by the player in this quarter. |
#' | two_pointers_turnaround_jump_shot_attempted | integer | 2-point field goals attempted that were a turnaround jump shot by the player in this quarter. |
#' | three_pointers_turnaround_jump_shot_made | integer | 3-point field goals made that were a turnaround jump shot by the player in this quarter. |
#' | three_pointers_turnaround_jump_shot_missed | integer | 3-point field goals missed that were a turnaround jump shot by the player in this quarter. |
#' | three_pointers_turnaround_jump_shot_attempted | integer | 3-point field goals attempted that were a turnaround jump shot by the player in this quarter. |
#' | two_pointers_step_back_jump_shot_made | integer | 2-point field goals made that were a step-back jump shot by the player in this quarter. |
#' | two_pointers_step_back_jump_shot_missed | integer | 2-point field goals missed that were a step-back jump shot by the player in this quarter. |
#' | two_pointers_step_back_jump_shot_attempted | integer | 2-point field goals attempted that were a step-back jump shot by the player in this quarter. |
#' | three_pointers_step_back_jump_shot_made | integer | 3-point field goals made that were a step-back jump shot by the player in this quarter. |
#' | three_pointers_step_back_jump_shot_missed | integer | 3-point field goals missed that were a step-back jump shot by the player in this quarter. |
#' | three_pointers_step_back_jump_shot_attempted | integer | 3-point field goals attempted that were a step-back jump shot by the player in this quarter. |
#' | two_pointers_pull_up_jump_shot_made | integer | 2-point field goals made that were a pull-up jump shot by the player in this quarter. |
#' | two_pointers_pull_up_jump_shot_missed | integer | 2-point field goals missed that were a pull-up jump shot by the player in this quarter. |
#' | two_pointers_pull_up_jump_shot_attempted | integer | 2-point field goals attempted that were a pull-up jump shot by the player in this quarter. |
#' | three_pointers_pull_up_jump_shot_made | integer | 3-point field goals made that were a pull-up jump shot by the player in this quarter. |
#' | three_pointers_pull_up_jump_shot_missed | integer | 3-point field goals missed that were a pull-up jump shot by the player in this quarter. |
#' | three_pointers_pull_up_jump_shot_attempted | integer | 3-point field goals attempted that were a pull-up jump shot by the player in this quarter. |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_box_player_periods(game_id = 6)")
#' @export
#' @family TPBL Functions
tpbl_box_player_periods <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = TRUE, call)
  .tpbl_out(.tpbl_parse_box_player_periods(res$body, res$req), "Player Box Score by Quarter")
}

#' @title
#' **Get TPBL Team Box Score**
#' @description
#' Whole-game team totals of both teams: shooting, rebounds, fouls, assists, turnovers and paint points.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: Whole-game team totals of both teams: shooting, rebounds, fouls, assists, turnovers and
#'   paint points. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_box_teams`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | opponent_team_id | integer | TPBL team id of the other side of the game (franchise, 2-8). Joins team_id. |
#' | field_goals_made | integer | Field goals made by the team over the whole game. |
#' | field_goals_missed | integer | Field goals missed by the team over the whole game. |
#' | field_goals_attempted | integer | Field goals attempted by the team over the whole game. |
#' | field_goals_percentage | double | Field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | two_pointers_made | integer | 2-point field goals made by the team over the whole game. |
#' | two_pointers_missed | integer | 2-point field goals missed by the team over the whole game. |
#' | two_pointers_attempted | integer | 2-point field goals attempted by the team over the whole game. |
#' | two_pointers_percentage | double | 2-point field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | three_pointers_made | integer | 3-point field goals made by the team over the whole game. |
#' | three_pointers_missed | integer | 3-point field goals missed by the team over the whole game. |
#' | three_pointers_attempted | integer | 3-point field goals attempted by the team over the whole game. |
#' | three_pointers_percentage | double | 3-point field goals percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | free_throws_made | integer | Free throws made by the team over the whole game. |
#' | free_throws_missed | integer | Free throws missed by the team over the whole game. |
#' | free_throws_attempted | integer | Free throws attempted by the team over the whole game. |
#' | free_throws_percentage | double | Free throws percentage by the team over the whole game, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | won_score | integer | Team-row field: points the team scored in the whole game (the final score). |
#' | total_won_score | integer | Team-row field: points the team scored in the whole game (the final score; equals won_score on this line). |
#' | lost_score | integer | Team-row field: points the team conceded in the whole game (the opponent's final score). |
#' | total_lost_score | integer | Team-row field: points the team conceded in the whole game (equals lost_score on this line). |
#' | rebounds | integer | Total rebounds by the team over the whole game (offensive + defensive). |
#' | defensive_rebounds | integer | Defensive rebounds by the team over the whole game. |
#' | offensive_rebounds | integer | Offensive rebounds by the team over the whole game. |
#' | defensive_fouls | integer | Fouls committed on defense by the team over the whole game. |
#' | offensive_fouls | integer | Fouls committed on offense by the team over the whole game. |
#' | personal_fouls | integer | Personal fouls by the team over the whole game (excludes technical, unsportsmanlike and disqualifying fouls). |
#' | fouls | integer | Fouls charged by the team over the whole game: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
#' | assists | integer | Assists by the team over the whole game. |
#' | steals | integer | Steals by the team over the whole game. |
#' | blocks | integer | Blocked shots by the team over the whole game. |
#' | turnovers | integer | Turnovers committed by the team over the whole game; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
#' | points_in_paint | integer | Points scored in the paint by the team over the whole game. |
#' | second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the team over the whole game. |
#' | fast_break_points | integer | Points scored on the fast break by the team over the whole game. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_box_teams(game_id = 6))
#' }
#' @export
#' @family TPBL Functions
tpbl_box_teams <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = TRUE, call)
  .tpbl_out(.tpbl_parse_box_teams(res$body, res$req), "Team Box Score")
}

#' @title
#' **Get TPBL Team Box Score by Quarter**
#' @description
#' Per-quarter team lines of both teams: points scored and conceded in the quarter, running totals and stats.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/games/{game_id}/stats`
#' @param game_id Required. TPBL game id (integer), e.g. 6; `game_id` in tpbl_games. Not sequential by date (2024-25
#'   = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). Only a finished game is served.
#' @return
#' A `hoopR_data` tibble: Per-quarter team lines of both teams: points scored and conceded in the quarter, running
#'   totals and stats. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_box_team_periods`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | side | character | Side of the game: home or away (the API lists the home team first and never infers it from the venue). |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | period | integer | Quarter number of the row: 1-4 regulation, 5 = the first overtime, 6 = the second. |
#' | won_score | integer | Team-row field: points the team scored in this quarter alone. Player stat lines carry no value for it. |
#' | time_on_court | integer | Seconds on court by the team in this quarter (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
#' | lost_score | integer | Team-row field: points the team conceded in this quarter alone. Not a player stat. |
#' | total_won_score | integer | Team-row field: points the team has scored up to and including this quarter (the last quarter's value is the final score). Not a player stat. |
#' | total_lost_score | integer | Team-row field: points the team has conceded up to and including this quarter. Not a player stat. |
#' | field_goals_made | integer | Field goals made by the team in this quarter. |
#' | field_goals_missed | integer | Field goals missed by the team in this quarter. |
#' | field_goals_attempted | integer | Field goals attempted by the team in this quarter. |
#' | field_goals_percentage | double | Field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | two_pointers_made | integer | 2-point field goals made by the team in this quarter. |
#' | two_pointers_missed | integer | 2-point field goals missed by the team in this quarter. |
#' | two_pointers_attempted | integer | 2-point field goals attempted by the team in this quarter. |
#' | two_pointers_percentage | double | 2-point field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | three_pointers_made | integer | 3-point field goals made by the team in this quarter. |
#' | three_pointers_missed | integer | 3-point field goals missed by the team in this quarter. |
#' | three_pointers_attempted | integer | 3-point field goals attempted by the team in this quarter. |
#' | three_pointers_percentage | double | 3-point field goals percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | free_throws_made | integer | Free throws made by the team in this quarter. |
#' | free_throws_missed | integer | Free throws missed by the team in this quarter. |
#' | free_throws_attempted | integer | Free throws attempted by the team in this quarter. |
#' | free_throws_percentage | double | Free throws percentage by the team in this quarter, 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | rebounds | integer | Total rebounds by the team in this quarter (offensive + defensive). |
#' | defensive_rebounds | integer | Defensive rebounds by the team in this quarter. |
#' | offensive_rebounds | integer | Offensive rebounds by the team in this quarter. |
#' | defensive_fouls | integer | Fouls committed on defense by the team in this quarter. |
#' | offensive_fouls | integer | Fouls committed on offense by the team in this quarter. |
#' | personal_fouls | integer | Personal fouls by the team in this quarter (excludes technical, unsportsmanlike and disqualifying fouls). |
#' | fouls | integer | Fouls charged by the team in this quarter: personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
#' | assists | integer | Assists by the team in this quarter. |
#' | steals | integer | Steals by the team in this quarter. |
#' | blocks | integer | Blocked shots by the team in this quarter. |
#' | turnovers | integer | Turnovers committed by the team in this quarter; equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
#' | points_in_paint | integer | Points scored in the paint by the team in this quarter. |
#' | second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the team in this quarter. |
#' | fast_break_points | integer | Points scored on the fast break by the team in this quarter. |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_box_team_periods(game_id = 6)")
#' @export
#' @family TPBL Functions
tpbl_box_team_periods <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_game_route(game_id, stats = TRUE, call)
  .tpbl_out(.tpbl_parse_box_team_periods(res$body, res$req), "Team Box Score by Quarter")
}

#' @title
#' **Get TPBL Roster**
#' @description
#' The registered roster of one team in one division (birth dates omitted).
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/players`
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id.
#' @param team_id Required. TPBL team id (the franchise, 2-8, stable across seasons); `team_id` in tpbl_teams. Not
#'   the GoHoops id.
#' @return
#' A `hoopR_data` tibble: The registered roster of one team in one division (birth dates omitted). An empty answer
#'   raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_roster`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | team | character | Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
#' | gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
#' | gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). The key of the box score players: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
#' | gohoops_squad_id | integer | GoHoops squad id (key space: GoHoops squads = one team in one season: 8209-8215 in 2024-25, 11931-11937 in 2025-26, 15536-15542 in 2026-27; it changes every season). |
#' | gohoops_event_id | integer | GoHoops event id (key space: GoHoops events, one per TPBL season; 319 = 2024-25, 490 = 2025-26, 613 = 2026-27). Not the TPBL season id and not the GoHoops season id. |
#' | gohoops_season_id | integer | GoHoops season id (key space: GoHoops seasons, the id system the API echoes beside its own; 101 = 2024-25, 213 = 2025-26, 275 = 2026-27). Not the TPBL season id. |
#' | player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
#' | alt_name | character | Romanized name (e.g. 'Chian Kuang-Chien'); '' when none. |
#' | number | character | Jersey number as text (so '0' and '00' stay distinct). |
#' | position | character | Playing position as a PascalCase enum: PointGuard, ShootingGuard, SmallForward, PowerForward, Center, and the combinations PointGuardAndShootingGuard, ShootingGuardAndSmallForward, SmallForwardAndPowerForward and PowerForwardAndCenter; '' when unset. |
#' | height_cm | integer | Height in centimetres. |
#' | weight_kg | double | Weight in kilograms (a number; fractions possible). |
#' | nationality | character | Nationality text: 'Local' for a Taiwan-born player, '' when unset. |
#' | national_identity | character | Player category: 'Local' (Taiwanese), '' when unset (foreign and naturalized categories use other strings). |
#' | national_identity_detail | character | Free-text detail on the category; '' in every sample. |
#' | registered | logical | True when the player is registered with the squad. |
#' | is_listing | logical | True when the player is shown on the team's public roster page. |
#' @inherit tpbl_seasons details
#' @examples
#' \donttest{
#'   try(tpbl_roster(division_id = 2, team_id = 4))
#' }
#' @export
#' @family TPBL Functions
tpbl_roster <- function(division_id, team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_team_route(division_id, team_id, "players", call = call)
  .tpbl_out(.tpbl_parse_roster(res$body, res$req), "Roster")
}

#' @title
#' **Get TPBL Team Shots**
#' @description
#' Every field-goal attempt of one team in one division with its court position (optionally per quarter).
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/divisions/{division_id}/teams/{team_id}/shooting-spots`
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id.
#' @param team_id Required. TPBL team id (the franchise, 2-8, stable across seasons); `team_id` in tpbl_teams. Not
#'   the GoHoops id.
#' @param rounds Quarter filter: a quarter number or a vector of them (1-4, 5 and 6 for overtimes); the runtime
#'   sends it as the API's repeatable `rounds[]`. `NULL` (the default) for all quarters.
#' @return
#' A `hoopR_data` tibble: Every field-goal attempt of one team in one division with its court position (optionally
#'   per quarter). An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_team_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. |
#' | rounds | character | The quarter filter asked for, comma-separated ('1' or '1,2'); null when all quarters were asked. |
#' | is_made | logical | True when the shot went in. |
#' | point_x | integer | Shot position in MILLIMETRES, 0-28000 along the court length (a 28 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. Verified on 2,971 shots of one team: the made rate within 1.2 m of the hoop is 62-71 %. Which baseline is x = 0 is unverified. |
#' | point_y | integer | Shot position in MILLIMETRES, 0-15000 across the court (a 15 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. The direction of y is unverified. |
#' | offense_basket | integer | Basket the team attacked: 0 = the hoop at x = 1575, 1 = the hoop at x = 26425. |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_team_shots(division_id = 2, team_id = 4, rounds = 1)")
#' @export
#' @family TPBL Functions
tpbl_team_shots <- function(division_id, team_id, rounds = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_team_route(division_id, team_id, "shooting-spots", rounds = rounds, call = call)
  .tpbl_out(.tpbl_parse_team_shots(res$body, res$req), "Team Shots")
}

#' @title
#' **Get TPBL Player Shots**
#' @description
#' Every field-goal attempt of one player in one division with its court position.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/divisions/{division_id}/players/{player_id}/shooting-spots`
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id.
#' @param player_id Required. TPBL player id (one per person across seasons and teams); `player_id` in tpbl_roster.
#'   Not the GoHoops person id and not the roster id.
#' @return
#' A `hoopR_data` tibble: Every field-goal attempt of one player in one division with its court position. An empty
#'   answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py `tpbl_player_shots`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. Not the GoHoops division id. |
#' | player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
#' | is_made | logical | True when the shot went in. |
#' | point_x | integer | Shot position in MILLIMETRES, 0-28000 along the court length (a 28 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. Same frame as the team list, where it was verified; here it is only checked to stay on the court. |
#' | point_y | integer | Shot position in MILLIMETRES, 0-15000 across the court (a 15 m court). The hoops sit at x = 1575 (offense_basket 0) and x = 26425 (offense_basket 1), y = 7500. The direction of y is unverified. |
#' | offense_basket | integer | Basket the player's team attacked: 0 = the hoop at x = 1575, 1 = the hoop at x = 26425. |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_player_shots(division_id = 2, player_id = 75)")
#' @export
#' @family TPBL Functions
tpbl_player_shots <- function(division_id, player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_player_shots_route(division_id, player_id, call)
  .tpbl_out(.tpbl_parse_player_shots(res$body, res$req), "Player Shots")
}

#' @title
#' **Get TPBL Player Game Log**
#' @description
#' A player's game log in one division: one row per game played, with that game's whole stat line.
#'
#' Endpoint: `GET https://api.tpbl.basketball/api/players/{player_id}/games/stats`
#' @param player_id Required. TPBL player id (one per person across seasons and teams); `player_id` in tpbl_roster.
#'   Not the GoHoops person id and not the roster id.
#' @param division_id Required. TPBL division id (one competition phase of one season: 1, 2, 5, 6, 7 = 2024-25
#'   preseason, regular season, playoffs, postseason challenge, finals; 8, 9, 11, 12, 35 = 2025-26; 655, 656 =
#'   2026-27); `division_id` in tpbl_divisions. Not the GoHoops division id. Without it the API answers HTTP 422; an
#'   unknown id answers HTTP 500, which is not retried.
#' @return
#' A `hoopR_data` tibble: A player's game log in one division: one row per game played, with that game's whole stat
#'   line. An empty answer raises `hoopR_no_data`; the columns are always these, in this order (sdv-py
#'   `tpbl_player_games`):
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | TPBL player id (key space: TPBL players; one per person across seasons and teams): the `{player_id}` of the player routes. Not the GoHoops person id and not the roster id. |
#' | gohoops_person_id | integer | GoHoops person id (key space: GoHoops persons; one per human). Not the TPBL player id and not the roster id. |
#' | gohoops_roster_id | integer | GoHoops roster id (key space: GoHoops rosters = one player registered with one squad in one season; it changes when the player changes season or team). His roster in the division: join tpbl_box_players to tpbl_roster on it. Not the TPBL player id and not the person id. |
#' | player | character | Player name (Traditional Chinese, or a transliteration for foreign players). |
#' | division_id | integer | TPBL division id (key space: TPBL divisions, one competition phase of one season; 1, 2, 5, 6, 7 = 2024-25, 8, 9, 11, 12, 35 = 2025-26, 655, 656 = 2026-27): the `{division_id}` of every division route. The division asked for. Not the GoHoops division id. |
#' | gohoops_division_id | integer | GoHoops division id (key space: GoHoops divisions; e.g. 64 = the 2024-25 preseason, 65 = the 2024-25 regular season). Not the TPBL division id. |
#' | team_id | integer | TPBL team id (key space: TPBL teams = franchises, 2-8 so far; stable across seasons): the `{team_id}` of the division team routes. Not the GoHoops franchise id and not the squad id. The team the player played for in that game. |
#' | team | character | Name of the team the player played for in that game. Team name in Traditional Chinese with the sponsor (Kaohsiung Aquas, Formosa Dreamers, Hsinchu Lioneers, Taoyuan Leopards, New Taipei CTBC DEA, New Taipei Kings, Taipei Mars). |
#' | game_id | integer | TPBL game id (key space: TPBL games on api.tpbl.basketball): the `{game_id}` of the game routes. Not sequential by date (2024-25 = 1-1367, 2025-26 = 1371-8641, 2026-27 = 27535-27667). The box score echoes no game id, so a box frame parsed without the request stamp has a null game_id. |
#' | gohoops_game_id | integer | GoHoops game id (key space: GoHoops games; 1242 for TPBL game 6). Not the TPBL game id. |
#' | game_title | character | Game title: the division name and the game number counted from the end (`<division name> Game 124` = regular season, game 124). |
#' | home_team_id | integer | TPBL team id of the home team of the game (franchise, 2-8). |
#' | away_team_id | integer | TPBL team id of the away team of the game (franchise, 2-8). |
#' | home_score | integer | Home team final score in the game. |
#' | away_score | integer | Away team final score in the game. |
#' | venue | character | Venue name in Traditional Chinese (the API's game location). |
#' | tipoff | POSIXct | Scheduled tip-off as a naive timestamp (no zone). Taiwan local date and time (UTC+8 by every tip-off seen; the API sends no zone). |
#' | periods_played | integer | Number of quarters in which the player was on court in this game. |
#' | score | integer | Points scored by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | rebounds | integer | Total rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (offensive + defensive). |
#' | assists | integer | Assists by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | steals | integer | Steals by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | blocks | integer | Blocked shots by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | turnovers | integer | Turnovers committed by the player in the game of this row (accumulated_stats of a one-game row is that game's total); equals the sum of the `*_turnovers` type columns (checked on 4,237 played player lines of 189 games). |
#' | fouls | integer | Fouls charged by the player in the game of this row (accumulated_stats of a one-game row is that game's total): personal + technical + unsportsmanlike + disqualifying; equals defensive_fouls + offensive_fouls (checked on 4,237 played player lines of 189 games). |
#' | roster_fouls | integer | Fouls charged to the roster member by the player in the game of this row (accumulated_stats of a one-game row is that game's total); equals fouls in the committed samples (meaning inferred from the name). |
#' | bench_fouls | integer | Fouls charged to the bench by the player in the game of this row (accumulated_stats of a one-game row is that game's total); 0 in every committed sample (meaning inferred from the name). |
#' | time_on_court | integer | Seconds on court by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (436 = 7:16). A team quarter sums its five players: 3600 = 5 x 720 s (12-minute quarter), 1500 = 5 x 300 s (5-minute overtime). |
#' | two_pointers_made | integer | 2-point field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_missed | integer | 2-point field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_attempted | integer | 2-point field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_made | integer | 3-point field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_missed | integer | 3-point field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_attempted | integer | 3-point field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | free_throws_made | integer | Free throws made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | free_throws_missed | integer | Free throws missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | free_throws_attempted | integer | Free throws attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_made | integer | Field goals made by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_missed | integer | Field goals missed by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_attempted | integer | Field goals attempted by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_made_in_the_paint | integer | Field goals made in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_missed_in_the_paint | integer | Field goals missed in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_attempted_in_the_paint | integer | Field goals attempted in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_made_on_fast_break | integer | Field goals made on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_missed_on_fast_break | integer | Field goals missed on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_attempted_on_fast_break | integer | Field goals attempted on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_made_on_second_chance | integer | Field goals made on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_missed_on_second_chance | integer | Field goals missed on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | field_goals_attempted_on_second_chance | integer | Field goals attempted on a second chance (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | defensive_rebounds | integer | Defensive rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | offensive_rebounds | integer | Offensive rebounds by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | offensive_fouls | integer | Fouls committed on offense by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | defensive_fouls | integer | Fouls committed on defense by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | personal_fouls | integer | Personal fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total) (excludes technical, unsportsmanlike and disqualifying fouls). |
#' | technical_fouls | integer | Technical fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | unsportsmanlike_fouls | integer | Unsportsmanlike fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | disqualifying_fouls | integer | Disqualifying fouls by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | bad_pass_turnovers | integer | Turnovers of type 'bad pass' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | ball_handling_turnovers | integer | Turnovers of type 'ball-handling error' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | out_of_bounds_turnovers | integer | Turnovers of type 'out of bounds' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | travel_turnovers | integer | Turnovers of type 'traveling' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_seconds_turnovers | integer | Turnovers of type 'three-second violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | five_seconds_turnovers | integer | Turnovers of type 'five-second violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | back_court_turnovers | integer | Turnovers of type 'back-court violation' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | offensive_goal_tending_turnovers | integer | Turnovers of type 'offensive goaltending' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | double_dribble_turnovers | integer | Turnovers of type 'double dribble' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | carry_turnovers | integer | Turnovers of type 'carrying' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | offensive_foul_turnovers | integer | Turnovers of type 'offensive foul' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | other_turnovers | integer | Turnovers of type 'other' by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | plus_minus | integer | Plus/minus: the team's point differential while the player was on court (standard definition; not independently checked). |
#' | fast_break_points | integer | Points scored on the fast break by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | second_chance_points | integer | Points scored on second chances (after an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | points_in_paint | integer | Points scored in the paint by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | points_off_turnovers | integer | Points scored off opponent turnovers by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_jump_shot_made | integer | 2-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_jump_shot_missed | integer | 2-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_jump_shot_attempted | integer | 2-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_jump_shot_made | integer | 3-point field goals made that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_jump_shot_missed | integer | 3-point field goals missed that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_jump_shot_attempted | integer | 3-point field goals attempted that were a jump shot (standing or catch-and-shoot) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_layup_made | integer | 2-point field goals made that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_layup_missed | integer | 2-point field goals missed that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_layup_attempted | integer | 2-point field goals attempted that were a layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_driving_layup_made | integer | 2-point field goals made that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_driving_layup_missed | integer | 2-point field goals missed that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_driving_layup_attempted | integer | 2-point field goals attempted that were a driving layup by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_dunk_made | integer | 2-point field goals made that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_dunk_missed | integer | 2-point field goals missed that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_dunk_attempted | integer | 2-point field goals attempted that were a dunk by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_dunk_made | integer | 2-point field goals made that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_dunk_missed | integer | 2-point field goals missed that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_dunk_attempted | integer | 2-point field goals attempted that were a putback dunk (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_tip_in_made | integer | 2-point field goals made that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_tip_in_missed | integer | 2-point field goals missed that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_putback_tip_in_attempted | integer | 2-point field goals attempted that were a putback tip-in (off an offensive rebound) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_alley_oop_made | integer | 2-point field goals made that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_alley_oop_missed | integer | 2-point field goals missed that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_alley_oop_attempted | integer | 2-point field goals attempted that were a alley-oop by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_hook_shot_made | integer | 2-point field goals made that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_hook_shot_missed | integer | 2-point field goals missed that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_hook_shot_attempted | integer | 2-point field goals attempted that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_hook_shot_made | integer | 3-point field goals made that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_hook_shot_missed | integer | 3-point field goals missed that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_hook_shot_attempted | integer | 3-point field goals attempted that were a hook shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_floating_jump_shot_made | integer | 2-point field goals made that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_floating_jump_shot_missed | integer | 2-point field goals missed that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_floating_jump_shot_attempted | integer | 2-point field goals attempted that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_floating_jump_shot_made | integer | 3-point field goals made that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_floating_jump_shot_missed | integer | 3-point field goals missed that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_floating_jump_shot_attempted | integer | 3-point field goals attempted that were a floating jump shot (floater) by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_fadeaway_jump_shot_made | integer | 2-point field goals made that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_fadeaway_jump_shot_missed | integer | 2-point field goals missed that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_fadeaway_jump_shot_attempted | integer | 2-point field goals attempted that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_fadeaway_jump_shot_made | integer | 3-point field goals made that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_fadeaway_jump_shot_missed | integer | 3-point field goals missed that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_fadeaway_jump_shot_attempted | integer | 3-point field goals attempted that were a fadeaway jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_turnaround_jump_shot_made | integer | 2-point field goals made that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_turnaround_jump_shot_missed | integer | 2-point field goals missed that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_turnaround_jump_shot_attempted | integer | 2-point field goals attempted that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_turnaround_jump_shot_made | integer | 3-point field goals made that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_turnaround_jump_shot_missed | integer | 3-point field goals missed that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_turnaround_jump_shot_attempted | integer | 3-point field goals attempted that were a turnaround jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_step_back_jump_shot_made | integer | 2-point field goals made that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_step_back_jump_shot_missed | integer | 2-point field goals missed that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_step_back_jump_shot_attempted | integer | 2-point field goals attempted that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_step_back_jump_shot_made | integer | 3-point field goals made that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_step_back_jump_shot_missed | integer | 3-point field goals missed that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_step_back_jump_shot_attempted | integer | 3-point field goals attempted that were a step-back jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_pull_up_jump_shot_made | integer | 2-point field goals made that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_pull_up_jump_shot_missed | integer | 2-point field goals missed that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | two_pointers_pull_up_jump_shot_attempted | integer | 2-point field goals attempted that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_pull_up_jump_shot_made | integer | 3-point field goals made that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_pull_up_jump_shot_missed | integer | 3-point field goals missed that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | three_pointers_pull_up_jump_shot_attempted | integer | 3-point field goals attempted that were a pull-up jump shot by the player in the game of this row (accumulated_stats of a one-game row is that game's total). |
#' | efficiency | integer | Efficiency rating by the player in the game of this row (accumulated_stats of a one-game row is that game's total): (points + rebounds + assists + steals + blocks) - (missed field goals + missed free throws + turnovers); verified on all 4,237 played player lines of 189 games. |
#' | pir | integer | Performance index rating: efficiency minus fouls (the API's performance_index_rating; checked on 189 games of the box-score lines). |
#' | two_pointers_percentage | double | 2-point field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | three_pointers_percentage | double | 3-point field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | free_throws_percentage | double | Free throws percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | field_goals_percentage | double | Field goals percentage , 0-100 as a string with one decimal ('57.1'); '0.0' without attempts. |
#' | turnovers_percentage | double | Turnover percentage, 0-100 (a one-decimal string on the API; the exact formula is not documented). |
#' | efg | double | Effective field-goal percentage, 0-100 (the API's effective_field_goals_percentage, a one-decimal string). |
#' | tsp | double | True-shooting percentage, 0-100 (the API's true_shooting_percentage, a one-decimal string). |
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_player_games(player_id = 75, division_id = 2)")
#' @export
#' @family TPBL Functions
tpbl_player_games <- function(player_id, division_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_player_games_route(player_id, division_id, call)
  .tpbl_out(.tpbl_parse_player_games(res$body, res$req), "Player Game Log")
}
