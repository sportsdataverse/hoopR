
#' **Add players on court in  NBA Stats API play-by-play**
#' @name .players_on_court
NULL
#' @title
#' **Add players on court in  NBA Stats API play-by-play**
#' @author Vladislav Shufinskiy
#' @param pbp_data PlayByPlay data frame received `nba_pbp` function
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @noRd
#' @family NBA PBP Functions
.players_on_court <- function(pbp_data) {

  pbp_data <- dplyr::mutate(pbp_data, PCTIMESTRING = ifelse(.data$period < 5, abs((.data$minute_remaining_quarter * 60 + .data$seconds_remaining_quarter) - 720 * .data$period),
                                                            abs((.data$minute_remaining_quarter * 60 + .data$seconds_remaining_quarter) - (2880 + 300 * (.data$period - 4)))))

  l <- lapply(sort(unique(pbp_data$period)), function(x){

    pbp_data_period <- dplyr::filter(pbp_data, .data$period == x)
    all_id <- unique(c(pbp_data_period$player1_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player1_name) & !pbp_data_period$person1type %in% c(6, 7)],
                       pbp_data_period$player2_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player2_name) & !pbp_data_period$person2type %in% c(6, 7)],
                       pbp_data_period$player3_id[!pbp_data_period$event_type %in% c(9, 18) & !is.na(pbp_data_period$player3_name) & !pbp_data_period$person3type %in% c(6, 7)]))
    all_id <- as.numeric(all_id)

    all_id <- all_id[all_id != 0 & all_id < 1610612737]

    sub_off <- as.numeric(unique(pbp_data_period$player1_id[pbp_data_period$event_type == 8]))
    sub_on <- as.numeric(unique(pbp_data_period$player2_id[pbp_data_period$event_type == 8]))

    '%!in%' <- Negate(`%in%`)
    all_id <- all_id[all_id  %!in% setdiff(sub_on, sub_off)]

    sub_on_off <- dplyr::intersect(sub_on, sub_off)

    for (i in sub_on_off){
      on <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
      off <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
      if (off > on){
        all_id <- all_id[all_id != i]
      } else if (off == on){
        on_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
        off_event <- min(pbp_data_period$event_num[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
        if(off_event > on_event){
          all_id <- all_id[all_id != i]
        }
      }
    }

    if((length(all_id) == 10)){
      ord_all_id <- pbp_data_period %>%
        dplyr::select("player1_id", "person1type") %>%
        dplyr::filter(.data$player1_id != 0 & .data$person1type %in% c(4, 5)) %>%
        dplyr::rename("player_id" = "player1_id", "persontype" = "person1type") %>%
        dplyr::bind_rows(pbp_data_period %>%
                           dplyr::select("player2_id", "person2type") %>%
                           dplyr::filter(.data$player2_id != 0 & .data$person2type %in% c(4, 5)) %>%
                           dplyr::rename("player_id" = "player2_id", "persontype" = "person2type")) %>%
        dplyr::bind_rows(pbp_data_period %>%
                           dplyr::select("player3_id", "person3type") %>%
                           dplyr::filter(.data$player3_id != 0 & .data$person3type %in% c(4, 5)) %>%
                           dplyr::rename("player_id" = "player3_id", "persontype" = "person3type")) %>%
        dplyr::distinct() %>%
        dplyr::arrange(dplyr::desc(.data$persontype)) %>%
        dplyr::select("player_id") %>%
        dplyr::mutate(player_id = as.numeric(.data$player_id)) %>%
        dplyr::pull()

      all_id <- ord_all_id[ord_all_id %in% all_id]
    }

    if(length(all_id) != 10){

      if(inherits(pbp_data$game_id[1], "integer")){
        tmp_gameid <- paste0("00", as.character(pbp_data$game_id[1]))
      } else{
        tmp_gameid <- pbp_data$game_id[1]
      }

      tmp_data <- nba_boxscoretraditionalv2(game_id = tmp_gameid, start_period = x, end_period = x, range_type = 1)$PlayerStats

      all_id <- as.integer(tmp_data$PLAYER_ID)

      sub_off <- unique(pbp_data_period$player1_id[pbp_data_period$event_type == 8])
      sub_on <- unique(pbp_data_period$player2_id[pbp_data_period$event_type == 8])

      '%!in%' <- Negate(`%in%`)
      all_id <- all_id[all_id  %!in% setdiff(sub_on, sub_off)]

      sub_on_off <- dplyr::intersect(sub_on, sub_off)

      for (i in sub_on_off){
        on <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
        off <- min(pbp_data_period$PCTIMESTRING[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
        if (off > on){
          all_id <- all_id[all_id != i]
        } else if (off == on){
          on_event <- min(pbp_data_period$even_num[pbp_data_period$event_type == 8 & pbp_data_period$player2_id == i])
          off_event <- min(pbp_data_period$even_num[pbp_data_period$event_type == 8 & pbp_data_period$player1_id == i])
          if(off_event > on_event){
            all_id <- all_id[all_id != i]
          }
        }
      }
    }

    columns <- paste0("player", seq(1, 10))
    pbp_data_period[columns] <- NA

    for(i in seq(1:10)){
      pbp_data_period[columns][i] <- all_id[i]
    }

    for(column in paste0("player", seq(1, 10))){
      i <- 1
      repeat{
        n <- nrow(pbp_data_period)
        if(length(which(pbp_data_period$event_type == 8 & as.numeric(pbp_data_period$player1_id) == pbp_data_period[, column])) == 0){
          break
        }
        i <- min(which(pbp_data_period$event_type == 8 & pbp_data_period[, column] == as.numeric(pbp_data_period$player1_id)))
        player_on <- as.numeric(pbp_data_period$player2_id[i])
        pbp_data_period[i:n, column] <- player_on
      }
    }
    return(dplyr::select(pbp_data_period, -"PCTIMESTRING"))
  })
  return(dplyr::bind_rows(l) %>% dplyr::rename(
    "away_player1" = 'player1',
    "away_player2" = 'player2',
    "away_player3" = 'player3',
    "away_player4" = 'player4',
    "away_player5" = 'player5',
    "home_player1" = 'player6',
    "home_player2" = 'player7',
    "home_player3" = 'player8',
    "home_player4" = 'player9',
    "home_player5" = 'player10'
  ))
}


#' **Get NBA Stats API play-by-play**
#' @name nba_pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname nba_pbp
#' @author Jason Lee
#' @param game_id Game ID
#' @param on_court IF TRUE will be added ID of players on court
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param p Progress bar
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#'  nba_pbp(game_id = '0022201086')
#' ```
nba_pbp <- function(
    game_id,
    on_court = TRUE,
    version = "v2",
    p,
    ...){

  if (version == "v2") {
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- endpoint

  params <- list(
    EndPeriod = 0,
    GameID = pad_id(game_id),
    StartPeriod = 0
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      # if (return_message) {
      #   glue::glue("Getting play by play for game {game_id}") %>% cat(fill = T)
      # }

      data <- resp$resultSets$rowSet[[1]] %>%
        data.frame() %>%
        dplyr::as_tibble()

      json_names <- resp$resultSets$headers[[1]]
      colnames(data) <- json_names

      # Fix version 2 Dataset
      if (version == "v2") {
        data <- data %>%
          # fix column names
          janitor::clean_names() %>%
          dplyr::rename(dplyr::any_of(c(
            "wc_time_string" = "wctimestring",
            "time_quarter" = "pctimestring",
            "score_margin" = "scoremargin",
            "event_num" = "eventnum",
            "event_type" = "eventmsgtype",
            "event_action_type" = "eventmsgactiontype",
            "home_description" = "homedescription",
            "neutral_description" = "neutraldescription",
            "visitor_description" = "visitordescription"
          ))) %>%
          ## Get Team Scores
          tidyr::separate(
            "score",
            into = c("away_score", "home_score"),
            sep = "\\ - ",
            remove = FALSE
          ) %>%
          dplyr::mutate(
            home_score = as.numeric(.data$home_score),
            away_score = as.numeric(.data$away_score),
            team_leading = dplyr::case_when(
              .data$score_margin == 0 ~ "Tie",
              .data$score_margin < 0 ~ "Away",
              is.na(.data$score_margin) ~ NA_character_,
              .default = "Home"
            )
          ) %>%
          ## Time Remaining
          tidyr::separate(
            "time_quarter",
            into = c("minute_remaining_quarter", "seconds_remaining_quarter"),
            sep = "\\:",
            remove = FALSE
          ) %>%
          dplyr::mutate(
            minute_remaining_quarter = as.numeric(.data$minute_remaining_quarter),
            seconds_remaining_quarter = as.numeric(.data$seconds_remaining_quarter),
            period = as.numeric(.data$period)
          ) %>%
          dplyr::mutate(
            minute_game = round(((.data$period - 1) * 12) + (12 - .data$minute_remaining_quarter) +
                                  (((
                                    60 - .data$seconds_remaining_quarter
                                  ) / 60) - 1), 2),
            time_remaining = 48 - round(((.data$period - 1) * 12) - (12 - .data$minute_remaining_quarter) -
                                          ((60 - .data$seconds_remaining_quarter) / 60 - 1), 2)
          ) %>%
          dplyr::relocate(
            "game_id":"period",
            "minute_game",
            "time_remaining"
          ) %>%
          make_hoopR_data("NBA Game Play-by-Play Information from NBA.com", Sys.time())

        if(on_court){
          data <- .players_on_court(data)
        }
      }
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {pad_id(game_id)} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}


#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @name nba_pbps
NULL
#' @title
#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @rdname nba_pbps
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param on_court IF TRUE will be added ID of players on court
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param nest_data If TRUE returns nested data by game
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |game_id                   |character |
#'    |event_num                 |character |
#'    |event_type                |character |
#'    |event_action_type         |character |
#'    |period                    |numeric   |
#'    |minute_game               |numeric   |
#'    |time_remaining            |numeric   |
#'    |wc_time_string            |character |
#'    |time_quarter              |character |
#'    |minute_remaining_quarter  |numeric   |
#'    |seconds_remaining_quarter |numeric   |
#'    |home_description          |character |
#'    |neutral_description       |character |
#'    |visitor_description       |character |
#'    |score                     |character |
#'    |away_score                |numeric   |
#'    |home_score                |numeric   |
#'    |score_margin              |character |
#'    |person1type               |character |
#'    |player1_id                |character |
#'    |player1_name              |character |
#'    |player1_team_id           |character |
#'    |player1_team_city         |character |
#'    |player1_team_nickname     |character |
#'    |player1_team_abbreviation |character |
#'    |person2type               |character |
#'    |player2_id                |character |
#'    |player2_name              |character |
#'    |player2_team_id           |character |
#'    |player2_team_city         |character |
#'    |player2_team_nickname     |character |
#'    |player2_team_abbreviation |character |
#'    |person3type               |character |
#'    |player3_id                |character |
#'    |player3_name              |character |
#'    |player3_team_id           |character |
#'    |player3_team_city         |character |
#'    |player3_team_nickname     |character |
#'    |player3_team_abbreviation |character |
#'    |video_available_flag      |character |
#'    |team_leading              |character |
#'    |away_player1              |numeric   |
#'    |away_player2              |numeric   |
#'    |away_player3              |numeric   |
#'    |away_player4              |numeric   |
#'    |away_player5              |numeric   |
#'    |home_player1              |numeric   |
#'    |home_player2              |numeric   |
#'    |home_player3              |numeric   |
#'    |home_player4              |numeric   |
#'    |home_player5              |numeric   |
#'
#' @export
#' @family NBA PBP Functions
#' @details
#' ```r
#' y <- c("0022201086", "0022200021")
#'
#' nba_pbps(game_ids = y, version = "v2")
#' ```
nba_pbps <- function(
    game_ids = NULL,
    on_court = TRUE,
    version = "v2",
    nest_data = FALSE,
    ...) {

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  if (rlang::is_null(game_ids)) {
    stop("Please enter game ids")
  }

  all_data <- purrr::map_dfr(
    cli::cli_progress_along(game_ids, name = "Loading"),
    function(i) {
      nba_pbp(game_id = game_ids[i], on_court = on_court)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(.data$game_id) %>%
      tidyr::nest()
  }

  return(all_data)
}


#' **Get NBA Stats API Live play-by-play**
#' @name nba_live_pbp
NULL
#' @title
#' **Get NBA Stats API Live play-by-play**
#' @rdname nba_live_pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame: PlayByPlay
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |event_num                    |integer   |
#'    |clock                        |character |
#'    |time_actual                  |character |
#'    |period                       |integer   |
#'    |period_type                  |character |
#'    |action_type                  |character |
#'    |sub_type                     |character |
#'    |qualifiers                   |list      |
#'    |player1_id                   |integer   |
#'    |x                            |numeric   |
#'    |y                            |numeric   |
#'    |offense_team_id              |integer   |
#'    |home_score                   |character |
#'    |away_score                   |character |
#'    |edited                       |character |
#'    |order                        |integer   |
#'    |is_target_score_last_period  |logical   |
#'    |x_legacy                     |integer   |
#'    |y_legacy                     |integer   |
#'    |is_field_goal                |integer   |
#'    |side                         |character |
#'    |description                  |character |
#'    |person_ids_filter            |list      |
#'    |team_id                      |integer   |
#'    |team_tricode                 |character |
#'    |descriptor                   |character |
#'    |jump_ball_recovered_name     |character |
#'    |jump_ball_recoverd_person_id |integer   |
#'    |player_name                  |character |
#'    |player_name_i                |character |
#'    |jump_ball_won_player_name    |character |
#'    |jump_ball_won_person_id      |integer   |
#'    |jump_ball_lost_player_name   |character |
#'    |jump_ball_lost_person_id     |integer   |
#'    |area                         |character |
#'    |area_detail                  |character |
#'    |shot_distance                |numeric   |
#'    |shot_result                  |character |
#'    |points_total                 |integer   |
#'    |assist_player_name_initial   |character |
#'    |assist_person_id             |integer   |
#'    |assist_total                 |integer   |
#'    |shot_action_number           |integer   |
#'    |rebound_total                |integer   |
#'    |rebound_defensive_total      |integer   |
#'    |rebound_offensive_total      |integer   |
#'    |official_id                  |integer   |
#'    |foul_personal_total          |integer   |
#'    |foul_technical_total         |integer   |
#'    |foul_drawn_player_name       |character |
#'    |foul_drawn_person_id         |integer   |
#'    |block_player_name            |character |
#'    |block_person_id              |integer   |
#'    |turnover_total               |integer   |
#'    |steal_player_name            |character |
#'    |steal_person_id              |integer   |
#'    |player2_id                   |integer   |
#'    |player3_id                   |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA PBP Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_live_pbp(game_id = '0022201086')
#' ```
nba_live_pbp <- function(
    game_id,
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nba_live_endpoint('playbyplay')

  full_url <- paste0(endpoint,
                     "/playbyplay_",
                     pad_id(game_id),
                     ".json")

  tryCatch(
    expr = {

      res <- rvest::session(url = full_url,  httr::timeout(60))

      resp <- res$response %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game") %>%
        purrr::pluck("actions") %>%
        janitor::clean_names()

      data <- data  %>%
        dplyr::rename(dplyr::any_of(c(
          "period" = "period",
          "event_num" = "action_number",
          "clock" = "clock",
          "description" = "description",
          "locX" = "xLegacy",
          "locY" = "yLegacy",
          "action_type" = "action_type",
          "sub_type" = "sub_type",
          "descriptor" = "descriptor",
          "shot_result" = "shot_result",
          "shot_action_number" = "shot_action_number",
          "qualifiers" = "qualifiers",
          "team_id" = "team_id",
          "player1_id" = "person_id",
          "home_score" = "score_home",
          "away_score" = "score_away",
          "offense_team_id" = "possession",
          "order" = "order_number"))) %>%
        dplyr::mutate(
          player2_id = dplyr::case_when(
            !is.na(.data$assist_person_id) ~ .data$assist_person_id,
            TRUE ~ NA_integer_),
          player3_id = dplyr::case_when(
            !is.na(.data$block_person_id) ~ .data$block_person_id,
            !is.na(.data$steal_person_id) ~ .data$steal_person_id,
            !is.na(.data$foul_drawn_person_id) ~ .data$foul_drawn_person_id,
            TRUE ~ NA_integer_
          )) %>%
        make_hoopR_data("NBA Game Play-by-Play Information from NBA.com", Sys.time())


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



#' **Get NBA Stats API Live Boxscore**
#' @name nba_live_boxscore
NULL
#' @title
#' **Get NBA Stats API Live Boxscore**
#' @rdname nba_live_boxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: game_details, arena, officials, home_team_boxscore,
#' away_team_boxscore, home_team_player_boxscore, away_team_player_boxscore, home_team_linescores,
#' away_team_linescores
#'
#'    **game_details**
#'
#'
#'    |col_name                     |types     |
#'    |:----------------------------|:---------|
#'    |game_id                      |character |
#'    |game_time_local              |character |
#'    |game_time_utc                |character |
#'    |game_time_home               |character |
#'    |game_time_away               |character |
#'    |game_et                      |character |
#'    |duration                     |integer   |
#'    |game_code                    |character |
#'    |game_status_text             |character |
#'    |game_status                  |integer   |
#'    |regulation_periods           |integer   |
#'    |period                       |integer   |
#'    |game_clock                   |character |
#'    |attendance                   |integer   |
#'    |sellout                      |character |
#'    |home_team_id                 |integer   |
#'    |home_team_name               |character |
#'    |home_team_city               |character |
#'    |home_team_tricode            |character |
#'    |home_team_score              |integer   |
#'    |home_team_in_bonus           |character |
#'    |home_team_timeouts_remaining |integer   |
#'    |away_team_id                 |integer   |
#'    |away_team_name               |character |
#'    |away_team_city               |character |
#'    |away_team_tricode            |character |
#'    |away_team_score              |integer   |
#'    |away_team_in_bonus           |character |
#'    |away_team_timeouts_remaining |integer   |
#'
#'    **arena**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |arena_id       |integer   |
#'    |arena_name     |character |
#'    |arena_city     |character |
#'    |arena_state    |character |
#'    |arena_country  |character |
#'    |arena_timezone |character |
#'
#'    **officials**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |person_id   |integer   |
#'    |name        |character |
#'    |name_i      |character |
#'    |first_name  |character |
#'    |family_name |character |
#'    |jersey_num  |character |
#'    |assignment  |character |
#'
#'    **home_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **away_team_boxscore**
#'
#'
#'    |col_name                        |types     |
#'    |:-------------------------------|:---------|
#'    |team_id                         |integer   |
#'    |team_name                       |character |
#'    |team_city                       |character |
#'    |team_tricode                    |character |
#'    |team_score                      |integer   |
#'    |team_in_bonus                   |character |
#'    |team_timeouts_remaining         |integer   |
#'    |assists                         |integer   |
#'    |assists_turnover_ratio          |numeric   |
#'    |bench_points                    |integer   |
#'    |biggest_lead                    |integer   |
#'    |biggest_lead_score              |character |
#'    |biggest_scoring_run             |integer   |
#'    |biggest_scoring_run_score       |character |
#'    |blocks                          |integer   |
#'    |blocks_received                 |integer   |
#'    |fast_break_points_attempted     |integer   |
#'    |fast_break_points_made          |integer   |
#'    |fast_break_points_percentage    |numeric   |
#'    |field_goals_attempted           |integer   |
#'    |field_goals_effective_adjusted  |numeric   |
#'    |field_goals_made                |integer   |
#'    |field_goals_percentage          |numeric   |
#'    |fouls_offensive                 |integer   |
#'    |fouls_drawn                     |integer   |
#'    |fouls_personal                  |integer   |
#'    |fouls_team                      |integer   |
#'    |fouls_technical                 |integer   |
#'    |fouls_team_technical            |integer   |
#'    |free_throws_attempted           |integer   |
#'    |free_throws_made                |integer   |
#'    |free_throws_percentage          |numeric   |
#'    |lead_changes                    |integer   |
#'    |minutes                         |character |
#'    |minutes_calculated              |character |
#'    |points                          |integer   |
#'    |points_against                  |integer   |
#'    |points_fast_break               |integer   |
#'    |points_from_turnovers           |integer   |
#'    |points_in_the_paint             |integer   |
#'    |points_in_the_paint_attempted   |integer   |
#'    |points_in_the_paint_made        |integer   |
#'    |points_in_the_paint_percentage  |numeric   |
#'    |points_second_chance            |integer   |
#'    |rebounds_defensive              |integer   |
#'    |rebounds_offensive              |integer   |
#'    |rebounds_personal               |integer   |
#'    |rebounds_team                   |integer   |
#'    |rebounds_team_defensive         |integer   |
#'    |rebounds_team_offensive         |integer   |
#'    |rebounds_total                  |integer   |
#'    |second_chance_points_attempted  |integer   |
#'    |second_chance_points_made       |integer   |
#'    |second_chance_points_percentage |numeric   |
#'    |steals                          |integer   |
#'    |three_pointers_attempted        |integer   |
#'    |three_pointers_made             |integer   |
#'    |three_pointers_percentage       |numeric   |
#'    |time_leading                    |character |
#'    |times_tied                      |integer   |
#'    |true_shooting_attempts          |numeric   |
#'    |true_shooting_percentage        |numeric   |
#'    |turnovers                       |integer   |
#'    |turnovers_team                  |integer   |
#'    |turnovers_total                 |integer   |
#'    |two_pointers_attempted          |integer   |
#'    |two_pointers_made               |integer   |
#'    |two_pointers_percentage         |numeric   |
#'
#'    **home_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **away_team_player_boxscore**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |team_id                   |integer   |
#'    |team_name                 |character |
#'    |team_city                 |character |
#'    |team_tricode              |character |
#'    |team_score                |integer   |
#'    |team_in_bonus             |character |
#'    |team_timeouts_remaining   |integer   |
#'    |status                    |character |
#'    |order                     |integer   |
#'    |person_id                 |integer   |
#'    |jersey_num                |character |
#'    |position                  |character |
#'    |starter                   |character |
#'    |oncourt                   |character |
#'    |played                    |character |
#'    |assists                   |integer   |
#'    |blocks                    |integer   |
#'    |blocks_received           |integer   |
#'    |field_goals_attempted     |integer   |
#'    |field_goals_made          |integer   |
#'    |field_goals_percentage    |numeric   |
#'    |fouls_offensive           |integer   |
#'    |fouls_drawn               |integer   |
#'    |fouls_personal            |integer   |
#'    |fouls_technical           |integer   |
#'    |free_throws_attempted     |integer   |
#'    |free_throws_made          |integer   |
#'    |free_throws_percentage    |numeric   |
#'    |minus                     |numeric   |
#'    |minutes                   |character |
#'    |minutes_calculated        |character |
#'    |plus                      |numeric   |
#'    |plus_minus_points         |numeric   |
#'    |points                    |integer   |
#'    |points_fast_break         |integer   |
#'    |points_in_the_paint       |integer   |
#'    |points_second_chance      |integer   |
#'    |rebounds_defensive        |integer   |
#'    |rebounds_offensive        |integer   |
#'    |rebounds_total            |integer   |
#'    |steals                    |integer   |
#'    |three_pointers_attempted  |integer   |
#'    |three_pointers_made       |integer   |
#'    |three_pointers_percentage |numeric   |
#'    |turnovers                 |integer   |
#'    |two_pointers_attempted    |integer   |
#'    |two_pointers_made         |integer   |
#'    |two_pointers_percentage   |numeric   |
#'    |name                      |character |
#'    |name_i                    |character |
#'    |first_name                |character |
#'    |family_name               |character |
#'    |not_playing_reason        |character |
#'    |not_playing_description   |character |
#'
#'    **home_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
#'
#'    **away_team_linescores**
#'
#'
#'    |col_name    |types     |
#'    |:-----------|:---------|
#'    |period      |integer   |
#'    |period_type |character |
#'    |score       |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Live Functions
#' @details
#' ```r
#'  nba_live_boxscore(game_id = "0022201086")
#' ```
nba_live_boxscore <- function(
    game_id,
    ...){

  old <- options(list(stringsAsFactors = FALSE, scipen = 999))
  on.exit(options(old))

  endpoint <- nba_live_endpoint('boxscore')

  full_url <- paste0(endpoint,
                     "/boxscore_",
                     pad_id(game_id),
                     ".json")

  tryCatch(
    expr = {

      res <- rvest::session(url = full_url, ..., httr::timeout(60))

      resp <- res$response %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON()

      data <- resp %>%
        purrr::pluck("game")

      game_details <- data.frame(
        game_id = data %>% purrr::pluck("gameId"),
        game_time_local = data %>% purrr::pluck("gameTimeLocal"),
        game_time_utc = data %>% purrr::pluck("gameTimeUTC"),
        game_time_home = data %>% purrr::pluck("gameTimeHome"),
        game_time_away = data %>% purrr::pluck("gameTimeAway"),
        game_et = data %>% purrr::pluck("gameEt"),
        duration = data %>% purrr::pluck("duration"),
        game_code = data %>% purrr::pluck("gameCode"),
        game_status_text = data %>% purrr::pluck("gameStatusText"),
        game_status = data %>% purrr::pluck("gameStatus"),
        regulation_periods = data %>% purrr::pluck("regulationPeriods"),
        period = data %>% purrr::pluck("period"),
        game_clock = data %>% purrr::pluck("gameClock"),
        attendance = data %>% purrr::pluck("attendance"),
        sellout = data %>% purrr::pluck("sellout")
      )

      arena <- data %>%
        purrr::pluck("arena") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Arena Information from NBA.com", Sys.time())

      officials <- data %>%
        purrr::pluck("officials") %>%
        data.frame() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Officials Information from NBA.com", Sys.time())

      if ("homeTeam" %in% names(data)) {

        home_team <- data %>%
          purrr::pluck("homeTeam")

        home_team_info <- data.frame(
          team_id = home_team %>% purrr::pluck("teamId"),
          team_name = home_team %>% purrr::pluck("teamName"),
          team_city = home_team %>% purrr::pluck("teamCity"),
          team_tricode = home_team %>% purrr::pluck("teamTricode"),
          team_score = home_team %>% purrr::pluck("score"),
          team_in_bonus = home_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = home_team %>% purrr::pluck("timeoutsRemaining")
        )

        home_team_box <- home_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        home_team_linescores <- home_team$periods %>%
          janitor::clean_names()

        home_team_players <- home_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        home_team_player_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Player Boxscore Information from NBA.com", Sys.time())

        home_team_boxscore <- home_team_info %>%
          dplyr::bind_cols(home_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())

      }

      if ("awayTeam" %in% names(data)) {

        away_team <- data %>%
          purrr::pluck("awayTeam")

        away_team_info <- data.frame(
          team_id = away_team %>% purrr::pluck("teamId"),
          team_name = away_team %>% purrr::pluck("teamName"),
          team_city = away_team %>% purrr::pluck("teamCity"),
          team_tricode = away_team %>% purrr::pluck("teamTricode"),
          team_score = away_team %>% purrr::pluck("score"),
          team_in_bonus = away_team %>% purrr::pluck("inBonus"),
          team_timeouts_remaining = away_team %>% purrr::pluck("timeoutsRemaining")
        )

        away_team_box <- away_team %>%
          purrr::pluck("statistics") %>%
          data.frame()

        away_team_linescores <- away_team$periods %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Linescore Information from NBA.com", Sys.time())

        away_team_players <- away_team %>%
          purrr::pluck("players") %>%
          tidyr::unnest("statistics")

        away_team_player_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_players) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Player Boxscore Information from NBA.com", Sys.time())

        away_team_boxscore <- away_team_info %>%
          dplyr::bind_cols(away_team_box) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Game Team Boxscore Information from NBA.com", Sys.time())

      }

      colnames(home_team_info) <- paste0("home_", colnames(home_team_info))
      colnames(away_team_info) <- paste0("away_", colnames(away_team_info))

      game_details <- game_details %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(away_team_info) %>%
        make_hoopR_data("NBA Game Linescore Information from NBA.com", Sys.time())

      df_list <- c(
        list(game_details),
        list(arena),
        list(officials),
        list(home_team_boxscore),
        list(away_team_boxscore),
        list(home_team_player_boxscore),
        list(away_team_player_boxscore),
        list(home_team_linescores),
        list(away_team_linescores)
      )

      names(df_list) = c(
        "game_details",
        "arena",
        "officials",
        "home_team_boxscore",
        "away_team_boxscore",
        "home_team_player_boxscore",
        "away_team_player_boxscore",
        "home_team_linescores",
        "away_team_linescores"
      )

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no boxscore data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
