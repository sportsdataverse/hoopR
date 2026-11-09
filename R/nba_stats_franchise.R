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
#' @eval .returns_rd("nba_franchiseleaders", class = "tibble")
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
#' @eval .returns_rd("nba_franchiseleaderswrank", class = "tibble")
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
#' @eval .returns_rd("nba_franchiseplayers", class = "tibble")
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
#' @eval .returns_rd("nba_franchisehistory", class = "tibble")
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
