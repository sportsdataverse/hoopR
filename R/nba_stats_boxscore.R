
#' **Get NBA Stats API Boxscore Traditional V2**
#' @name nba_boxscoretraditionalv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return A list of data frames: PlayerStats, TeamStats, TeamStarterBenchStats
#'
#'    **PlayerStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
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
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TO \tab character \tab To. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
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
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TO \tab character \tab To. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       PLUS_MINUS \tab character \tab Plus/minus point differential while on court. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamStarterBenchStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       STARTERS_BENCH \tab character \tab  \cr
#'       MIN \tab character \tab Minutes played. \cr
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
#'       STL \tab character \tab Steals. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       TO \tab character \tab To. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PTS \tab character \tab Points scored. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscoretraditionalv2(game_id = "0022200021")
#' ```
nba_boxscoretraditionalv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoretraditionalv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no traditional boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Advanced V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerStats, TeamStats
#'
#'    PlayerStats
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       E_OFF_RATING \tab character \tab  \cr
#'       OFF_RATING \tab character \tab Offensive rating (points produced per 100 possessions). \cr
#'       E_DEF_RATING \tab character \tab  \cr
#'       DEF_RATING \tab character \tab Defensive rating (points allowed per 100 possessions). \cr
#'       E_NET_RATING \tab character \tab  \cr
#'       NET_RATING \tab character \tab Net rating (off rating - def rating). \cr
#'       AST_PCT \tab character \tab Assist percentage (0-1). \cr
#'       AST_TOV \tab character \tab  \cr
#'       AST_RATIO \tab character \tab Assist ratio (assists per 100 possessions used). \cr
#'       OREB_PCT \tab character \tab Offensive rebound percentage (0-1). \cr
#'       DREB_PCT \tab character \tab Defensive rebound percentage (0-1). \cr
#'       REB_PCT \tab character \tab Total rebound percentage (0-1). \cr
#'       TM_TOV_PCT \tab character \tab  \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       TS_PCT \tab character \tab True shooting percentage (0-1). \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'       E_USG_PCT \tab character \tab  \cr
#'       E_PACE \tab character \tab  \cr
#'       PACE \tab character \tab Possessions per 48 minutes. \cr
#'       PACE_PER40 \tab character \tab Pace per40. \cr
#'       POSS \tab character \tab Poss. \cr
#'       PIE \tab character \tab Player Impact Estimate (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    TeamStats
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       E_OFF_RATING \tab character \tab  \cr
#'       OFF_RATING \tab character \tab Offensive rating (points produced per 100 possessions). \cr
#'       E_DEF_RATING \tab character \tab  \cr
#'       DEF_RATING \tab character \tab Defensive rating (points allowed per 100 possessions). \cr
#'       E_NET_RATING \tab character \tab  \cr
#'       NET_RATING \tab character \tab Net rating (off rating - def rating). \cr
#'       AST_PCT \tab character \tab Assist percentage (0-1). \cr
#'       AST_TOV \tab character \tab  \cr
#'       AST_RATIO \tab character \tab Assist ratio (assists per 100 possessions used). \cr
#'       OREB_PCT \tab character \tab Offensive rebound percentage (0-1). \cr
#'       DREB_PCT \tab character \tab Defensive rebound percentage (0-1). \cr
#'       REB_PCT \tab character \tab Total rebound percentage (0-1). \cr
#'       E_TM_TOV_PCT \tab character \tab  \cr
#'       TM_TOV_PCT \tab character \tab  \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       TS_PCT \tab character \tab True shooting percentage (0-1). \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'       E_USG_PCT \tab character \tab  \cr
#'       E_PACE \tab character \tab  \cr
#'       PACE \tab character \tab Possessions per 48 minutes. \cr
#'       PACE_PER40 \tab character \tab Pace per40. \cr
#'       POSS \tab character \tab Poss. \cr
#'       PIE \tab character \tab Player Impact Estimate (0-1). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' League-scoped: as of a 2026-08-24 residential-IP probe sweep this V2
#' endpoint returns HTTP 200 with zero rows for NBA (LeagueID '00') game IDs
#' -- use [nba_boxscoreadvancedv3()] for NBA instead. It still serves real
#' rows for WNBA (LeagueID '10') and G-League (LeagueID '20') game IDs, so
#' the wrapper stays exported/active rather than deprecated.
#' ```r
#'  nba_boxscoreadvancedv2(game_id = "0022200021")
#' ```
nba_boxscoreadvancedv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoreadvancedv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no advanced boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Defensive**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_boxscoredefensive
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerDefensiveStats, Table1
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_boxscoredefensive(game_id = "0022200021")
#' ```
nba_boxscoredefensive <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoredefensive"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defensive boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Four Factors V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorefourfactorsv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersFourFactors, sqlTeamFourFactors
#'
#'    **sqlPlayersFourFactors**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       FTA_RATE \tab character \tab Free throw attempt rate (FTA / FGA). \cr
#'       TM_TOV_PCT \tab character \tab  \cr
#'       OREB_PCT \tab character \tab Offensive rebound percentage (0-1). \cr
#'       OPP_EFG_PCT \tab character \tab  \cr
#'       OPP_FTA_RATE \tab character \tab  \cr
#'       OPP_TOV_PCT \tab character \tab  \cr
#'       OPP_OREB_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **sqlTeamsFourFactors**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       EFG_PCT \tab character \tab Effective field goal percentage (0-1). \cr
#'       FTA_RATE \tab character \tab Free throw attempt rate (FTA / FGA). \cr
#'       TM_TOV_PCT \tab character \tab  \cr
#'       OREB_PCT \tab character \tab Offensive rebound percentage (0-1). \cr
#'       OPP_EFG_PCT \tab character \tab  \cr
#'       OPP_FTA_RATE \tab character \tab  \cr
#'       OPP_TOV_PCT \tab character \tab  \cr
#'       OPP_OREB_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscorefourfactorsv2(game_id = "0022200021")
#' ```
nba_boxscorefourfactorsv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorefourfactorsv2()",
    with = "nba_boxscorefourfactorsv3()"
  )

  version <- "boxscorefourfactorsv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no four factors boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Misc V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoremiscv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersMisc, sqlTeamsMisc
