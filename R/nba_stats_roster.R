#' **Get NBA Stats API All Players**
#' @name nba_commonallplayers
NULL
#' @title
#' **Get NBA Stats API All Players**
#' @rdname nba_commonallplayers
#' @author Saiem Gilani
#' @param is_only_current_season is_only_current_season
#' @param league_id league_id
#' @param season season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: CommonAllPlayers
#'
#'    **CommonAllPlayers**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       DISPLAY_LAST_COMMA_FIRST \tab character \tab  \cr
#'       DISPLAY_FIRST_LAST \tab character \tab  \cr
#'       ROSTERSTATUS \tab character \tab  \cr
#'       FROM_YEAR \tab character \tab  \cr
#'       TO_YEAR \tab character \tab  \cr
#'       PLAYERCODE \tab character \tab  \cr
#'       PLAYER_SLUG \tab character \tab URL-safe player identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CODE \tab character \tab  \cr
#'       TEAM_SLUG \tab character \tab URL-safe team identifier (e.g. 'lasvegas-aces' / 'aces'). \cr
#'       GAMES_PLAYED_FLAG \tab character \tab  \cr
#'       OTHERLEAGUE_EXPERIENCE_CH \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' [All Players](https://www.nba.com/players)
#' ```r
#'   nba_commonallplayers(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_commonallplayers <- function(
    is_only_current_season = 0,
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "commonallplayers"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    IsOnlyCurrentSeason = is_only_current_season,
    Season = season
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or common all players data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Info**
#' @name nba_commonplayerinfo
NULL
#' @title
#' **Get NBA Stats API Player Info**
#' @rdname nba_commonplayerinfo
#' @author Saiem Gilani
#' @param league_id league_id
#' @param player_id player_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: CommonPlayerInfo, PlayerHeadlineStats,
#'  AvailableSeasons
#'
#'    **CommonPlayerInfo**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       DISPLAY_FIRST_LAST \tab character \tab  \cr
#'       DISPLAY_LAST_COMMA_FIRST \tab character \tab  \cr
#'       DISPLAY_FI_LAST \tab character \tab  \cr
#'       PLAYER_SLUG \tab character \tab URL-safe player identifier. \cr
#'       BIRTHDATE \tab character \tab  \cr
#'       SCHOOL \tab character \tab Player's school / college (when distinct from 'college'). \cr
#'       COUNTRY \tab character \tab Country (full name or code). \cr
#'       LAST_AFFILIATION \tab character \tab  \cr
#'       HEIGHT \tab character \tab Player height (string e.g. '6-2' or inches). \cr
#'       WEIGHT \tab character \tab Player weight in pounds. \cr
#'       SEASON_EXP \tab character \tab  \cr
#'       JERSEY \tab character \tab Jersey number worn by the player. \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       ROSTERSTATUS \tab character \tab  \cr
#'       GAMES_PLAYED_CURRENT_SEASON_FLAG \tab character \tab  \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CODE \tab character \tab  \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYERCODE \tab character \tab  \cr
#'       FROM_YEAR \tab character \tab  \cr
#'       TO_YEAR \tab character \tab  \cr
#'       DLEAGUE_FLAG \tab character \tab  \cr
#'       NBA_FLAG \tab character \tab  \cr
#'       GAMES_PLAYED_FLAG \tab character \tab  \cr
#'       DRAFT_YEAR \tab character \tab Draft year (4-digit). \cr
#'       DRAFT_ROUND \tab character \tab Round of the draft selection. \cr
#'       DRAFT_NUMBER \tab character \tab  \cr
#'       GREATEST_75_FLAG \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerHeadlineStats**
#'
#'
#'    |col_name    |types     |description                   |
#'    |:-----------|:---------|:-----------------------------|
#'    |PLAYER_ID   |character |Unique player identifier.     |
#'    |PLAYER_NAME |character |Player name.                  |
#'    |TimeFrame   |character |                              |
#'    |PTS         |character |Points scored.                |
#'    |AST         |character |Assists.                      |
#'    |REB         |character |Total rebounds.               |
#'    |PIE         |character |Player Impact Estimate (0-1). |
#'
#'    **AvailableSeasons**
#'
#'
#'    |col_name  |types     |description               |
#'    |:---------|:---------|:-------------------------|
#'    |SEASON_ID |character |Unique season identifier. |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' [Player Info](https://www.nba.com/stats/player/2544)
#' ```r
#'  nba_commonplayerinfo(league_id = '00', player_id = '2544')
#' ```
nba_commonplayerinfo <- function(
    league_id = '00',
    player_id = '2544',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "commonplayerinfo"
  endpoint <- nba_endpoint(version)

  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PlayerID = player_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or common player info data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Playoff Series**
#' @name nba_commonplayoffseries
NULL
#' @title
#' **Get NBA Stats API Playoff Series**
#' @rdname nba_commonplayoffseries
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param series_id series_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: PlayoffSeries
#'
#'    **PlayoffSeries**
#'
#'
#'    |col_name        |types     |description                          |
#'    |:---------------|:---------|:------------------------------------|
#'    |GAME_ID         |character |Unique game identifier.              |
#'    |HOME_TEAM_ID    |character |Unique identifier for the home team. |
#'    |VISITOR_TEAM_ID |character |                                     |
#'    |SERIES_ID       |character |                                     |
#'    |GAME_NUM        |character |                                     |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_commonplayoffseries(league_id = '00', season = year_to_season(most_recent_nba_season() - 2))
#' ```
nba_commonplayoffseries <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 2),
    series_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "commonplayoffseries"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeriesID = series_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or common playoff series data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Team Roster**
