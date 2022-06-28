
#' **Get NBA Stats API play-by-play**
#' @name pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname pbp
#' @author Jason Lee
#' @param game_id Game ID
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param p Progress bar
#' @return Returns a data frame: PlayByPlay
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
.nba_pbp <- function(game_id, version = "v2", p){

  p("loading...")
  if(version=="v2"){
    endpoint <- nba_endpoint('playbyplayv2')
  } else {
    endpoint <- nba_endpoint('playbyplay')
  }

  full_url <- paste0(endpoint,
                     "?EndPeriod=0&",
                     "GameID=",pad_id(game_id),
                     "&StartPeriod=0")

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()


      data <-resp$resultSets$rowSet[[1]] %>%
        data.frame(stringsAsFactors = F) %>%
        as_tibble()

      json_names <- resp$resultSets$headers[[1]]
      colnames(data) <- json_names

      # Fix version 2 Dataset
      if (version == "v2") {
        data <- data %>%
          # fix column names
          janitor::clean_names() %>%
          dplyr::rename(
            wc_time_string = .data$wctimestring,
            time_quarter = .data$pctimestring,
            score_margin = .data$scoremargin,
            even_num = .data$eventnum,
            event_msg_type = .data$eventmsgtype,
            event_msg_action_type = .data$eventmsgactiontype,
            home_description = .data$homedescription,
            neutral_description = .data$neutraldescription,
            visitor_description = .data$visitordescription
          ) %>%
          ## Get Team Scores
          tidyr::separate(
            "score",
            into = c("away_score", "home_score"),
            sep = "\\ - ",
            remove = F
          ) %>%
          dplyr::mutate(
            home_score = as.numeric(.data$home_score),
            away_score = as.numeric(.data$away_score),
            team_leading = dplyr::case_when(
              .data$score_margin == 0 ~ "Tie",
              .data$score_margin < 0 ~ "Away",
              is.na(.data$score_margin) ~ NA_character_,
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
          dplyr::select(
            .data$game_id:.data$period,
            .data$minute_game,
            .data$time_remaining,
            dplyr::everything()
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


#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @name pbps
NULL
#' @title
#' **Get NBA Stats API play-by-play (Multiple Games)**
#' @rdname pbps
#' @author Jason Lee
#' @param game_ids Game IDs
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @param nest_data If TRUE returns nested data by game
#' @return Returns a data frame: PlayByPlay
#' @export
nba_pbps <-function(game_ids = NULL,
                    version = "v2",
                    nest_data = FALSE) {

  if (game_ids %>% purrr::is_null()) {
    stop("Please enter game ids")
  }


  p <- NULL
  if (is_installed("progressr")) p <- progressr::progressor(along = game_ids)
  get_pbp_safe <- progressively(.nba_pbp, p)


  all_data <-
    game_ids %>%
    purrr::map_dfr(function(game_id) {
      get_pbp_safe(game_id = game_id, p = p)
    })

  if (nest_data) {
    all_data <-
      all_data %>%
      dplyr::group_by(.data$game_id) %>%
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