#'
#'    **sqlPlayersMisc**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       PTS_OFF_TOV \tab character \tab Points scored off opponent turnovers. \cr
#'       PTS_2ND_CHANCE \tab character \tab  \cr
#'       PTS_FB \tab character \tab  \cr
#'       PTS_PAINT \tab character \tab Points scored in the paint. \cr
#'       OPP_PTS_OFF_TOV \tab character \tab  \cr
#'       OPP_PTS_2ND_CHANCE \tab character \tab  \cr
#'       OPP_PTS_FB \tab character \tab  \cr
#'       OPP_PTS_PAINT \tab character \tab  \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **sqlTeamsMisc**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       PTS_OFF_TOV \tab character \tab Points scored off opponent turnovers. \cr
#'       PTS_2ND_CHANCE \tab character \tab  \cr
#'       PTS_FB \tab character \tab  \cr
#'       PTS_PAINT \tab character \tab Points scored in the paint. \cr
#'       OPP_PTS_OFF_TOV \tab character \tab  \cr
#'       OPP_PTS_2ND_CHANCE \tab character \tab  \cr
#'       OPP_PTS_FB \tab character \tab  \cr
#'       OPP_PTS_PAINT \tab character \tab  \cr
#'       BLK \tab character \tab Blocks. \cr
#'       BLKA \tab character \tab  \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       PFD \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscoremiscv2(game_id = "0022200021")
#' ```
nba_boxscoremiscv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoremiscv2()",
    with = "nba_boxscoremiscv3()"
  )

  version <- "boxscoremiscv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no miscellaneous boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Scoring V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorescoringv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersScoring, sqlTeamsScoring
