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
#' @eval .returns_rd("nba_commonallplayers", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' All Players (www.nba.com/players)
#' ```r
#'   nba_commonallplayers(league_id = '00', season = year_to_season(most_recent_nba_season() - 2))
#' ```
nba_commonallplayers <- function(
    is_only_current_season = 0,
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 2),
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
#' @rdname nba_commonallplayers
#' @name nba_commonplayerinfo
NULL
#' @title
#' **Get NBA Stats API Player Info**
#' @rdname nba_commonallplayers
#' @author Saiem Gilani
#' @param player_id player_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_commonplayerinfo", class = "tibble")
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
#' @rdname nba_commonallplayers
#' @name nba_commonplayoffseries
NULL
#' @title
#' **Get NBA Stats API Playoff Series**
#' @rdname nba_commonallplayers
#' @author Saiem Gilani
#' @param season season
#' @param series_id series_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_commonplayoffseries", class = "tibble")
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
#' @rdname nba_commonallplayers
#' @name nba_commonteamroster
NULL
#' @title
#' **Get NBA Stats API Team Roster**
#' @rdname nba_commonallplayers
#' @author Saiem Gilani
#' @param season season
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_commonteamroster", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Roster Functions
#' @details
#' [Team Roster](https://www.nba.com/stats/team/1610612756)
#' ```r
#'  nba_commonteamroster(season = year_to_season(most_recent_nba_season() - 2), team_id = '1610612739')
#' ```
nba_commonteamroster <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 2),
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
#' @rdname nba_commonallplayers
#' @name nba_commonteamyears
NULL
#' @title
#' **Get NBA Stats API Common Team Years**
#' @rdname nba_commonallplayers
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_commonteamyears", class = "tibble")
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
