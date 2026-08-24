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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       uuid \tab character \tab Uuid. \cr
#'       sdur \tab integer \tab Sdur. \cr
#'       surl \tab character \tab Surl. \cr
#'       sth \tab character \tab Sth. \cr
#'       mdur \tab integer \tab Mdur. \cr
#'       murl \tab character \tab Murl. \cr
#'       mth \tab character \tab Mth. \cr
#'       ldur \tab integer \tab Ldur. \cr
#'       lurl \tab character \tab Lurl. \cr
#'       lth \tab character \tab Lth. \cr
#'       vtt \tab character \tab Vtt. \cr
#'       scc \tab character \tab Scc. \cr
#'       srt \tab character \tab Srt. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **playlist**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       gi \tab character \tab Gi. \cr
#'       ei \tab integer \tab Ei. \cr
#'       y \tab integer \tab Y. \cr
#'       m \tab character \tab M. \cr
#'       d \tab character \tab D. \cr
#'       gc \tab character \tab Gc. \cr
#'       p \tab integer \tab P. \cr
#'       dsc \tab character \tab Dsc. \cr
#'       ha \tab character \tab Ha. \cr
#'       hid \tab integer \tab Hid. \cr
#'       va \tab character \tab Va. \cr
#'       vid \tab integer \tab Vid. \cr
#'       hpb \tab integer \tab Hpb. \cr
#'       hpa \tab integer \tab Hpa. \cr
#'       vpb \tab integer \tab Vpb. \cr
#'       vpa \tab integer \tab Vpa. \cr
#'       pta \tab integer \tab Pta. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
  .args <- mget(setdiff(names(formals()), "..."))

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "videodetailsasset"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
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
  df_list <- list()

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no video detail assets data available!",
      args = .args
    ),
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
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_videodetailsasset()` instead.
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       uuid \tab character \tab Uuid. \cr
#'       dur \tab logical \tab Dur. \cr
#'       stt \tab logical \tab Stt. \cr
#'       stp \tab logical \tab Stp. \cr
#'       sth \tab logical \tab Sth. \cr
#'       stw \tab logical \tab Stw. \cr
#'       mtt \tab logical \tab Mtt. \cr
#'       mtp \tab logical \tab Mtp. \cr
#'       mth \tab logical \tab Mth. \cr
#'       mtw \tab logical \tab Mtw. \cr
#'       ltt \tab logical \tab Ltt. \cr
#'       ltp \tab logical \tab Ltp. \cr
#'       lth \tab logical \tab Lth. \cr
#'       ltw \tab logical \tab Ltw. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'    **playlist**
#'
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       gi \tab character \tab Gi. \cr
#'       ei \tab integer \tab Ei. \cr
#'       y \tab integer \tab Y. \cr
#'       m \tab character \tab M. \cr
#'       d \tab character \tab D. \cr
#'       gc \tab character \tab Gc. \cr
#'       p \tab integer \tab P. \cr
#'       dsc \tab character \tab Dsc. \cr
#'       ha \tab character \tab Ha. \cr
#'       va \tab character \tab Va. \cr
#'       hpb \tab integer \tab Hpb. \cr
#'       hpa \tab integer \tab Hpa. \cr
#'       vpb \tab integer \tab Vpb. \cr
#'       vpa \tab integer \tab Vpa. \cr
#'       pta \tab integer \tab Pta. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_videodetails()",
    with = "nba_videodetailsasset()",
    details = "Live re-probe (2026-08-24, residential IP) returned an empty response body; confirmed defunct upstream. nba_videodetailsasset() serves the equivalent live data."
  )

  # season_type <- gsub(' ', '+', season_type)
  version <- "videodetails"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
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
  df_list <- list()

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no video details data available!",
      args = .args
    ),
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
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "videoevents"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = game_id,
    GameEventID = game_event_id
  )

  df_list <- list()

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
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no video events data for {game_id} available!",
      args = .args
    ),
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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       GAME_ID \tab character \tab Unique game identifier. \cr
#'       GAME_DATE \tab character \tab Game date (YYYY-MM-DD). \cr
#'       VISITOR_TEAM_ID \tab character \tab  \cr
#'       VISITOR_TEAM_CITY \tab character \tab  \cr
#'       VISITOR_TEAM_NAME \tab character \tab  \cr
#'       VISITOR_TEAM_ABBREVIATION \tab character \tab  \cr
#'       HOME_TEAM_ID \tab character \tab Unique identifier for the home team. \cr
#'       HOME_TEAM_CITY \tab character \tab Home team city / location. \cr
#'       HOME_TEAM_NAME \tab character \tab Home team name. \cr
#'       HOME_TEAM_ABBREVIATION \tab character \tab  \cr
#'       GAME_STATUS \tab character \tab Game status label. \cr
#'       GAME_STATUS_TEXT \tab character \tab Game status display text (e.g. 'Final', '4:32 - 4th'). \cr
#'       IS_AVAILABLE \tab character \tab  \cr
#'       PT_XYZ_AVAILABLE \tab character \tab Pt xyz available. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
  .args <- mget(setdiff(names(formals()), "..."))

  version <- "videostatus"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    GameDate = game_date
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no video status data for {game_date} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Video Events Asset**
#' @name nba_videoeventsasset
NULL
#' @title
#' **Get NBA Stats API Video Events Asset**
#' @rdname nba_videoeventsasset
#' @author Saiem Gilani
#' @param game_id Game ID - 10-digit zero-padded ID (e.g., '0021700807')
#' @param game_event_id Game Event ID - event number from play-by-play data
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a named list containing video event asset data (structure varies by response)
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Video Functions
#' @details
#' (Possibly Defunct)
#' ```r
#'  nba_videoeventsasset(game_id = '0021700807', game_event_id = 10)
#' ```
nba_videoeventsasset <- function(
    game_id,
    game_event_id = 0,
    ...){
  .args <- mget(setdiff(names(formals()), "..."))

  lifecycle::deprecate_warn(
    when = "3.1.0",
    what = "nba_videoeventsasset()",
    details = "The videoeventsasset endpoint returns HTTP 200 but zero rows across multiple game/event IDs (2026-08-24 residential-IP probe sweep). The endpoint no longer serves NBA data; no direct replacement exists (nba_videodetailsasset() serves the analogous live data). This is a soft warning -- the call still proceeds."
  )

  version <- "videoeventsasset"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = game_id,
    GameEventID = game_event_id
  )

  df_list <- list()

  tryCatch(
    expr = {

      resp <- request_with_proxy(url = full_url, params = params, ...)

      if ("resultSets" %in% names(resp) || "resultSet" %in% names(resp)) {
        df_list <- nba_stats_map_result_sets(resp)
      } else {
        df_list <- resp
      }

    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no video events asset data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
