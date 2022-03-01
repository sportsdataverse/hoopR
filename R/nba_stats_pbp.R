
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
            even_num = eventnum,
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


