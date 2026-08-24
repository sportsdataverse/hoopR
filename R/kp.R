#' @name kp
#' @aliases kp kenpom hoopR_kenpom
#' @title **KenPom Scraper Overview**
#' @description
#' Authenticated scrapers for [kenpom.com](https://kenpom.com) men's
#' college-basketball pages. Authentication uses an `httr2` cookie jar
#' via `login()`; pages are pulled with `.kp_get_page(jar, url)` and
#' parsed with `rvest`. CSS selectors for tables are fragile — KenPom
#' changes the HTML occasionally and selectors may need updating.
#'
#' Credentials are read from `KP_USER` / `KP_PW` env vars (or function
#' args). See `?login` for the auth flow.
#'
#' @details
#'
#' ## **Team / season ratings**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_pomeroy_ratings()]              | Pomeroy season ratings |
#' | [kp_pomeroy_archive_ratings()]      | Historical Pomeroy ratings |
#' | [kp_program_ratings()]              | Program-level ratings |
#' | [kp_team_history()]                 | Team history page |
#' | [kp_arenas()]                       | Arena reference |
#'
#' ## **Per-game / per-team detail**
#'
#' \if{html}{\tabular{ll}{
#'    Function \tab Purpose \cr
#'    \code{\link[=kp_box]{kp_box()}} \tab Box-score detail \cr
#'    \code{\link[=kp_fanmatch]{kp_fanmatch()}} \tab FanMatch daily slate \cr
#'    \code{\link[=kp_gameplan]{kp_gameplan()}} \tab Game-plan page \cr
#'    \code{\link[=kp_team_lineups]{kp_team_lineups()}} \tab Team lineup stats \cr
#'    \code{\link[=kp_team_depth_chart]{kp_team_depth_chart()}} \tab Team depth chart \cr
#'    \code{\link[=kp_team_player_stats]{kp_team_player_stats()}} \tab Per-team player stats \cr
#'    \code{\link[=kp_team_schedule]{kp_team_schedule()}} \tab Per-team schedule \cr
#'    \code{\link[=kp_team_players]{kp_team_players()}} \tab Team roster \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' ## **Conference / efficiency / four-factor splits**
#'
#' \if{html}{\tabular{ll}{
#'    Function \tab Purpose \cr
#'    \code{\link[=kp_conf]{kp_conf()}} \tab Conference summary \cr
#'    \code{\link[=kp_confhistory]{kp_confhistory()}} \tab Conference history \cr
#'    \code{\link[=kp_confstats]{kp_confstats()}} \tab Conference stats \cr
#'    \code{\link[=kp_efficiency]{kp_efficiency()}} \tab Efficiency rankings \cr
#'    \code{\link[=kp_fourfactors]{kp_fourfactors()}} \tab Four-factor rankings \cr
#'    \code{\link[=kp_pointdist]{kp_pointdist()}} \tab Points distribution \cr
#'    \code{\link[=kp_teamstats]{kp_teamstats()}} \tab Team stats \cr
#'    \code{\link[=kp_hca]{kp_hca()}} \tab Home-court advantage \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' ## **Player + coach + officials**
#'
#' | Function | Purpose |
#' |---|---|
#' | [kp_player_career()]         | Player career page |
#' | [kp_playerstats()]           | Player stats |
#' | [kp_kpoy()]                  | KenPom player of the year |
#' | [kp_height()]                | Team height/experience |
#' | [kp_coach_history()]         | Coach history |
#' | [kp_referee()]               | Referee splits |
#' | [kp_officials()]             | Game officials |
#'
#' ## **Trends and miscellany**
#'
#' [kp_trends()], [kp_winprob()], [kp_minutes_matrix()],
#' [kp_foul_trouble()], [kp_opptracker()], [kp_game_attrs()],
#' `kp_user_pw`.
#'
#' @keywords KenPom
#' @family KenPom
NULL
