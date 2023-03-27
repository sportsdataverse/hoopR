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
#'   |col_name      |types     |
#'   |:-------------|:---------|
#'   |TEAM_ID       |character |
#'   |PTS           |character |
#'   |PTS_PERSON_ID |character |
#'   |PTS_PLAYER    |character |
#'   |AST           |character |
#'   |AST_PERSON_ID |character |
#'   |AST_PLAYER    |character |
#'   |REB           |character |
#'   |REB_PERSON_ID |character |
#'   |REB_PLAYER    |character |
#'   |BLK           |character |
#'   |BLK_PERSON_ID |character |
#'   |BLK_PLAYER    |character |
#'   |STL           |character |
#'   |STL_PERSON_ID |character |
#'   |STL_PLAYER    |character |
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

  version <- "franchiseleaders"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no franchise leaders data available for {team_id}!"))
    },
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
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |LEAGUE_ID        |character |
#'    |TEAM_ID          |character |
#'    |TEAM             |character |
#'    |PERSON_ID        |character |
#'    |PLAYER           |character |
#'    |SEASON_TYPE      |character |
#'    |ACTIVE_WITH_TEAM |character |
#'    |GP               |character |
#'    |MINUTES          |character |
#'    |FGM              |character |
#'    |FGA              |character |
#'    |FG_PCT           |character |
#'    |FG3M             |character |
#'    |FG3A             |character |
#'    |FG3_PCT          |character |
#'    |FTM              |character |
#'    |FTA              |character |
#'    |FT_PCT           |character |
#'    |OREB             |character |
#'    |DREB             |character |
#'    |REB              |character |
#'    |AST              |character |
#'    |PF               |character |
#'    |STL              |character |
#'    |TOV              |character |
#'    |BLK              |character |
#'    |PTS              |character |
#'    |F_RANK_GP        |character |
#'    |F_RANK_MINUTES   |character |
#'    |F_RANK_FGM       |character |
#'    |F_RANK_FGA       |character |
#'    |F_RANK_FG_PCT    |character |
#'    |F_RANK_FG3M      |character |
#'    |F_RANK_FG3A      |character |
#'    |F_RANK_FG3_PCT   |character |
#'    |F_RANK_FTM       |character |
#'    |F_RANK_FTA       |character |
#'    |F_RANK_FT_PCT    |character |
#'    |F_RANK_OREB      |character |
#'    |F_RANK_DREB      |character |
#'    |F_RANK_REB       |character |
#'    |F_RANK_AST       |character |
#'    |F_RANK_PF        |character |
#'    |F_RANK_STL       |character |
#'    |F_RANK_TOV       |character |
#'    |F_RANK_BLK       |character |
#'    |F_RANK_PTS       |character |
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

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no franchise players data available for {team_id}!"))
    },
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
#'    |col_name         |types     |
#'    |:----------------|:---------|
#'    |LEAGUE_ID        |character |
#'    |TEAM_ID          |character |
#'    |TEAM             |character |
#'    |PERSON_ID        |character |
#'    |PLAYER           |character |
#'    |SEASON_TYPE      |character |
#'    |ACTIVE_WITH_TEAM |character |
#'    |GP               |character |
#'    |FGM              |character |
#'    |FGA              |character |
#'    |FG_PCT           |character |
#'    |FG3M             |character |
#'    |FG3A             |character |
#'    |FG3_PCT          |character |
#'    |FTM              |character |
#'    |FTA              |character |
#'    |FT_PCT           |character |
#'    |OREB             |character |
#'    |DREB             |character |
#'    |REB              |character |
#'    |AST              |character |
#'    |PF               |character |
#'    |STL              |character |
#'    |TOV              |character |
#'    |BLK              |character |
#'    |PTS              |character |
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

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no franchise players data available for {team_id}!"))
    },
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
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |LEAGUE_ID      |character |
#'    |TEAM_ID        |character |
#'    |TEAM_CITY      |character |
#'    |TEAM_NAME      |character |
#'    |START_YEAR     |character |
#'    |END_YEAR       |character |
#'    |YEARS          |character |
#'    |GAMES          |character |
#'    |WINS           |character |
#'    |LOSSES         |character |
#'    |WIN_PCT        |character |
#'    |PO_APPEARANCES |character |
#'    |DIV_TITLES     |character |
#'    |CONF_TITLES    |character |
#'    |LEAGUE_TITLES  |character |
#'
#'    **DefunctTeams**
#'
#'
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |LEAGUE_ID      |character |
#'    |TEAM_ID        |character |
#'    |TEAM_CITY      |character |
#'    |TEAM_NAME      |character |
#'    |START_YEAR     |character |
#'    |END_YEAR       |character |
#'    |YEARS          |character |
#'    |GAMES          |character |
#'    |WINS           |character |
#'    |LOSSES         |character |
#'    |WIN_PCT        |character |
#'    |PO_APPEARANCES |character |
#'    |DIV_TITLES     |character |
#'    |CONF_TITLES    |character |
#'    |LEAGUE_TITLES  |character |
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

  version <- "franchisehistory"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no franchise history data available for {team_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
