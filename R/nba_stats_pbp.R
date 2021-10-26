
#' **Get NBA Stats API play-by-play**
#' @name pbp
NULL
#' @title
#' **Get NBA Stats API play-by-play**
#' @rdname pbp
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param version Play-by-play version ("v2" available from 2016-17 onwards)
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_pbp <- function(game_id, version = "v2"){

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

      data <-
        resp$resultSets$rowSet[[1]] %>%
        data.frame(stringsAsFactors = F) %>%
        as_tibble()

      json_names <-
        resp$resultSets$headers[[1]]
      colnames(data) <- json_names
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

#' **Get NBA Stats API Schedule**
#' @name schedule
NULL
#' @title
#' **Get NBA Stats API Schedule**
#' @rdname schedule
#' @author Saiem Gilani
#' @param season Season - 4 digit integer corresponding to the first year in the season format 2020-21
#' @param league League - default: 'NBA'. Other options include 'all'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
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


