#' **Get NBA Stats API Video Details**
#' @name nba_stats_videodetails
NULL
#' @title
#' **Get NBA Stats API Video Details**
#' @rdname nba_stats_videodetails
#' @author Saiem Gilani
#' @param ahead_behind ahead_behind
#' @param clutch_time clutch_time
#' @param context_filter context_filter
#' @param context_measure context_measure
#' @param date_from date_from
#' @param date_to date_to
#' @param end_period end_period
#' @param end_range end_range
#' @param game_id game_id
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param period period
#' @param player_id player_id
#' @param point_diff point_diff
#' @param position position
#' @param range_type range_type
#' @param rookie_year rookie_year
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param start_period start_period
#' @param start_range start_range
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_videodetails <- function(
  ahead_behind='',
  clutch_time='',
  context_filter = '',
  context_measure = 'FGA',
  date_from = '',
  date_to = '',
  end_period='',
  end_range='',
  game_id='',
  game_segment = '',
  last_n_games=0,
  league_id='00',
  location='',
  month=0,
  opponent_team_id=0,
  outcome='',
  period=0,
  player_id='2544',
  point_diff='',
  position='',
  range_type='',
  rookie_year='',
  season='2020-21',
  season_segment='',
  season_type='Regular Season',
  start_period='',
  start_range='',
  team_id='1610612739',
  vs_conference='',
  vs_division=''){
  season_type <- gsub(' ','+',season_type)
  version <- "videodetails"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?AheadBehind=", ahead_behind,
                     "&ClutchTime=", clutch_time,
                     "&ContextFilter=", context_filter,
                     "&ContextMeasure=", context_measure,
                     "&DateFrom=", date_from,
                     "&DateTo=", date_to,
                     "&EndPeriod=", end_period,
                     "&EndRange=", end_range,
                     "&GameID=", game_id,
                     "&GameSegment=", game_segment,
                     "&LastNGames=", last_n_games,
                     "&LeagueID=", league_id,
                     "&Location=", location,
                     "&Month=", month,
                     "&OpponentTeamID=", opponent_team_id,
                     "&Outcome=", outcome,
                     "&Period=", period,
                     "&PlayerID=", player_id,
                     "&PointDiff=", point_diff,
                     "&Position=", position,
                     "&RangeType=", range_type,
                     "&RookieYear=", rookie_year,
                     "&Season=", season,
                     "&SeasonSegment=", season_segment,
                     "&SeasonType=", season_type,
                     "&StartPeriod=", start_period,
                     "&StartRange=", start_range,
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


#' **Get NBA Stats API Video Events**
#' @name nba_stats_videoevents
NULL
#' @title
#' **Get NBA Stats API Video Events**
#' @rdname nba_stats_videoevents
#' @author Saiem Gilani
#' @param game_id game_id
#' @param game_event_id game_event_id
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_videoevents <- function(
  game_id='0021700807',
  game_event_id='0'){

  version <- "videoevents"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameID=", game_id,
                     "&GameEventID=", game_event_id)

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


#' **Get NBA Stats API Video Events**
#' @name nba_stats_videoevents
NULL
#' @title
#' **Get NBA Stats API Video Events**
#' @rdname nba_stats_videoevents
#' @author Saiem Gilani
#' @param game_date game_date
#' @param league_id league_id
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows
#' @importFrom tidyr unnest unnest_wider everything
#' @import rvest
#' @export
nba_videostatus <- function(
  game_date='2020-08-16',
  league_id='00'){

  version <- "videostatus"
  endpoint <- nba_endpoint(version)

  full_url <- paste0(endpoint,
                     "?GameDate=", game_date,
                     "&LeagueID=", league_id)

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
