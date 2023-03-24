
#' **Get NBA Stats API Draft Board**
#' @name nba_draftboard
NULL
#' @title
#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftboard
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
#' @details
#' ```r
#'  nba_draftboard(season = most_recent_nba_season() - 1)
#' ```
nba_draftboard <- function(
    league_id = '00',
    college = '',
    overall_pick = '',
    round_pick = '',
    round_num = '',
    season = most_recent_nba_season() - 1,
    team_id = '',
    top_x = '',
    ...){

  version <- "draftboard"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    College = college,
    LeagueID = league_id,
    OverallPick = overall_pick,
    RoundNum = round_num,
    RoundPick = round_pick,
    Season = season,
    TeamID = team_id,
    TopX = top_x
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @name nba_draftcombinestats
NULL
#' @title
#' **Get NBA Stats API Draft Combine Stats**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: DraftCombineStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_draftcombinestats(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinestats <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinestats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @name nba_draftcombinedrillresults
NULL
#' @title
#' **Get NBA Stats API Draft Combine Drill Results**
#' @rdname nba_draftcombinedrillresults
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [Draft Combine](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombinedrillresults(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinedrillresults <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinedrillresults"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @name nba_draftcombinenonstationaryshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @rdname nba_draftcombinenonstationaryshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [Draft Combine Non-stationary Shooting](https://www.nba.com/stats/draft/combine-non-stationary)
#' ```r
#'  nba_draftcombinenonstationaryshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinenonstationaryshooting <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinenonstationaryshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @name nba_draftcombineplayeranthro
NULL
#' @title
#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @rdname nba_draftcombineplayeranthro
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [Draft Combine Player Anthro](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombineplayeranthro(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombineplayeranthro <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombineplayeranthro"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @name nba_draftcombinespotshooting
NULL
#' @title
#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @rdname nba_draftcombinespotshooting
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: Results
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' [Draft Combine Spot Shooting](https://www.nba.com/stats/draft/combine-spot-up)
#' ```r
#'  nba_draftcombinespotshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinespotshooting <- function(
    league_id = '00',
    season_year = most_recent_nba_season() - 1,
    ...){

  version <- "draftcombinespotshooting"
  endpoint <- nba_endpoint(version)

  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
#' @rdname nba_drafthistory
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
#' @details
#' [Draft History](https://www.nba.com/stats/draft/history)
#' ```r
#'  nba_drafthistory(season = most_recent_nba_season() - 1)
#' ```
nba_drafthistory <- function(
    league_id = '00',
    college = '',
    overall_pick = '',
    round_pick = '',
    round_num = '',
    season = most_recent_nba_season() - 1,
    team_id = '',
    top_x = '',
    ...){

  version <- "drafthistory"
  endpoint <- nba_endpoint(version)

  full_url <- endpoint

  params <- list(
    College = college,
    LeagueID = league_id,
    OverallPick = overall_pick,
    RoundNum = round_num,
    RoundPick = round_pick,
    Season = season,
    TeamID = team_id,
    TopX = top_x
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

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
