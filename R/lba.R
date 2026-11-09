# lba.R -- Lega Basket Serie A (Italy) wrappers over the site's own JSON API (www.legabasket.it/api), at parity
# with sportsdataverse-py sportsdataverse/basketball/lba (origin/main e3d232ebc9). Transport, season mapping and refusals:
# R/lba_runtime.R; frames: R/lba_parsers.R; columns: R/lba_schema.R. Generated from sportsdataverse-py
# tools/codegen/endpoints/legabasket.yaml and manual_column_descriptions.yaml.
# The @details of every lba topic that shares the lba_championships() notes (roxygen @eval .intl_details()).
.lba_championships_details <- c(
  "* Unofficial and unsupported: these wrappers read the JSON API that the Next.js site www.legabasket.it itself",
  "  calls. Legal notice: the site's terms say \"Non e' consentito copiare ... dati e informazioni senza",
  '  autorizzazione scritta" (copying data and information without written authorisation is not allowed), except for',
  "  personal, non-commercial use. Use the data accordingly, and check the terms before you republish it.",
  "* robots.txt allows /api and sets Crawl-delay: 2. The runtime waits 2 s before every request, retries included.",
  "  Crawl incrementally: fetch a final game once (keyed by game_id), find new games with one lba_calendar call per",
  "  round, and do not backfill a history in a burst.",
  "* Seasons are END years (2027 = 2026-27); the site sends START years and the runtime maps them (season - 1 on the",
  "  wire). Game and player ids are global; team ids are re-issued every season (join lba_teams for the stable",
  "  club_id); a championship id is one season AND one phase (Regular Season and Play Off differ).",
  "* Play-by-play starts in 2017-18 and changes shape in 2019-20 (pixel frame to court percent) and 2021-22; see",
  "  lba_pbp. Box scores reach back to 1995-96, where the period scores were not recorded (0 means missing).",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (HTTP 404, or a body with no rows:",
  "  an unknown season, a play-by-play before 2017-18, standings of a finished championship without a round),",
  "  `hoopR_bad_request` (a season that is not an END year, a bad choice, HTTP 400 / 422) and `hoopR_asset_fetch`",
  "  (any other non-2xx, a connection failure after retries, an empty / non-JSON / error-shaped 200, a game that is",
  "  not final on the box score, play-by-play and shot routes, a truncated page, or a body for another season,",
  "  championship, game, team, player, round or category than the one asked for). An unknown id is HTTP 500, which",
  "  is not retried. A body the parser finds no rows in gives a zero-row tibble with these columns."
)

#' @title
#' **Get LBA Championships**
#' @description
#' Championships of a season, one per phase (Regular Season, Play Off); every season when none is given.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships` (`cs_id=1&items=1000&s=<season>`)
#' @param season Season END year (2027 = 2026-27). Omitted = every season (310 championships).
#' @eval .returns_rd("lba_championships", inline = FALSE, unit = "championship (phase)")
#' @eval .intl_details(.lba_championships_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(lba_championships(season = 2027))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_championships <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("championships", list(s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Calendar**
#' @description
#' Games of one round of a championship: teams, score, venue, referees and broadcasters.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-calendar-by-id` (`id=<championship_id>&d=<round>`)
#' @param championship_id (required) Championship id (championship_id in lba_championships): one season AND one
#'   phase.
#' @param round Round number (day_serial, 1, 2, ...). Omitted = the current round (the last played for a finished
#'   championship).
#' @eval .returns_rd("lba_calendar", inline = FALSE, unit = "game")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_calendar(championship_id = 602, round = 1))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_calendar <- function(championship_id, round = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("calendar", list(id = championship_id, d = round), call = rlang::current_env())
}

