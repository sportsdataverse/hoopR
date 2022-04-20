#' **Get NBA Data API Play-by-Play for G League Games**
#' @name nbagl_pbp
NULL
#' @title
#' **Get NBA Data API Play-by-Play for G League Games**
#' @description Scrapes the NBA Data API for Play By Play for G League games
#' @rdname nbagl_pbp
#' @author Billy Fryer
#' @param game_id Game ID - 10 digits, i.e. 0021900001
#' @return Returns a data frame of play by play
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows
#' @importFrom glue glue
#' @import rvest
#' @export

nbagl_pbp <- function(game_id) {

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

  plays_df <- data.frame()

  tryCatch(
    expr={
      res <- httr::RETRY("GET", full_url)

      # Check the result
      check_status(res)

      resp <- res %>%
        httr::content(as = "text", encoding = "UTF-8")


      data <- jsonlite::fromJSON(resp)$g
      plays <- jsonlite::fromJSON(jsonlite::toJSON(data$pd),flatten=TRUE)
      plays_df <- purrr::map_df(plays[[1]],function(x){
        plays_df <- plays[[2]][[x]] %>%
          dplyr::mutate(period = x) %>%
          dplyr::select(.data$period, tidyr::everything())
      }) %>%
        make_hoopR_data("NBA G-League Play-by-Play Information from NBA.com",Sys.time())
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


### Variables included

# evt = Event number
# cl = Time Remaining in Quarter
# de = description
# locX = X location of action
# locY = Y location of action
# opt1 = ???
# opt2 = ???
# mtype = ???
# etype = ???
# opid = ???
# tid = Team ID, 0 for events not relating to a team (such as end of Q)
# pid = Player ID
# hs = Home Score
# vs = Visitor Score
# epid = Secondary Person ID (such as assister)
# oftid = Offensive Team ID? This is equal to tid in my test case
# ord = ???
