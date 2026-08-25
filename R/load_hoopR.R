#' @name hoopR_loaders
#' @aliases hoopR_loaders load_nba load_mbb
#' @title **hoopR Data Loaders Overview**
#' @description
#' Loaders for full seasons of pre-scraped data from the
#' `sportsdataverse/hoopR-{nba,mbb}-data` releases on
#' `sportsdataverse-data`. Each helper validates the requested
#' seasons, builds the per-asset URLs, downloads in parallel (with
#' optional [progressr] progress + optional `DBI` insertion), and
#' tags the result with the `hoopR_data` S3 class.
#'
#' @details
#'
#' ## **NBA loaders**
#'
#' \if{html}{\tabular{ll}{
#'    Function \tab Asset family \cr
#'    \code{\link[=load_nba_pbp]{load_nba_pbp()}} \tab NBA play-by-play \cr
#'    \code{\link[=load_nba_player_box]{load_nba_player_box()}} \tab NBA player boxscores \cr
#'    \code{\link[=load_nba_team_box]{load_nba_team_box()}} \tab NBA team boxscores \cr
#'    \code{\link[=load_nba_schedule]{load_nba_schedule()}} \tab NBA schedule \cr
#'    \code{\link[=update_nba_db]{update_nba_db()}} \tab Delta loader -> DB \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' ## **MBB loaders**
#'
#' \if{html}{\tabular{ll}{
#'    Function \tab Asset family \cr
#'    \code{\link[=load_mbb_pbp]{load_mbb_pbp()}} \tab Men's college basketball PBP \cr
#'    \code{\link[=load_mbb_player_box]{load_mbb_player_box()}} \tab MBB player boxscores \cr
#'    \code{\link[=load_mbb_team_box]{load_mbb_team_box()}} \tab MBB team boxscores \cr
#'    \code{\link[=load_mbb_schedule]{load_mbb_schedule()}} \tab MBB schedule \cr
#'    \code{\link[=update_mbb_db]{update_mbb_db()}} \tab Delta loader -> DB \cr
#' }}
#' \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords Loaders
#' @family hoopR Loaders
NULL
