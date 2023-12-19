#' **Get NBA Stats API Video Details**
#' @name nba_videodetailsasset
NULL
#' @title
#' **Get NBA Stats API Video Details**
#' @rdname nba_videodetailsasset
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a list of tibbles: videoUrls, playlist
#'
#'    **videoUrls**
#'
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |uuid     |character |
#'    |sdur     |integer   |
#'    |surl     |character |
#'    |sth      |character |
#'    |mdur     |integer   |
#'    |murl     |character |
#'    |mth      |character |
#'    |ldur     |integer   |
#'    |lurl     |character |
#'    |lth      |character |
#'    |vtt      |character |
#'    |scc      |character |
#'    |srt      |character |
#'
#'    **playlist**
#'
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |gi       |character |
#'    |ei       |integer   |
#'    |y        |integer   |
#'    |m        |character |
#'    |d        |character |
#'    |gc       |character |
#'    |p        |integer   |
#'    |dsc      |character |
#'    |ha       |character |
#'    |hid      |integer   |
#'    |va       |character |
#'    |vid      |integer   |
#'    |hpb      |integer   |
#'    |hpa      |integer   |
#'    |vpb      |integer   |
#'    |vpa      |integer   |
#'    |pta      |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Video Functions
#' @details
#' ```r
#'  nba_videodetailsasset(player_id = '2544', team_id = '1610612747')
#' ```
nba_videodetailsasset <- function(
    ahead_behind = '',
    clutch_time = '',
    context_filter = '',
    context_measure = 'FGA',
    date_from = '',
    date_to = '',
    end_period = '',
    end_range = '',
    game_id = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    period = 0,
    player_id = '2544',
    point_diff = '',
    position = '',
    range_type = '',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    start_period = '',
    start_range = '',
    team_id = '1610612747',
    vs_conference = '',
    vs_division = '',
    ...){

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "videodetailsasset"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    AheadBehind = ahead_behind,
    ClutchTime = clutch_time,
    ContextFilter = context_filter,
    ContextMeasure = context_measure,
    DateFrom = date_from,
    DateTo = date_to,
    EndPeriod = end_period,
    EndRange = end_range,
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
    PointDiff = point_diff,
    Position = position,
    RangeType = range_type,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StartPeriod = start_period,
    StartRange = start_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)
      videoUrls <- resp$resultSets$Meta$videoUrls %>%
        data.frame() %>%
        dplyr::as_tibble()
      playlist <- resp$resultSets$playlist %>%
        data.frame() %>%
        dplyr::as_tibble()
      df_list <- c(list(videoUrls), list(playlist))
      names(df_list) <- c("videoUrls", "playlist")

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no video detail assets data available!"))
      if (!exists("df_list")) df_list <- list() # to silence failing tests
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Video Details**
#' @name nba_videodetails
NULL
#' @title
#' **Get NBA Stats API Video Details**
#' @rdname nba_videodetails
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a list of tibbles: videoUrls, playlist
#'
#'    **videoUrls**
#'
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |uuid     |character |
#'    |dur      |logical   |
#'    |stt      |logical   |
#'    |stp      |logical   |
#'    |sth      |logical   |
#'    |stw      |logical   |
#'    |mtt      |logical   |
#'    |mtp      |logical   |
#'    |mth      |logical   |
#'    |mtw      |logical   |
#'    |ltt      |logical   |
#'    |ltp      |logical   |
#'    |lth      |logical   |
#'    |ltw      |logical   |
#'
#'    **playlist**
#'
#'
#'    |col_name |types     |
#'    |:--------|:---------|
#'    |gi       |character |
#'    |ei       |integer   |
#'    |y        |integer   |
#'    |m        |character |
#'    |d        |character |
#'    |gc       |character |
#'    |p        |integer   |
#'    |dsc      |character |
#'    |ha       |character |
#'    |va       |character |
#'    |hpb      |integer   |
#'    |hpa      |integer   |
#'    |vpb      |integer   |
#'    |vpa      |integer   |
#'    |pta      |integer   |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Video Functions
#' @details
#' ```r
#'  nba_videodetails(player_id = '2544', team_id = '1610612747')
#' ```
nba_videodetails <- function(
    ahead_behind = '',
    clutch_time = '',
    context_filter = '',
    context_measure = 'FGA',
    date_from = '',
    date_to = '',
    end_period = '',
    end_range = '',
    game_id = '',
    game_segment = '',
    last_n_games = 0,
    league_id = '00',
    location = '',
    month = 0,
    opponent_team_id = 0,
    outcome = '',
    period = 0,
    player_id = '2544',
    point_diff = '',
    position = '',
    range_type = '',
    rookie_year = '',
    season = year_to_season(most_recent_nba_season() - 1),
    season_segment = '',
    season_type = 'Regular Season',
    start_period = '',
    start_range = '',
    team_id = '1610612747',
    vs_conference = '',
    vs_division = '',
    ...){

  # season_type <- gsub(' ', '+', season_type)
  version <- "videodetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    AheadBehind = ahead_behind,
    ClutchTime = clutch_time,
    ContextFilter = context_filter,
    ContextMeasure = context_measure,
    DateFrom = date_from,
    DateTo = date_to,
    EndPeriod = end_period,
    EndRange = end_range,
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
    PointDiff = point_diff,
    Position = position,
    RangeType = range_type,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StartPeriod = start_period,
    StartRange = start_range,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )
  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)
      videoUrls <- resp$resultSets$Meta$videoUrls %>%
        data.frame() %>%
        dplyr::as_tibble()
      playlist <- resp$resultSets$playlist %>%
        data.frame() %>%
        dplyr::as_tibble()
      df_list <- c(list(videoUrls), list(playlist))
      names(df_list) <- c("videoUrls", "playlist")

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no video details data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Video Events**
#' @name nba_videoevents
NULL
#' @title
#' **Get NBA Stats API Video Events**
#' @rdname nba_videoevents
#' @author Saiem Gilani
#' @param game_id game_id
#' @param game_event_id game_event_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a list of tibbles: videoUrls, playlist
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Video Functions
#' @details
#' ```r
#'  nba_videoevents(game_id = '0021700807', game_event_id = '10')
#' ```
nba_videoevents <- function(
    game_id = '0021700807',
    game_event_id = '10',
    ...){

  version <- "videoevents"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = game_id,
    GameEventID = game_event_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      videoUrls <- resp$resultSets$Meta$videoUrls %>%
        data.frame() %>%
        dplyr::as_tibble()
      playlist <- resp$resultSets$playlist %>%
        data.frame() %>%
        dplyr::as_tibble()

      df_list <- c(list(videoUrls), list(playlist))
      names(df_list) <- c("videoUrls", "playlist")

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no video events data for {game_id} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Video Status**
#' @name nba_videostatus
NULL
#' @title
#' **Get NBA Stats API Video Status**
#' @rdname nba_videostatus
#' @author Saiem Gilani
#' @param game_date game_date
#' @param league_id league_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Return a list of tibbles: VideoStatus
#'
#'    **VideoStatus**
#'
#'
#'    |col_name                  |types     |
#'    |:-------------------------|:---------|
#'    |GAME_ID                   |character |
#'    |GAME_DATE                 |character |
#'    |VISITOR_TEAM_ID           |character |
#'    |VISITOR_TEAM_CITY         |character |
#'    |VISITOR_TEAM_NAME         |character |
#'    |VISITOR_TEAM_ABBREVIATION |character |
#'    |HOME_TEAM_ID              |character |
#'    |HOME_TEAM_CITY            |character |
#'    |HOME_TEAM_NAME            |character |
#'    |HOME_TEAM_ABBREVIATION    |character |
#'    |GAME_STATUS               |character |
#'    |GAME_STATUS_TEXT          |character |
#'    |IS_AVAILABLE              |character |
#'    |PT_XYZ_AVAILABLE          |character |
#'
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Video Functions
#' @details
#' ```r
#'  nba_videostatus(game_date = '2023-03-10', league_id = '00')
#' ```
nba_videostatus <- function(
    game_date = '2023-03-10',
    league_id = '00',
    ...){

  version <- "videostatus"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameDate = game_date,
    LeagueID = league_id
  )

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments or no video status data for {game_date} available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