#'
#'    **sqlPlayersScoring**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       PCT_FGA_2PT \tab character \tab  \cr
#'       PCT_FGA_3PT \tab character \tab  \cr
#'       PCT_PTS_2PT \tab character \tab  \cr
#'       PCT_PTS_2PT_MR \tab character \tab  \cr
#'       PCT_PTS_3PT \tab character \tab  \cr
#'       PCT_PTS_FB \tab character \tab  \cr
#'       PCT_PTS_FT \tab character \tab  \cr
#'       PCT_PTS_OFF_TOV \tab character \tab  \cr
#'       PCT_PTS_PAINT \tab character \tab  \cr
#'       PCT_AST_2PM \tab character \tab  \cr
#'       PCT_UAST_2PM \tab character \tab  \cr
#'       PCT_AST_3PM \tab character \tab  \cr
#'       PCT_UAST_3PM \tab character \tab  \cr
#'       PCT_AST_FGM \tab character \tab  \cr
#'       PCT_UAST_FGM \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **sqlTeamsScoring**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       PCT_FGA_2PT \tab character \tab  \cr
#'       PCT_FGA_3PT \tab character \tab  \cr
#'       PCT_PTS_2PT \tab character \tab  \cr
#'       PCT_PTS_2PT_MR \tab character \tab  \cr
#'       PCT_PTS_3PT \tab character \tab  \cr
#'       PCT_PTS_FB \tab character \tab  \cr
#'       PCT_PTS_FT \tab character \tab  \cr
#'       PCT_PTS_OFF_TOV \tab character \tab  \cr
#'       PCT_PTS_PAINT \tab character \tab  \cr
#'       PCT_AST_2PM \tab character \tab  \cr
#'       PCT_UAST_2PM \tab character \tab  \cr
#'       PCT_AST_3PM \tab character \tab  \cr
#'       PCT_UAST_3PM \tab character \tab  \cr
#'       PCT_AST_FGM \tab character \tab  \cr
#'       PCT_UAST_FGM \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscorescoringv2(game_id = "0022200021")
#' ```
nba_boxscorescoringv2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorescoringv2()",
    with = "nba_boxscorescoringv3()"
  )

  version <- "boxscorescoringv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoring boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Usage V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreusagev3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param start_period start_period
#' @param end_period end_period
#' @param start_range start_range
#' @param end_range end_range
#' @param range_type range_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: sqlPlayersUsage, sqlTeamsUsage
#'
#'    **sqlPlayersUsage**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'       PCT_FGM \tab character \tab  \cr
#'       PCT_FGA \tab character \tab  \cr
#'       PCT_FG3M \tab character \tab  \cr
#'       PCT_FG3A \tab character \tab  \cr
#'       PCT_FTM \tab character \tab  \cr
#'       PCT_FTA \tab character \tab  \cr
#'       PCT_OREB \tab character \tab  \cr
#'       PCT_DREB \tab character \tab  \cr
#'       PCT_REB \tab character \tab  \cr
#'       PCT_AST \tab character \tab  \cr
#'       PCT_TOV \tab character \tab  \cr
#'       PCT_STL \tab character \tab  \cr
#'       PCT_BLK \tab character \tab  \cr
#'       PCT_BLKA \tab character \tab  \cr
#'       PCT_PF \tab character \tab  \cr
#'       PCT_PFD \tab character \tab  \cr
#'       PCT_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **sqlTeamsUsage**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       USG_PCT \tab character \tab Usage percentage (0-1). \cr
#'       PCT_FGM \tab character \tab  \cr
#'       PCT_FGA \tab character \tab  \cr
#'       PCT_FG3M \tab character \tab  \cr
#'       PCT_FG3A \tab character \tab  \cr
#'       PCT_FTM \tab character \tab  \cr
#'       PCT_FTA \tab character \tab  \cr
#'       PCT_OREB \tab character \tab  \cr
#'       PCT_DREB \tab character \tab  \cr
#'       PCT_REB \tab character \tab  \cr
#'       PCT_AST \tab character \tab  \cr
#'       PCT_TOV \tab character \tab  \cr
#'       PCT_STL \tab character \tab  \cr
#'       PCT_BLK \tab character \tab  \cr
#'       PCT_BLKA \tab character \tab  \cr
#'       PCT_PF \tab character \tab  \cr
#'       PCT_PFD \tab character \tab  \cr
#'       PCT_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscoreusagev2(game_id = "0022200021")
#' ```
nba_boxscoreusagev2 <- function(
    game_id,
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoreusagev2()",
    with = "nba_boxscoreusagev3()"
  )

  version <- "boxscoreusagev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no usage boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Summary V2**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AvailableVideo, GameInfo, GameSummary,
