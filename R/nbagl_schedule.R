#' **Get G League Schedule from NBA API**
#' @name nbagl_schedule
NULL
#' @title **Get G League Schedule from NBA API**
#' @description Scrapes the NBA Data API for G League Schedule for a Given Season
#' @rdname nbagl_schedule
#' @author Billy Fryer
#' @param season Season - 4 digit, i.e. 2021
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a data frame of the G League Season Schedule
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |mon      |character |
#'    |gid      |character |
#'    |gcode    |character |
#'    |seri     |character |
#'    |is       |integer   |
#'    |gdte     |character |
#'    |htm      |character |
#'    |vtm      |character |
#'    |etm      |character |
#'    |an       |character |
#'    |ac       |character |
#'    |as       |character |
#'    |st       |character |
#'    |stt      |character |
#'    |gdtutc   |character |
#'    |utctm    |character |
#'    |ppdst    |character |
#'    |seq      |integer   |
#'    |bd_b     |list      |
#'    |v_tid    |integer   |
#'    |v_re     |character |
#'    |v_ta     |character |
#'    |v_tn     |character |
#'    |v_tc     |character |
#'    |v_s      |character |
#'    |h_tid    |integer   |
#'    |h_re     |character |
#'    |h_ta     |character |
#'    |h_tn     |character |
#'    |h_tc     |character |
#'    |h_s      |character |
#'    |ptsls_pl |list      |
#'
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows arrange
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_schedule(season = most_recent_nba_season() - 1)
#' ```

nbagl_schedule <- function(
    season = most_recent_nba_season() - 1,
    ...) {
  # From This Line to My next comment, basically everything is
  # Copied from hoopR except the url and the table name
  full_url <- glue::glue("https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/{season}/league/20_full_schedule.json")
  tryCatch(
    expr = {

      res <- httr::RETRY("GET", full_url, ...)

      resp <- res$content %>%
        rawToChar() %>%
        jsonlite::fromJSON(simplifyVector = T)

      schedule_df <- resp$lscd$mscd %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten=TRUE) %>%
        tidyr::unnest("g") %>%
        janitor::clean_names() %>%
        dplyr::arrange(.data$gdte) %>%
        make_hoopR_data("NBA G-League Season Schedule Information from NBA.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no season schedule data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )

  return(schedule_df)
}

# Example JSON Link:
# https://data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/league/20_full_schedule.json

# 2015 and Older does not work

### Variable Explanation

# gid = Game Id
# gcode = GameDate/VisitorAbbreveationHomeAbbreviation
# seri = Always returns ""
# is = Always returns 1
# gdte = Game Date
# htm = Game Date and time for Home Team
# vtm = Game Date and time for Visiting Team
# etm = Game Date and time in Eastern
# an = Arena where game was played
# ac = City where game was played
# as = Atate where game was played
# st = Always "1"
# stt = Game Start time in eastern for "12:00 pm EST"
# bd.b = Data Frame with 6 variables about television broadcast
# v.tid = Visitor Team Id
# v.re = Visitor Record (?)
# v.ta = Visitor Abbreviation
# v.tn = Visitor Team Nickname
# v.tc = Visitor Team City
# v.s = NULL
# h.tid = Home Team Id
# h.re =  Home Record (?)
# h.ta =  Home Abbreviation
# h.tn =  Home Team Nickname
# h.tc =  Home Team City
# h.s = NULL
# gdctm = Game Date but somehow different than gdte
# utctm = ???
# ppdst = ???
# seq = Game Order By Day (1st game on 1-1-2022, 2nd game on 1-1-2022, 1st game on 1-2-2022, etc.)

