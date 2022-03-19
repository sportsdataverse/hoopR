#' **Get NBA Stats API Player Awards**
#' @name playerawards
NULL
#' @title
#' **Get NBA Stats API Player Awards**
#' @rdname playerawards
#' @author Saiem Gilani
#' @param player_id Player ID
#' @return Return a named list of data frames: PlayerAwards
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerawards <- function(player_id){

  version <- "playerawards"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?PlayerID=",pad_id(player_id))
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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player awards data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Career By College**
#' @name pcareerbycollege
NULL
#' @title
#' **Get NBA Stats API Player Career By College**
#' @rdname pcareerbycollege
#' @author Saiem Gilani
#' @param college College Name
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @return Return a named list of data frames: PlayerCareerByCollege
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playercareerbycollege <- function(college = 'Florida State',
                                      league_id = '00',
                                      per_mode = 'Totals',
                                      season='2020-21',
                                      season_type='Regular Season'){
  college <- gsub(' ','+',college)
  season_type <- gsub(' ','+',season_type)
  version <- "playercareerbycollege"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=",college,
                     "&LeagueID=", league_id,
                     "&PerMode=", per_mode,
                     "&Season=",season,
                     "&SeasonType=",season_type)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player careers by college data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Career By College Rollup**
#' @name pcareerbycollege_ru
NULL
#' @title
#' **Get NBA Stats API Player Career By College Rollup**
#' @rdname pcareerbycollege_ru
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @return Return a named list of data frames: East, Midwest, South, West
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playercareerbycollegerollup <- function(league_id = '00',
                                            per_mode = 'Totals',
                                            season='2020-21',
                                            season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playercareerbycollegerollup"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&PerMode=", per_mode,
                     "&Season=",season,
                     "&SeasonType=",season_type)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player careers by college rollup data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Career Stats**
#' @name playercareerstats
NULL
#' @title
#' **Get NBA Stats API Player Career Stats**
#' @rdname playercareerstats
#' @author Saiem Gilani
#' @param player_id Player ID
#' @param per_mode Per Mode - PerGame, Totals
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @return Return a named list of data frames: CareerTotalsAllStarSeason, CareerTotalsCollegeSeason, CareerTotalsPostSeason,
#' CareerTotalsRegularSeason, SeasonRankingsPostSeason, SeasonRankingsRegularSeason, SeasonTotalsAllStarSeason, SeasonTotalsCollegeSeason,
#' SeasonTotalsPostSeason, SeasonTotalsRegularSeason
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playercareerstats <- function(league_id = '00',
                                  per_mode = 'Totals',
                                  player_id='2544'){


  version <- "playercareerstats"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&PerMode=", per_mode,
                     "&PlayerID=",player_id)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player career stats data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Fantasy Profile**
#' @name pfantasy
NULL
#' @title
#' **Get NBA Stats API Player Fantasy Profile**
#' @rdname pfantasy
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param measure_type measure_type
#' @param player_id Player ID
#' @param per_mode Per Mode - PerGame, Totals
#' @param pace_adjust Pace Adjustment - Y/N
#' @param plus_minus Plus Minus - Y/N
#' @param rank Rank - Y/N
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @return Return a named list of data frames: DaysRestModified, LastNGames, Location, Opponent, Overall
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerfantasyprofile <- function(league_id = '00',
                                     measure_type='Base',
                                     pace_adjust='N',
                                     per_mode='Totals',
                                     player_id='2544',
                                     plus_minus='N',
                                     rank='N',
                                     season='2020-21',
                                     season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playerfantasyprofile"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&MeasureType=", measure_type,
                     "&PaceAdjust=", pace_adjust,
                     "&PerMode=", per_mode,
                     "&PlayerID=",player_id,
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=",season,
                     "&SeasonType=",season_type)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player fantasy profile data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Fantasy Profile Bar Graph**
#' @name pfantasy_bg
NULL
#' @title
#' **Get NBA Stats API Player Fantasy Profile Bar Graph**
#' @rdname pfantasy_bg
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param player_id Player ID
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @return Return a named list of data frames: LastFiveGamesAvg, SeasonAvg
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerfantasyprofilebargraph <- function(league_id = '00',
                                             player_id='2544',
                                             season='2020-21',
                                             season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playerfantasyprofilebargraph"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&PlayerID=",player_id,
                     "&Season=",season,
                     "&SeasonType=",season_type)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player fantasy profile bar graph data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Estimated Metrics**
#' @name p_est_metr
NULL
#' @title
#' **Get NBA Stats API Player Estimated Metrics**
#' @rdname p_est_metr
#' @author Saiem Gilani
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @return Return a named list of data frames: PlayerEstimatedMetrics
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerestimatedmetrics <- function(league_id = '00',
                                       season='2020-21',
                                       season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playerestimatedmetrics"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&Season=",season,
                     "&SeasonType=",season_type)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player estimated metrics data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Index**
#' @name p_index
NULL
#' @title
#' **Get NBA Stats API Player Index**
#' @rdname p_index
#' @author Saiem Gilani
#' @param college Player College
#' @param country Player Country
#' @param draft_pick Draft Pick
#' @param draft_round Draft Round
#' @param draft_year Draft Year
#' @param height Player Height
#' @param historical Whether to include only current players (0) or all historical (1).
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param team_id Team ID. Default: 0 (all teams).
#' @param weight Player weight
#' @return Return a named list of data frames: PlayerIndex
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerindex <- function(
  college = '',
  country = '',
  draft_pick = '',
  draft_round='',
  draft_year='',
  height = '',
  historical = 1,
  league_id = '00',
  season='2020-21',
  season_type='Regular Season',
  team_id = '0',
  weight = ''){

  season_type <- gsub(' ','+',season_type)
  version <- "playerindex"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?College=", college,
                     "&Country=", country,
                     "&DraftPick=", draft_pick,
                     "&DraftRound=", draft_round,
                     "&DraftYear=", draft_year,
                     "&Height=", height,
                     "&Historical=", historical,
                     "&LeagueID=", league_id,
                     "&Season=", season,
                     "&SeasonType=",season_type,
                     "&TeamID=", team_id,
                     "&Weight=", weight)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player game log data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Game Log**
#' @name p_gamelog
NULL
#' @title
#' **Get NBA Stats API Player Game Log**
#' @rdname p_gamelog
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param player_id Player ID
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @return Return a named list of data frames: PlayerGameLog
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playergamelog <- function(
  date_from = '',
  date_to = '',
  league_id = '00',
  player_id='2544',
  season='2020-21',
  season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playergamelog"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&LeagueID=", league_id,
                     "&PlayerID=",player_id,
                     "&Season=",season,
                     "&SeasonType=",season_type)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player game log data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Game Logs**
#' @name p_gamelogs
NULL
#' @title
#' **Get NBA Stats API Player Game Logs**
#' @rdname p_gamelogs
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param per_mode per_mode
#' @param period period
#' @param player_id Player ID
#' @param season Season - format 2020-21
#' @param season_segment season_segment
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @return Return a named list of data frames: PlayerGameLogs
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playergamelogs <- function(
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
  per_mode='Totals',
  period=0,
  player_id='2544',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='',
  vs_conference='',
  vs_division=''){

  season_type <- gsub(' ','+',season_type)
  version <- "playergamelogs"
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
                     "&PORound=", po_round,
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

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player game logs data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Game Streak Finder**
#' @name pg_streak
NULL
#' @title
#' **Get NBA Stats API Player Game Streak Finder**
#' @rdname pg_streak
#' @author Saiem Gilani
#' @param active_streaks_only active_streaks_only
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_year draft_year
#' @param draft_team_id draft_team_id
#' @param draft_round draft_round
#' @param draft_number draft_number
#' @param et_ast et_ast
#' @param et_blk et_blk
#' @param et_dd et_dd
#' @param et_dreb et_dreb
#' @param et_fg3a et_fg3a
#' @param et_fg3m et_fg3m
#' @param et_fg3_pct et_fg3_pct
#' @param et_fga et_fga
#' @param et_fgm et_fgm
#' @param et_fg_pct et_fg_pct
#' @param et_fta et_fta
#' @param et_ftm et_ftm
#' @param et_ft_pct et_ft_pct
#' @param et_minutes et_minutes
#' @param et_oreb et_oreb
#' @param et_pf et_pf
#' @param et_pts et_pts
#' @param et_reb et_reb
#' @param et_stl et_stl
#' @param et_td et_td
#' @param et_tov et_tov
#' @param game_id game_id
#' @param gt_ast gt_ast
#' @param gt_blk gt_blk
#' @param gt_dd gt_dd
#' @param gt_dreb gt_dreb
#' @param gt_fg3a gt_fg3a
#' @param gt_fg3m gt_fg3m
#' @param gt_fg3_pct gt_fg3_pct
#' @param gt_fga gt_fga
#' @param gt_fgm gt_fgm
#' @param gt_fg_pct gt_fg_pct
#' @param gt_fta gt_fta
#' @param gt_ftm gt_ftm
#' @param gt_ft_pct gt_ft_pct
#' @param gt_minutes gt_minutes
#' @param gt_oreb gt_oreb
#' @param gt_pf gt_pf
#' @param gt_pts gt_pts
#' @param gt_reb gt_reb
#' @param gt_stl gt_stl
#' @param gt_td gt_td
#' @param gt_tov gt_tov
#' @param league_id league_id
#' @param location location
#' @param lt_ast lt_ast
#' @param lt_blk lt_blk
#' @param lt_dd lt_dd
#' @param lt_dreb lt_dreb
#' @param lt_fg3a lt_fg3a
#' @param lt_fg3m lt_fg3m
#' @param lt_fg3_pct lt_fg3_pct
#' @param lt_fga lt_fga
#' @param lt_fgm lt_fgm
#' @param lt_fg_pct lt_fg_pct
#' @param lt_fta lt_fta
#' @param lt_ftm lt_ftm
#' @param lt_ft_pct lt_ft_pct
#' @param lt_minutes lt_minutes
#' @param lt_oreb lt_oreb
#' @param lt_pf lt_pf
#' @param lt_pts lt_pts
#' @param lt_reb lt_reb
#' @param lt_stl lt_stl
#' @param lt_td lt_td
#' @param lt_tov lt_tov
#' @param min_games min_games
#' @param outcome outcome
#' @param po_round po_round
#' @param player_id player_id
#' @param rookie_year rookie_year
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param years_experience years_experience
#' @return Return a named list of data frames: PlayerGameStreakFinderResults
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export

nba_playergamestreakfinder <- function(
  active_streaks_only='',
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  draft_year='',
  draft_team_id='',
  draft_round='',
  draft_number='',
  et_ast='',
  et_blk='',
  et_dd='',
  et_dreb='',
  et_fg3a='',
  et_fg3m='',
  et_fg3_pct='',
  et_fga='',
  et_fgm='',
  et_fg_pct='',
  et_fta='',
  et_ftm='',
  et_ft_pct='',
  et_minutes='',
  et_oreb='',
  et_pf='',
  et_pts='',
  et_reb='',
  et_stl='',
  et_td='',
  et_tov='',
  game_id='',
  gt_ast='',
  gt_blk='',
  gt_dd='',
  gt_dreb='',
  gt_fg3a='',
  gt_fg3m='',
  gt_fg3_pct='',
  gt_fga='',
  gt_fgm='',
  gt_fg_pct='',
  gt_fta='',
  gt_ftm='',
  gt_ft_pct='',
  gt_minutes='',
  gt_oreb='',
  gt_pf='',
  gt_pts='',
  gt_reb='',
  gt_stl='',
  gt_td='',
  gt_tov='',
  league_id='00',
  location='',
  lt_ast='',
  lt_blk='',
  lt_dd='',
  lt_dreb='',
  lt_fg3a='',
  lt_fg3m='',
  lt_fg3_pct='',
  lt_fga='',
  lt_fgm='',
  lt_fg_pct='',
  lt_fta='',
  lt_ftm='',
  lt_ft_pct='',
  lt_minutes='',
  lt_oreb='',
  lt_pf='',
  lt_pts='',
  lt_reb='',
  lt_stl='',
  lt_td='',
  lt_tov='',
  min_games='',
  outcome='',
  po_round='',
  player_id='',
  rookie_year='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  starter_bench='',
  team_id='',
  vs_conference='',
  vs_division='',
  vs_team_id='',
  years_experience=''){
  season_type <- gsub(' ','+',season_type)
  version <- "playergamestreakfinder"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?ActiveStreaksOnly", active_streaks_only,
                     "&Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&DraftNumber=",draft_number,
                     "&DraftRound=",draft_round,
                     "&DraftTeamID=",draft_team_id,
                     "&DraftYear=",draft_year,
                     "&EqAST=",et_ast,
                     "&EqBLK=",et_blk,
                     "&EqDD=",et_dd,
                     "&EqDREB=",et_dreb,
                     "&EqFG3A=",et_fg3a,
                     "&EqFG3M=",et_fg3m,
                     "&EqFG3_PCT=",et_fg3_pct,
                     "&EqFGA=",et_fga,
                     "&EqFGM=",et_fgm,
                     "&EqFG_PCT=",et_fg_pct,
                     "&EqFTA=",et_fta,
                     "&EqFTM=",et_ftm,
                     "&EqFT_PCT=", et_ft_pct,
                     "&EqMINUTES=",et_minutes,
                     "&EqOREB=", et_oreb,
                     "&EqPF=",et_pf,
                     "&EqPTS=",et_pts,
                     "&EqREB=", et_reb,
                     "&EqSTL=",et_stl,
                     "&EqTD=",et_td,
                     "&EqTOV=",et_tov,
                     "&GameID=",game_id,
                     "&GtAST=",gt_ast,
                     "&GtBLK=",gt_blk,
                     "&GtDD=",gt_dd,
                     "&GtDREB=",gt_dreb,
                     "&GtFG3A=",gt_fg3a,
                     "&GtFG3M=",gt_fg3m,
                     "&GtFG3_PCT=",gt_fg3_pct,
                     "&GtFGA=",gt_fga,
                     "&GtFGM=",gt_fgm,
                     "&GtFG_PCT=",gt_fg_pct,
                     "&GtFTA=",gt_fta,
                     "&GtFTM=",gt_ftm,
                     "&GtFT_PCT=", gt_ft_pct,
                     "&GtMINUTES=",gt_minutes,
                     "&GtOREB=", gt_oreb,
                     "&GtPF=",gt_pf,
                     "&GtPTS=",gt_pts,
                     "&GtREB=", gt_reb,
                     "&GtSTL=",gt_stl,
                     "&GtTD=",gt_td,
                     "&GtTOV=",gt_tov,
                     "&LeagueID=", league_id,
                     "&Location=",location,
                     "&LtAST=",lt_ast,
                     "&LtBLK=",lt_blk,
                     "&LtDD=",lt_dd,
                     "&LtDREB=",lt_dreb,
                     "&LtFG3A=",lt_fg3a,
                     "&LtFG3M=",lt_fg3m,
                     "&LtFG3_PCT=",lt_fg3_pct,
                     "&LtFGA=",lt_fga,
                     "&LtFGM=",lt_fgm,
                     "&LtFG_PCT=",lt_fg_pct,
                     "&LtFTA=",lt_fta,
                     "&LtFTM=",lt_ftm,
                     "&LtFT_PCT=", lt_ft_pct,
                     "&LtMINUTES=",lt_minutes,
                     "&LtOREB=", lt_oreb,
                     "&LtPF=",lt_pf,
                     "&LtPTS=",lt_pts,
                     "&LtREB=", lt_reb,
                     "&LtSTL=",lt_stl,
                     "&LtTD=",lt_td,
                     "&LtTOV=",lt_tov,
                     "&MinGames=", min_games,
                     "&Outcome=",outcome,
                     "&PORound=",po_round,
                     "&PlayerID=",player_id,
                     "&RookieYear=",rookie_year,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&StarterBench",starter_bench,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&VsTeamID=", vs_team_id,
                     "&YearsExperience=", years_experience
  )

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
      message(glue::glue("{Sys.time()}: Invalid arguments or no player streak finder data available for the parameters selected!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Next N Games**
#' @name p_n_g
NULL
#' @title
#' **Get NBA Stats API Player Next N Games**
#' @rdname p_n_g
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param number_of_games N in number of games
#' @param player_id Player ID
#' @param season Season - format 2020-21
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @return Return a named list of data frames: NextNGames
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playernextngames <- function(league_id = '',
                                 number_of_games=2147483647,
                                 player_id='2544',
                                 season='2020-21',
                                 season_type='Regular Season'){

  season_type <- gsub(' ','+',season_type)
  version <- "playernextngames"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&NumberOfGames=", number_of_games,
                     "&PlayerID=",player_id,
                     "&Season=",season,
                     "&SeasonType=",season_type)

  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player next n games data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API Player Profile V2**
#' @name playerprofilev2
NULL
#' @title
#' **Get NBA Stats API Player Profile V2**
#' @rdname playerprofilev2
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param player_id Player ID
#' @param per_mode Season - format 2020-21
#' @return Return a named list of data frames: CareerHighs, CareerTotalsAllStarSeason, CareerTotalsCollegeSeason, CareerTotalsPostSeason, CareerTotalsPreseason,
#' CareerTotalsRegularSeason, NextGame, SeasonHighs, SeasonRankingsPostSeason, SeasonRankingsRegularSeason, SeasonTotalsAllStarSeason, SeasonTotalsCollegeSeason,
#'  SeasonTotalsPostSeason, SeasonTotalsPreseason, SeasonTotalsRegularSeason
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playerprofilev2 <- function(league_id = '',
                                per_mode='Totals',
                                player_id='2544'){


  version <- "playerprofilev2"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?LeagueID=", league_id,
                     "&PerMode=", per_mode,
                     "&PlayerID=",player_id)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no player profile v2 data available for {player_id}!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player vs Player**
#' @name playervsplayer
NULL
#' @title
#' **Get NBA Stats API Player vs Player**
#' @rdname playervsplayer
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id Player ID
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season Season - format 2020-21
#' @param season_segment season_segment
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id vs_player_id
#' @return Return a named list of data frames: OnOffCourt, Overall, PlayerInfo, ShotAreaOffCourt, ShotAreaOnCourt, ShotAreaOverall, ShotDistanceOffCourt, ShotDistanceOnCourt,
#' ShotDistanceOverall, VsPlayerInfo
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playervsplayer <- function(
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
  per_mode='Totals',
  period=0,
  player_id='2544',
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  vs_conference='',
  vs_division='',
  vs_player_id='203076'){

  season_type <- gsub(' ','+',season_type)
  version <- "playervsplayer"
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
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerID=",player_id,
                     "&PlusMinus=",plus_minus,
                     "&Rank=",rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&VsPlayerID=", vs_player_id)
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player vs player data unavailable for the parameters selected!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Compare**
#' @name playercompare
NULL
#' @title
#' **Get NBA Stats API Player Compare**
#' @rdname playercompare
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param player_id_list Player ID
#' @param plus_minus plus_minus
#' @param rank rank
#' @param season Season - format 2020-21
#' @param season_segment season_segment
#' @param season_type Season Type - Regular Season, Playoffs, All-Star
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id_list vs_player_id_list
#' @return Return a named list of data frames: Individual, OverallCompare
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
nba_playercompare <- function(
  conference = '',
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
  per_mode='Totals',
  period=0,
  player_id_list='202681,203078,2544,201567,203954',
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  vs_conference='',
  vs_division='',
  vs_player_id_list='201566,201939,201935,201142,203076'){

  season_type <- gsub(' ','+',season_type)
  version <- "playercompare"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference", conference,
                     "&DateFrom=", date_from,
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
                     "&PerMode=", per_mode,
                     "&Period=", period,
                     "&PlayerIDList=",URLencode(player_id_list),
                     "&PlusMinus=",plus_minus,
                     "&Rank=",rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&ShotClockRange=",shot_clock_range,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division,
                     "&VsPlayerIDList=", URLencode(vs_player_id_list))
  tryCatch(
    expr = {
      resp <- full_url %>%
        .nba_headers()

      df_list <- purrr::map(1:length(resp$resultSet$name), function(x){
        data <- resp$resultSet$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSet$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or player comparison data unavailable for the parameters selected!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
