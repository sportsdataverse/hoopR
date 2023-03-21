
#' **Get NBA Stats API Draft Board**
#' @name dboard
NULL
#' @title
#' **Get NBA Stats API Draft Board**
#' @rdname dboard
#' @author Saiem Gilani
#' @param league_id league_id
#' @param college college
#' @param overall_pick overall_pick
#' @param round_pick round_pick
#' @param round_num round_num
#' @param season season
#' @param team_id team_id
#' @param top_x top_x
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftBoard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftboard <- function(
    league_id = '00',
    college = '',
    overall_pick = '',
    round_pick = '',
    round_num = '',
    season = '2019',
    team_id = '',
    top_x = '',
    ...){


  version <- "draftboard"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&LeagueID=",league_id,
                     "&OverallPick=", overall_pick,
                     "&RoundNum=", round_num,
                     "&RoundPick=", round_pick,
                     "&Season=", season,
                     "&TeamID=", team_id,
                     "&TopX=", top_x)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft board data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Stats**
#' @name dcombine_stats
NULL
#' @title
#' **Get NBA Stats API Draft Combine Stats**
#' @rdname dcombine_stats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftCombineStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftcombinestats <- function(
    league_id = '00',
    season_year = '2020',
    ...){


  version <- "draftcombinestats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&SeasonYear=",season_year)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine stats data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Drill Results**
#' @name dcombine_drill
NULL
#' @title
#' **Get NBA Stats API Draft Combine Drill Results**
#' @rdname dcombine_drill
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftcombinedrillresults <- function(
    league_id = '00',
    season_year = '2020',
    ...){


  version <- "draftcombinedrillresults"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&SeasonYear=",season_year)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine drill results data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @name dcombine_nsshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @rdname dcombine_nsshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftcombinenonstationaryshooting <- function(
    league_id = '00',
    season_year = '2020',
    ...){


  version <- "draftcombinenonstationaryshooting"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&SeasonYear=",season_year)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine stationary shooting data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @name dcombine_anthro
NULL
#' @title
#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @rdname dcombine_anthro
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftcombineplayeranthro <- function(
    league_id = '00',
    season_year = '2020',
    ...){


  version <- "draftcombineplayeranthro"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&SeasonYear=",season_year)
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine player anthropological data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @name dcombine_sshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @rdname dcombine_sshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_draftcombinespotshooting <- function(
    league_id = '00',
    season_year = '2020',
    ...){


  version <- "draftcombinespotshooting"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=",league_id,
                     "&SeasonYear=",season_year)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft combine spot shooting data available for {season_year}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Draft History**
#' @rdname dhistory
#' @author Saiem Gilani
#' @param league_id league_id
#' @param college college
#' @param overall_pick overall_pick
#' @param round_pick round_pick
#' @param round_num round_num
#' @param season season
#' @param team_id team_id
#' @param top_x top_x
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftHistory
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_drafthistory <- function(
    league_id = '00',
    college = '',
    overall_pick = '',
    round_pick = '',
    round_num = '',
    season = '2019',
    team_id = '',
    top_x = '',
    ...){


  version <- "drafthistory"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&LeagueID=",league_id,
                     "&OverallPick=", overall_pick,
                     "&RoundNum=", round_num,
                     "&RoundPick=", round_pick,
                     "&Season=", season,
                     "&TeamID=", team_id,
                     "&TopX=", top_x)

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no draft history data available for {season}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
