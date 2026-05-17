
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
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |NICKNAME          |character |Team or athlete nickname.                                                    |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |FGM               |character |Field goals made.                                                            |
#'    |FGA               |character |Field goal attempts.                                                         |
#'    |FG_PCT            |character |Field goal percentage (0-1).                                                 |
#'    |FG3M              |character |Three-point field goals made.                                                |
#'    |FG3A              |character |Three-point field goal attempts.                                             |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).                                     |
#'    |FTM               |character |Free throws made.                                                            |
#'    |FTA               |character |Free throw attempts.                                                         |
#'    |FT_PCT            |character |Free throw percentage (0-1).                                                 |
#'    |OREB              |character |Offensive rebounds.                                                          |
#'    |DREB              |character |Defensive rebounds.                                                          |
#'    |REB               |character |Total rebounds.                                                              |
#'    |AST               |character |Assists.                                                                     |
#'    |STL               |character |Steals.                                                                      |
#'    |BLK               |character |Blocks.                                                                      |
#'    |TO                |character |To.                                                                          |
#'    |PF                |character |Personal fouls.                                                              |
#'    |PTS               |character |Points scored.                                                               |
#'    |PLUS_MINUS        |character |Plus/minus point differential while on court.                                |
#'
#'    **TeamStats**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN               |character |Minutes played.                                 |
#'    |FGM               |character |Field goals made.                               |
#'    |FGA               |character |Field goal attempts.                            |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'    |FG3M              |character |Three-point field goals made.                   |
#'    |FG3A              |character |Three-point field goal attempts.                |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).        |
#'    |FTM               |character |Free throws made.                               |
#'    |FTA               |character |Free throw attempts.                            |
#'    |FT_PCT            |character |Free throw percentage (0-1).                    |
#'    |OREB              |character |Offensive rebounds.                             |
#'    |DREB              |character |Defensive rebounds.                             |
#'    |REB               |character |Total rebounds.                                 |
#'    |AST               |character |Assists.                                        |
#'    |STL               |character |Steals.                                         |
#'    |BLK               |character |Blocks.                                         |
#'    |TO                |character |To.                                             |
#'    |PF                |character |Personal fouls.                                 |
#'    |PTS               |character |Points scored.                                  |
#'    |PLUS_MINUS        |character |Plus/minus point differential while on court.   |
#'
#'    **TeamStarterBenchStats**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |STARTERS_BENCH    |character |                                                |
#'    |MIN               |character |Minutes played.                                 |
#'    |FGM               |character |Field goals made.                               |
#'    |FGA               |character |Field goal attempts.                            |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'    |FG3M              |character |Three-point field goals made.                   |
#'    |FG3A              |character |Three-point field goal attempts.                |
#'    |FG3_PCT           |character |Three-point field goal percentage (0-1).        |
#'    |FTM               |character |Free throws made.                               |
#'    |FTA               |character |Free throw attempts.                            |
#'    |FT_PCT            |character |Free throw percentage (0-1).                    |
#'    |OREB              |character |Offensive rebounds.                             |
#'    |DREB              |character |Defensive rebounds.                             |
#'    |REB               |character |Total rebounds.                                 |
#'    |AST               |character |Assists.                                        |
#'    |STL               |character |Steals.                                         |
#'    |BLK               |character |Blocks.                                         |
#'    |TO                |character |To.                                             |
#'    |PF                |character |Personal fouls.                                 |
#'    |PTS               |character |Points scored.                                  |
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

