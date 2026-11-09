# The @details of every feb topic that shares the feb_game_info() notes (roxygen @eval .intl_details()).
.feb_game_info_details <- c(
  "The Spanish Basketball Federation (FEB) wrappers cover Primera FEB, Segunda",
  "FEB and Liga Femenina Endesa (plus the federation's other groups on the same",
  "routes). They mirror sportsdataverse-py's `sportsdataverse.basketball.feb` wrappers of",
  "the same names: same arguments, the same snake_case columns and types, one",
  "row per sportsdataverse-py row.",
  "",
  "**Legal notice.** The FEB's aviso legal (legal notice) asserts",
  "intellectual-property rights over the site's content and its databases (the",
  "EU database right). It has no explicit scraping clause, and robots.txt",
  "answers 404 on both hosts. Fetching for your own use on your own machine is",
  "how these wrappers are meant to be used; check the notice before you",
  "republish the data.",
  "",
  "**Unofficial and unsupported.** The LiveStats API",
  "(`intrafeb.feb.es`) is the federation's own widget backend, not a documented",
  "public API. It needs a bearer token, which is public: it is read from the",
  "home page of `baloncestoenvivo.feb.es` at run time, kept in memory for the R",
  "session (24 h validity, renewed once on an HTTP 401) and never printed,",
  "logged or written. Requests are spaced at least one second apart per host;",
  "429 and 5xx answers are retried (three attempts).",
  "",
  "**Coverage.** The game routes answer from 2020-21 (Liga Femenina Endesa from",
  "its first game; Primera FEB from 2021-03-12, so its earlier 2020-21 games",
  "and every earlier season answer 404). 2020-21 play-by-play is text only. The",
  "schedule pages go back to 1996-97 (`season = 1997`).",
  "",
  "**Seasons** are END years (`season = 2027` is 2026-27); the site's own `t`",
  "key is the START year, so the request sends `t = season - 1`.",
  "",
  "**Errors** are classed conditions, never a warning plus an empty frame:",
  "`hoopR_no_data` (HTTP 404, an unknown group, a schedule page with no games,",
  "an empty overview window), `hoopR_bad_request` (HTTP 400 / 422, or a",
  "`game_id`, `group` or `season` that is not a non-negative integer) and",
  "`hoopR_asset_fetch` (any other failure: another status, a transport error,",
  "a token the API still rejects after one renewal, a non-JSON or non-HTML",
  "body, an error or changed envelope, a play-by-play of another game, a page",
  "for another group or season, or layout drift). All inherit `hoopR_error`."
)

#' @title
#' **FEB Game Info**
#' @description
#' **Game header of one FEB game: competition, tip-off, venue, officials,
#' status, both teams and the score.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#' (every game route carries the header; this reads the lightest one).
#' @param game_id (*integer* required): FEB game id, e.g. `2535725`; the
#'   `game_id` column of [feb_schedule()], [feb_results()] and [feb_overview()].
#' @eval .intl_details(.feb_game_info_details, full = TRUE)
#' @eval .returns_rd("feb_game_info", inline = FALSE, unit = "game")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_game_info(game_id = 2535725))
#' }
feb_game_info <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_game_info(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Period Scores**
#' @description
#' **Points each team scored in each period of one FEB game.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#'
#' One row per period played; the points are scored IN the period, not
#' cumulative. Overtime numbering is unverified.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_period_scores(game_id = 2535725)")
#' @eval .returns_rd("feb_period_scores", inline = FALSE, unit = "period played")
#' @family FEB Functions
#' @export
feb_period_scores <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_period_scores(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Team Stats**
#' @description
#' **Team totals of both teams in one FEB game: shooting, rebounds, assists,
#' turnovers, fouls.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/TeamStats/{game_id}`
#'
#' One row per team, home first. `fastb`, `ptsto`, `secpts`, `bench` and
#' `paint` are null on every sampled game (the stat crews do not fill them);
#' `seconds_played` and `val` are null on these rows.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_team_stats(game_id = 2535725)")
#' @eval .returns_rd("feb_team_stats", inline = FALSE, unit = "team")
#' @family FEB Functions
#' @export
feb_team_stats <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_team_stats(.feb_api_get("TeamStats", gid), as.integer(gid))
}

#' @title
#' **FEB Player Box Score**
#' @description
#' **Per-player box score of one FEB game: minutes, points, shooting splits,
#' rebounds, assists, fouls and plus/minus.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/BoxScore/{game_id}`
#'
#' One row per player and team. `p1` / `p2` / `p3` are free throws, two- and
#' three-point field goals (`m` made, `a` attempted, `p` percentage 0-100);
#' `seconds_played` is the provider's `min` (seconds, not minutes);
#' `player_id` is the FEB person id (stable across seasons) and
#' `shirt_number` stays a string (`"00"` is not `"0"`).
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details)
#' @eval .returns_rd("feb_player_box", inline = FALSE, unit = "player and team")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_player_box(game_id = 2535725))
#' }
feb_player_box <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_player_box(.feb_api_get("BoxScore", gid), as.integer(gid))
}

#' @title
#' **FEB Play-by-Play**
#' @description
#' **Play-by-play of one FEB game (KeyFacts): every shot, rebound, foul,
#' substitution and timeout, in Spanish text with coded actions, oldest play
#' first.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/KeyFacts/{game_id}`
#'
#' A body whose plays name another game is refused (`hoopR_asset_fetch`), not
#' returned. 2020-21 games are text only: `action`, the ids, the parameters,
#' the position and the log times are `NA` there.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details)
#' @eval .returns_rd("feb_pbp", inline = FALSE, unit = "play-by-play event")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_pbp(game_id = 2535725))
#' }
feb_pbp <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_pbp(.feb_api_get("KeyFacts", gid), as.integer(gid))
}