#' @name nba_commonteamroster
NULL
#' @title
#' **Get NBA Stats API Team Roster**
#' @rdname nba_commonteamroster
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season season
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: Coaches, CommonTeamRoster
#'
#'    **CommonTeamRoster**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TeamID \tab character \tab Teamid. \cr
#'       SEASON \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       LeagueID \tab character \tab  \cr
#'       PLAYER \tab character \tab Player. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       PLAYER_SLUG \tab character \tab URL-safe player identifier. \cr
#'       NUM \tab character \tab  \cr
#'       POSITION \tab character \tab Listed roster position (G, F, C, etc.). \cr
#'       HEIGHT \tab character \tab Player height (string e.g. '6-2' or inches). \cr
#'       WEIGHT \tab character \tab Player weight in pounds. \cr
#'       BIRTH_DATE \tab character \tab Date of birth (YYYY-MM-DD). \cr
#'       AGE \tab character \tab Player age (in years). \cr
#'       EXP \tab character \tab Exp. \cr
#'       SCHOOL \tab character \tab Player's school / college (when distinct from 'college'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       HOW_ACQUIRED \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **Coaches**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       SEASON \tab character \tab Season identifier (4-digit year or 'YYYY-YY' string). \cr
#'       COACH_ID \tab character \tab  \cr
#'       FIRST_NAME \tab character \tab Player's first name. \cr
#'       LAST_NAME \tab character \tab Player's last name. \cr
#'       COACH_NAME \tab character \tab  \cr
#'       IS_ASSISTANT \tab character \tab  \cr
#'       COACH_TYPE \tab character \tab  \cr
#'       SORT_SEQUENCE \tab character \tab  \cr
#'       SUB_SORT_SEQUENCE \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' [Team Roster](https://www.nba.com/stats/team/1610612756)
#' ```r
#'  nba_commonteamroster(season = year_to_season(most_recent_nba_season() - 1), team_id = '1610612739')
#' ```
nba_commonteamroster <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    team_id = '1610612739',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "commonteamroster"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    TeamID = team_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or common team roster data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Common Team Years**
#' @name nba_commonteamyears
NULL
#' @title
#' **Get NBA Stats API Common Team Years**
#' @rdname nba_commonteamyears
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: TeamYears
#'
#'    **TeamYears**
#'
#'
#'    |col_name     |types     |description                      |
#'    |:------------|:---------|:--------------------------------|
#'    |LEAGUE_ID    |character |League identifier ('10' = WNBA). |
#'    |TEAM_ID      |character |Unique team identifier.          |
#'    |MIN_YEAR     |character |                                 |
#'    |MAX_YEAR     |character |                                 |
#'    |ABBREVIATION |character |Short abbreviation.              |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' ```r
#'  nba_commonteamyears(league_id = '00')
#' ```
nba_commonteamyears <- function(
    league_id = '00',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "commonteamyears"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no common team years data available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
