#' **Get College Men's Basketball Rosters from ESPN API**
#' @name fantasywidget
NULL
#' @title
#' **Get College Men's Basketball Rosters from ESPN API**
#' @rdname fantasywidget
#' @author Billy Fryer
#' @param team_id team_id
#' @return Returns data frame of the team roster
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom httr GET RETRY content

espn_mbb_roster <- function(team_id) {
  # Base URL
  play_base_url <- "https://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/teams/"
  
  # Add team ID
  full_url <- paste0(play_base_url, team_id, "/roster")
  tryCatch(
    expr={
      res <- httr::RETRY("GET", full_url)
      
      resp <- httr::content(x = res, as = "text", encoding = "UTF-8")
      
      data <- jsonlite::fromJSON(resp)[["athletes"]]
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no roster available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  
  return(data)
}


