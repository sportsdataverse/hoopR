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
#' | NBA function | MBB function |
#' |---|---|
#' | [espn_nba_pbp()]            | [espn_mbb_pbp()] |
#' | [espn_nba_scoreboard()]     | [espn_mbb_scoreboard()] |
#' | [espn_nba_game_all()]       | [espn_mbb_game_all()] |
#' | [espn_nba_game_rosters()]   | [espn_mbb_game_rosters()] |
#' | [espn_nba_player_box()]     | [espn_mbb_player_box()] |
#' | [espn_nba_team_box()]       | [espn_mbb_team_box()] |
#' | [espn_nba_wp()]             | [espn_mbb_wp()] |
#'
#' ## **Reference data**
#'
#' | NBA function | MBB function |
#' |---|---|
#' | [espn_nba_teams()]          | [espn_mbb_teams()] |
#' | [espn_nba_standings()]      | [espn_mbb_standings()] |
#' | [espn_nba_player_stats()]   | [espn_mbb_player_stats()] |
#' | [espn_nba_team_stats()]     | [espn_mbb_team_stats()] |
#' | [espn_nba_betting()]        | [espn_mbb_betting()] |
#' |                             | [espn_mbb_conferences()] |
#' |                             | [espn_mbb_rankings()] |
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