#' @title
#' **Get LBA Game**
#' @description
#' Game header: teams, venue, quarter scores, coaches, referees and broadcasters.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-by-id` (`sc=1&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_game", inline = FALSE, unit = "game")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_game(game_id = 25602))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_game <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("game", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Box Score**
#' @description
#' Box score of a final game: one row per player of both teams (Italian-named stat columns).
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id` (`info=true&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_box_score", inline = FALSE, unit = "player of both teams")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_box_score(game_id = 25602))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_box_score <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("box_score", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Team Box Score**
#' @description
#' Team lines of a final game's box score: the team-booked stats and the totals of each side.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-scores-by-id` (`info=true&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_team_box_score", inline = FALSE, unit = "team in the game")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_team_box_score(game_id = 25602))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_team_box_score <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("team_box_score", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Play-by-Play**
#' @description
#' Play-by-play of a final game (2017-18 on), one row per action with x/y; coordinate frame by era.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play` (`info=true&sort=asc&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_pbp", inline = FALSE, unit = "action with x/y")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_pbp(game_id = 25602))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_pbp <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("pbp", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Play-by-Play Legend**
#' @description
#' The play-by-play qualifier code table (59 codes) with its Italian labels.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championships-matches-play-by-play` (`info=true&sort=asc&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_pbp_legend", inline = FALSE, unit = "play-by-play code")
#' @eval .intl_details(.lba_championships_details, "lba_pbp_legend(game_id = 25602)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_pbp_legend <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("pbp_legend", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Shots**
#' @description
#' Shooting by court zone per team for a final game (made / attempted aggregates; zone 7 includes free throws).
#'
#' Endpoint: `GET https://www.legabasket.it/api/matches/get-championship-matches-shots-by-id` (`info=1&id=<game_id>`)
#' @param game_id (required) Game id (game_id in lba_calendar), e.g. 25602. Global across seasons.
#' @eval .returns_rd("lba_shots", inline = FALSE, unit = "shooting zone")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_shots(game_id = 25602))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_shots <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("shots", list(id = game_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Standings**
#' @description
#' Standings of a championship after a round, one row per team.
#'
#' Endpoint: `GET https://www.legabasket.it/api/championships/get-championship-ranking` (`id=<championship_id>&d=<round>`)
#' @param championship_id (required) Championship id (championship_id in lba_championships; a Regular Season id
#'   carries standings).
#' @param round Standings after this round. Required in practice for a finished championship: without it the site
#'   sends none (NoDataError).
#' @eval .returns_rd("lba_standings", inline = FALSE, unit = "team in the standings")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_standings(championship_id = 602, round = 3))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_standings <- function(championship_id, round = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("standings", list(id = championship_id, d = round), call = rlang::current_env())
}

#' @title
#' **Get LBA Teams**
#' @description
#' Teams of a season, one row per team-season with the stable club id.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-teams` (`items=50&year=<season>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @eval .returns_rd("lba_teams", inline = FALSE, unit = "team-season with the stable club id")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_teams(season = 2027))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_teams <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("teams", list(year = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Roster**
#' @description
#' Players of one team-season with bio, number and role.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster` (`id=<team_id>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @eval .returns_rd("lba_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.lba_championships_details, "lba_roster(team_id = 1764)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_roster <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("roster", list(id = team_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Roster Coach**
#' @description
#' Head coach of one team-season.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-roster` (`id=<team_id>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @eval .returns_rd("lba_roster_coach", inline = FALSE, unit = "head coach")
#' @eval .intl_details(.lba_championships_details, "lba_roster_coach(team_id = 1764)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_roster_coach <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("roster_coach", list(id = team_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Team Players Stats**
#' @description
#' Season totals of each player of a team-season.
#'
#' Endpoint: `GET https://www.legabasket.it/api/teams/get-team-players-stats` (`cs_id=1&id=<team_id>&s=<season>`)
#' @param team_id (required) Team id (team_id in lba_teams), e.g. 1764. One team-season: ids are re-issued every
#'   season.
#' @param season Season END year (2027 = 2026-27) of the team id. Omitted = the site's default (unverified).
#' @eval .returns_rd("lba_team_players_stats", inline = FALSE, unit = "player of the team")
#' @eval .intl_details(.lba_championships_details, "lba_team_players_stats(team_id = 1764, season = 2027)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_team_players_stats <- function(team_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("team_players_stats", list(id = team_id, s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Players**
#' @description
#' Players of a season, 50 per page (walk the pages with page).
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-players` (`items=50&year=<season>&page=<page>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @param page Page number, 1-based. Omitted = the first page.
#' @eval .returns_rd("lba_players", inline = FALSE, unit = "player")
#' @eval .intl_details(.lba_championships_details)
#' @examples
#' \donttest{
#'   try(lba_players(season = 2027))
#' }
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_players <- function(season = NULL, page = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("players", list(year = season, page = page), call = rlang::current_env())
}

