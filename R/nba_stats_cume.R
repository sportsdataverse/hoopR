#' **Get NBA Stats API Cumulative Player Stats**
#' @name nba_cumestatsplayer
NULL
#' @title
#' **Get NBA Stats API Cumulative Player Stats**
#' @rdname nba_cumestatsplayer
#' @author Saiem Gilani
#' @param game_ids game_ids
#' @param league_id league_id
#' @param player_id player_id
#' @param season season
#' @param season_type season_type
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: GameByGameStats, TotalPlayerStats
#'
#'    **GameByGameStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       DATE_EST \tab character \tab  \cr
#'       VISITOR_TEAM \tab character \tab  \cr
#'       HOME_TEAM \tab character \tab Home team's team. \cr
#'       GP \tab character \tab Games played. \cr
#'       GS \tab character \tab Games started. \cr
#'       ACTUAL_MINUTES \tab character \tab  \cr
#'       ACTUAL_SECONDS \tab character \tab  \cr
#'       FG \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3 \tab character \tab  \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FT \tab character \tab  \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OFF_REB \tab character \tab  \cr
#'       DEF_REB \tab character \tab  \cr
#'       TOT_REB \tab character \tab  \cr
#'       AVG_TOT_REB \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       DQ \tab character \tab  \cr
#'       STL \tab character \tab Steals. \cr
#'       TURNOVERS \tab character \tab Total turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       AVG_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TotalPlayerStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       DISPLAY_FI_LAST \tab character \tab  \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       JERSEY_NUM \tab character \tab Jersey number worn by the player. \cr
#'       GP \tab character \tab Games played. \cr
#'       GS \tab character \tab Games started. \cr
#'       ACTUAL_MINUTES \tab character \tab  \cr
#'       ACTUAL_SECONDS \tab character \tab  \cr
#'       FG \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3 \tab character \tab  \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FT \tab character \tab  \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OFF_REB \tab character \tab  \cr
#'       DEF_REB \tab character \tab  \cr
#'       TOT_REB \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       DQ \tab character \tab  \cr
#'       STL \tab character \tab Steals. \cr
#'       TURNOVERS \tab character \tab Total turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       MAX_ACTUAL_MINUTES \tab character \tab  \cr
#'       MAX_ACTUAL_SECONDS \tab character \tab  \cr
#'       MAX_REB \tab character \tab  \cr
#'       MAX_AST \tab character \tab  \cr
#'       MAX_STL \tab character \tab  \cr
#'       MAX_TURNOVERS \tab character \tab  \cr
#'       MAX_BLK \tab character \tab  \cr
#'       MAX_PTS \tab character \tab  \cr
#'       AVG_ACTUAL_MINUTES \tab character \tab  \cr
#'       AVG_ACTUAL_SECONDS \tab character \tab  \cr
#'       AVG_TOT_REB \tab character \tab  \cr
#'       AVG_AST \tab character \tab  \cr
#'       AVG_STL \tab character \tab  \cr
#'       AVG_TURNOVERS \tab character \tab The average turnovers committed per game. \cr
#'       AVG_BLK \tab character \tab  \cr
#'       AVG_PTS \tab character \tab  \cr
#'       PER_MIN_TOT_REB \tab character \tab  \cr
#'       PER_MIN_AST \tab character \tab  \cr
#'       PER_MIN_STL \tab character \tab  \cr
#'       PER_MIN_TURNOVERS \tab character \tab  \cr
#'       PER_MIN_BLK \tab character \tab  \cr
#'       PER_MIN_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Cume Functions
#' @details
#' [CUME Stats](https://www.nba.com/stats/cumestats)
#' ```r
#'  nba_cumestatsplayer()
#' ```

