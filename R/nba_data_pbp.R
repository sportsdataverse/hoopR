#' **Get NBA Data API Play-by-Play**
#' @name nba_data_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play**
#' @rdname nba_data_pbp
#' @author Saiem Gilani
#' @param game_id Game ID - 10 digits, i.e. "0021900001"
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a tibble
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |period   |integer   | period
#'    |evt      |integer   | event number
#'    |cl       |character | clock
#'    |de       |character | description
#'    |locX     |integer   | Location x-coordinate
#'    |locY     |integer   | Location y-coordinate
#'    |opt1     |integer   | description value
#'    |opt2     |integer   |
#'    |mtype    |integer   | event message action type "Message (i.e., action) Type"
#'    |etype    |integer   | event message type "Event Type"
#'    |opid     |character | player_id_3 "Opposing player ID; e.g., player fouled"
#'    |tid      |integer   | team_id "Team ID of player"
#'    |pid      |integer   | player_id_1 "Player ID"
#'    |hs       |integer   | home team score
#'    |vs       |integer   | visiting team score
#'    |epid     |character | player_id_2 "Extra person ID; e.g., official's ID on foul call"
#'    |oftid    |integer   | team_id_2 "Offensive team's ID"
#'    |ord      |integer   | play order number
#'
#'   Event Message Types (etype):
#'
#'   1 -> MAKE
#'
#'   2 -> MISS
#'
#'   3 -> FreeThrow
#'
#'   4 -> Rebound
#'
#'   5 -> Turnover
#'
#'   6 -> Foul
#'
#'   7 -> Violation
#'
#'   8 -> Substitution
#'
#'   9 -> Timeout
#'
#'   10 -> JumpBall
#'
#'   11 -> Ejection
#'
#'   12 -> StartOfPeriod
#'
#'   13 -> EndOfPeriod
#'
#'   14 -> Empty
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr select mutate rename case_when
#' @importFrom tidyr everything
#' @import furrr
#' @import rvest
#' @export
#' @family NBA PBP Functions
nba_data_pbp <- function(game_id = "0021900001",
                         ...){

  league_id <- substr(game_id,1,2)
  season_id <- substr(game_id,4,5)
  season <- ifelse(substr(season_id,1,1)=="9", paste0('19',season_id), paste0('20',season_id))
  league <- dplyr::case_when(
    substr(game_id,1,2)=='00' ~ 'nba',
    substr(game_id, 1, 2)=='10' ~ 'wnba',
    substr(game_id, 1, 2)=='20' ~ 'dleague',
    TRUE ~ 'NBA'
  )
  full_url <- glue::glue("https://data.nba.com/data/v2015/json/mobile_teams/{league}/{season}/scores/pbp/{game_id}_full_pbp.json")

  tryCatch(
    expr = {

      res <- httr::RETRY("GET", full_url, ...)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")


      data <- jsonlite::fromJSON(resp)$g
      plays <- jsonlite::fromJSON(jsonlite::toJSON(data$pd),flatten=TRUE)
      plays_df <- data.frame()
      plays_df <- purrr::map_df(plays[[1]],function(x){
        plays_df <- plays[[2]][[x]] %>%
          dplyr::mutate(period = x) %>%
          dplyr::select("period", tidyr::everything())
      }) %>%
        make_hoopR_data("NBA Play-by-Play Information from NBA.com",Sys.time())
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

