# kzs.R -- KZS (Basketball Federation of Slovenia) wrappers over api.kzs.si/api/v1/public, the read API the
# kzs.si site calls, at parity with sportsdataverse-py sportsdataverse/basketball/kzs (origin/main e3d232ebc9).
# Transport, season mapping and refusals: R/kzs_runtime.R; frames: R/kzs_parsers.R; columns: R/kzs_schema.R.

# The @details of every kzs topic that shares the kzs_seasons() notes (roxygen @eval .intl_details()).
.kzs_seasons_details <- c(
  "* Unofficial and unsupported: these wrappers read the public read API (Java/Spring, built by OnixWeb) that the",
  "  kzs.si site itself calls. No terms of use were located (unverified), api.kzs.si/robots.txt answers 401 and",
  "  www.kzs.si/robots.txt 404, so no policy or Crawl-delay is published. The runtime waits at least 1 s before every",
  "  request, retries included.",
  "* Personal data: the API serves officials' and coaches' emails, phones and home towns, and clubs' bank accounts and",
  "  addresses, publicly. The parsers never output them (officials appear by name only; club addresses, personnel and",
  "  the commissioner report are dropped). Do not add them back.",
  "* Seasons are END years (2027 = 2026/2027); KZS' own season ids are opaque (27 = 2026/2027) and the runtime maps",
  "  them. Competition ids are per season. Three team keys are never interchangeable: the match-team id (per match and",
  "  side), team_id (one club team in one season) and club_id (across seasons). player_id is the registry id,",
  "  person_id the person behind it.",
  "* Errors are HTTP 400 for everything (an unknown id and a bad parameter alike), so the runtime raises",
  "  `hoopR_asset_fetch` for it, never `hoopR_bad_request` or an empty frame. List routes default to 150 rows with no",
  "  truncation signal: every list wrapper asks for a large limit and refuses a full page. The play-by-play and",
  "  box-score wrappers, the leaderboards, teams, rounds and playing days each make one extra, cached request (the",
  "  match header or the competition) to prove the answer is the one asked for and the game is final.",
  "* Coverage: scores from 2007/08; box scores and play-by-play from 2015/16. Some 2020/21 men's games have a box",
  "  score but no play-by-play (`hoopR_no_data`): the Genius data.json (genius_match_id in kzs_matches) is the",
  "  fallback. Shot x/y are Genius court percent; side (LEFT/RIGHT) names the basket end and teams switch ends at half",
  "  time, so normalise with side before stacking shots. Advanced box-score fields are 0 in every observed game.",
  "* Errors are classed conditions, all inheriting `hoopR_error`: `hoopR_no_data` (an empty answer or list, a",
  "  competition without standings, a final game with no play-by-play or box score, HTTP 404), `hoopR_asset_fetch`",
  "  (HTTP 400, the API's only error status for an unknown id and a bad parameter alike; any other non-2xx; a non-JSON",
  "  or empty body; an envelope whose status is not OK; a full list page; a game that is not final; a body for another",
  "  competition, match, team, player or season than the one asked for) and `hoopR_bad_request` (a bad argument,",
  "  before any request). HTTP 500 is retried. Wrappers raise; they never return an empty frame for a failed fetch."
)

#' @title
#' **Get KZS Seasons**
#' @description
#' Every season (39: 1991/1992 to 2029/2030) with its opaque id and the sdv END year.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/seasons/`
#' @eval .returns_rd("kzs_seasons", inline = FALSE, unit = "season")
#' @eval .intl_details(.kzs_seasons_details, full = TRUE)
#' @examples
#' \donttest{
#'   try(kzs_seasons())
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_seasons <- function() {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  raw <- .kzs_get("/seasons/", ids = list(), query = list(limit = 1000L), call = call)
  .kzs_out(.kzs_parse("seasons", raw), "KZS Seasons from api.kzs.si")
}

