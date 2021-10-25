## Player Dashboard parameters are the same

#' **Get NBA Stats API Player Dashboard by Clutch Splits**
#' @name pbyclutch
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Clutch Splits**
#' @rdname pbyclutch
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbyclutch <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbyclutch"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or player dashboard by clutch splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Game Splits**
#' @name pbygamesplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Game Splits**
#' @rdname pbygamesplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbygamesplits <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbygamesplits"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or player dashboard by game splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by General Splits**
#' @name pbygeneralsplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by General Splits**
#' @rdname pbygeneralsplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbygeneralsplits <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbygeneralsplits"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by general splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by Last N Games**
#' @name pbylastngames
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Last N Games**
#' @rdname pbylastngames
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbylastngames <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbylastngames"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by last n games data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard by Opponent**
#' @name pbyopponent
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Opponent**
#' @rdname pbyopponent
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbyopponent <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbyopponent"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by opponent data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Shooting Splits**
#' @name pbyshootingsplits
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Shooting Splits**
#' @rdname pbyshootingsplits
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbyshootingsplits <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbyshootingsplits"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by shooting splits data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard by Team Performance**
#' @name pbyteamperformance
NULL
#' @title
#' **Get NBA Stats API Player Dashboard by Team Performance**
#' @rdname pbyteamperformance
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbyteamperformance <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbyteamperformance"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard by team performance data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Year over Year**
#' @name pbyyearoveryear
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Year over Year**
#' @rdname pbyyearoveryear
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashboardbyyearoveryear <- function(
  date_from = '',
  date_to = '',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus = 'N',
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashboardbyyearoveryear"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PaceAdjust=", pace_adjust,
                     "&PORound=", po_round,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard year-over-year data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Dashboard Player Tracking - Passing**
#' @name pptpass
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Passing**
#' @rdname pptpass
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashptpass  <- function(
  date_from = '',
  date_to = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  per_mode='Totals',
  player_id='2544',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='0',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashptpass"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PerMode=", per_mode,
                     "&PlayerID=",player_id,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking passing data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Player Tracking - Rebounding**
#' @name pptreb
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Rebounding**
#' @rdname pptreb
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashptreb  <- function(
  date_from = '',
  date_to = '',
  game_segment='',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  per_mode='Totals',
  period=0,
  player_id='2544',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='0',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashptreb"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=",game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking rebounding data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Dashboard Player Tracking - Defense**
#' @name pptshotdefend
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Defense**
#' @rdname pptshotdefend
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashptshotdefend  <- function(
  date_from = '',
  date_to = '',
  game_segment='',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  per_mode='Totals',
  period=0,
  player_id='2544',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='0',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashptshotdefend"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=",game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {

      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking shot defense data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Dashboard Player Tracking - Shots**
#' @name pptshots
NULL
#' @title
#' **Get NBA Stats API Player Dashboard Player Tracking - Shots**
#' @rdname pptshots
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param per_mode per_mode
#' @param period period
#' @param player_id player_id
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_playerdashptshots  <- function(
  date_from = '',
  date_to = '',
  game_segment='',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  per_mode='Totals',
  period=0,
  player_id='2544',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='0',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playerdashptshots"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameSegment=",game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)
  tryCatch(
    expr = {


      resp <- full_url %>%
        .nba_headers()

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player dashboard player-tracking shots data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
