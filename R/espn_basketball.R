#' @name espn_basketball
#' @aliases espn_basketball espn_nba espn_mbb
#' @title **ESPN Basketball Endpoint Overview (NBA + MBB)**
#' @description
#' Wrappers around ESPN's basketball endpoints. Two parallel families
#' share a common set of internal helpers in `R/espn_basketball_*.R`:
#'
#' - `espn_nba_*()` — ESPN NBA wrappers
#' - `espn_mbb_*()` — ESPN men's college basketball wrappers
#'
#' Each public wrapper is a thin shim over an internal helper that takes
#' a `league` argument (`"nba"` or `"mens-college-basketball"`); the
#' helper does the actual HTTP call + parsing.
#'
#' @details
#'
#' ## **Play-by-play, scoreboard, schedule**
#'
#' \if{html}{\tabular{ll}{
#'    NBA function \tab MBB function \cr
#'    \code{\link[=espn_nba_pbp]{espn_nba_pbp()}} \tab \code{\link[=espn_mbb_pbp]{espn_mbb_pbp()}} \cr
#'    \code{\link[=espn_nba_scoreboard]{espn_nba_scoreboard()}} \tab \code{\link[=espn_mbb_scoreboard]{espn_mbb_scoreboard()}} \cr
#'    \code{\link[=espn_nba_game_all]{espn_nba_game_all()}} \tab \code{\link[=espn_mbb_game_all]{espn_mbb_game_all()}} \cr
#'    \code{\link[=espn_nba_game_rosters]{espn_nba_game_rosters()}} \tab \code{\link[=espn_mbb_game_rosters]{espn_mbb_game_rosters()}} \cr
#'    \code{\link[=espn_nba_player_box]{espn_nba_player_box()}} \tab \code{\link[=espn_mbb_player_box]{espn_mbb_player_box()}} \cr
#'    \code{\link[=espn_nba_team_box]{espn_nba_team_box()}} \tab \code{\link[=espn_mbb_team_box]{espn_mbb_team_box()}} \cr
#'    \code{\link[=espn_nba_wp]{espn_nba_wp()}} \tab \code{\link[=espn_mbb_wp]{espn_mbb_wp()}} \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' ## **Reference data**
#'
#' \if{html}{\tabular{ll}{
#'    NBA function \tab MBB function \cr
#'    \code{\link[=espn_nba_teams]{espn_nba_teams()}} \tab \code{\link[=espn_mbb_teams]{espn_mbb_teams()}} \cr
#'    \code{\link[=espn_nba_standings]{espn_nba_standings()}} \tab \code{\link[=espn_mbb_standings]{espn_mbb_standings()}} \cr
#'    \code{\link[=espn_nba_player_stats]{espn_nba_player_stats()}} \tab \code{\link[=espn_mbb_player_stats]{espn_mbb_player_stats()}} \cr
#'    \code{\link[=espn_nba_team_stats]{espn_nba_team_stats()}} \tab \code{\link[=espn_mbb_team_stats]{espn_mbb_team_stats()}} \cr
#'    \code{\link[=espn_nba_betting]{espn_nba_betting()}} \tab \code{\link[=espn_mbb_betting]{espn_mbb_betting()}} \cr
#'     \tab \code{\link[=espn_mbb_conferences]{espn_mbb_conferences()}} \cr
#'     \tab \code{\link[=espn_mbb_rankings]{espn_mbb_rankings()}} \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' ## **HTTP layer**
#'
#' ESPN wrappers call `.retry_request()` directly without `...`, so
#' per-call proxy overrides aren't supported. Use
#' `options(hoopR.proxy = ...)` or the `http_proxy` /
#' `https_proxy` env vars for proxy routing.
#'
#' @keywords ESPN
#' @family ESPN Basketball
NULL
