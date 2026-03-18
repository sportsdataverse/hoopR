#' **Get G League Player Data Base from NBA API**
#' @name nbagl_players
NULL
#' @title
#' **Get G League Player Data Base from NBA API**
#' @description Retrieves G-League player index data via the NBA Stats API player index endpoint.
#' @rdname nbagl_players
#' @author Billy Fryer
#' @param college College filter.
#' @param country Country filter.
#' @param draft_pick Draft pick filter.
#' @param draft_round Draft round filter.
#' @param draft_year Draft year filter.
#' @param height Height filter.
#' @param historical Historical flag.
#' @param league_id League - default: '20' (G-League).
#' @param player_position Player position filter.
#' @param season Season - format 2020-21.
#' @param season_type Season Type - Regular Season, Playoffs, All-Star.
#' @param team_id Team ID filter.
#' @param weight Weight filter.
#' @param active Active status filter.
#' @param all_star All-Star filter.
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerIndex
#'
#'    **PlayerIndex**
#'
#'    |col_name          |types     |
#'    |:-----------------|:---------|
#'    |PERSON_ID         |character |
#'    |PLAYER_LAST_NAME  |character |
#'    |PLAYER_FIRST_NAME |character |
#'    |PLAYER_SLUG       |character |
#'    |TEAM_ID           |character |
#'    |TEAM_SLUG         |character |
#'    |TEAM_CITY         |character |
#'    |TEAM_NAME         |character |
#'    |TEAM_ABBREVIATION |character |
#'    |JERSEY_NUMBER     |character |
#'    |POSITION          |character |
#'    |HEIGHT            |character |
#'    |WEIGHT            |character |
#'    |COLLEGE           |character |
#'    |COUNTRY           |character |
#'    |DRAFT_YEAR        |character |
#'    |DRAFT_ROUND       |character |
#'    |DRAFT_NUMBER      |character |
#'    |ROSTER_STATUS     |character |
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
    college = "",
    country = "",
    draft_pick = "",
    draft_round = "",
    draft_year = "",
    height = "",
    historical = 1,
    league_id = "20",
    player_position = "",
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = "Regular Season",
    team_id = "0",
    weight = "",
    active = "",
    all_star = "",
    ...) {
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerindex"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Active = active,
    AllStar = all_star,
    College = college,
    Country = country,
    DraftPick = draft_pick,
    DraftRound = draft_round,
    DraftYear = draft_year,
    Height = height,
    Historical = historical,
    LeagueID = league_id,
    PlayerPosition = player_position,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player index data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
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
