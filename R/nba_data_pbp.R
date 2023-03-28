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
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |game_id           |character |
#'    |league            |character |
#'    |period            |integer   |
#'    |event_num         |integer   |
#'    |clock             |character |
#'    |description       |character |
#'    |locX              |integer   |
#'    |locY              |integer   |
#'    |opt1              |integer   |
#'    |opt2              |integer   |
#'    |event_action_type |integer   |
#'    |event_type        |integer   |
#'    |team_id           |integer   |
#'    |offense_team_id   |integer   |
#'    |player1_id        |integer   |
#'    |player2_id        |integer   |
#'    |player3_id        |integer   |
#'    |home_score        |integer   |
#'    |away_score        |integer   |
#'    |order             |integer   |
#'
#'   Event Message Types (event_type):
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
#' @details
#' ```r
#'  nba_data_pbp(game_id = "0021900001")
#' ```
nba_data_pbp <- function(game_id = "0021900001",
                         ...){

  league_id <- substr(game_id, 1, 2)
  season_id <- substr(game_id, 4, 5)
  season <- ifelse(substr(season_id, 1, 1) == "9", paste0('19', season_id), paste0('20', season_id))
  league <- dplyr::case_when(
    substr(game_id,1,2) == '00' ~ 'nba',
    substr(game_id, 1, 2) == '10' ~ 'wnba',
    substr(game_id, 1, 2) == '20' ~ 'dleague',
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
      plays <- jsonlite::fromJSON(jsonlite::toJSON(data$pd), flatten = TRUE)
      plays_df <- data.frame()
      plays_df <- purrr::map_df(plays[[1]], function(x){
        plays_df <- plays[[2]][[x]] %>%
          dplyr::mutate(period = x) %>%
          dplyr::select("period", tidyr::everything())
      })

      plays_df <- plays_df %>%
        dplyr::select(dplyr::any_of(c(
          "period" = "period",
          "event_num" = "evt",
          "clock" = "cl",
          "description" = "de",
          "locX" = "locX",
          "locY" = "locY",
          "opt1" = "opt1",
          "opt2" = "opt2",
          "event_action_type" = "mtype",
          "event_type" = "etype",
          "team_id" = "tid",
          "offense_team_id" = "oftid",
          "player1_id" = "pid",
          "player2_id" = "epid",
          "player3_id" = "opid",
          "home_score" = "hs",
          "away_score" = "vs",
          "order" = "ord"))) %>%
        dplyr::mutate(
          player2_id = as.integer(.data$player2_id),
          player3_id = as.integer(.data$player3_id),
          game_id = game_id,
          league = dplyr::case_when(
            substr(game_id,1,2) == '00' ~ 'NBA',
            substr(game_id, 1, 2) == '10' ~ 'WNBA',
            substr(game_id, 1, 2) == '20' ~ 'G-League',
            TRUE ~ 'NBA')) %>%
        dplyr::select("game_id", "league", tidyr::everything()) %>%
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

