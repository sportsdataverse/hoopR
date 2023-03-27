#' **Get Current G League Standings from NBA API**
#' @name nbagl_standings
NULL
#' @title **Get Current G League Standings from NBA API**
#' @description Scrapes the NBA Data API for G League Standings
#' @rdname nbagl_standings
#' @author Billy Fryer
#' @param season Season - 4 digit, i.e. 2021
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a tibble of the G League Season Standings
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |val      |character |
#'    |di_val   |character |
#'    |tid      |integer   |
#'    |see      |integer   |
#'    |cli      |integer   |
#'    |clid     |integer   |
#'    |clic     |integer   |
#'    |elim     |integer   |
#'    |str      |character |
#'    |l10      |character |
#'    |dr       |character |
#'    |cr       |character |
#'    |l        |integer   |
#'    |w        |integer   |
#'    |hr       |character |
#'    |ar       |character |
#'    |gb       |numeric   |
#'    |gbd      |numeric   |
#'    |ta       |character |
#'    |tn       |character |
#'    |tc       |character |
#'
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr pull bind_rows arrange
#' @import rvest
#' @export
#' @family NBA G-League Functions
#' @details
#' ```r
#'  nbagl_standings(season = most_recent_nba_season() - 1)
#' ```

nbagl_standings <- function(
    season = most_recent_nba_season() - 1,
    ...) {

  full_url <- glue::glue("https://s.data.nba.com/data/10s/v2015/json/mobile_teams/dleague/{season}/20_standings_05.json")
  tryCatch(
    expr = {

      res <- httr::RETRY("GET", full_url, ...)

      resp <- res$content %>%
        rawToChar() %>%
        jsonlite::fromJSON(simplifyVector = T)
      # Find Table with the pbp in it
      data <- resp$sta$co %>%
        tidyr::unnest("di", names_sep = '_') %>%
        tidyr::unnest("di_t") %>%
        arrange(.data$see) %>%
        make_hoopR_data("NBA G-League Standings Information from NBA.com",Sys.time())
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no G-League standings data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )


  return(data)
}
# Example PBP JSON Link:
# https://s.data.nba.com/data/10s/v2015/json/mobile_teams/dleague/2021/20_standings_05.json

### Variable Explanation

# tid = Team ID
# see = Ranking
# cli = ???
# clid = ???
# clic = ???
# elim = ???
# str = Win Streak. All data comes in format "W/L ##"
# l10 = Last 10 Games Record
# dr = ???
# cr = ???
# l = Losses
# w = Wins
# hr = Home Record
# ar = Away Record
# gb = Games Behind
# gbd = Games Behind Division
# crnk = Conference Rank? This appears to be the same as see
# drnk = Division Rank
# ta = Team Abbreviation
# tn = Team Nickname
# tc = Team City