#' **Get NBA Stats API Boxscore Advanced V2**
#' @name nba_boxscoreadvancedv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Advanced V2**
#' @rdname nba_boxscoreadvancedv2
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
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |NICKNAME          |character |Team or athlete nickname.                                                    |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |E_OFF_RATING      |character |                                                                             |
#'    |OFF_RATING        |character |Offensive rating (points produced per 100 possessions).                      |
#'    |E_DEF_RATING      |character |                                                                             |
#'    |DEF_RATING        |character |Defensive rating (points allowed per 100 possessions).                       |
#'    |E_NET_RATING      |character |                                                                             |
#'    |NET_RATING        |character |Net rating (off rating - def rating).                                        |
#'    |AST_PCT           |character |Assist percentage (0-1).                                                     |
#'    |AST_TOV           |character |                                                                             |
#'    |AST_RATIO         |character |Assist ratio (assists per 100 possessions used).                             |
#'    |OREB_PCT          |character |Offensive rebound percentage (0-1).                                          |
#'    |DREB_PCT          |character |Defensive rebound percentage (0-1).                                          |
#'    |REB_PCT           |character |Total rebound percentage (0-1).                                              |
#'    |TM_TOV_PCT        |character |                                                                             |
#'    |EFG_PCT           |character |Effective field goal percentage (0-1).                                       |
#'    |TS_PCT            |character |True shooting percentage (0-1).                                              |
#'    |USG_PCT           |character |Usage percentage (0-1).                                                      |
#'    |E_USG_PCT         |character |                                                                             |
#'    |E_PACE            |character |                                                                             |
#'    |PACE              |character |Possessions per 48 minutes.                                                  |
#'    |PACE_PER40        |character |Pace per40.                                                                  |
#'    |POSS              |character |Poss.                                                                        |
#'    |PIE               |character |Player Impact Estimate (0-1).                                                |
#'
#'    TeamStats
#'
#'    |col_name          |types     |description                                             |
#'    |:-----------------|:---------|:-------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                 |
#'    |TEAM_ID           |character |Unique team identifier.                                 |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces').         |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                   |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                 |
#'    |MIN               |character |Minutes played.                                         |
#'    |E_OFF_RATING      |character |                                                        |
#'    |OFF_RATING        |character |Offensive rating (points produced per 100 possessions). |
#'    |E_DEF_RATING      |character |                                                        |
#'    |DEF_RATING        |character |Defensive rating (points allowed per 100 possessions).  |
#'    |E_NET_RATING      |character |                                                        |
#'    |NET_RATING        |character |Net rating (off rating - def rating).                   |
#'    |AST_PCT           |character |Assist percentage (0-1).                                |
#'    |AST_TOV           |character |                                                        |
#'    |AST_RATIO         |character |Assist ratio (assists per 100 possessions used).        |
#'    |OREB_PCT          |character |Offensive rebound percentage (0-1).                     |
#'    |DREB_PCT          |character |Defensive rebound percentage (0-1).                     |
#'    |REB_PCT           |character |Total rebound percentage (0-1).                         |
#'    |E_TM_TOV_PCT      |character |                                                        |
#'    |TM_TOV_PCT        |character |                                                        |
#'    |EFG_PCT           |character |Effective field goal percentage (0-1).                  |
#'    |TS_PCT            |character |True shooting percentage (0-1).                         |
#'    |USG_PCT           |character |Usage percentage (0-1).                                 |
#'    |E_USG_PCT         |character |                                                        |
#'    |E_PACE            |character |                                                        |
#'    |PACE              |character |Possessions per 48 minutes.                             |
#'    |PACE_PER40        |character |Pace per40.                                             |
#'    |POSS              |character |Poss.                                                   |
#'    |PIE               |character |Player Impact Estimate (0-1).                           |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @details
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
#' @name nba_boxscoredefensive
NULL
#' @title
#' **Get NBA Stats API Boxscore Defensive**
#' @rdname nba_boxscoredefensive
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

