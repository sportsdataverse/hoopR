#' **Get NBA Stats API Franchise Leaders**
#' @name franchiseleaders
NULL
#' @title
#' **Get NBA Stats API Franchise Leaders**
#' @rdname franchiseleaders
#' @author Saiem Gilani
#' @param league_id league_id
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchiseLeaders
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_franchiseleaders <- function(
    league_id='00',
    team_id = '1610612739',
    ...){
  season_type <- gsub(' ','+',season_type)
  version <- "franchiseleaders"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&TeamID=",team_id)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name

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


#' **Get NBA Stats API Franchise Players**
#' @name franchiseplayers
NULL
#' @title
#' **Get NBA Stats API Franchise Players**
#' @rdname franchiseplayers
#' @author Saiem Gilani
#' @param league_id league_id
#' @param per_mode per_mode
#' @param season_type season_type
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: FranchisePlayers
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_franchiseplayers <- function(
    league_id='00',
    per_mode = 'Totals',
    season_type = 'Regular Season',
    team_id = '1610612739',
    ...){
  season_type <- gsub(' ','+',season_type)
  version <- "franchiseplayers"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&PerMode=", per_mode,
                     "&SeasonType=", season_type,
                     "&TeamID=",team_id)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name

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
#' @name franchisehistory
NULL
#' @title
#' **Get NBA Stats API Franchise History**
#' @rdname franchisehistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DefunctTeams, FranchiseHistory
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_franchisehistory <- function(
    league_id='00',
    ...){

  version <- "franchisehistory"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- purrr::map(1:length(resp$resultSets$name), function(x){
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name

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