#' @title
#' **Get KZS Competitions**
#' @description
#' Competitions of a season (leagues, cups, youth, 3x3, national teams), or of every season.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/`
#' @param season Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque season id. Omitted = every
#'   season (627 competitions).
#' @eval .returns_rd("kzs_competitions", inline = FALSE, unit = "competition")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_competitions(season = 2026))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_competitions <- function(season = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  raw <- .kzs_get("/competitions/", ids = list(), query = list(limit = 10000L, season = season), call = call)
  .kzs_out(.kzs_parse("competitions", raw), "KZS Competitions from api.kzs.si")
}

#' @title
#' **Get KZS Competition**
#' @description
#' One competition: season, gender, category, rank and type (its phases are kzs_phases).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_competition", inline = FALSE, unit = "competition")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_competition(competition_id = 579))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_competition <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("competition", raw), "KZS Competition from api.kzs.si")
}

#' @title
#' **Get KZS Competition Phases**
#' @description
#' The phases of a competition (regular season, play-offs, finals) with dates and type.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_phases", inline = FALSE, unit = "phase")
#' @eval .intl_details(.kzs_seasons_details, "kzs_phases(competition_id = 579)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_phases <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("phases", raw), "KZS Competition Phases from api.kzs.si")
}

#' @title
#' **Get KZS Competition Rounds**
#' @description
#' Number of rounds of each phase of a competition.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/rounds`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_rounds", inline = FALSE, unit = "round")
#' @eval .intl_details(.kzs_seasons_details, "kzs_rounds(competition_id = 579)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_rounds <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/rounds", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("rounds", raw), "KZS Competition Rounds from api.kzs.si")
}

#' @title
#' **Get KZS Player Leaderboard**
#' @description
#' Player leaderboard of a competition for one stat category (total, per-game average and single-game best).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/playerStats`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param stats_category Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2 two-pointers,
#'   M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D
#'   defensive, R_O offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls committed/received, ASS_TOV
#'   and ST_TOV ratios. Competitions without live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of "PTS",
#'   "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG", "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D",
#'   "R_O", "ASS", "ST", "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".
#' @param order_type Figure the leaderboard is built on: AVERAGE (per game), SUM (season total) or BEST_PERFORMANCE.
#'   One of "AVERAGE", "SUM", "BEST_PERFORMANCE".
#' @param sort_by Row column the board is ordered by: avg (average), sum or max. The runtime checks the order. One of
#'   "avg", "sum", "max".
#' @param sort Sort direction. One of "ASC", "DESC".
#' @eval .returns_rd("kzs_player_leaderboard", inline = FALSE, unit = "player")
#' @eval .intl_details(.kzs_seasons_details, "kzs_player_leaderboard(competition_id = 579)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_player_leaderboard <- function(competition_id, stats_category = "PTS", order_type = "AVERAGE", sort_by = "avg",
                                    sort = "DESC") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  stats_category <- .kzs_choice(stats_category, .KZS_STATS_CATEGORIES, "stats_category", call = call)
  order_type <- .kzs_choice(order_type, c("AVERAGE", "SUM", "BEST_PERFORMANCE"), "order_type", call = call)
  sort_by <- .kzs_choice(sort_by, c("avg", "sum", "max"), "sort_by", call = call)
  sort <- .kzs_choice(sort, c("ASC", "DESC"), "sort", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/playerStats", ids = list(competition_id = competition_id),
                  query = list(limit = 1000L, statsCategory = stats_category, orderType = order_type, sortBy = sort_by,
                  sort = sort), call = call)
  .kzs_out(.kzs_parse("player_leaderboard", raw), "KZS Player Leaderboard from api.kzs.si")
}