#' **Get NBA Stats API Boxscore Four Factors V2**
#' @name nba_boxscorefourfactorsv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Four Factors V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorefourfactorsv3()` instead.
#' @rdname nba_boxscorefourfactorsv2
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
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |NICKNAME          |character |Team or athlete nickname.                                                    |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |EFG_PCT           |character |Effective field goal percentage (0-1).                                       |
#'    |FTA_RATE          |character |Free throw attempt rate (FTA / FGA).                                         |
#'    |TM_TOV_PCT        |character |                                                                             |
#'    |OREB_PCT          |character |Offensive rebound percentage (0-1).                                          |
#'    |OPP_EFG_PCT       |character |                                                                             |
#'    |OPP_FTA_RATE      |character |                                                                             |
#'    |OPP_TOV_PCT       |character |                                                                             |
#'    |OPP_OREB_PCT      |character |                                                                             |
#'
#'    **sqlTeamsFourFactors**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN               |character |Minutes played.                                 |
#'    |EFG_PCT           |character |Effective field goal percentage (0-1).          |
#'    |FTA_RATE          |character |Free throw attempt rate (FTA / FGA).            |
#'    |TM_TOV_PCT        |character |                                                |
#'    |OREB_PCT          |character |Offensive rebound percentage (0-1).             |
#'    |OPP_EFG_PCT       |character |                                                |
#'    |OPP_FTA_RATE      |character |                                                |
#'    |OPP_TOV_PCT       |character |                                                |
#'    |OPP_OREB_PCT      |character |                                                |
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

#' **Get NBA Stats API Boxscore Misc V2**
#' @name nba_boxscoremiscv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Misc V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoremiscv3()` instead.
#' @rdname nba_boxscoremiscv2
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
#'    |col_name           |types     |description                                                                  |
#'    |:------------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID            |character |Unique game identifier.                                                      |
#'    |TEAM_ID            |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION  |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY          |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID          |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME        |character |Player name.                                                                 |
#'    |NICKNAME           |character |Team or athlete nickname.                                                    |
#'    |START_POSITION     |character |                                                                             |
#'    |COMMENT            |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN                |character |Minutes played.                                                              |
#'    |PTS_OFF_TOV        |character |Points scored off opponent turnovers.                                        |
#'    |PTS_2ND_CHANCE     |character |                                                                             |
#'    |PTS_FB             |character |                                                                             |
#'    |PTS_PAINT          |character |Points scored in the paint.                                                  |
#'    |OPP_PTS_OFF_TOV    |character |                                                                             |
#'    |OPP_PTS_2ND_CHANCE |character |                                                                             |
#'    |OPP_PTS_FB         |character |                                                                             |
#'    |OPP_PTS_PAINT      |character |                                                                             |
#'    |BLK                |character |Blocks.                                                                      |
#'    |BLKA               |character |                                                                             |
#'    |PF                 |character |Personal fouls.                                                              |
#'    |PFD                |character |                                                                             |
#'
#'    **sqlTeamsMisc**
#'
#'
#'    |col_name           |types     |description                                     |
#'    |:------------------|:---------|:-----------------------------------------------|
#'    |GAME_ID            |character |Unique game identifier.                         |
#'    |TEAM_ID            |character |Unique team identifier.                         |
#'    |TEAM_NAME          |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION  |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY          |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN                |character |Minutes played.                                 |
#'    |PTS_OFF_TOV        |character |Points scored off opponent turnovers.           |
#'    |PTS_2ND_CHANCE     |character |                                                |
#'    |PTS_FB             |character |                                                |
#'    |PTS_PAINT          |character |Points scored in the paint.                     |
#'    |OPP_PTS_OFF_TOV    |character |                                                |
#'    |OPP_PTS_2ND_CHANCE |character |                                                |
#'    |OPP_PTS_FB         |character |                                                |
#'    |OPP_PTS_PAINT      |character |                                                |
#'    |BLK                |character |Blocks.                                         |
#'    |BLKA               |character |                                                |
#'    |PF                 |character |Personal fouls.                                 |
#'    |PFD                |character |                                                |
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

