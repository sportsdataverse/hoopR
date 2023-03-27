#' **Get G League Player Data Base from NBA API**
#' @name nbagl_players
NULL
#' @title
#' **Get G League Player Data Base from NBA API**
#' @description Scrapes the NBA Data API for All Players in G League History
#' @rdname nbagl_players
#' @author Billy Fryer
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame of G League Players from NBA Database
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |nba-affiliation |character |
#'    |season          |integer   |
#'    |permalink       |character |
#'    |tid             |integer   |
#'    |fn              |character |
#'    |ln              |character |
#'    |pid             |integer   |
#'    |num             |character |
#'    |pos             |character |
#'    |dob             |character |
#'    |ht              |character |
#'    |wt              |integer   |
#'    |y               |integer   |
#'    |sn              |character |
#'    |ty              |character |
#'    |co              |character |
#'    |la              |character |
#'    |dy              |character |
#'    |pc              |character |
#'    |fa              |character |
#'    |s               |character |
#'    |twc             |character |
#'    |ta              |character |
#'    |tn              |character |
#'    |tc              |character |
#'
#' @importFrom jsonlite fromJSON
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_players()
#' ```

nbagl_players <- function(
    ...) {
  full_url <- "https://gleague.nba.com/config/gleague/players.json"
  tryCatch(
    expr = {

      res <- httr::RETRY("GET", full_url, ...)

      resp <- httr::content(x = res, as = "text", encoding = "UTF-8")

      data <- jsonlite::fromJSON(resp)[["_data"]] %>%
        make_hoopR_data("NBA G-League Players Information from NBA.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no players data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(data)
}

# Example JSON Link:
# "https://gleague.nba.com/config/gleague/players.json"

### Variable Explanation


# tid = Team Id
# fn = First Name
# ln = Last Name
# pid = Player Id
# num = Jersey Number
# pos = Position
# dob = Date of Birth in "YYYY-MM-DD" Form
# ht = Height In "F-I" Form
# wt = Weight
# y = Years of Experience
# sn = Previous Team
# ty = Last Level Played at (college, international, etc)
# co = Home Country
# la = Last Team/Home Country, if last team not available, replace with Home Country
# dy = ??? Draft Year?, 0 if not drafted?
# pc = First Name_Last Name
# fa = ??? Free Agency? Only Options are "N" and NA
# s = ??? Have reached the NBA at some point? Only Options are "A" "I" or NA
# twc = ???
# ta = Team Abbreviation
# tn = Team Name
# tc = Team City
# nba-affiliation = Team ID of Affiliated NBA Team
# season = Year. Seems to go back to 2014 and is a little messy
# permalink = https://gleague.nba.com/player/{pc variable}
