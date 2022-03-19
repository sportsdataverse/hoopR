



#' **Get NBA Stats API play-by-play**
#' @name pbp_linups
NULL
#' @title
#' **Get NBA Stats API play-by-play with Line-Ups**
#' @rdname pbp_linups
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param nest_data If TRUE returns nested data by game
#' @param return_message If TRUE returns message
#' @return Returns a named list of data frames: PlayByPlay
#'
# pbp_linups <-function(season = "2019-20",
#                       nest_data = FALSE,
#                       return_message = TRUE) {
#
#   if (game_ids %>% purrr::is_null()) {
#     stop("Please enter game ids")
#   }
#
#   games <- nba_leaguegamelog(season = "2019-20")
#
#   ids <- unique(games$game_id)
#
#   get_pbp_safe <- purrr::possibly(nba_pbp, dplyr::tibble())
#
#   all_data <- ids[1:5] %>%
#     purrr::map_dfr(function(game_id) {
#       get_pbp_safe(game_id = game_id,
#                    return_message = return_message,
#                    version = "v2")
#     })
#
#   team_loc <- games %>%
#     dplyr::select(game_id, team, opp, location) %>%
#     dplyr::mutate(
#       home_team = ifelse(.data$location == "H", .data$team, .data$opp),
#       away_team = ifelse(.data$location == "A", .data$opp, .data$team)
#     ) %>%
#     dplyr::select(-c(.data$team, .data$opp, .data$location)) %>%
#     dplyr::distinct(.data$game_id, .keep_all = TRUE)
#
#   all_data <- all_data %>%
#     dplyr::left_join(team_loc, by = "game_id")
#
#   # Get when subs are made
#   subs_made <- all_data %>%
#     dplyr::filter(event_msg_type == 8) %>%
#     dplyr::mutate(team_location = ifelse(player1_team_abbreviation == home_team, "Home", "Away")) %>%
#     dplyr::select(
#       game_id,
#       period,
#       time_quarter,
#       secs_passed_game,
#       player_team = player1_team_abbreviation,
#       team_location,
#       playerOut = player1_name,
#       playerIn = player2_name
#     ) %>%
#     tidyr::pivot_longer(
#       cols = c("playerOut", "playerIn"),
#       names_to = "in_out",
#       names_prefix = "player",
#       values_to = "player_name"
#     ) %>%
#     dplyr::group_by(game_id, period, player_team, player_name) %>%
#     dplyr::filter(dplyr::row_number() == 1) %>%
#     dplyr::ungroup()
#
#   # start of Quarters or OT
#   others_qtr <- all_data %>%
#     dplyr::filter(
#       event_msg_type == 8,
#       !(action %in% c("6_10", "6_11", "6_16", "6_18", "6_25")),
#       !(action == "11_1")
#     ) %>%
#     tidyr::pivot_longer(
#       cols = c("player1_name", "player2_name", "player3_name"),
#       names_to = "player_number",
#       names_prefix = "player_name",
#       values_to = "player_name"
#     ) %>%
#     dplyr::mutate(
#       player_team = dplyr::case_when(
#         player_number == "player1_name" ~ player1_team_abbreviation,
#         player_number == "player2_name" ~ player2_team_abbreviation,
#         player_number == "player3_name" ~ player3_team_abbreviation,
#         TRUE ~ "None"
#       )
#     ) %>%
#     dplyr::mutate(team_location = ifelse(player_team == home_team, "Home", "Away")) %>%
#     dplyr::filter(
#       !is.na(player_name),
#       !is.na(player_team)
#     ) %>%
#     dplyr::anti_join(
#       subs_made %>%
#         dplyr::select(game_id, period, player_team, player_name),
#       by = c("game_id", "period", "player_name", "player_team")
#     ) %>%
#     dplyr::distinct(
#       game_id,
#       period,
#       player_name,
#       player_team,
#       team_location
#     )
#
#
#   # get all the players who played
#   lineups_quarters <- subs_made %>%
#     dplyr::filter(in_out == "Out") %>%
#     dplyr::bind_rows(others_qtr) %>%
#     dplyr::select(
#       game_id,
#       period,
#       player_team,
#       player_name,
#       team_location
#     ) %>%
#     dplyr::arrange(
#       game_id,
#       period,
#       player_team
#     )
#
#
#
#
#
#
#   if (nest_data) {
#     all_data <-
#       all_data %>%
#       dplyr::group_by(.data$game_id) %>%
#       tidyr::nest()
#   }
#
#   return(all_data)
# }