#' **Get NBA Stats API Boxscore Scoring V2**
#' @name nba_boxscorescoringv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Scoring V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscorescoringv3()` instead.
#' @rdname nba_boxscorescoringv2
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
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |NICKNAME          |character |Team or athlete nickname.                                                    |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |PCT_FGA_2PT       |character |                                                                             |
#'    |PCT_FGA_3PT       |character |                                                                             |
#'    |PCT_PTS_2PT       |character |                                                                             |
#'    |PCT_PTS_2PT_MR    |character |                                                                             |
#'    |PCT_PTS_3PT       |character |                                                                             |
#'    |PCT_PTS_FB        |character |                                                                             |
#'    |PCT_PTS_FT        |character |                                                                             |
#'    |PCT_PTS_OFF_TOV   |character |                                                                             |
#'    |PCT_PTS_PAINT     |character |                                                                             |
#'    |PCT_AST_2PM       |character |                                                                             |
#'    |PCT_UAST_2PM      |character |                                                                             |
#'    |PCT_AST_3PM       |character |                                                                             |
#'    |PCT_UAST_3PM      |character |                                                                             |
#'    |PCT_AST_FGM       |character |                                                                             |
#'    |PCT_UAST_FGM      |character |                                                                             |
#'
#'    **sqlTeamsScoring**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN               |character |Minutes played.                                 |
#'    |PCT_FGA_2PT       |character |                                                |
#'    |PCT_FGA_3PT       |character |                                                |
#'    |PCT_PTS_2PT       |character |                                                |
#'    |PCT_PTS_2PT_MR    |character |                                                |
#'    |PCT_PTS_3PT       |character |                                                |
#'    |PCT_PTS_FB        |character |                                                |
#'    |PCT_PTS_FT        |character |                                                |
#'    |PCT_PTS_OFF_TOV   |character |                                                |
#'    |PCT_PTS_PAINT     |character |                                                |
#'    |PCT_AST_2PM       |character |                                                |
#'    |PCT_UAST_2PM      |character |                                                |
#'    |PCT_AST_3PM       |character |                                                |
#'    |PCT_UAST_3PM      |character |                                                |
#'    |PCT_AST_FGM       |character |                                                |
#'    |PCT_UAST_FGM      |character |                                                |
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

#' **Get NBA Stats API Boxscore Usage V2**
#' @name nba_boxscoreusagev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Usage V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreusagev3()` instead.
#' @rdname nba_boxscoreusagev2
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
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |NICKNAME          |character |Team or athlete nickname.                                                    |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |USG_PCT           |character |Usage percentage (0-1).                                                      |
#'    |PCT_FGM           |character |                                                                             |
#'    |PCT_FGA           |character |                                                                             |
#'    |PCT_FG3M          |character |                                                                             |
#'    |PCT_FG3A          |character |                                                                             |
#'    |PCT_FTM           |character |                                                                             |
#'    |PCT_FTA           |character |                                                                             |
#'    |PCT_OREB          |character |                                                                             |
#'    |PCT_DREB          |character |                                                                             |
#'    |PCT_REB           |character |                                                                             |
#'    |PCT_AST           |character |                                                                             |
#'    |PCT_TOV           |character |                                                                             |
#'    |PCT_STL           |character |                                                                             |
#'    |PCT_BLK           |character |                                                                             |
#'    |PCT_BLKA          |character |                                                                             |
#'    |PCT_PF            |character |                                                                             |
#'    |PCT_PFD           |character |                                                                             |
#'    |PCT_PTS           |character |                                                                             |
#'
#'    **sqlTeamsUsage**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN               |character |Minutes played.                                 |
#'    |USG_PCT           |character |Usage percentage (0-1).                         |
#'    |PCT_FGM           |character |                                                |
#'    |PCT_FGA           |character |                                                |
#'    |PCT_FG3M          |character |                                                |
#'    |PCT_FG3A          |character |                                                |
#'    |PCT_FTM           |character |                                                |
#'    |PCT_FTA           |character |                                                |
#'    |PCT_OREB          |character |                                                |
#'    |PCT_DREB          |character |                                                |
#'    |PCT_REB           |character |                                                |
#'    |PCT_AST           |character |                                                |
#'    |PCT_TOV           |character |                                                |
#'    |PCT_STL           |character |                                                |
#'    |PCT_BLK           |character |                                                |
#'    |PCT_BLKA          |character |                                                |
#'    |PCT_PF            |character |                                                |
#'    |PCT_PFD           |character |                                                |
#'    |PCT_PTS           |character |                                                |
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