nba_cumestatsplayer <- function(
    game_ids = '0022000756',
    league_id = '00',
    player_id = '1629611',
    season = '2020-21',
    season_type = 'Regular Season',
    team_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameIDs = game_ids,
    PlayerID = player_id,
    Season = season,
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
      hint = "Invalid arguments or no cumulative player stats data available for {player_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Cumulative Player Game Stats**
#' @name nba_cumestatsplayergames
NULL
#' @title
#' **Get NBA Stats API Cumulative Player Game Stats**
#' @rdname nba_cumestatsplayergames
#' @author Saiem Gilani
#' @param league_id league_id
#' @param location location
#' @param outcome outcome
#' @param player_id player_id
#' @param season season
#' @param season_type season_type
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: CumeStatsPlayerGames
#'
#'    **CumeStatsPlayerGames**
#'
#'
#'    |col_name |types     |description             |
#'    |:--------|:---------|:-----------------------|
#'    |MATCHUP  |character |Matchup.                |
#'    |GAME_ID  |character |Unique game identifier. |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Cume Functions
#' @details
#' [CUME Stats](https://www.nba.com/stats/cumestats)
#' ```r
#'  nba_cumestatsplayergames(player_id = '2544')
#' ```
nba_cumestatsplayergames <- function(
    league_id = '00',
    location = '',
    outcome = '',
    player_id = '2544',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    vs_conference = '',
    vs_division = '',
    vs_team_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsplayergames"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Location = location,
    Outcome = outcome,
    PlayerID = player_id,
    Season = season,
    SeasonType = season_type,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no cumulative player game stats data available for {player_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Cumulative Team Stats**
#' @name nba_cumestatsteam
NULL
#' @title
#' **Get NBA Stats API Cumulative Team Stats**
#' @rdname nba_cumestatsteam
#' @author Saiem Gilani
#' @param game_ids game_ids
#' @param league_id league_id
#' @param season season
#' @param season_type season_type
#' @param team_id team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: GameByGameStats, TotalTeamStats
#'
#'    **GameByGameStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       JERSEY_NUM \tab character \tab Jersey number worn by the player. \cr
#'       PLAYER \tab character \tab Player. \cr
#'       PERSON_ID \tab character \tab Unique player identifier (V3 endpoints). \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       GP \tab character \tab Games played. \cr
#'       GS \tab character \tab Games started. \cr
#'       ACTUAL_MINUTES \tab character \tab  \cr
#'       ACTUAL_SECONDS \tab character \tab  \cr
#'       FG \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3 \tab character \tab  \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FT \tab character \tab  \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OFF_REB \tab character \tab  \cr
#'       DEF_REB \tab character \tab  \cr
#'       TOT_REB \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       DQ \tab character \tab  \cr
#'       STL \tab character \tab Steals. \cr
#'       TURNOVERS \tab character \tab Total turnovers. \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       MAX_ACTUAL_MINUTES \tab character \tab  \cr
#'       MAX_ACTUAL_SECONDS \tab character \tab  \cr
#'       MAX_REB \tab character \tab  \cr
#'       MAX_AST \tab character \tab  \cr
#'       MAX_STL \tab character \tab  \cr
#'       MAX_TURNOVERS \tab character \tab  \cr
#'       MAX_BLKP \tab character \tab  \cr
#'       MAX_PTS \tab character \tab  \cr
#'       AVG_ACTUAL_MINUTES \tab character \tab  \cr
#'       AVG_ACTUAL_SECONDS \tab character \tab  \cr
#'       AVG_REB \tab character \tab  \cr
#'       AVG_AST \tab character \tab  \cr
#'       AVG_STL \tab character \tab  \cr
#'       AVG_TURNOVERS \tab character \tab The average turnovers committed per game. \cr
#'       AVG_BLKP \tab character \tab  \cr
#'       AVG_PTS \tab character \tab  \cr
#'       PER_MIN_REB \tab character \tab  \cr
#'       PER_MIN_AST \tab character \tab  \cr
#'       PER_MIN_STL \tab character \tab  \cr
#'       PER_MIN_TURNOVERS \tab character \tab  \cr
#'       PER_MIN_BLK \tab character \tab  \cr
#'       PER_MIN_PTS \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **TotalTeamStats**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       CITY \tab character \tab City. \cr
#'       NICKNAME \tab character \tab Team or athlete nickname. \cr
#'       TEAM_ID \tab character \tab Unique team identifier. \cr
#'       W \tab character \tab Wins. \cr
#'       L \tab character \tab Losses. \cr
#'       W_HOME \tab character \tab  \cr
#'       L_HOME \tab character \tab  \cr
#'       W_ROAD \tab character \tab  \cr
#'       L_ROAD \tab character \tab  \cr
#'       TEAM_TURNOVERS \tab character \tab Team turnovers (turnovers credited to the team rather than a player). \cr
#'       TEAM_REBOUNDS \tab character \tab Team rebounds (rebounds credited to the team rather than a player). \cr
#'       GP \tab character \tab Games played. \cr
#'       GS \tab character \tab Games started. \cr
#'       ACTUAL_MINUTES \tab character \tab  \cr
#'       ACTUAL_SECONDS \tab character \tab  \cr
#'       FG \tab character \tab Field goals made. \cr
#'       FGA \tab character \tab Field goal attempts. \cr
#'       FG_PCT \tab character \tab Field goal percentage (0-1). \cr
#'       FG3 \tab character \tab  \cr
#'       FG3A \tab character \tab Three-point field goal attempts. \cr
#'       FG3_PCT \tab character \tab Three-point field goal percentage (0-1). \cr
#'       FT \tab character \tab  \cr
#'       FTA \tab character \tab Free throw attempts. \cr
#'       FT_PCT \tab character \tab Free throw percentage (0-1). \cr
#'       OFF_REB \tab character \tab  \cr
#'       DEF_REB \tab character \tab  \cr
#'       TOT_REB \tab character \tab  \cr
#'       AST \tab character \tab Assists. \cr
#'       PF \tab character \tab Personal fouls. \cr
#'       STL \tab character \tab Steals. \cr
#'       TOTAL_TURNOVERS \tab character \tab Total turnovers (player + team). \cr
#'       BLK \tab character \tab Blocks. \cr
#'       PTS \tab character \tab Points scored. \cr
#'       AVG_REB \tab character \tab  \cr
#'       AVG_PTS \tab character \tab  \cr
#'       DQ \tab character \tab  \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Cume Functions
#' @details
#' [CUME Stats](https://www.nba.com/stats/cumestats)
#' ```r
#'  nba_cumestatsteam(game_ids = '0022201094', season = '2022-23', team_id = '1610612739')
#' ```
nba_cumestatsteam <- function(
    game_ids = '0022201094',
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    season_type = 'Regular Season',
    team_id = '1610612739',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsteam"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameIDs = game_ids,
    Season = season,
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
      hint = "Invalid arguments or no cumulative team stats data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
#' **Get NBA Stats API Cumulative Team Game Stats**
#' @name nba_cumestatsteamgames
NULL
#' @title
#' **Get NBA Stats API Cumulative Team Game Stats**
#' @rdname nba_cumestatsteamgames
#' @author Saiem Gilani
#' @param league_id league_id
#' @param location location
#' @param outcome outcome
#' @param season season
#' @param season_id season_id
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list of data frames: CumeStatsTeamGames
#'
#'    **CumeStatsTeamGames**
#'
#'
#'    |col_name |types     |description             |
#'    |:--------|:---------|:-----------------------|
#'    |MATCHUP  |character |Matchup.                |
#'    |GAME_ID  |character |Unique game identifier. |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Cume Functions
#' @details
#' [CUME Stats](https://www.nba.com/stats/cumestats)
#' ```r
#'  nba_cumestatsteamgames(team_id = 1610612739, season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_cumestatsteamgames <- function(
    league_id = '00',
    location = '',
    outcome = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_id = '',
    season_type = 'Regular Season',
    team_id = 1610612739,
    vs_conference = '',
    vs_division = '',
    vs_team_id = '',
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsteamgames"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Location = location,
    Outcome = outcome,
    Season = season,
    SeasonID = season_id,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no cumulative team game stats data available for {team_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
