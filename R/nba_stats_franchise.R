#' **Get NBA Stats API Franchise Leaders**
#' @name nba_franchiseleaders
NULL
#' @title
#' **Get NBA Stats API Franchise Leaders**
#' @rdname nba_franchiseleaders
#' @author Saiem Gilani
#' @param league_id league_id
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchiseLeaders
#'
#'   **FranchiseLeaders**
#'
#'
#'   |col_name      |types     |description             |
#'   |:-------------|:---------|:-----------------------|
#'   |TEAM_ID       |character |Unique team identifier. |
#'   |PTS           |character |Points scored.          |
#'   |PTS_PERSON_ID |character |                        |
#'   |PTS_PLAYER    |character |                        |
#'   |AST           |character |Assists.                |
#'   |AST_PERSON_ID |character |                        |
#'   |AST_PLAYER    |character |                        |
#'   |REB           |character |Total rebounds.         |
#'   |REB_PERSON_ID |character |                        |
#'   |REB_PLAYER    |character |                        |
#'   |BLK           |character |Blocks.                 |
#'   |BLK_PERSON_ID |character |                        |
#'   |BLK_PLAYER    |character |                        |
#'   |STL           |character |Steals.                 |
#'   |STL_PERSON_ID |character |                        |
#'   |STL_PLAYER    |character |                        |
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
#' @name nba_franchiseleaderswrank
NULL
#' @title
#' **Get NBA Stats API Franchise Leaders with Rank**
#' @rdname nba_franchiseleaderswrank
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
#'    |col_name         |types     |description                                                                                                        |
#'    |:----------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |LEAGUE_ID        |character |League identifier ('10' = WNBA).                                                                                   |
#'    |TEAM_ID          |character |Unique team identifier.                                                                                            |
#'    |TEAM             |character |Team-side label or team identifier.                                                                                |
#'    |PERSON_ID        |character |Unique player identifier (V3 endpoints).                                                                           |
#'    |PLAYER           |character |Player.                                                                                                            |
#'    |SEASON_TYPE      |character |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |ACTIVE_WITH_TEAM |character |                                                                                                                   |
#'    |GP               |character |Games played.                                                                                                      |
#'    |MINUTES          |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2).                                   |
#'    |FGM              |character |Field goals made.                                                                                                  |
#'    |FGA              |character |Field goal attempts.                                                                                               |
#'    |FG_PCT           |character |Field goal percentage (0-1).                                                                                       |
#'    |FG3M             |character |Three-point field goals made.                                                                                      |
#'    |FG3A             |character |Three-point field goal attempts.                                                                                   |
#'    |FG3_PCT          |character |Three-point field goal percentage (0-1).                                                                           |
#'    |FTM              |character |Free throws made.                                                                                                  |
#'    |FTA              |character |Free throw attempts.                                                                                               |
#'    |FT_PCT           |character |Free throw percentage (0-1).                                                                                       |
#'    |OREB             |character |Offensive rebounds.                                                                                                |
#'    |DREB             |character |Defensive rebounds.                                                                                                |
#'    |REB              |character |Total rebounds.                                                                                                    |
#'    |AST              |character |Assists.                                                                                                           |
#'    |PF               |character |Personal fouls.                                                                                                    |
#'    |STL              |character |Steals.                                                                                                            |
#'    |TOV              |character |Turnovers.                                                                                                         |
#'    |BLK              |character |Blocks.                                                                                                            |
#'    |PTS              |character |Points scored.                                                                                                     |
#'    |F_RANK_GP        |character |                                                                                                                   |
#'    |F_RANK_MINUTES   |character |                                                                                                                   |
#'    |F_RANK_FGM       |character |                                                                                                                   |
#'    |F_RANK_FGA       |character |                                                                                                                   |
#'    |F_RANK_FG_PCT    |character |                                                                                                                   |
#'    |F_RANK_FG3M      |character |                                                                                                                   |
#'    |F_RANK_FG3A      |character |                                                                                                                   |
#'    |F_RANK_FG3_PCT   |character |                                                                                                                   |
#'    |F_RANK_FTM       |character |                                                                                                                   |
#'    |F_RANK_FTA       |character |                                                                                                                   |
#'    |F_RANK_FT_PCT    |character |                                                                                                                   |
#'    |F_RANK_OREB      |character |                                                                                                                   |
#'    |F_RANK_DREB      |character |                                                                                                                   |
#'    |F_RANK_REB       |character |                                                                                                                   |
#'    |F_RANK_AST       |character |                                                                                                                   |
#'    |F_RANK_PF        |character |                                                                                                                   |
#'    |F_RANK_STL       |character |                                                                                                                   |
#'    |F_RANK_TOV       |character |                                                                                                                   |
#'    |F_RANK_BLK       |character |                                                                                                                   |
#'    |F_RANK_PTS       |character |                                                                                                                   |
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
#' @name nba_franchiseplayers
NULL
#' @title
#' **Get NBA Stats API Franchise Players**
#' @rdname nba_franchiseplayers
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
#'    |col_name         |types     |description                                                                                                        |
#'    |:----------------|:---------|:------------------------------------------------------------------------------------------------------------------|
#'    |LEAGUE_ID        |character |League identifier ('10' = WNBA).                                                                                   |
#'    |TEAM_ID          |character |Unique team identifier.                                                                                            |
#'    |TEAM             |character |Team-side label or team identifier.                                                                                |
#'    |PERSON_ID        |character |Unique player identifier (V3 endpoints).                                                                           |
#'    |PLAYER           |character |Player.                                                                                                            |
#'    |SEASON_TYPE      |character |Season type (1=pre-season, 2=regular season, 3=postseason, 4=off-season for ESPN; or string label for WNBA Stats). |
#'    |ACTIVE_WITH_TEAM |character |                                                                                                                   |
#'    |GP               |character |Games played.                                                                                                      |
#'    |FGM              |character |Field goals made.                                                                                                  |
#'    |FGA              |character |Field goal attempts.                                                                                               |
#'    |FG_PCT           |character |Field goal percentage (0-1).                                                                                       |
#'    |FG3M             |character |Three-point field goals made.                                                                                      |
#'    |FG3A             |character |Three-point field goal attempts.                                                                                   |
#'    |FG3_PCT          |character |Three-point field goal percentage (0-1).                                                                           |
#'    |FTM              |character |Free throws made.                                                                                                  |
#'    |FTA              |character |Free throw attempts.                                                                                               |
#'    |FT_PCT           |character |Free throw percentage (0-1).                                                                                       |
#'    |OREB             |character |Offensive rebounds.                                                                                                |
#'    |DREB             |character |Defensive rebounds.                                                                                                |
#'    |REB              |character |Total rebounds.                                                                                                    |
#'    |AST              |character |Assists.                                                                                                           |
#'    |PF               |character |Personal fouls.                                                                                                    |
#'    |STL              |character |Steals.                                                                                                            |
#'    |TOV              |character |Turnovers.                                                                                                         |
#'    |BLK              |character |Blocks.                                                                                                            |
#'    |PTS              |character |Points scored.                                                                                                     |
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
#'    |col_name       |types     |description                                     |
#'    |:--------------|:---------|:-----------------------------------------------|
#'    |LEAGUE_ID      |character |League identifier ('10' = WNBA).                |
#'    |TEAM_ID        |character |Unique team identifier.                         |
#'    |TEAM_CITY      |character |Team city or region (e.g. 'Las Vegas').         |
#'    |TEAM_NAME      |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |START_YEAR     |character |                                                |
#'    |END_YEAR       |character |                                                |
#'    |YEARS          |character |Years.                                          |
#'    |GAMES          |character |                                                |
#'    |WINS           |character |Total wins.                                     |
#'    |LOSSES         |character |Total losses.                                   |
#'    |WIN_PCT        |character |                                                |
#'    |PO_APPEARANCES |character |                                                |
#'    |DIV_TITLES     |character |                                                |
#'    |CONF_TITLES    |character |                                                |
#'    |LEAGUE_TITLES  |character |                                                |
#'
#'    **DefunctTeams**
#'
#'
#'    |col_name       |types     |description                                     |
#'    |:--------------|:---------|:-----------------------------------------------|
#'    |LEAGUE_ID      |character |League identifier ('10' = WNBA).                |
#'    |TEAM_ID        |character |Unique team identifier.                         |
#'    |TEAM_CITY      |character |Team city or region (e.g. 'Las Vegas').         |
#'    |TEAM_NAME      |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |START_YEAR     |character |                                                |
#'    |END_YEAR       |character |                                                |
#'    |YEARS          |character |Years.                                          |
#'    |GAMES          |character |                                                |
#'    |WINS           |character |Total wins.                                     |
#'    |LOSSES         |character |Total losses.                                   |
#'    |WIN_PCT        |character |                                                |
#'    |PO_APPEARANCES |character |                                                |
#'    |DIV_TITLES     |character |                                                |
#'    |CONF_TITLES    |character |                                                |
#'    |LEAGUE_TITLES  |character |                                                |
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