#' **Get NBA Stats API Boxscore Summary V2**
#' @name nba_boxscoresummaryv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V2**
#' @rdname nba_boxscoresummaryv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: AvailableVideo, GameInfo, GameSummary,
#'  InactivePlayers, LastMeeting, LineScore, Officials, OtherStats, SeasonSeries
#'
#'    **GameSummary**
#'
#'
#'    |col_name                         |types     |description                                            |
#'    |:--------------------------------|:---------|:------------------------------------------------------|
#'    |GAME_DATE_EST                    |character |Game date est.                                         |
#'    |GAME_SEQUENCE                    |character |Game sequence.                                         |
#'    |GAME_ID                          |character |Unique game identifier.                                |
#'    |GAME_STATUS_ID                   |character |Numeric game status identifier.                        |
#'    |GAME_STATUS_TEXT                 |character |Game status display text (e.g. 'Final', '4:32 - 4th'). |
#'    |GAMECODE                         |character |                                                       |
#'    |HOME_TEAM_ID                     |character |Unique identifier for the home team.                   |
#'    |VISITOR_TEAM_ID                  |character |                                                       |
#'    |SEASON                           |character |Season identifier (4-digit year or 'YYYY-YY' string).  |
#'    |LIVE_PERIOD                      |character |                                                       |
#'    |LIVE_PC_TIME                     |character |                                                       |
#'    |NATL_TV_BROADCASTER_ABBREVIATION |character |                                                       |
#'    |LIVE_PERIOD_TIME_BCAST           |character |                                                       |
#'    |WH_STATUS                        |character |Wh status.                                             |
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
#'    |col_name                         |types     |description             |
#'    |:--------------------------------|:---------|:-----------------------|
#'    |GAME_ID                          |character |Unique game identifier. |
#'    |LAST_GAME_ID                     |character |                        |
#'    |LAST_GAME_DATE_EST               |character |                        |
#'    |LAST_GAME_HOME_TEAM_ID           |character |                        |
#'    |LAST_GAME_HOME_TEAM_CITY         |character |                        |
#'    |LAST_GAME_HOME_TEAM_NAME         |character |                        |
#'    |LAST_GAME_HOME_TEAM_ABBREVIATION |character |                        |
#'    |LAST_GAME_HOME_TEAM_POINTS       |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_ID        |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_CITY      |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_NAME      |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_CITY1     |character |                        |
#'    |LAST_GAME_VISITOR_TEAM_POINTS    |character |                        |
#'
#'    **SeasonSeries**
#'
#'
#'    |col_name         |types     |description                          |
#'    |:----------------|:---------|:------------------------------------|
#'    |GAME_ID          |character |Unique game identifier.              |
#'    |HOME_TEAM_ID     |character |Unique identifier for the home team. |
#'    |VISITOR_TEAM_ID  |character |                                     |
#'    |GAME_DATE_EST    |character |Game date est.                       |
#'    |HOME_TEAM_WINS   |character |Home team's team wins.               |
#'    |HOME_TEAM_LOSSES |character |Home team's team losses.             |
#'    |SERIES_LEADER    |character |                                     |
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

#' **Get NBA Stats API Boxscore Matchups**
#' @name nba_boxscorematchups
NULL
#' @title
#' **Get NBA Stats API Boxscore Matchups**
#' @rdname nba_boxscorematchups
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

