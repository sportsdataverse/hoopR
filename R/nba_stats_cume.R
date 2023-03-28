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
#'    |col_name       |types     |
#'    |:--------------|:---------|
#'    |DATE_EST       |character |
#'    |VISITOR_TEAM   |character |
#'    |HOME_TEAM      |character |
#'    |GP             |character |
#'    |GS             |character |
#'    |ACTUAL_MINUTES |character |
#'    |ACTUAL_SECONDS |character |
#'    |FG             |character |
#'    |FGA            |character |
#'    |FG_PCT         |character |
#'    |FG3            |character |
#'    |FG3A           |character |
#'    |FG3_PCT        |character |
#'    |FT             |character |
#'    |FTA            |character |
#'    |FT_PCT         |character |
#'    |OFF_REB        |character |
#'    |DEF_REB        |character |
#'    |TOT_REB        |character |
#'    |AVG_TOT_REB    |character |
#'    |AST            |character |
#'    |PF             |character |
#'    |DQ             |character |
#'    |STL            |character |
#'    |TURNOVERS      |character |
#'    |BLK            |character |
#'    |PTS            |character |
#'    |AVG_PTS        |character |
#'
#'    **TotalPlayerStats**
#'
#'
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |DISPLAY_FI_LAST    |character |
#'    |PERSON_ID          |character |
#'    |JERSEY_NUM         |character |
#'    |GP                 |character |
#'    |GS                 |character |
#'    |ACTUAL_MINUTES     |character |
#'    |ACTUAL_SECONDS     |character |
#'    |FG                 |character |
#'    |FGA                |character |
#'    |FG_PCT             |character |
#'    |FG3                |character |
#'    |FG3A               |character |
#'    |FG3_PCT            |character |
#'    |FT                 |character |
#'    |FTA                |character |
#'    |FT_PCT             |character |
#'    |OFF_REB            |character |
#'    |DEF_REB            |character |
#'    |TOT_REB            |character |
#'    |AST                |character |
#'    |PF                 |character |
#'    |DQ                 |character |
#'    |STL                |character |
#'    |TURNOVERS          |character |
#'    |BLK                |character |
#'    |PTS                |character |
#'    |MAX_ACTUAL_MINUTES |character |
#'    |MAX_ACTUAL_SECONDS |character |
#'    |MAX_REB            |character |
#'    |MAX_AST            |character |
#'    |MAX_STL            |character |
#'    |MAX_TURNOVERS      |character |
#'    |MAX_BLK            |character |
#'    |MAX_PTS            |character |
#'    |AVG_ACTUAL_MINUTES |character |
#'    |AVG_ACTUAL_SECONDS |character |
#'    |AVG_TOT_REB        |character |
#'    |AVG_AST            |character |
#'    |AVG_STL            |character |
#'    |AVG_TURNOVERS      |character |
#'    |AVG_BLK            |character |
#'    |AVG_PTS            |character |
#'    |PER_MIN_TOT_REB    |character |
#'    |PER_MIN_AST        |character |
#'    |PER_MIN_STL        |character |
#'    |PER_MIN_TURNOVERS  |character |
#'    |PER_MIN_BLK        |character |
#'    |PER_MIN_PTS        |character |
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

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameIDs = game_ids,
    LeagueID = league_id,
    PlayerID = player_id,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no cumulative player stats data available for {player_id}!"))
    },
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
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |MATCHUP  |character |
#'    |GAME_ID  |character |
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

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no cumulative player game stats data available for {player_id}!"))
    },
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
#'    |col_name           |types     |
#'    |:------------------|:---------|
#'    |JERSEY_NUM         |character |
#'    |PLAYER             |character |
#'    |PERSON_ID          |character |
#'    |TEAM_ID            |character |
#'    |GP                 |character |
#'    |GS                 |character |
#'    |ACTUAL_MINUTES     |character |
#'    |ACTUAL_SECONDS     |character |
#'    |FG                 |character |
#'    |FGA                |character |
#'    |FG_PCT             |character |
#'    |FG3                |character |
#'    |FG3A               |character |
#'    |FG3_PCT            |character |
#'    |FT                 |character |
#'    |FTA                |character |
#'    |FT_PCT             |character |
#'    |OFF_REB            |character |
#'    |DEF_REB            |character |
#'    |TOT_REB            |character |
#'    |AST                |character |
#'    |PF                 |character |
#'    |DQ                 |character |
#'    |STL                |character |
#'    |TURNOVERS          |character |
#'    |BLK                |character |
#'    |PTS                |character |
#'    |MAX_ACTUAL_MINUTES |character |
#'    |MAX_ACTUAL_SECONDS |character |
#'    |MAX_REB            |character |
#'    |MAX_AST            |character |
#'    |MAX_STL            |character |
#'    |MAX_TURNOVERS      |character |
#'    |MAX_BLKP           |character |
#'    |MAX_PTS            |character |
#'    |AVG_ACTUAL_MINUTES |character |
#'    |AVG_ACTUAL_SECONDS |character |
#'    |AVG_REB            |character |
#'    |AVG_AST            |character |
#'    |AVG_STL            |character |
#'    |AVG_TURNOVERS      |character |
#'    |AVG_BLKP           |character |
#'    |AVG_PTS            |character |
#'    |PER_MIN_REB        |character |
#'    |PER_MIN_AST        |character |
#'    |PER_MIN_STL        |character |
#'    |PER_MIN_TURNOVERS  |character |
#'    |PER_MIN_BLK        |character |
#'    |PER_MIN_PTS        |character |
#'
#'    **TotalTeamStats**
#'
#'
#'    |col_name        |types     |
#'    |:---------------|:---------|
#'    |CITY            |character |
#'    |NICKNAME        |character |
#'    |TEAM_ID         |character |
#'    |W               |character |
#'    |L               |character |
#'    |W_HOME          |character |
#'    |L_HOME          |character |
#'    |W_ROAD          |character |
#'    |L_ROAD          |character |
#'    |TEAM_TURNOVERS  |character |
#'    |TEAM_REBOUNDS   |character |
#'    |GP              |character |
#'    |GS              |character |
#'    |ACTUAL_MINUTES  |character |
#'    |ACTUAL_SECONDS  |character |
#'    |FG              |character |
#'    |FGA             |character |
#'    |FG_PCT          |character |
#'    |FG3             |character |
#'    |FG3A            |character |
#'    |FG3_PCT         |character |
#'    |FT              |character |
#'    |FTA             |character |
#'    |FT_PCT          |character |
#'    |OFF_REB         |character |
#'    |DEF_REB         |character |
#'    |TOT_REB         |character |
#'    |AST             |character |
#'    |PF              |character |
#'    |STL             |character |
#'    |TOTAL_TURNOVERS |character |
#'    |BLK             |character |
#'    |PTS             |character |
#'    |AVG_REB         |character |
#'    |AVG_PTS         |character |
#'    |DQ              |character |
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

  # intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "cumestatsteam"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameIDs = game_ids,
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no cumulative team stats data available for {team_id}!"))
    },
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
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |MATCHUP  |character |
#'    |GAME_ID  |character |
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

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no cumulative team game stats data available for {team_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
