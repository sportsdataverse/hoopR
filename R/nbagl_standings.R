#' **Get Current G League Standings from NBA API**
#' @name nbagl_standings
NULL
#' @title **Get Current G League Standings from NBA API**
#' @description Retrieves G-League standings via the NBA Stats API standings endpoint.
#' @rdname nbagl_standings
#' @author Billy Fryer
#' @param league_id League - default: '20' (G-League).
#' @param season Season - format 2020-21.
#' @param season_type Season Type - Regular Season, Playoffs, All-Star.
#' @param season_year Season year filter (optional).
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Standings
#'
#'    **Standings**
#'
#'    |col_name             |types     |
#'    |:--------------------|:---------|
#'    |LeagueID             |character |
#'    |SeasonID             |character |
#'    |TeamID               |character |
#'    |TeamCity             |character |
#'    |TeamName             |character |
#'    |TeamSlug             |character |
#'    |Conference           |character |
#'    |ConferenceRecord     |character |
#'    |PlayoffRank          |character |
#'    |Division             |character |
#'    |WINS                 |character |
#'    |LOSSES               |character |
#'    |WinPCT               |character |
#'    |LeagueRank           |character |
#'    |Record               |character |
#'    |HOME                 |character |
#'    |ROAD                 |character |
#'    |CurrentStreak        |character |
#'    |strCurrentStreak     |character |
#'    |ConferenceGamesBack  |character |
#'    |DivisionGamesBack    |character |
#'    |LeagueGamesBack      |character |
#'    |ClinchedPostSeason   |character |
#'    |NEUTRAL              |character |
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
    league_id = "20",
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    season_year = "",
    ...) {
  # Intentional
  # season_type <- gsub(' ','+',season_type)
  version <- "leaguestandingsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league standings v3 data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
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
