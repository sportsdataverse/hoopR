#' **Get NBA Data API Play-by-Play**
#' @name nba_data_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play**
#' @rdname nba_data_pbp
#' @author Saiem Gilani
#' @param game_id Game ID - 10 digits, i.e. "0021900001"
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select mutate rename case_when
#' @importFrom tidyr everything
#' @import furrr
#' @import rvest
#' @export
nba_data_pbp <- function(game_id = "0021900001"){

  league_id <- substr(game_id,1,2)
  season_id <- substr(game_id,4,5)
  season <- ifelse(substr(season_id,1,1)=="9", paste0('19',season_id), paste0('20',season_id))
  league <- dplyr::case_when(
    substr(game_id,1,2)=='00' ~ 'nba',
    substr(game_id, 1, 2)=='10' ~ 'wnba',
    substr(game_id, 1, 2)=='20' ~ 'dleague',
    TRUE ~ 'NBA'
  )
  full_url <- glue::glue("https://data.{league}.com/data/v2015/json/mobile_teams/{league}/{season}/scores/pbp/{game_id}_full_pbp.json")
  res <- httr::RETRY("GET", full_url)

  # Check the result
  check_status(res)
  tryCatch(
    expr={
      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")


      data <- jsonlite::fromJSON(resp)$g
      plays <- jsonlite::fromJSON(jsonlite::toJSON(data$pd),flatten=TRUE)
      plays_df <- data.frame()
      plays_df <- purrr::map_df(plays[[1]],function(x){
        plays_df <- plays[[2]][[x]] %>%
          dplyr::mutate(period = x) %>%
          dplyr::select(.data$period, tidyr::everything())
      })
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no play-by-play data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(plays_df)
}

