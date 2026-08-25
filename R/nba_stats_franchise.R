#' **Get NBA Stats API Franchise Leaders**
#' @rdname nba_franchisehistory
#' @name nba_franchiseleaders
NULL
#' @title
#' **Get NBA Stats API Franchise Leaders**
#' @rdname nba_franchisehistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchiseLeaders
#'
#'   **FranchiseLeaders**
#'
#'
#'   \if{html}{\tabular{lll}{
#'      col_name \tab types \tab description \cr
#'      TEAM_ID \tab character \tab Unique team identifier. \cr
#'      PTS \tab character \tab Points scored. \cr
#'      PTS_PERSON_ID \tab character \tab  \cr
#'      PTS_PLAYER \tab character \tab  \cr
#'      AST \tab character \tab Assists. \cr
#'      AST_PERSON_ID \tab character \tab  \cr
#'      AST_PLAYER \tab character \tab  \cr
#'      REB \tab character \tab Total rebounds. \cr
#'      REB_PERSON_ID \tab character \tab  \cr
#'      REB_PLAYER \tab character \tab  \cr
#'      BLK \tab character \tab Blocks. \cr
#'      BLK_PERSON_ID \tab character \tab  \cr
#'      BLK_PLAYER \tab character \tab  \cr
#'      STL \tab character \tab Steals. \cr
#'      STL_PERSON_ID \tab character \tab  \cr
#'      STL_PLAYER \tab character \tab  \cr
#'   }}
#'   \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Franchise Functions
#' @details
#' [Franchise Leaders](https://www.nba.com/stats/team/1610612737/franchise-leaders)
#' ```r
#'  nba_franchiseleaders(league_id = '00', team_id = '1610612739')
#' ```
nba_franchiseleaders <- function(
    league_id = '00',
    team_id = '1610612739',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "franchiseleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
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
      hint = "Invalid arguments or no franchise leaders data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Franchise Leaders with Rank**
#' @rdname nba_franchisehistory
#' @name nba_franchiseleaderswrank
NULL
#' @title
#' **Get NBA Stats API Franchise Leaders with Rank**
#' @rdname nba_franchisehistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param per_mode per_mode
#' @param season_type season_type
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchiseLeaderswRank
#'
#'    **FranchiseLeaderswRank**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LEAGUE_ID \tab character \tab League identifier ('10' = WNBA). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM \tab character \tab Team-side label or team identifier. \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       PLAYER \tab character \tab Player. \cr
#'       SEASON_TYPE \tab character \tab Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). \cr
#'       ACTIVE_WITH_TEAM \tab character \tab  \cr
#'       GP \tab character \tab Games played. \cr
#'       MINUTES \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       STL \tab character \tab Steals. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       F_RANK_GP \tab character \tab  \cr
#'       F_RANK_MINUTES \tab character \tab  \cr
#'       F_RANK_FGM \tab character \tab  \cr
#'       F_RANK_FGA \tab character \tab  \cr
#'       F_RANK_FG_PCT \tab character \tab  \cr
#'       F_RANK_FG3M \tab character \tab  \cr
#'       F_RANK_FG3A \tab character \tab  \cr
#'       F_RANK_FG3_PCT \tab character \tab  \cr
#'       F_RANK_FTM \tab character \tab  \cr
#'       F_RANK_FTA \tab character \tab  \cr
#'       F_RANK_FT_PCT \tab character \tab  \cr
#'       F_RANK_OREB \tab character \tab  \cr
#'       F_RANK_DREB \tab character \tab  \cr
#'       F_RANK_REB \tab character \tab  \cr
#'       F_RANK_AST \tab character \tab  \cr
#'       F_RANK_PF \tab character \tab  \cr
#'       F_RANK_STL \tab character \tab  \cr
#'       F_RANK_TOV \tab character \tab  \cr
#'       F_RANK_BLK \tab character \tab  \cr
#'       F_RANK_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Franchise Functions
#' @details
#' [Franchise Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)
#' ```r
#'  nba_franchiseleaderswrank(league_id = '00', team_id = '1610612739')
#'  nba_franchiseleaderswrank(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')
#' ```
nba_franchiseleaderswrank <- function(
    league_id = '00',
    per_mode = 'Totals',
    season_type = 'Regular Season',
    team_id = '1610612739',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  version <- "franchiseleaderswrank"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no franchise players data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Franchise Players**
#' @rdname nba_franchisehistory
#' @name nba_franchiseplayers
NULL
#' @title
#' **Get NBA Stats API Franchise Players**
#' @rdname nba_franchisehistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param per_mode per_mode
#' @param season_type season_type
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchisePlayers
#'
#'    **FranchisePlayers**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LEAGUE_ID \tab character \tab League identifier ('10' = WNBA). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM \tab character \tab Team-side label or team identifier. \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       PLAYER \tab character \tab Player. \cr
#'       SEASON_TYPE \tab character \tab Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). \cr
#'       ACTIVE_WITH_TEAM \tab character \tab  \cr
#'       GP \tab character \tab Games played. \cr
#'       FGM \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3M \tab character \tab Three-point field goals made. \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FTM \tab character \tab Free throws made. \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OREB \tab character \tab Offensive rebounds. \cr
#'       DREB \tab character \tab Defensive rebounds. \cr
#'       REB \tab character \tab Total rebounds. \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       STL \tab character \tab Steals. \cr
#'       TOV \tab character \tab Turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Franchise Functions
#' @details
#' [Franchise Players](https://www.nba.com/stats/team/1610612739/franchise-leaders)
#' ```r
#'  nba_franchiseplayers(league_id = '00', team_id = '1610612739')
#'  nba_franchiseplayers(league_id = '00', season_type = 'Playoffs', team_id = '1610612739')
#' ```
nba_franchiseplayers <- function(
    league_id = '00',
    per_mode = 'Totals',
    season_type = 'Regular Season',
    team_id = '1610612739',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # season_type <- gsub(' ','+',season_type)
  version <- "franchiseplayers"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    SeasonType = season_type,
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
      hint = "Invalid arguments or no franchise players data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Franchise History**
#' @name nba_franchisehistory
NULL
#' @title
#' **Get NBA Stats API Franchise History**
#' @rdname nba_franchisehistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DefunctTeams, FranchiseHistory
#'
#'    **FranchiseHistory**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LEAGUE_ID \tab character \tab League identifier ('10' = WNBA). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       START_YEAR \tab character \tab  \cr
#'       END_YEAR \tab character \tab  \cr
#'       YEARS \tab character \tab Years. \cr
#'       GAMES \tab character \tab  \cr
#'       WINS \tab character \tab Total wins. \cr
#'       LOSSES \tab character \tab Total losses. \cr
#'       WIN_PCT \tab character \tab  \cr
#'       PO_APPEARANCES \tab character \tab  \cr
#'       DIV_TITLES \tab character \tab  \cr
#'       CONF_TITLES \tab character \tab  \cr
#'       LEAGUE_TITLES \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **DefunctTeams**
#'
#'
#'    Same columns as the **FranchiseHistory** table above.
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Franchise Functions
#' @details
#' [Franchise History](https://www.nba.com/stats/history)
#' ```r
#'  nba_franchisehistory(league_id = '00')
#'  nba_franchisehistory(league_id = '01')
#'  nba_franchisehistory(league_id = '10')
#'  nba_franchisehistory(league_id = '20')
#' ```
nba_franchisehistory <- function(
    league_id = '00',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "franchisehistory"
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
      hint = "Invalid arguments or no franchise history data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