#' @title
#' **Get LBA Player**
#' @description
#' Player bio with current-season totals, highs and averages (one row).
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-by-id` (`stats=1&id=<player_id>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @eval .returns_rd("lba_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.lba_championships_details, "lba_player(player_id = 969)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("player", list(id = player_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Player Stats**
#' @description
#' A player's career by championship: per-game averages, single-game highs and totals.
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-stats` (`id=<player_id>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @eval .returns_rd("lba_player_stats", inline = FALSE, unit = "statistic type, season and championship")
#' @eval .intl_details(.lba_championships_details, "lba_player_stats(player_id = 969)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_player_stats <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("player_stats", list(id = player_id), call = rlang::current_env())
}

#' @title
#' **Get LBA Game Log**
#' @description
#' A player's game log for one season, one row per game.
#'
#' Endpoint: `GET https://www.legabasket.it/api/players/get-player-matches` (`cs_id=1&id=<player_id>&s=<season>`)
#' @param player_id (required) Player id (player_id in lba_players or a box score), e.g. 969. Global: one id for a
#'   whole career.
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @eval .returns_rd("lba_game_log", inline = FALSE, unit = "game")
#' @eval .intl_details(.lba_championships_details, "lba_game_log(player_id = 969, season = 2027)")
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_game_log <- function(player_id, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("game_log", list(id = player_id, s = season), call = rlang::current_env())
}

#' @title
#' **Get LBA Players Leaderboard**
#' @description
#' Season player leaderboard for one category (per-game average).
#'
#' Endpoint: `GET https://www.legabasket.it/api/statistics/get-players-statistics` (`cs_id=1&s=<season>&cat=<category>`)
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @param category Category: points, rating_lega, total_rebound, assists, shots_3p_perc, ... (the site's
#'   filters.categories).
#' @eval .returns_rd("lba_players_leaderboard", inline = FALSE, unit = "player")
#' @eval .intl_details(.lba_championships_details, 'lba_players_leaderboard(season = 2027, category = "points")')
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_players_leaderboard <- function(season = NULL, category = "points") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_call("players_leaderboard", list(s = season, cat = category), call = rlang::current_env())
}

#' @title
#' **Get LBA Teams Leaderboard**
#' @description
#' Season team leaderboards, offensive or defensive, one row per team and category.
#'
#' Endpoint: `GET https://www.legabasket.it/api/statistics/get-teams-statistics-by-type` (`cs_id=1&type=<board>&s=<season>`)
#' @param board (required) Board: teams_offensive or teams_defensive. One of `"teams_offensive"`,
#'   `"teams_defensive"`.
#' @param season Season END year (2027 = 2026-27). Omitted = the site's default season (unverified).
#' @eval .returns_rd("lba_teams_leaderboard", inline = FALSE, unit = "team and category")
#' @eval .intl_details(.lba_championships_details, 'lba_teams_leaderboard(board = "teams_offensive", season = 2027)')
#' @export
#' @concept LBA Functions
#' @seealso [family_lba] lists every function in this family.
lba_teams_leaderboard <- function(board, season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .lba_choice(board, c("teams_offensive", "teams_defensive"), "board", call = rlang::current_env())
  .lba_call("teams_leaderboard", list(type = board, s = season), call = rlang::current_env())
}