#' @title
#' **Get KZS Team Leaderboard**
#' @description
#' Team leaderboard of a competition for one stat category (total, per-game average and single-game best).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/competitions/{competition_id}/teamStats`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param stats_category Stat category (the site's statsCategory): PTS points, M_2/A_2/PERC_2 two-pointers,
#'   M_3/A_3/PERC_3 three-pointers, M_FG/A_FG/PERC_FG field goals, M_FT/A_FT/PERC_FT free throws, R rebounds (R_D
#'   defensive, R_O offensive), ASS assists, ST steals, TOV turnovers, PF_CM/PF_RV fouls committed/received, ASS_TOV
#'   and ST_TOV ratios. Competitions without live stats offer only PTS, M_2, M_3, M_FT, A_FT, PERC_FT. One of "PTS",
#'   "M_2", "A_2", "PERC_2", "M_3", "A_3", "PERC_3", "M_FG", "A_FG", "PERC_FG", "M_FT", "A_FT", "PERC_FT", "R", "R_D",
#'   "R_O", "ASS", "ST", "TOV", "PF_CM", "PF_RV", "ASS_TOV", "ST_TOV".
#' @param order_type Figure the leaderboard is built on: AVERAGE (per game), SUM (season total) or BEST_PERFORMANCE.
#'   One of "AVERAGE", "SUM", "BEST_PERFORMANCE".
#' @param sort_by Row column the board is ordered by: avg (average), sum or max. The runtime checks the order. One of
#'   "avg", "sum", "max".
#' @param sort Sort direction. One of "ASC", "DESC".
#' @eval .returns_rd("kzs_team_leaderboard", inline = FALSE, unit = "team")
#' @eval .intl_details(.kzs_seasons_details, "kzs_team_leaderboard(competition_id = 579)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_team_leaderboard <- function(competition_id, stats_category = "PTS", order_type = "AVERAGE", sort_by = "avg", sort
                                  = "DESC") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  stats_category <- .kzs_choice(stats_category, .KZS_STATS_CATEGORIES, "stats_category", call = call)
  order_type <- .kzs_choice(order_type, c("AVERAGE", "SUM", "BEST_PERFORMANCE"), "order_type", call = call)
  sort_by <- .kzs_choice(sort_by, c("avg", "sum", "max"), "sort_by", call = call)
  sort <- .kzs_choice(sort, c("ASC", "DESC"), "sort", call = call)
  raw <- .kzs_get("/competitions/{competition_id}/teamStats", ids = list(competition_id = competition_id),
                  query = list(limit = 1000L, statsCategory = stats_category, orderType = order_type, sortBy = sort_by,
                  sort = sort), call = call)
  .kzs_out(.kzs_parse("team_leaderboard", raw), "KZS Team Leaderboard from api.kzs.si")
}

#' @title
#' **Get KZS Matches**
#' @description
#' Matches of a competition (optionally inside a from/to window) with the Genius LiveStats id.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @param date_from Earliest tip-off, an ISO instant such as 2025-10-01T00:00:00.000Z (a bare date is a 400). Omitted
#'   = the whole competition.
#' @param date_to Latest tip-off, an ISO instant such as 2025-10-31T23:59:59.000Z. Omitted = the whole competition.
#' @eval .returns_rd("kzs_matches", inline = FALSE, unit = "game")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_matches(
#'     competition_id = 579, date_from = "2025-10-01T00:00:00.000Z",
#'     date_to = "2025-10-31T23:59:59.000Z"
#'   ))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_matches <- function(competition_id, date_from = NULL, date_to = NULL) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  date_from <- .kzs_opt_str(date_from, "date_from", call = call)
  date_to <- .kzs_opt_str(date_to, "date_to", call = call)
  raw <- .kzs_get("/matches/", ids = list(), query = list(limit = 1000L, competitionId = competition_id,
                  from = date_from, to = date_to), call = call)
  .kzs_out(.kzs_parse("matches", raw), "KZS Matches from api.kzs.si")
}

#' @title
#' **Get KZS Match Header**
#' @description
#' Match header: teams, scores, venue, officials' names, best performers and status.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_match", inline = FALSE, unit = "game")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_match(match_id = 101839))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_match <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("match", raw), "KZS Match Header from api.kzs.si")
}

