# tpbl.R -- TPBL (Taiwan Professional Basketball League) wrappers over api.tpbl.basketball, the Laravel
# JSON API behind tpbl.basketball, at parity with sportsdataverse-py sportsdataverse/basketball/tpbl (origin/main
# e3d232ebc9). Transport, season mapping and refusals: R/tpbl_runtime.R; frames and columns:
# R/tpbl_parsers.R. Roxygen generated from sportsdataverse-py's endpoint YAML and column descriptions.

# The @details of every tpbl topic that shares the tpbl_seasons() notes (roxygen @eval .intl_details()).
.tpbl_seasons_details <- c(
  "* Unofficial and unsupported: these are the routes the tpbl.basketball site's own front end calls on",
  "  api.tpbl.basketball (read from its JavaScript bundle). The API is keyless and needs no headers;",
  "  tpbl.basketball/robots.txt answers 200 with an empty body. The runtime waits at least 1 s before every request,",
  "  retries included.",
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
#' @eval .returns_rd("tpbl_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.tpbl_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(tpbl_seasons())
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_divisions", inline = FALSE, unit = "division")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_divisions(season = 2026)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_teams(season = 2026))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_games", inline = FALSE, unit = "game")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_games(season = 2026))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_standings(division_id = 2))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_standings_against", inline = FALSE, unit = "team and opponent")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_standings_against(division_id = 2)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_game(game_id = 6))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_referees", inline = FALSE, unit = "official")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_referees(game_id = 6)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_box_players", inline = FALSE, unit = "player in the game")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_box_players(game_id = 6))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_box_player_periods", inline = FALSE, unit = "player and period")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_box_player_periods(game_id = 6)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_box_teams", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_box_teams(game_id = 6))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_box_team_periods", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_box_team_periods(game_id = 6)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.tpbl_seasons_details)
#' @examples
#' \donttest{
#'   try(tpbl_roster(division_id = 2, team_id = 4))
#' }
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_team_shots", inline = FALSE, unit = "shot")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_team_shots(division_id = 2, team_id = 4, rounds = 1)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_player_shots", inline = FALSE, unit = "shot")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_player_shots(division_id = 2, player_id = 75)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
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
#' @eval .returns_rd("tpbl_player_games", inline = FALSE, unit = "game played")
#' @eval .intl_details(.tpbl_seasons_details, "tpbl_player_games(player_id = 75, division_id = 2)")
#' @export
#' @concept TPBL Functions
#' @seealso [family_tpbl] lists every function in this family.
tpbl_player_games <- function(player_id, division_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  res <- .tpbl_player_games_route(player_id, division_id, call)
  .tpbl_out(.tpbl_parse_player_games(res$body, res$req), "Player Game Log")
}
