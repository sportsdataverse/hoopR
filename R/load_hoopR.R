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
#' | Function | Asset family |
#' |---|---|
#' | [load_nba_pbp()]            | NBA play-by-play |
#' | [load_nba_player_box()]     | NBA player boxscores |
#' | [load_nba_team_box()]       | NBA team boxscores |
#' | [load_nba_schedule()]       | NBA schedule |
#' | [update_nba_db()]           | Delta loader -> DB |
#'
#' ## **MBB loaders**
#'
#' | Function | Asset family |
#' |---|---|
#' | [load_mbb_pbp()]            | Men's college basketball PBP |
#' | [load_mbb_player_box()]     | MBB player boxscores |
#' | [load_mbb_team_box()]       | MBB team boxscores |
#' | [load_mbb_schedule()]       | MBB schedule |
#' | [update_mbb_db()]           | Delta loader -> DB |
#'
#' @keywords Loaders
#' @family hoopR Loaders
NULL