#' @title
#' **Get KZS Period Scores**
#' @description
#' Points by match part (quarters and overtimes) from the match header.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_period_scores", inline = FALSE, unit = "team and period")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_period_scores(match_id = 101839))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_period_scores <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("period_scores", raw), "KZS Period Scores from api.kzs.si")
}

#' @title
#' **Get KZS Play-by-Play**
#' @description
#' Play-by-play of a final game (2015/16 on, with gaps), one row per action with shot x/y.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_pbp", inline = FALSE, unit = "action with shot x/y")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_pbp(match_id = 101839))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_pbp <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/playByPlay", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("pbp", raw), "KZS Play-by-Play from api.kzs.si")
}

#' @title
#' **Get KZS Play-by-Play Players**
#' @description
#' The players the play-by-play feed lists for each side of a final game.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/playByPlay`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_pbp_players", inline = FALSE, unit = "player in the game")
#' @eval .intl_details(.kzs_seasons_details, "kzs_pbp_players(match_id = 101839)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_pbp_players <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/playByPlay", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("pbp_players", raw), "KZS Play-by-Play Players from api.kzs.si")
}

#' @title
#' **Get KZS Player Box Score**
#' @description
#' Box score of a final game (2015/16 on): one row per player of both teams.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_box_score", inline = FALSE, unit = "player of both teams")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_box_score(match_id = 101839))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_box_score <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("box_score", raw), "KZS Player Box Score from api.kzs.si")
}

#' @title
#' **Get KZS Team Box Score**
#' @description
#' Team totals of a final game's box score, one row per side.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_team_box_score", inline = FALSE, unit = "side")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_team_box_score(match_id = 101839))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_team_box_score <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("team_box_score", raw), "KZS Team Box Score from api.kzs.si")
}

#' @title
#' **Get KZS Score by Minute**
#' @description
#' The score at the end of each minute of a final game.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{match_id}/stats`
#' @param match_id (required) Match id (match_id in kzs_matches), e.g. 101839. Global across seasons.
#' @eval .returns_rd("kzs_score_changes", inline = FALSE, unit = "minute")
#' @eval .intl_details(.kzs_seasons_details, "kzs_score_changes(match_id = 101839)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_score_changes <- function(match_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  match_id <- .kzs_int_arg(match_id, "match_id", call = call)
  raw <- .kzs_get("/matches/{match_id}/stats", ids = list(match_id = match_id), query = list(), call = call)
  .kzs_out(.kzs_parse("score_changes", raw), "KZS Score by Minute from api.kzs.si")
}

#' @title
#' **Get KZS Standings**
#' @description
#' Standings of a competition, one row per team in each phase (and group).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/standings`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_standings", inline = FALSE, unit = "team in each phase")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_standings(competition_id = 579))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_standings <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/matches/standings", ids = list(), query = list(competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("standings", raw), "KZS Standings from api.kzs.si")
}

#' @title
#' **Get KZS Playing Days**
#' @description
#' Match days of a competition and the number of games on each.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/matches/{competition_id}/playingDays`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_playing_days", inline = FALSE, unit = "match day")
#' @eval .intl_details(.kzs_seasons_details, "kzs_playing_days(competition_id = 579)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_playing_days <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/matches/{competition_id}/playingDays", ids = list(competition_id = competition_id), query = list(),
                  call = call)
  .kzs_out(.kzs_parse("playing_days", raw), "KZS Playing Days from api.kzs.si")
}

#' @title
#' **Get KZS Teams**
#' @description
#' Teams entered in a competition.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/`
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_teams", inline = FALSE, unit = "team")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_teams(competition_id = 579))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_teams <- function(competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teams/", ids = list(), query = list(limit = 1000L, competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("teams", raw), "KZS Teams from api.kzs.si")
}

