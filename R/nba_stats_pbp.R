
#' **Get NBA Stats API play-by-play**
#' @name pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param return_message If TRUE returns message
#' @return Returns a named list of data frames: PlayByPlay
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_pbp <- function(game_id, version = "v2", return_message = TRUE){

  if(version=="v2"){
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0&",
                     "GameID=",pad_id(game_id),
                     "&StartPeriod=0")

  # Shot Types - (numberEventActionType)
  layup <- c(5, 6, 41, 43, 44, 71:76, 97:100)
  dunk <- c(7, 9, 50, 51, 52, 87, 106:110)
  jump_shot <- c(1, 2, 66)
  hook_shot <- c(3, 57, 58, 67, 93, 96, 105)
  turnaround <- c(47)
  step_back <- c(80, 104)
  fade_away <- c(63, 86)
  floater <- c(78, 101, 102)
  pull_up <- c(79, 103)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      if (return_message) {
        glue::glue("Getting play by play for game {game_id}") %>% cat(fill = T)
      }

      data <-
        resp$resultSets$rowSet[[1]] %>%
        data.frame(stringsAsFactors = F) %>%
        as_tibble()

      json_names <-
        resp$resultSets$headers[[1]]
      colnames(data) <- json_names

      # Fix version 2 Dataset
      if (version == "v2") {
        data <- data %>%
          # fix column names
          janitor::clean_names() %>%
          dplyr::rename(
            wc_time_string = wctimestring,
            time_quarter = pctimestring,
            score_margin = scoremargin,
            event_num = eventnum,
            event_msg_type = eventmsgtype,
            event_msg_action_type = eventmsgactiontype,
            home_description = homedescription,
            neutral_description = neutraldescription,
            visitor_description = visitordescription
          ) %>%
          ## Get Team Scores
          tidyr::separate(
            score,
            into = c("away_score", "home_score"),
            sep = "\\ - ",
            remove = F
          ) %>%
          dplyr::mutate_at(c("home_score", "away_score"),
                           list(. %>% as.numeric())) %>%
          dplyr::mutate(
            team_leading = dplyr::case_when(
              score_margin == 0 ~ "Tie",
              score_margin < 0 ~ "Away",
              is.na(score_margin) ~ NA_character_,
              TRUE ~ "Home"
            )
          ) %>%
          ## Time Remaining
          tidyr::separate(
            "time_quarter",
            into = c("minute_remaining_quarter", "seconds_remaining_quarter"),
            sep = "\\:",
            remove = F
          ) %>%
          dplyr::mutate_at(
            c(
              "minute_remaining_quarter",
              "seconds_remaining_quarter",
              "period"
            ),
            list(. %>% as.numeric())
          ) %>%
          dplyr::mutate(
            minute_game = ((period - 1) * 12) + (12 - minute_remaining_quarter) +
              (((
                60 - seconds_remaining_quarter
              ) / 60) - 1),
            time_remaining = 48 - ((period - 1) * 12) - (12 - minute_remaining_quarter) -
              ((60 - seconds_remaining_quarter) / 60 - 1)
          ) %>%
          dplyr::select(
            game_id:period,
            minute_game,
            time_remaining,
            dplyr::everything()
          ) %>%
          dplyr::distinct(.data$game_id, .data$event_num, .keep_all = TRUE) %>%
          dplyr::mutate(
            event_num = dplyr::row_number(),
            home_shot_pts = dplyr::case_when(
              .data$event_msg_type == 3 & !stringr::str_detect(.data$home_description, "MISS") ~ 1,
              .data$event_msg_type == 1 &  stringr::str_detect(.data$home_description, "3PT")  ~ 3,
              .data$event_msg_type == 1 & !stringr::str_detect(.data$home_description, "3PT")  ~ 2,
              TRUE ~ 0
            ),
            away_shot_pts = dplyr::case_when(
              .data$event_msg_type == 3 & !stringr::str_detect(.data$visitor_description, "MISS") ~ 1,
              .data$event_msg_type == 1 &  stringr::str_detect(.data$visitor_description, "3PT")  ~ 3,
              .data$event_msg_type == 1 & !stringr::str_detect(.data$visitor_description, "3PT")  ~ 2,
              TRUE ~ 0
            ),
            action = paste0(.data$event_msg_type, "_", .data$event_msg_action_type),
            home_play_result = dplyr::case_when(
              # blocks
              stringr::str_detect(.data$visitor_description, "BLK") & stringr::str_detect(.data$home_description, "3PT") ~ "Block_3",
              stringr::str_detect(.data$visitor_description, "BLK") & !stringr::str_detect(.data$home_description, "3PT") ~ "Block_2",

              # layup
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(layup) & stringr::str_detect(.data$home_description, "AST") ~ "Layup_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(layup) & !stringr::str_detect(.data$home_description, "AST") ~ "Layup_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(layup) & !stringr::str_detect(.data$home_description, "BLK") ~ "Layup_Miss",

              # dunk
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(dunk) & stringr::str_detect(.data$home_description, "AST") ~ "Dunk_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(dunk) & !stringr::str_detect(.data$home_description, "AST") ~ "Dunk_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(dunk) & !stringr::str_detect(.data$home_description, "BLK") ~ "Dunk_Miss",

              # jump shot
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "JumpShot3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "JumpShot2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "JumpShot3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "JumpShot3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "JumpShot3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "JumpShot2_Miss",

              # hook shot
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "HookShot3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "HookShot2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "HookShot3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "HookShot3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "HookShot3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "HookShot2_Miss",

              # turnaround
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Turnaround3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Turnaround2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Turnaround3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Turnaround3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Turnaround3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Turnaround2_Miss",

              # step back
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Stepback3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Stepback2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Stepback3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Stepback3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Stepback3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Stepback2_Miss",

              # fade away
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Fadeaway3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Fadeaway2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Fadeaway3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Fadeaway3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Fadeaway3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Fadeaway2_Miss",

              # floater
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Floater3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Floater2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Floater3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Floater3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Floater3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Floater2_Miss",

              # pullup
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Pullup3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Pullup2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$home_description, "AST") & stringr::str_detect(.data$home_description, "3PT") ~ "Pullup3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$home_description, "AST") & !stringr::str_detect(.data$home_description, "3PT") ~ "Pullup3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Pullup3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$home_description, "3PT") & !stringr::str_detect(.data$home_description, "BLK") ~ "Pullup2_Miss",

              # rebounds
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$home_description, "MISS")) & lag(stringr::str_detect(.data$home_description, "3PT")) & !is.na(.data$home_description) ~ "Off_Reb3",
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$home_description, "MISS")) & lag(!stringr::str_detect(.data$home_description, "3PT")) & !is.na(.data$home_description) ~ "Off_Reb2",
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$home_description, "3PT")) & is.na(.data$home_description) ~ "Def_Reb3",
              .data$event_msg_type == 4 & lag(!stringr::str_detect(.data$home_description, "3PT")) & is.na(.data$home_description)  ~ "Def_Reb2",

              # fouls
              .data$event_msg_type == 6 & .data$event_msg_action_type == 2 & is.na(.data$home_description) ~ "Shooting_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 1 & is.na(.data$home_description) ~ "Personal_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 4 & is.na(.data$home_description) ~ "Off_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 26 & !is.na(.data$home_description) ~ "Charge",
              .data$event_msg_type == 6 & .data$event_msg_action_type != 26 & is.na(.data$home_description) ~ "Other_Foul",

              # turnover
              .data$event_msg_type == 5 & !is.na(.data$home_description) & !stringr::str_detect(.data$home_description, "STL")  ~ "Turnover",

              # everything else is NA
              TRUE ~ NA_character_
            ),
            away_play_result = dplyr::case_when(
              # blocks
              stringr::str_detect(.data$home_description, "BLK") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Block_3",
              stringr::str_detect(.data$home_description, "BLK") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Block_2",

              # layup
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(layup) & stringr::str_detect(.data$visitor_description, "AST") ~ "Layup_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(layup) & !stringr::str_detect(.data$visitor_description, "AST") ~ "Layup_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(layup) & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Layup_Miss",

              # dunk
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(dunk) & stringr::str_detect(.data$visitor_description, "AST") ~ "Dunk_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(dunk) & !stringr::str_detect(.data$visitor_description, "AST") ~ "Dunk_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(dunk) & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Dunk_Miss",

              # jump shot
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "JumpShot3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "JumpShot2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "JumpShot3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "JumpShot3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(jump_shot) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "JumpShot3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(jump_shot) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "JumpShot2_Miss",

              # hook shot
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "HookShot3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "HookShot2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "HookShot3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "HookShot3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(hook_shot) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "HookShot3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(hook_shot) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "HookShot2_Miss",

              # turnaround
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Turnaround3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Turnaround2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Turnaround3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Turnaround3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(turnaround) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Turnaround3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(turnaround) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Turnaround2_Miss",

              # step back
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Stepback3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Stepback2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Stepback3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Stepback3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(step_back) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Stepback3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(step_back) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Stepback2_Miss",

              # fade away
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Fadeaway3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Fadeaway2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Fadeaway3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Fadeaway3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(fade_away) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Fadeaway3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(fade_away) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Fadeaway2_Miss",

              # floater
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Floater3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Floater2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Floater3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Floater3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(floater) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Floater3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(floater) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Floater2_Miss",

              # pullup
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Pullup3_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Pullup2_Assist",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$visitor_description, "AST") & stringr::str_detect(.data$visitor_description, "3PT") ~ "Pullup3_Made",
              .data$event_msg_type == 1 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$visitor_description, "AST") & !stringr::str_detect(.data$visitor_description, "3PT") ~ "Pullup3_Made",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(pull_up) & stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Pullup3_Miss",
              .data$event_msg_type == 2 & .data$event_msg_action_type %in% c(pull_up) & !stringr::str_detect(.data$visitor_description, "3PT") & !stringr::str_detect(.data$visitor_description, "BLK") ~ "Pullup2_Miss",

              # rebounds
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$visitor_description, "MISS")) & lag(stringr::str_detect(.data$visitor_description, "3PT")) & !is.na(.data$visitor_description) ~ "Off_Reb3",
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$visitor_description, "MISS")) & lag(!stringr::str_detect(.data$visitor_description, "3PT")) & !is.na(.data$visitor_description) ~ "Off_Reb2",
              .data$event_msg_type == 4 & lag(stringr::str_detect(.data$visitor_description, "3PT")) & lag(!stringr::str_detect(.data$visitor_description, "3PT")) & is.na(.data$visitor_description) ~ "Def_Reb3",
              .data$event_msg_type == 4 & lag(!stringr::str_detect(.data$visitor_description, "3PT")) & is.na(.data$visitor_description) ~ "Def_Reb2",

              # fouls
              .data$event_msg_type == 6 & .data$event_msg_action_type == 2 & is.na(.data$visitor_description) ~ "Shooting_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 1 & is.na(.data$visitor_description) ~ "Personal_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 4 & is.na(.data$visitor_description) ~ "Off_Foul",
              .data$event_msg_type == 6 & .data$event_msg_action_type == 26 & !is.na(.data$visitor_description) ~ "Charge",
              .data$event_msg_type == 6 & .data$event_msg_action_type != 26 & is.na(.data$visitor_description) ~ "Other_Foul",

              # turnover
              .data$event_msg_type == 5 & !is.na(.data$visitor_description) & !stringr::str_detect(.data$visitor_description, "STL")  ~ "Turnover",

              # everything else is NA
              TRUE ~ NA_character_
            ),
            home_play_result = ifelse(.data$away_play_result %in% c("Off_Reb2", "Off_Reb3"), NA_character_, .data$home_play_result),
            away_play_result = ifelse(.data$home_play_result %in% c("Off_Reb2", "Off_Reb3"), NA_character_, .data$away_play_result),
            home_score = cumsum(.data$home_shot_pts),
            away_score = cumsum(.data$away_shot_pts),
            score_margin = .data$home_score - .data$away_score
          )
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}