#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @name nba_boxscoreplayertrackv2
NULL
#' @title
#' **Get NBA Stats API Boxscore Player Tracking V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_boxscoreplayertrackv3()` instead.
#' @rdname nba_boxscoreplayertrackv2
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: PlayerStats, TeamStats
#'
#'    **PlayerStats**
#'
#'
#'    |col_name          |types     |description                                                                  |
#'    |:-----------------|:---------|:----------------------------------------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                                                      |
#'    |TEAM_ID           |character |Unique team identifier.                                                      |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').                                        |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').                                      |
#'    |PLAYER_ID         |character |Unique player identifier.                                                    |
#'    |PLAYER_NAME       |character |Player name.                                                                 |
#'    |START_POSITION    |character |                                                                             |
#'    |COMMENT           |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive'). |
#'    |MIN               |character |Minutes played.                                                              |
#'    |SPD               |character |                                                                             |
#'    |DIST              |character |                                                                             |
#'    |ORBC              |character |                                                                             |
#'    |DRBC              |character |                                                                             |
#'    |RBC               |character |                                                                             |
#'    |TCHS              |character |                                                                             |
#'    |SAST              |character |                                                                             |
#'    |FTAST             |character |                                                                             |
#'    |PASS              |character |                                                                             |
#'    |AST               |character |Assists.                                                                     |
#'    |CFGM              |character |                                                                             |
#'    |CFGA              |character |                                                                             |
#'    |CFG_PCT           |character |                                                                             |
#'    |UFGM              |character |                                                                             |
#'    |UFGA              |character |                                                                             |
#'    |UFG_PCT           |character |                                                                             |
#'    |FG_PCT            |character |Field goal percentage (0-1).                                                 |
#'    |DFGM              |character |                                                                             |
#'    |DFGA              |character |                                                                             |
#'    |DFG_PCT           |character |                                                                             |
#'
#'    **TeamStats**
#'
#'
#'    |col_name          |types     |description                                     |
#'    |:-----------------|:---------|:-----------------------------------------------|
#'    |GAME_ID           |character |Unique game identifier.                         |
#'    |TEAM_ID           |character |Unique team identifier.                         |
#'    |TEAM_NAME         |character |Full team display name (e.g. 'Las Vegas Aces'). |
#'    |TEAM_ABBREVIATION |character |Short team abbreviation (e.g. 'LAS').           |
#'    |TEAM_CITY         |character |Team city or region (e.g. 'Las Vegas').         |
#'    |MIN               |character |Minutes played.                                 |
#'    |DIST              |character |                                                |
#'    |ORBC              |character |                                                |
#'    |DRBC              |character |                                                |
#'    |RBC               |character |                                                |
#'    |TCHS              |character |                                                |
#'    |SAST              |character |                                                |
#'    |FTAST             |character |                                                |
#'    |PASS              |character |                                                |
#'    |AST               |character |Assists.                                        |
#'    |CFGM              |character |                                                |
#'    |CFGA              |character |                                                |
#'    |CFG_PCT           |character |                                                |
#'    |UFGM              |character |                                                |
#'    |UFGA              |character |                                                |
#'    |UFG_PCT           |character |                                                |
#'    |FG_PCT            |character |Field goal percentage (0-1).                    |
#'    |DFGM              |character |                                                |
#'    |DFGA              |character |                                                |
#'    |DFG_PCT           |character |                                                |
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
    with = "nba_boxscoreplayertrackv3()"
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