#' @title
#' **Get KZS Team Profile**
#' @description
#' Team profile: club, home hall, colours and the competitions the team entered.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @eval .returns_rd("kzs_team", inline = FALSE, unit = "team")
#' @eval .intl_details(.kzs_seasons_details, "kzs_team(team_id = 17551)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_team <- function(team_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  raw <- .kzs_get("/teams/{team_id}", ids = list(team_id = team_id), query = list(), call = call)
  .kzs_out(.kzs_parse("team", raw), "KZS Team Profile from api.kzs.si")
}

#' @title
#' **Get KZS Team Summary**
#' @description
#' A team's record, form and best players in one competition (the body echoes neither id).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teams/{team_id}/general`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_team_general", inline = FALSE, unit = "team")
#' @eval .intl_details(.kzs_seasons_details, "kzs_team_general(competition_id = 579, team_id = 17551)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_team_general <- function(team_id, competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teams/{team_id}/general", ids = list(team_id = team_id),
                  query = list(competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("team_general", raw), "KZS Team Summary from api.kzs.si")
}

#' @title
#' **Get KZS Team Roster**
#' @description
#' A team's roster in one competition (the rows carry no team or competition id).
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/teamPlayers/`
#' @param team_id (required) Team id (team_id in kzs_teams): one club team in one season, e.g. 17551. Not the
#'   match-team id nor the club id.
#' @param competition_id (required) Competition id (competition_id in kzs_competitions): one per competition per
#'   season, e.g. 579 (men's first league 2025/26).
#' @eval .returns_rd("kzs_roster", inline = FALSE, unit = "player")
#' @eval .intl_details(.kzs_seasons_details, "kzs_roster(competition_id = 579, team_id = 17551)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_roster <- function(team_id, competition_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  team_id <- .kzs_int_arg(team_id, "team_id", call = call)
  competition_id <- .kzs_int_arg(competition_id, "competition_id", call = call)
  raw <- .kzs_get("/teamPlayers/", ids = list(), query = list(limit = 1000L, teamId = team_id,
                  competitionId = competition_id), call = call)
  .kzs_out(.kzs_parse("roster", raw), "KZS Team Roster from api.kzs.si")
}

#' @title
#' **Get KZS Player Profile**
#' @description
#' Player profile: names, year of birth, nationality and positions.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}`
#' @param player_id (required) Player registry id (player_id in a box score or roster), e.g. 106285. Not the person
#'   id.
#' @eval .returns_rd("kzs_player", inline = FALSE, unit = "player")
#' @eval .intl_details(.kzs_seasons_details, "kzs_player(player_id = 106285)")
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_player <- function(player_id) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  player_id <- .kzs_int_arg(player_id, "player_id", call = call)
  raw <- .kzs_get("/players/{player_id}", ids = list(player_id = player_id), query = list(), call = call)
  .kzs_out(.kzs_parse("player", raw), "KZS Player Profile from api.kzs.si")
}

#' @title
#' **Get KZS Player Season Stats**
#' @description
#' A player's totals and per-game averages in each competition of one season.
#'
#' Endpoint: `GET https://api.kzs.si/api/v1/public/players/{player_id}/stats`
#' @param player_id (required) Player registry id (player_id in a box score or roster), e.g. 106285. Not the person
#'   id.
#' @param season (required) Season END year (2027 = 2026/2027); the wrapper maps it to KZS' opaque season id.
#' @eval .returns_rd("kzs_player_stats", inline = FALSE, unit = "competition")
#' @eval .intl_details(.kzs_seasons_details)
#' @examples
#' \donttest{
#'   try(kzs_player_stats(player_id = 106285, season = 2026))
#' }
#' @export
#' @concept KZS Functions
#' @seealso [family_kzs] lists every function in this family.
kzs_player_stats <- function(player_id, season) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  call <- rlang::current_env()
  player_id <- .kzs_int_arg(player_id, "player_id", call = call)
  raw <- .kzs_get("/players/{player_id}/stats", ids = list(player_id = player_id), query = list(season = season),
                  call = call)
  .kzs_out(.kzs_parse("player_stats", raw), "KZS Player Season Stats from api.kzs.si")
}