#'  InactivePlayers, LastMeeting, LineScore, Officials, OtherStats, SeasonSeries
#'
#'    **GameSummary**
#'
#'
#'    Columns as documented in the shared [nba_boxscoresummaryv2_gamesummary_schema] table.
#'
#'    **OtherStats**
#'
#'
#'    |col_name          |types     |description                                                           |
#'    |:-----------------|:---------|:---------------------------------------------------------------------|
#'    |LEAGUE_ID         |character |League identifier ('10' = WNBA).                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                 |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                               |
#'    |PTS_PAINT         |character |Points scored in the paint.                                           |
#'    |PTS_2ND_CHANCE    |character |                                                                      |
#'    |PTS_FB            |character |                                                                      |
#'    |LARGEST_LEAD      |character |Largest lead during the game.                                         |
#'    |LEAD_CHANGES      |character |Lead changes.                                                         |
#'    |TIMES_TIED        |character |Times tied.                                                           |
#'    |TEAM_TURNOVERS    |character |Team turnovers (turnovers credited to the team rather than a player). |
#'    |TOTAL_TURNOVERS   |character |Total turnovers (player + team).                                      |
#'    |TEAM_REBOUNDS     |character |Team rebounds (rebounds credited to the team rather than a player).   |
#'    |PTS_OFF_TO        |character |                                                                      |
#'
#'    **Officials**
#'
#'
#'    |col_name    |types     |description                           |
#'    |:-----------|:---------|:-------------------------------------|
#'    |OFFICIAL_ID |character |Unique official / referee identifier. |
#'    |FIRST_NAME  |character |Player's first name.                  |
#'    |LAST_NAME   |character |Player's last name.                   |
#'    |JERSEY_NUM  |character |Jersey number worn by the player.     |
#'
#'    **InactivePlayers**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |PLAYER_ID         |character |Unique player identifier.                       |
#'    |FIRST_NAME        |character |Player's first name.                            |
#'    |LAST_NAME         |character |Player's last name.                             |
#'    |JERSEY_NUM        |character |Jersey number worn by the player.               |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'
#'    **GameInfo**
#'
#'
#'    |col_name   |types     |description             |
#'    |:----------|:---------|:-----------------------|
#'    |GAME_DATE  |character |Game date (YYYY-MM-DD). |
#'    |ATTENDANCE |character |Reported attendance.    |
#'    |GAME_TIME  |character |Game start time.        |
#'
#'    **LineScore**
#'
#'
#'    |col_name          |types     |description                           |
#'    |:-----------------|:---------|:-------------------------------------|
#'    |GAME_DATE_EST     |character |Game date est.                        |
#'    |GAME_SEQUENCE     |character |Game sequence.                        |
#'    |GAME_ID           |character |Unique game identifier.               |
#'    |TEAM_ID           |character |Unique team identifier.               |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS'). |
#'    |TEAM_CITY_NAME    |character |                                      |
#'    |TEAM_NICKNAME     |character |Team nickname.                        |
#'    |TEAM_WINS_LOSSES  |character |                                      |
#'    |PTS_QTR1          |character |                                      |
#'    |PTS_QTR2          |character |                                      |
#'    |PTS_QTR3          |character |                                      |
#'    |PTS_QTR4          |character |                                      |
#'    |PTS_OT1           |character |                                      |
#'    |PTS_OT2           |character |                                      |
#'    |PTS_OT3           |character |                                      |
#'    |PTS_OT4           |character |                                      |
#'    |PTS_OT5           |character |                                      |
#'    |PTS_OT6           |character |                                      |
#'    |PTS_OT7           |character |                                      |
#'    |PTS_OT8           |character |                                      |
#'    |PTS_OT9           |character |                                      |
#'    |PTS_OT10          |character |                                      |
#'    |PTS               |character |Points scored.                        |
#'
#'    **LastMeeting**
#'
#'
#'    Columns as documented in the shared [nba_boxscoresummaryv2_lastmeeting_schema] table.
#'
#'    **SeasonSeries**
#'
#'
#'    Columns as documented in the shared [nba_boxscoresummaryv2_seasonseries_schema] table.
#'
#'    **AvailableVideo**
#'
#'
#'    |col_name             |types     |description             |
#'    |:--------------------|:---------|:-----------------------|
#'    |GAME_ID              |character |Unique game identifier. |
#'    |VIDEO_AVAILABLE_FLAG |character |Video available flag.   |
#'    |PT_AVAILABLE         |character |Pt available.           |
#'    |PT_XYZ_AVAILABLE     |character |Pt xyz available.       |
#'    |WH_STATUS            |character |Wh status.              |
#'    |HUSTLE_STATUS        |character |Hustle status.          |
#'    |HISTORICAL_STATUS    |character |Historical status.      |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' ```r
#'  nba_boxscoresummaryv2(game_id = "0022200021")
#' ```
nba_boxscoresummaryv2 <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "boxscoresummaryv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no summary boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Matchups**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerMatchupsStats
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#'  nba_boxscorematchups(game_id = "0022200021")
#' ```
nba_boxscorematchups <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  endpoint <- nba_endpoint('boxscorematchups')
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no matchups boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreplayertrackv3()` instead.
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerStats, TeamStats
#'
#'    **PlayerStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       SPD \tab character \tab  \cr
#'       DIST \tab character \tab  \cr
#'       ORBC \tab character \tab  \cr
#'       DRBC \tab character \tab  \cr
#'       RBC \tab character \tab  \cr
#'       TCHS \tab character \tab  \cr
#'       SAST \tab character \tab  \cr
#'       FTAST \tab character \tab  \cr
#'       PASS \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       CFGM \tab character \tab  \cr
#'       CFGA \tab character \tab  \cr
#'       CFG_PCT \tab character \tab  \cr
#'       UFGM \tab character \tab  \cr
#'       UFGA \tab character \tab  \cr
#'       UFG_PCT \tab character \tab  \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       DFGM \tab character \tab  \cr
#'       DFGA \tab character \tab  \cr
#'       DFG_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MIN \tab character \tab Minutes played. \cr
#'       DIST \tab character \tab  \cr
#'       ORBC \tab character \tab  \cr
#'       DRBC \tab character \tab  \cr
#'       RBC \tab character \tab  \cr
#'       TCHS \tab character \tab  \cr
#'       SAST \tab character \tab  \cr
#'       FTAST \tab character \tab  \cr
#'       PASS \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       CFGM \tab character \tab  \cr
#'       CFGA \tab character \tab  \cr
#'       CFG_PCT \tab character \tab  \cr
#'       UFGM \tab character \tab  \cr
#'       UFGA \tab character \tab  \cr
#'       UFG_PCT \tab character \tab  \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       DFGM \tab character \tab  \cr
#'       DFGA \tab character \tab  \cr
#'       DFG_PCT \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Player Tracking Functions
#' @details
#' ```r
#'  nba_boxscoreplayertrackv2(game_id = "0022200021")
#' ```
nba_boxscoreplayertrackv2 <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscoreplayertrackv2()",
    with = "nba_boxscoreplayertrackv3()",
    details = "Live re-probe (2026-08-24, residential IP) across multiple game IDs returned an empty response body; confirmed defunct upstream."
  )

  version <- "boxscoreplayertrackv2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no  player tracking boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Hustle Stats Boxscore**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HustleStatsAvailable, PlayerStats, TeamStats
