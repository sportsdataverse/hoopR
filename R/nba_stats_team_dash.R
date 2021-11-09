## Team Dashboard parameters are the same

#' **Get NBA Stats API Team Dashboard by Clutch Splits**
#' @name tbyclutch
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Clutch Splits**
#' @rdname tbyclutch
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: Last10Sec3Point2TeamDashboard,
#' Last10Sec3PointTeamDashboard, Last1Min5PointTeamDashboard, Last1MinPlusMinus5PointTeamDashboard,
#' Last30Sec3Point2TeamDashboard, Last30Sec3PointTeamDashboard, Last3Min5PointTeamDashboard,
#' Last3MinPlusMinus5PointTeamDashboard, Last5Min5PointTeamDashboard,
#' Last5MinPlusMinus5PointTeamDashboard, OverallTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbyclutch <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbyclutch"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&TeamID=",team_id,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by clutch data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Game Splits**
#' @name tbygamesplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Game Splits**
#' @rdname tbygamesplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: ByActualMarginTeamDashboard,
#' ByHalfTeamDashboard, ByPeriodTeamDashboard, ByScoreMarginTeamDashboard,
#' OverallTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbygamesplits <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbygamesplits"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by game splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by General Splits**
#' @name tbygeneralsplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by General Splits**
#' @rdname tbygeneralsplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: DaysRestTeamDashboard,
#' LocationTeamDashboard, MonthTeamDashboard, OverallTeamDashboard,
#' PrePostAllStarTeamDashboard, WinsLossesTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbygeneralsplits <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbygeneralsplits"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by general splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by Last N Games**
#' @name tbylastngames
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Last N Games**
#' @rdname tbylastngames
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: GameNumberTeamDashboard,
#' Last10TeamDashboard, Last15TeamDashboard, Last20TeamDashboard,
#' Last5TeamDashboard, OverallTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbylastngames <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbylastngames"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no teamdashboard by last n games data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard by Opponent**
#' @name tbyopponent
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Opponent**
#' @rdname tbyopponent
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: ConferenceTeamDashboard,
#' DivisionTeamDashboard, OpponentTeamDashboard, OverallTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbyopponent <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbyopponent"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by opponent data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Shooting Splits**
#' @name tbyshootingsplits
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Shooting Splits**
#' @rdname tbyshootingsplits
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: AssistedBy,
#' AssitedShotTeamDashboard, OverallTeamDashboard, Shot5FTTeamDashboard,
#' Shot8FTTeamDashboard, ShotAreaTeamDashboard, ShotTypeTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbyshootingsplits <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbyshootingsplits"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by shooting splits data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard by Team Performance**
#' @name tbyteamperformance
NULL
#' @title
#' **Get NBA Stats API Team Dashboard by Team Performance**
#' @rdname tbyteamperformance
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: OverallTeamDashboard,
#' PointsScoredTeamDashboard, PontsAgainstTeamDashboard, ScoreDifferentialTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbyteamperformance <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbyteamperformance"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by team performance data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard Year over Year**
#' @name tbyyearoveryear
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Year over Year**
#' @rdname tbyyearoveryear
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: ByYearTeamDashboard, OverallTeamDashboard
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashboardbyyearoveryear <- function(
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
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashboardbyyearoveryear"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by year-over-year data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard - Lineups**
#' @name teamdashlineups
NULL
#' @title
#' **Get NBA Stats API Team Dashboard - Lineups**
#' @rdname teamdashlineups
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_id game_id
#' @param game_segment game_segment
#' @param group_quantity group_quantity
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
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: Lineups, Overall
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashlineups <- function(
  date_from = '',
  date_to = '',
  game_id = '',
  game_segment = '',
  group_quantity = 5,
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  month=0,
  opponent_team_id=0,
  outcome='',
  pace_adjust='N',
  plus_minus = 'N',
  po_round='',
  per_mode='Totals',
  period=0,
  rank = 'N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "teamdashlineups"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&GameID=", game_id,
                     "&GameSegment=", game_segment,
                     "&GroupQuantity=", group_quantity,
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard by lineups data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Team Dashboard Player Tracking - Passing**
#' @name t_ptpass
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Passing**
#' @rdname t_ptpass
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
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: PassesMade, PassesReceived
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashptpass  <- function(
  date_from = '',
  date_to = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  per_mode='Totals',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)

  version <- "teamdashptpass"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking passing data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Team Dashboard Player Tracking - Rebounding**
#' @name t_ptreb
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Rebounding**
#' @rdname t_ptreb
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
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: NumContestedRebounding, OverallRebounding,
#' RebDistanceRebounding, ShotDistanceRebounding, ShotTypeRebounding
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashptreb  <- function(
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
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)

  version <- "teamdashptreb"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking rebounding data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Team Dashboard Player Tracking - Shots**
#' @name t_ptshots
NULL
#' @title
#' **Get NBA Stats API Team Dashboard Player Tracking - Shots**
#' @rdname t_ptshots
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
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: ClosestDefender10ftPlusShooting,
#' ClosestDefenderShooting, DribbleShooting, GeneralShooting, ShotClockShooting,
#' TouchTimeShooting
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_teamdashptshots  <- function(
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
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)

  version <- "teamdashptshots"
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no team dashboard player-tracking shooting data for {team_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