#' **Get NBA Stats API play-by-play**
#' @name pbp2
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname pbp2
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param nest_data If TRUE returns nested data by game
#' @param return_message If TRUE returns message
#' @return Returns a named list of data frames: PlayByPlay
#' @export
nba_pbp2 <-function(game_ids = NULL,
                    version = "v2",
                    nest_data = FALSE,
                    return_message = TRUE) {

  if (game_ids %>% purrr::is_null()) {
    stop("Please enter game ids")
  }

  get_pbp_safe <-
    purrr::possibly(nba_pbp, dplyr::tibble())

  all_data <-
    game_ids %>%
    purrr::map_dfr(function(game_id) {
      get_pbp_safe(game_id = game_id, return_message = return_message, version = version)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(game_id) %>%
      tidyr::nest()
  }

  return(all_data)
}


#' **Get NBA Stats API Schedule**
#' @name schedule
NULL
#' @title
#' **Get NBA Stats API Schedule**
#' @rdname schedule
#' @author Saiem Gilani
#' @param season Season - 4 digit integer corresponding to the first year in the season format 2020-21
#' @param league League - default: 'NBA'. Other options include 'all'
#' @return Returns a tibble
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_schedule <- function(season = 2021, league = 'NBA'){

  full_url <- glue::glue("https://data.nba.com/prod/v1/{season}/schedule.json")
  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  tryCatch(
    expr = {
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")


      data <- jsonlite::fromJSON(resp)[["league"]]

      if(tolower(league) != 'all'){
        data <- data[["standard"]]
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no schedule data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(data)
}