#'
#'    **HustleStatsAvailable**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       LEAGUE_ID \tab character \tab League identifier ('10' = WNBA). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PTS_PAINT \tab character \tab Points scored in the paint. \cr
#'       PTS_2ND_CHANCE \tab character \tab  \cr
#'       PTS_FB \tab character \tab  \cr
#'       LARGEST_LEAD \tab character \tab Largest lead during the game. \cr
#'       LEAD_CHANGES \tab character \tab Lead changes. \cr
#'       TIMES_TIED \tab character \tab Times tied. \cr
#'       TEAM_TURNOVERS \tab character \tab Team turnovers (turnovers credited to the team rather than a player). \cr
#'       TOTAL_TURNOVERS \tab character \tab Total turnovers (player + team). \cr
#'       TEAM_REBOUNDS \tab character \tab Team rebounds (rebounds credited to the team rather than a player). \cr
#'       PTS_OFF_TO \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **PlayerStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       PLAYER_ID \tab character \tab Unique player identifier. \cr
#'       PLAYER_NAME \tab character \tab Player name. \cr
#'       START_POSITION \tab character \tab  \cr
#'       COMMENT \tab character \tab Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). \cr
#'       MINUTES \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       PTS \tab character \tab Points scored. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'       CONTESTED_SHOTS_2PT \tab character \tab Contested two-point shots. \cr
#'       CONTESTED_SHOTS_3PT \tab character \tab Contested three-point shots. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'       SCREEN_AST_PTS \tab character \tab  \cr
#'       OFF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       DEF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'       OFF_BOXOUTS \tab character \tab  \cr
#'       DEF_BOXOUTS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_TEAM_REBS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_REBS \tab character \tab  \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TeamStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       TEAM_NAME \tab character \tab Full team display name (e.g. 'Las Vegas Aces'). \cr
#'       TEAM_ABBREVIATION \tab character \tab Short team abbreviation (e.g. 'LAS'). \cr
#'       TEAM_CITY \tab character \tab Team city or region (e.g. 'Las Vegas'). \cr
#'       MINUTES \tab character \tab Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). \cr
#'       PTS \tab character \tab Points scored. \cr
#'       CONTESTED_SHOTS \tab character \tab Defensively contested shots. \cr
#'       CONTESTED_SHOTS_2PT \tab character \tab Contested two-point shots. \cr
#'       CONTESTED_SHOTS_3PT \tab character \tab Contested three-point shots. \cr
#'       DEFLECTIONS \tab character \tab Defensive deflections. \cr
#'       CHARGES_DRAWN \tab character \tab Charges drawn. \cr
#'       SCREEN_ASSISTS \tab character \tab Screen assists (resulting in a basket). \cr
#'       SCREEN_AST_PTS \tab character \tab  \cr
#'       OFF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       DEF_LOOSE_BALLS_RECOVERED \tab character \tab  \cr
#'       LOOSE_BALLS_RECOVERED \tab character \tab Loose balls recovered. \cr
#'       OFF_BOXOUTS \tab character \tab  \cr
#'       DEF_BOXOUTS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_TEAM_REBS \tab character \tab  \cr
#'       BOX_OUT_PLAYER_REBS \tab character \tab  \cr
#'       BOX_OUTS \tab character \tab Box-outs executed. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Hustle Functions
#' @details
#' ```r
#'  nba_hustlestatsboxscore(game_id = "0022200021")
#' ```
nba_hustlestatsboxscore <- function(
    game_id,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "hustlestatsboxscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no hustle stats boxscore data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_boxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param person_1_id person_1_id
#' @param person_1_league_id person_1_league_id
#' @param person_1_season person_1_season
#' @param person_1_season_type person_1_season_type
#' @param person_2_id person_2_id
#' @param person_2_league_id person_2_league_id
#' @param person_2_season person_2_season
#' @param person_2_season_type person_2_season_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: BoxScoreSimilarityScores
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Similarity Functions
#' @details
#' (Possibly Deprecated)
#' ```r
#' z <- nba_commonallplayers()$CommonAllPlayers
#' klay <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Klay Thompson')
#' book <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == 'Devin Booker')
#' nba_boxscoresimilarityscore(person_1_id = klay$PERSON_ID,
#'   person_1_league_id = '00',
#'   person_1_season = year_to_season(most_recent_nba_season() - 1),
#'   person_1_season_type = 'Regular Season',
#'   person_2_id = book$PERSON_ID,
#'   person_2_league_id = '00',
#'   person_2_season = year_to_season(most_recent_nba_season() - 1),
#'   person_2_season_type = 'Regular Season'
#' )
#' ```
nba_boxscoresimilarityscore <- function(
    person_1_id = '202691',
    person_1_league_id = '00',
    person_1_season = most_recent_nba_season() - 3,
    person_1_season_type = 'Regular Season',
    person_2_id = '1626164',
    person_2_league_id = '00',
    person_2_season = most_recent_nba_season() - 3,
    person_2_season_type = 'Regular Season',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  person_1_season_type <- gsub(' ', '+', person_1_season_type)
  person_2_season_type <- gsub(' ', '+', person_2_season_type)
  version <- "boxscoresimilarityscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Person1Id = person_1_id,
    Person1LeagueId = person_1_league_id,
    Person1Season = person_1_season,
    Person1SeasonType = person_1_season_type,
    Person2Id = person_2_id,
    Person2LeagueId = person_2_league_id,
    Person2Season = person_2_season,
    Person2SeasonType = person_2_season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore similarity data for given parameters available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @name nba_glalumboxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname nba_boxscoretraditionalv2
#' @author Saiem Gilani
#' @param person_1_id person_1_id
#' @param person_1_league_id person_1_league_id
#' @param person_1_season person_1_season
#' @param person_1_season_type person_1_season_type
#' @param person_2_id person_2_id
#' @param person_2_league_id person_2_league_id
#' @param person_2_season person_2_season
#' @param person_2_season_type person_2_season_type
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: GLeagueAlumBoxScoreSimilarityScores
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Similarity Functions
#' @details
#' (Possibly Deprecated)
nba_glalumboxscoresimilarityscore <- function(
    person_1_id,
    person_1_league_id,
    person_1_season,
    person_1_season_type,
    person_2_id,
    person_2_league_id,
    person_2_season,
    person_2_season_type,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  person_1_season_type <- gsub(' ', '+', person_1_season_type)
  person_2_season_type <- gsub(' ', '+', person_2_season_type)
  version <- "glalumboxscoresimilarityscore"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    Person1Id = person_1_id,
    Person1LeagueId = person_1_league_id,
    Person1Season = person_1_season,
    Person1SeasonType = person_1_season_type,
    Person2Id = person_2_id,
    Person2LeagueId = person_2_league_id,
    Person2Season = person_2_season,
    Person2SeasonType = person_2_season_type
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no G-League alum boxscore similarity data for given parameters available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#
# nba_boxscore <- function(game_id, version = "boxscoretraditionalv2"){
#
#   if(version=="all"){
#     endpoint_list <- c("boxscoretraditionalv2","boxscoreadvancedv2",
#                        "boxscorescoringv2", "boxscoremiscv2",
#                        "boxscoreusagev2", "boxscorefourfactorsv2",
#                        "hustlestatsboxscore","boxscoreplayertrackv2",
#                        "winprobabilitypbp", "boxscoredefensive",
#                        "boxscorematchups")
#     endpoint <- nba_boxscore(game_id=game_id,version=endpoint_list[i])
#   } else {
#     endpoint <- nba_endpoint(version)
#   }
#
#   full_url <- paste0(endpoint,
#                      "?EndPeriod=0",
#                      "&EndRange=0",
#                      "&GameID=",pad_id(game_id),
#                      "&RangeType=0",
#                      "&StartPeriod=0",
#                      "&StartRange=0")
#   resp <- full_url %>%
#     .nba_headers()
#
#   data <-
#     resp$resultSets$rowSet[[1]] %>%
#     data.frame(stringsAsFactors = F) %>%
#     as_tibble()
#
#   json_names <-
#     resp$resultSets$headers[[1]]
#   colnames(data) <- json_names
#   return(data)
# }