#' @title
#' **FEB Shots**
#' @description
#' **Every field-goal attempt of one FEB game with its court position (percent
#' of a full-court image).**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/ShotChart/{game_id}`
#'
#' Free throws are not in the feed. `x` / `y` are percent (0-100) of a
#' horizontal full-court image, origin top-left; teams change ends at
#' half-time. The feed names the shooter by shirt number: `player_id` is
#' resolved through the game's roster (side + shirt number) and is `NA` when
#' that pair is not unique.
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_shots(game_id = 2535725)")
#' @eval .returns_rd("feb_shots", inline = FALSE, unit = "shot")
#' @family FEB Functions
#' @export
feb_shots <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_shots(.feb_api_get("ShotChart", gid), as.integer(gid))
}

#' @title
#' **FEB Game Leaders**
#' @description
#' **Each team's top players of one FEB game by points, rebounds, assists and
#' fouls.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/Ranking/{game_id}`
#'
#' One row per team, category and ranked player (`rank` 1 = the leader, in the
#' order the feed lists them).
#' @inheritParams feb_game_info
#' @eval .intl_details(.feb_game_info_details, "feb_leaders(game_id = 2535725)")
#' @eval .returns_rd("feb_leaders", inline = FALSE, unit = "team, statistic and rank")
#' @family FEB Functions
#' @export
feb_leaders <- function(game_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  gid <- .feb_int_arg(game_id, "game_id")
  .feb_parse_leaders(.feb_api_get("Ranking", gid), as.integer(gid))
}

#' @title
#' **FEB Overview**
#' @description
#' **Today's (or the latest) games of every live FEB competition, with scores
#' and status.**
#'
#' Endpoint: `GET https://intrafeb.feb.es/LiveStats.API/api/v1/overview`
#'
#' One row per game across the competitions with games in the window. An off
#' day with no competitions raises `hoopR_no_data`; a game listed under
#' another competition is refused (`hoopR_asset_fetch`).
#' @eval .intl_details(.feb_game_info_details, "feb_overview()")
#' @eval .returns_rd("feb_overview", inline = FALSE, unit = "game across the competitions with games in the window")
#' @family FEB Functions
#' @export
feb_overview <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .feb_parse_overview(.feb_api_get("overview"))
}

#' @title
#' **FEB Schedule**
#' @description
#' **Full schedule of one group (phase) of a FEB competition season: every
#' round, game, result and team-season id.**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/calendario.aspx?g={group}&t={season - 1}`
#'
#' Played games carry no date or time on this page: use `round_date` or
#' [feb_game_info()]'s `start_time`. The page renders only the FIRST phase of
#' the group (Segunda FEB shows group A); other phases and the playoffs need an
#' ASP.NET postback and are not modelled. A page for another group or season
#' is refused (`hoopR_asset_fetch`), an unknown group is `hoopR_no_data`.
#' @param group (*integer* required): The site's menu group: 1 Primera FEB, 2
#'   Segunda FEB, 4 Liga Femenina Endesa, 9 and 10 LF-2, 67 LF Challenge, 73
#'   Copa de Espana, 74 Liga U. A group is not a competition id (see
#'   `comp_id`).
#' @param season (*integer* required): Season END year (`2027` = 2026-27),
#'   sent to the site as its START-year key `t = season - 1`.
#' @eval .intl_details(.feb_game_info_details)
#' @eval .returns_rd("feb_schedule", inline = FALSE, unit = "game")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_schedule(group = 1, season = 2027))
#' }
feb_schedule <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("calendar", group, season)
  .feb_frame(rec$games, .feb_specs$schedule, "schedule")
}

#' @title
#' **FEB Results**
#' @description
#' **Latest round's results and the next round's fixtures of a FEB competition
#' season.**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`
#'
#' `section` is `results` (the LATEST round of the shown phase; for a finished
#' season the last playoff round) or `next_round` (empty once the season is
#' over). `comp_id` ties the site group to the API's competition id (group 1
#' -> 115, 2 -> 118, 4 -> 210).
#' @inheritParams feb_schedule
#' @eval .intl_details(.feb_game_info_details)
#' @eval .returns_rd("feb_results", inline = FALSE, unit = "game")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_results(group = 1, season = 2027))
#' }
feb_results <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("results", group, season)
  .feb_frame(rec$results, .feb_specs$results, "results")
}

#' @title
#' **FEB Standings**
#' @description
#' **League table of a FEB competition season (live standings, or the final
#' classification once it is over).**
#'
#' Endpoint: `GET https://baloncestoenvivo.feb.es/resultados.aspx?g={group}&t={season - 1}`
#'
#' `table` is `live` (the in-season table) or `final` (the final
#' classification: only `position` and the team, every other statistic is
#' `NA`); the page shows one of the two. Only the first phase of the group is
#' shown.
#' @inheritParams feb_schedule
#' @eval .intl_details(.feb_game_info_details)
#' @eval .returns_rd("feb_standings", inline = FALSE, unit = "team in the standings")
#' @family FEB Functions
#' @export
#' @examples
#' \donttest{
#'   try(feb_standings(group = 1, season = 2027))
#' }
feb_standings <- function(group, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  rec <- .feb_page("results", group, season)
  .feb_frame(rec$standings, .feb_specs$standings, "standings")
}
