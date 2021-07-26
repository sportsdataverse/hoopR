#' **Get NBA Stats API Fantasy Widget**
#' @name fantasywidget
NULL
#' @title
#' **Get NBA Stats API Fantasy Widget**
#' @rdname fantasywidget
#' @author Saiem Gilani
#' @param active_players active_players
#' @param date_from date_from date_from
#' @param date_to date_to date_to
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param po_round po_round
#' @param player_id player_id
#' @param position position
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param todays_opponent todays_opponent
#' @param todays_players todays_players
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_fantasywidget <- function(active_players='N',
                              date_from='',
                              date_to='',
                              last_n_games=0,
                              league_id='00',
                              location='',
                              month='',
                              opponent_team_id = '',
                              po_round='',
                              player_id='',
                              position='',
                              season='2019-20',
                              season_segment='',
                              season_type='Regular Season',
                              team_id='',
                              todays_opponent=0,
                              todays_players='N',
                              vs_conference='',
                              vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "fantasywidget"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?ActivePlayers=", active_players,
                     "&DateFrom=",date_from,
                     "&DateTo=",date_to,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=",league_id,
                     "&Location=",location,
                     "&Month=",month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&PORound=",po_round,
                     "&PlayerID=",player_id,
                     "&Position=",position,
                     "&Season=",season,
                     "&SeasonSegment=",season_segment,
                     "&SeasonType=",season_type,
                     "&TeamID=",team_id,
                     "&TodaysOpponent=",todays_opponent,
                     "&TodaysPlayers=",todays_players,
                     "&VsConference=",vs_conference,
                     "&VsDivision=",vs_division)

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
  return(df_list)
}

#' **Get NBA Stats API League Dashboard Lineups**
#' @name leaguedashlineups
NULL
#' @title
#' **Get NBA Stats API League Dashboard Lineups**
#' @rdname leaguedashlineups
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguedashlineups <- function(
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  game_segment = '',
  group_quantity=5,
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
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguedashlineups"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&GameSegment=", game_segment,
                     "&GroupQuantity=", group_quantity,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
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
  return(df_list)
}

#' **Get NBA Stats API League Lineup Visual Data**
#' @name leaguelineupviz
NULL
#' @title
#' **Get NBA Stats API League Lineup Visual Data**
#' @rdname leaguelineupviz
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param game_segment game_segment
#' @param group_quantity group_quantity
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param measure_type measure_type
#' @param minutes_min minutes_min
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
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leaguelineupviz <- function(
  conference = '',
  date_from = '',
  date_to = '',
  division = '',
  game_segment = '',
  group_quantity=5,
  last_n_games=0,
  league_id='00',
  location='',
  measure_type='Base',
  minutes_min = 10,
  month=0,
  opponent_team_id=0,
  outcome='',
  po_round='',
  pace_adjust='N',
  per_mode='Totals',
  period=0,
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  shot_clock_range='',
  team_id='',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leaguelineupviz"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?Conference=", conference,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&Division=", division,
                     "&GameSegment=", game_segment,
                     "&GroupQuantity=", group_quantity,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&MeasureType=", measure_type,
                     "&MinutesMin=", minutes_min,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&PORound=", po_round,
                     "&PaceAdjust=", pace_adjust,
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
  return(df_list)
}



#' **Get NBA Stats API League Player On/Off Details**
#' @name leagueplayerondetails
NULL
#' @title
#' **Get NBA Stats API League Player On/Off Details**
#' @rdname leagueplayerondetails
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
#' @param pace_adjust pace_adjust
#' @param per_mode per_mode
#' @param period period
#' @param plus_minus plus_minus
#' @param rank rank
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
nba_leagueplayerondetails <- function(
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
  plus_minus='N',
  rank='N',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  team_id='1610612749',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "leagueplayerondetails"
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
                     "&PlusMinus=", plus_minus,
                     "&Rank=", rank,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&TeamID=", team_id,
                     "&VsConference=", vs_conference,
                     "&VsDivision=", vs_division)

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
  return(df_list)
}



#' **Get NBA Stats API League Season Matchups**
#' @name leagueseasonmatchups
NULL
#' @title
#' **Get NBA Stats API League Season Matchups**
#' @rdname leagueseasonmatchups
#' @author Saiem Gilani
#' @param def_player_id def_player_id
#' @param def_team_id def_team_id
#' @param league_id league_id
#' @param off_player_id off_player_id
#' @param off_team_id off_team_id
#' @param per_mode per_mode
#' @param season season
#' @param season_type season_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_leagueseasonmatchups <- function(
  def_player_id='',
  def_team_id='',
  league_id='00',
  off_player_id='',
  off_team_id='',
  per_mode='Totals',
  season='2020-21',
  season_type='Regular Season'){
  season_type <- gsub(' ','+',season_type)
  version <- "leagueseasonmatchups"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DefPlayerID=", def_player_id,
                     "&DefTeamID=", def_team_id,
                     "&LeagueID=", league_id,
                     "&OffPlayerID=", off_player_id,
                     "&OffTeamID=", off_team_id,
                     "&PerMode=", per_mode,
                     "&Season=", season,
                     "&SeasonType=", season_type)

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
  return(df_list)
}
#' **Get NBA Stats API Matchups Rollup**
#' @name matchupsrollup
NULL
#' @title
#' **Get NBA Stats API Matchups Rollup**
#' @rdname matchupsrollup
#' @author Saiem Gilani
#' @param def_player_id def_player_id
#' @param def_team_id def_team_id
#' @param league_id league_id
#' @param off_player_id off_player_id
#' @param off_team_id off_team_id
#' @param per_mode per_mode
#' @param season season
#' @param season_type season_type
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_matchupsrollup <- function(
  def_player_id='',
  def_team_id='',
  league_id='00',
  off_player_id='',
  off_team_id='',
  per_mode='Totals',
  season='2020-21',
  season_type='Regular Season'){
  season_type <- gsub(' ','+',season_type)
  version <- "matchupsrollup"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?DefPlayerID=", def_player_id,
                     "&DefTeamID=", def_team_id,
                     "&LeagueID=", league_id,
                     "&OffPlayerID=", off_player_id,
                     "&OffTeamID=", off_team_id,
                     "&PerMode=", per_mode,
                     "&Season=", season,
                     "&SeasonType=", season_type)

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
  return(df_list)
}