#' **Get NBA Stats API Hustle Stats Boxscore**
#' @name nba_hustlestatsboxscore
NULL
#' @title
#' **Get NBA Stats API Hustle Stats Boxscore**
#' @rdname nba_hustlestatsboxscore
#' @author Saiem Gilani
#' @param game_id Game ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: HustleStatsAvailable, PlayerStats, TeamStats
#'
#'    **HustleStatsAvailable**
#'
#'
#'    |col_name      |types     |description             |
#'    |:-------------|:---------|:-----------------------|
#'    |GAME_ID       |character |Unique game identifier. |
#'    |HUSTLE_STATUS |character |Hustle status.          |
#'
#'    **PlayerStats**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |GAME_ID                   |character |Unique game identifier.                                                          |
#'    |TEAM_ID                   |character |Unique team identifier.                                                          |
#'    |TEAM_ABBREVIATION         |character |Short team abbreviation (e.g. 'LAS').                                            |
#'    |TEAM_CITY                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |PLAYER_ID                 |character |Unique player identifier.                                                        |
#'    |PLAYER_NAME               |character |Player name.                                                                     |
#'    |START_POSITION            |character |                                                                                 |
#'    |COMMENT                   |character |Player status / inactive reason (e.g. 'DNP - Coach's Decision', 'Inactive').     |
#'    |MINUTES                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |PTS                       |character |Points scored.                                                                   |
#'    |CONTESTED_SHOTS           |character |Defensively contested shots.                                                     |
#'    |CONTESTED_SHOTS_2PT       |character |Contested two-point shots.                                                       |
#'    |CONTESTED_SHOTS_3PT       |character |Contested three-point shots.                                                     |
#'    |DEFLECTIONS               |character |Defensive deflections.                                                           |
#'    |CHARGES_DRAWN             |character |Charges drawn.                                                                   |
#'    |SCREEN_ASSISTS            |character |Screen assists (resulting in a basket).                                          |
#'    |SCREEN_AST_PTS            |character |                                                                                 |
#'    |OFF_LOOSE_BALLS_RECOVERED |character |                                                                                 |
#'    |DEF_LOOSE_BALLS_RECOVERED |character |                                                                                 |
#'    |LOOSE_BALLS_RECOVERED     |character |Loose balls recovered.                                                           |
#'    |OFF_BOXOUTS               |character |                                                                                 |
#'    |DEF_BOXOUTS               |character |                                                                                 |
#'    |BOX_OUT_PLAYER_TEAM_REBS  |character |                                                                                 |
#'    |BOX_OUT_PLAYER_REBS       |character |                                                                                 |
#'    |BOX_OUTS                  |character |Box-outs executed.                                                               |
#'
#'    **TeamStats**
#'
#'
#'    |col_name                  |types     |description                                                                      |
#'    |:-------------------------|:---------|:--------------------------------------------------------------------------------|
#'    |GAME_ID                   |character |Unique game identifier.                                                          |
#'    |TEAM_ID                   |character |Unique team identifier.                                                          |
#'    |TEAM_NAME                 |character |Full team display name (e.g. 'Las Vegas Aces').                                  |
#'    |TEAM_ABBREVIATION         |character |Short team abbreviation (e.g. 'LAS').                                            |
#'    |TEAM_CITY                 |character |Team city or region (e.g. 'Las Vegas').                                          |
#'    |MINUTES                   |character |Minutes played, formatted MM:SS (V3 PT-duration parsed) or decimal minutes (V2). |
#'    |PTS                       |character |Points scored.                                                                   |
#'    |CONTESTED_SHOTS           |character |Defensively contested shots.                                                     |
#'    |CONTESTED_SHOTS_2PT       |character |Contested two-point shots.                                                       |
#'    |CONTESTED_SHOTS_3PT       |character |Contested three-point shots.                                                     |
#'    |DEFLECTIONS               |character |Defensive deflections.                                                           |
#'    |CHARGES_DRAWN             |character |Charges drawn.                                                                   |
#'    |SCREEN_ASSISTS            |character |Screen assists (resulting in a basket).                                          |
#'    |SCREEN_AST_PTS            |character |                                                                                 |
#'    |OFF_LOOSE_BALLS_RECOVERED |character |                                                                                 |
#'    |DEF_LOOSE_BALLS_RECOVERED |character |                                                                                 |
#'    |LOOSE_BALLS_RECOVERED     |character |Loose balls recovered.                                                           |
#'    |OFF_BOXOUTS               |character |                                                                                 |
#'    |DEF_BOXOUTS               |character |                                                                                 |
#'    |BOX_OUT_PLAYER_TEAM_REBS  |character |                                                                                 |
#'    |BOX_OUT_PLAYER_REBS       |character |                                                                                 |
#'    |BOX_OUTS                  |character |Box-outs executed.                                                               |
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
#' @name nba_boxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API Boxscore Similarity Score**
#' @rdname nba_boxscoresimilarityscore
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
#' @name nba_glalumboxscoresimilarityscore
NULL
#' @title
#' **Get NBA Stats API G-League Alum Boxscore Similarity Score**
#' @rdname nba_glalumboxscoresimilarityscore
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
