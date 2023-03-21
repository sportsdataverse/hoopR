# #' **Get NBA Stats API Boxscore Traditional V3**
# #' @name bs_trad_v3
# NULL
# #' @title
# #' **Get NBA Stats API Boxscore Traditional V3**
# #' @rdname bs_trad_v3
# #' @author Saiem Gilani
# #' @param game_id Game ID
# #' @param start_period start_period
# #' @param end_period end_period
# #' @param start_range start_range
# #' @param end_range end_range
# #' @param range_type range_type
# #' @param ... Additional arguments passed to an underlying function like httr.
# #' @return A list of data frames: PlayerStats, TeamStarterBenchStats, TeamStats
# #' @importFrom jsonlite fromJSON toJSON
# #' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
# #' @import rvest
# #' @export
# nba_boxscoretraditionalv3 <- function(
#     game_id = '0022200021',
#     start_period = 0,
#     end_period = 14,
#     start_range = 0,
#     end_range = 0,
#     range_type = 0,
#     ...){
#
#   version <- "boxscoretraditionalv3"
#   endpoint <- nba_endpoint(version)
#
#   full_url <- paste0(endpoint,
#                      "?EndPeriod=", end_period,
#                      "&EndRange=", end_range,
#                      "&GameID=",pad_id(game_id),
#                      "&RangeType=", range_type,
#                      "&StartPeriod=",start_period,
#                      "&StartRange=", start_range)
#   tryCatch(
#     expr = {
#
#       resp <- request_with_proxy(url = full_url)
#
#       df_list <- resp %>%
#         purrr::pluck("boxScoreTraditional") %>%
#         dplyr::as_tibble()
#       df_list$homeTeam %>%
#         dplyr::as_tibble() %>%
#         tidyr::unnest("players")
#
#     },
#     error = function(e) {
#       message(glue::glue("{Sys.time()}: Invalid arguments or no traditional boxscore v2 data for {game_id} available!"))
#     },
#     warning = function(w) {
#     },
#     finally = {
#     }
#   )
#   return(df_list)
# }
#
#
#
# #' **Get NBA Stats API Boxscore Hustle V2**
# #' @name bs_hustle_v2
# NULL
# #' @title
# #' **Get NBA Stats API Boxscore Hustle V2**
# #' @rdname bs_hustle_v2
# #' @author Saiem Gilani
# #' @param game_id Game ID
# #' @param ... Additional arguments passed to an underlying function like httr.
# #' @return Returns a named list of data frames: HustleStatsAvailable, PlayerStats, TeamStats
# #' @importFrom jsonlite fromJSON toJSON
# #' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
# #' @import rvest
# #' @export
# #' @details
# #' ```r
# #'  nba_boxscorehustlev2(game_id = "0022200021")
# #' ```
# nba_boxscorehustlev2 <- function(
#     game_id = '0022200021',
#     ...){
#
#   version <- "boxscorehustlev2"
#   endpoint <- nba_endpoint(version)
#
#   full_url <- paste0(endpoint,
#                      "?GameID=",pad_id(game_id))
#   tryCatch(
#     expr = {
#
#       resp <- request_with_proxy(url = full_url)
#       box_score_hustle <- resp %>%
#         purrr::pluck("boxScoreHustle")
#
#       ids_df <- box_score_hustle %>%
#         data.frame() %>%
#         dplyr::select("gameId","awayTeamId","homeTeamId") %>%
#         dplyr::distinct()
#
#       home_team_hustle <- box_score_hustle %>%
#         purrr::pluck("homeTeam")
#       home_team_totals <- home_team_hustle %>%
#         purrr::pluck("statistics") %>%
#         data.frame(stringsAsFactors = F)
#       home_team_players <- home_team_hustle %>%
#         purrr::pluck("players") %>%
#         data.frame(stringsAsFactors = F) %>%
#         tidyr::unnest("statistics")
#       df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
#         data <- resp$resultSets$rowSet[[x]] %>%
#           data.frame(stringsAsFactors = F) %>%
#           dplyr::as_tibble()
#
#         json_names <- resp$resultSets$headers[[x]]
#         colnames(data) <- json_names
#         return(data)
#       })
#       names(df_list) <- resp$resultSets$name
#     },
#     error = function(e) {
#       message(glue::glue("{Sys.time()}: Invalid arguments or no hustle stats boxscore data for {game_id} available!"))
#     },
#     warning = function(w) {
#     },
#     finally = {
#     }
#   )
#   return(df_list)
# }


