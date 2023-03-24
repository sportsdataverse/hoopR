#' **Get NBA Stats API Shot Chart Detail**
#' @name nba_shotchartdetail
NULL
#' @title
#' **Get NBA Stats API Shot Chart Detail**
#' @rdname nba_shotchartdetail
#' @author Saiem Gilani
#' @param context_measure context_measure
#' @param date_from date_from
#' @param date_to date_to
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
#' @param player_position player_position
#' @param rookie_year rookie_year
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: LeagueAverages, Shot_Chart_Detail
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_shotchartdetail(league_id = '00', player_id = '202696', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_shotchartdetail <- function(
    context_measure = 'FGA',
    date_from = '',
    date_to = '',
    game_id = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    period = 0,
    player_id = '202696',
    player_position = '',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    team_id = 0,
    vs_conference = '',
    vs_division = '',
    ...){


  season_type <- gsub(' ','+',season_type)
  version <- "shotchartdetail"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    ContextMeasure = context_measure,
    DateFrom = date_from,
    DateTo = date_to,
    GameID = game_id,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    Period = period,
    PlayerID = player_id,
    PlayerPosition = player_position,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no shot chart detail data for {player_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Shot Chart League-Wide**
#' @name nba_shotchartleaguewide
NULL
#' @title
#' **Get NBA Stats API Shot Chart League-Wide**
#' @rdname nba_shotchartleaguewide
#' @author Saiem Gilani
#' @param league_id League - default: '00'. Other options include '10': WNBA, '20': G-League
#' @param season season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: League_Wide
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_shotchartleaguewide(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_shotchartleaguewide <- function(
    league_id = '00',
    season = year_to_season(most_recent_nba_season() - 1),
    ...){

  version <- "shotchartleaguewide"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no league-wide shot chart data for {season} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Shot Chart for Lineups**
#' @name nba_shotchartlineupdetail
NULL
#' @title
#' **Get NBA Stats API Shot Chart for Lineups**
#' @rdname nba_shotchartlineupdetail
#' @author Saiem Gilani
#' @param ahead_behind ahead_behind
#' @param cfid cfid
#' @param cfparams cfparams
#' @param clutch_time clutch_time
#' @param conference conference
#' @param context_filter context_filter
#' @param context_measure context_measure
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param end_period end_period
#' @param end_range end_range
#' @param group_id group_id
#' @param game_event_id game_event_id
#' @param game_id game_id
#' @param game_segment game_segment
#' @param group_id2 group_id2
#' @param group_mode group_mode
#' @param group_quantity group_quantity
#' @param last_n_games last_n_games
#' @param league_id league_id
#' @param location location
#' @param month month
#' @param on_off on_off
#' @param opp_player_id opp_player_id
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param period period
#' @param player_id player_id
#' @param player_id1 player_id1
#' @param player_id2 player_id2
#' @param player_id3 player_id3
#' @param player_id4 player_id4
#' @param player_id5 player_id5
#' @param player_position player_position
#' @param point_diff point_diff
#' @param position position
#' @param range_type range_type
#' @param rookie_year rookie_year
#' @param season season
#' @param season_segment season_segment
#' @param season_type season_type
#' @param shot_clock_range shot_clock_range
#' @param start_period start_period
#' @param start_range start_range
#' @param starter_bench starter_bench
#' @param team_id team_id
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id1 vs_player_id1
#' @param vs_player_id2 vs_player_id2
#' @param vs_player_id3 vs_player_id3
#' @param vs_player_id4 vs_player_id4
#' @param vs_player_id5 vs_player_id5
#' @param vs_team_id vs_team_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a named list of data frames: League_Wide
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @details
#' ```r
#'  nba_shotchartlineupdetail(group_id = '-202689-203493-203501-1626174-1627827-',
#'                            group_id2 = '-202689-203493-203501-1626174-1627827-',
#'                            season = year_to_season(most_recent_nba_season() - 1))
#' ```
nba_shotchartlineupdetail <- function(
    ahead_behind = '',
    cfid = '',
    cfparams = '',
    clutch_time = '',
    conference = '',
    context_filter = '',
    context_measure = 'FGA',
    date_from = '',
    date_to = '',
    division = '',
    end_period = '10',
    end_range = '28800',
    group_id = '-202689-203493-203501-1626174-1627827-',
    game_event_id = '',
    game_id = '',
    game_segment = '',
    group_id2 = '-202689-203493-203501-1626174-1627827-',
    group_mode = '',
    group_quantity = '5',
    last_n_games = '0',
    league_id = '00',
    location = '',
    month = '0',
    on_off = '',
    opp_player_id = '',
    opponent_team_id = '0',
    outcome = '',
    po_round = '0',
    period = '0',
    player_id = '0',
    player_id1 = '',
    player_id2 = '',
    player_id3 = '',
    player_id4 = '',
    player_id5 = '',
    player_position = '',
    point_diff = '',
    position = '',
    range_type = '0',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    shot_clock_range = '',
    start_period = '1',
    start_range = '0',
    starter_bench = '',
    team_id = '1610612742',
    vs_conference = '',
    vs_division = '',
    vs_player_id1 = '',
    vs_player_id2 = '',
    vs_player_id3 = '',
    vs_player_id4 = '',
    vs_player_id5 = '',
    vs_team_id = '',
    ...){
  # season_type <- gsub(' ','+',season_type)
  version <- "shotchartlineupdetail"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    AheadBehind = ahead_behind,
    CFID = cfid,
    CFPARAMS = cfparams,
    ClutchTime = clutch_time,
    Conference = conference,
    ContextFilter = context_filter,
    ContextMeasure = context_measure,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    EndPeriod = end_period,
    EndRange = end_range,
    GROUP_ID = group_id,
    GameEventID = game_event_id,
    GameID = game_id,
    GameSegment = game_segment,
    GroupID = group_id2,
    GroupMode = group_mode,
    GroupQuantity = group_quantity,
    LastNGames = last_n_games,
    LeagueID = league_id,
    Location = location,
    Month = month,
    OnOff = on_off,
    OppPlayerID = opp_player_id,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    Period = period,
    PlayerID = player_id,
    PlayerID1 = player_id1,
    PlayerID2 = player_id2,
    PlayerID3 = player_id3,
    PlayerID4 = player_id4,
    PlayerID5 = player_id5,
    PlayerPosition = player_position,
    PointDiff = point_diff,
    Position = position,
    RangeType = range_type,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    StartPeriod = start_period,
    StartRange = start_range,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsPlayerID1 = vs_player_id1,
    VsPlayerID2 = vs_player_id2,
    VsPlayerID3 = vs_player_id3,
    VsPlayerID4 = vs_player_id4,
    VsPlayerID5 = vs_player_id5,
    VsTeamID = vs_team_id
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no shot chart lineup data available for {season}! (group_id: {group_id})"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

