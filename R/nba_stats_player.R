#' **Get NBA Stats API Player Index**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerindex
NULL
#' @title
#' **Get NBA Stats API Player Index**
#' @rdname nba_infographicfanduelplayer
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
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerindex", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Index](https://www.nba.com/stats/players)
#' ```r
#'  nba_playerindex()
#' ```
nba_playerindex <- function(
    college = "",
    country = "",
    draft_pick = "",
    draft_round = "",
    draft_year = "",
    height = "",
    historical = 1,
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    team_id = "0",
    weight = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerindex"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    Country = country,
    DraftPick = draft_pick,
    DraftRound = draft_round,
    DraftYear = draft_year,
    Height = height,
    Historical = historical,
    Season = season,
    SeasonType = season_type,
    TeamID = team_id,
    Weight = weight
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player index data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Head-shot**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerheadshot
NULL
#' @title
#' **Get NBA Stats API Player Head-shot**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param player_id Player ID
#' @param ... Additional arguments passed to an underlying function like httr.
#' @return Returns a url of the png for the player_id selected
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Headshot](https://cdn.nba.com/headshots/nba/latest/260x190/2544.png)
#' ```r
#'  nba_playerheadshot(player_id = '2544')
#' ```
nba_playerheadshot <- function(
    player_id = "2544",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  endpoint <- "https://cdn.nba.com/headshots/nba/latest/260x190/"

  full_url <- paste0(endpoint, player_id, ".png")

  resp <- NULL

  tryCatch(
    expr = {
      resp <- full_url
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player headshot for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(resp)
}

#' **Get NBA Stats API Player Awards**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerawards
NULL
#' @title
#' **Get NBA Stats API Player Awards**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerawards", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Awards](https://www.nba.com/stats/player/2544/career)
#' ```r
#'  nba_playerawards(player_id = '2544')
#' ```
nba_playerawards <- function(
    player_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "playerawards"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    PlayerID = player_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player awards data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Career By College**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playercareerbycollege
NULL
#' @title
#' **Get NBA Stats API Player Career By College**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use `nba_playercareerbycollegerollup()` instead.
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param per_mode Per Mode - PerGame, Totals
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playercareerbycollege", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' ```r
#'  nba_playercareerbycollege(college = 'Florida State', per_mode = 'PerGame')
#' ```
nba_playercareerbycollege <- function(
    college = "Florida State",
    league_id = "00",
    per_mode = "Totals",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_playercareerbycollege()",
    details = "No direct replacement is available in hoopR for this unstable endpoint. Consider using  `nba_playercareerbycollegerollup()` or `nba_leaguedashplayerbiostats()` for aggregated career stats by college instead."
  )

  college <- gsub(" ", "+", college)
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playercareerbycollege"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    PerMode = per_mode,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or player careers by college data for {college} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Career By College Rollup**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playercareerbycollegerollup
NULL
#' @title
#' **Get NBA Stats API Player Career By College Rollup**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playercareerbycollegerollup", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' ```r
#'  nba_playercareerbycollegerollup(per_mode = 'Totals')
#' ```
nba_playercareerbycollegerollup <- function(
    league_id = "00",
    per_mode = "Totals",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playercareerbycollegerollup"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or player careers by college rollup data for {season} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Career Stats**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playercareerstats
NULL
#' @title
#' **Get NBA Stats API Player Career Stats**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playercareerstats", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Career Stats](https://www.nba.com/stats/player/2544/career)
#' ```r
#'  nba_playercareerstats(player_id = '2544')
#' ```
nba_playercareerstats <- function(
    league_id = "00",
    per_mode = "Totals",
    player_id = "2544",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "playercareerstats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    PlayerID = player_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or player career stats data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API FanDuel Player Infographic**
#' @name nba_infographicfanduelplayer
NULL
#' @title
#' **Get NBA Stats API FanDuel Player Infographic**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param game_id game_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_infographicfanduelplayer", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Fantasy Functions
#' @details
#' ```r
#'  nba_infographicfanduelplayer(game_id = "0022201086")
#' ```
nba_infographicfanduelplayer <- function(
    game_id,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "infographicfanduelplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = game_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no FanDuel player infographic data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Fantasy Profile**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerfantasyprofile
NULL
#' @title
#' **Get NBA Stats API Player Fantasy Profile**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param measure_type measure_type
#' @param pace_adjust Pace Adjustment - Y/N
#' @param plus_minus Plus Minus - Y/N
#' @param rank Rank - Y/N
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerfantasyprofile", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Fantasy Functions
#' @details
#' ```r
#'  nba_playerfantasyprofile(player_id = '2544')
#' ```
nba_playerfantasyprofile <- function(
    league_id = "00",
    measure_type = "Base",
    pace_adjust = "N",
    per_mode = "Totals",
    player_id = "2544",
    plus_minus = "N",
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerfantasyprofile"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    MeasureType = measure_type,
    PaceAdjust = pace_adjust,
    PerMode = per_mode,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player fantasy profile data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}



#' **Get NBA Stats API Player Fantasy Profile Bar Graph**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerfantasyprofilebargraph
NULL
#' @title
#' **Get NBA Stats API Player Fantasy Profile Bar Graph**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerfantasyprofilebargraph", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Fantasy Functions
#' @details
#' ```r
#'  nba_playerfantasyprofilebargraph(player_id = '2544')
#' ```
nba_playerfantasyprofilebargraph <- function(
    league_id = "00",
    player_id = "2544",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerfantasyprofilebargraph"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PlayerID = player_id,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player fantasy profile bar graph data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Estimated Metrics**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerestimatedmetrics
NULL
#' @title
#' **Get NBA Stats API Player Estimated Metrics**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerestimatedmetrics", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Estimated Metrics](https://www.nba.com/stats/players/estimated-advanced)
#' ```r
#'  nba_playerestimatedmetrics()
#' ```
nba_playerestimatedmetrics <- function(
    league_id = "00",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playerestimatedmetrics"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)


      df_list <- purrr::map(seq_along(resp$resultSet$name), function(x) {
        data <- resp$resultSet$rowSet %>%
          data.frame(stringsAsFactors = FALSE) %>%
          dplyr::as_tibble()

        json_names <- resp$resultSet$headers
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSet$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player estimated metrics data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Game Log**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playergamelog
NULL
#' @title
#' **Get NBA Stats API Player Game Log**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playergamelog", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Game Log](https://www.nba.com/stats/player/2544/boxscores-traditional)
#' ```r
#'  nba_playergamelog(player_id = '2544')
#' ```
nba_playergamelog <- function(
    date_from = "",
    date_to = "",
    league_id = "00",
    player_id = "2544",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playergamelog"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    PlayerID = player_id,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player game log data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Player Game Logs**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playergamelogs
NULL
#' @title
#' **Get NBA Stats API Player Game Logs**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param po_round po_round
#' @param period period
#' @param season_segment season_segment
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playergamelogs", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Game Logs](https://www.nba.com/stats/player/2544/boxscores-traditional)
#' ```r
#'  nba_playergamelogs(player_id = '2544')
#' ```
nba_playergamelogs <- function(
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    po_round = "",
    per_mode = "Totals",
    period = 0,
    player_id = "2544",
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = "",
    season_type = "Regular Season",
    team_id = "",
    vs_conference = "",
    vs_division = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playergamelogs"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PORound = po_round,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division
  )


  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player game logs data for {player_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Game Streak Finder**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playergamestreakfinder
NULL
#' @title
#' **Get NBA Stats API Player Game Streak Finder**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param active_streaks_only active_streaks_only
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param division division
#' @param draft_team_id draft_team_id
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
#' @param rookie_year rookie_year
#' @param season_segment season_segment
#' @param starter_bench starter_bench
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_team_id vs_team_id
#' @param years_experience years_experience
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playergamestreakfinder", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @family NBA Game Finder Functions
#' @details
#' ```r
#'  nba_playergamestreakfinder()
#' ```

nba_playergamestreakfinder <- function(
    active_streaks_only = "",
    conference = "",
    date_from = "",
    date_to = "",
    division = "",
    draft_year = "",
    draft_team_id = "",
    draft_round = "",
    draft_number = "",
    et_ast = "",
    et_blk = "",
    et_dd = "",
    et_dreb = "",
    et_fg3a = "",
    et_fg3m = "",
    et_fg3_pct = "",
    et_fga = "",
    et_fgm = "",
    et_fg_pct = "",
    et_fta = "",
    et_ftm = "",
    et_ft_pct = "",
    et_minutes = "",
    et_oreb = "",
    et_pf = "",
    et_pts = "",
    et_reb = "",
    et_stl = "",
    et_td = "",
    et_tov = "",
    game_id = "",
    gt_ast = "",
    gt_blk = "",
    gt_dd = "",
    gt_dreb = "",
    gt_fg3a = "",
    gt_fg3m = "",
    gt_fg3_pct = "",
    gt_fga = "",
    gt_fgm = "",
    gt_fg_pct = "",
    gt_fta = "",
    gt_ftm = "",
    gt_ft_pct = "",
    gt_minutes = "",
    gt_oreb = "",
    gt_pf = "",
    gt_pts = "",
    gt_reb = "",
    gt_stl = "",
    gt_td = "",
    gt_tov = "",
    league_id = "00",
    location = "",
    lt_ast = "",
    lt_blk = "",
    lt_dd = "",
    lt_dreb = "",
    lt_fg3a = "",
    lt_fg3m = "",
    lt_fg3_pct = "",
    lt_fga = "",
    lt_fgm = "",
    lt_fg_pct = "",
    lt_fta = "",
    lt_ftm = "",
    lt_ft_pct = "",
    lt_minutes = "",
    lt_oreb = "",
    lt_pf = "",
    lt_pts = "",
    lt_reb = "",
    lt_stl = "",
    lt_td = "",
    lt_tov = "",
    min_games = "",
    outcome = "",
    po_round = "",
    player_id = "",
    rookie_year = "",
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = "",
    season_type = "Regular Season",
    starter_bench = "",
    team_id = "",
    vs_conference = "",
    vs_division = "",
    vs_team_id = "",
    years_experience = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playergamestreakfinder"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    ActiveStreaksOnly = active_streaks_only,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    Division = division,
    DraftNumber = draft_number,
    DraftRound = draft_round,
    DraftTeamID = draft_team_id,
    DraftYear = draft_year,
    EqAST = et_ast,
    EqBLK = et_blk,
    EqDD = et_dd,
    EqDREB = et_dreb,
    EqFG3A = et_fg3a,
    EqFG3M = et_fg3m,
    EqFG3_PCT = et_fg3_pct,
    EqFGA = et_fga,
    EqFGM = et_fgm,
    EqFG_PCT = et_fg_pct,
    EqFTA = et_fta,
    EqFTM = et_ftm,
    EqFT_PCT = et_ft_pct,
    EqMINUTES = et_minutes,
    EqOREB = et_oreb,
    EqPF = et_pf,
    EqPTS = et_pts,
    EqREB = et_reb,
    EqSTL = et_stl,
    EqTD = et_td,
    EqTOV = et_tov,
    GameID = game_id,
    GtAST = gt_ast,
    GtBLK = gt_blk,
    GtDD = gt_dd,
    GtDREB = gt_dreb,
    GtFG3A = gt_fg3a,
    GtFG3M = gt_fg3m,
    GtFG3_PCT = gt_fg3_pct,
    GtFGA = gt_fga,
    GtFGM = gt_fgm,
    GtFG_PCT = gt_fg_pct,
    GtFTA = gt_fta,
    GtFTM = gt_ftm,
    GtFT_PCT = gt_ft_pct,
    GtMINUTES = gt_minutes,
    GtOREB = gt_oreb,
    GtPF = gt_pf,
    GtPTS = gt_pts,
    GtREB = gt_reb,
    GtSTL = gt_stl,
    GtTD = gt_td,
    GtTOV = gt_tov,
    Location = location,
    LtAST = lt_ast,
    LtBLK = lt_blk,
    LtDD = lt_dd,
    LtDREB = lt_dreb,
    LtFG3A = lt_fg3a,
    LtFG3M = lt_fg3m,
    LtFG3_PCT = lt_fg3_pct,
    LtFGA = lt_fga,
    LtFGM = lt_fgm,
    LtFG_PCT = lt_fg_pct,
    LtFTA = lt_fta,
    LtFTM = lt_ftm,
    LtFT_PCT = lt_ft_pct,
    LtMINUTES = lt_minutes,
    LtOREB = lt_oreb,
    LtPF = lt_pf,
    LtPTS = lt_pts,
    LtREB = lt_reb,
    LtSTL = lt_stl,
    LtTD = lt_td,
    LtTOV = lt_tov,
    MinGames = min_games,
    Outcome = outcome,
    PORound = po_round,
    PlayerID = player_id,
    RookieYear = rookie_year,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    StarterBench = starter_bench,
    TeamID = team_id,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsTeamID = vs_team_id,
    YearsExperience = years_experience
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player streak finder data available for the parameters selected!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Next N Games**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playernextngames
NULL
#' @title
#' **Get NBA Stats API Player Next N Games**
#' @description Deprecated in `hoopR` 3.0.0. This endpoint is unstable/empty; use `nba_playerprofilev2()` instead.
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param number_of_games N in number of games
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playernextngames", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' ```r
#'  nba_playernextngames(player_id = '2544')
#' ```
nba_playernextngames <- function(
    league_id = "",
    number_of_games = 2147483647,
    player_id = "2544",
    season = year_to_season(most_recent_nba_season() - 2),
    season_type = "Regular Season",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_playernextngames()",
    with = "nba_playerprofilev2()"
  )

  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playernextngames"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    NumberOfGames = number_of_games,
    PlayerID = player_id,
    Season = season,
    SeasonType = season_type
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player next n games data available for {player_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}




#' **Get NBA Stats API Player Profile V2**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playerprofilev2
NULL
#' @title
#' **Get NBA Stats API Player Profile V2**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playerprofilev2", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' [Player Profile](https://www.nba.com/stats/player/2544/career)
#' ```r
#'  nba_playerprofilev2(player_id = '2544')
#' ```
nba_playerprofilev2 <- function(
    league_id = "",
    per_mode = "Totals",
    player_id = "2544",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "playerprofilev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    PerMode = per_mode,
    PlayerID = player_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player profile v2 data available for {player_id}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player vs Player**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playervsplayer
NULL
#' @title
#' **Get NBA Stats API Player vs Player**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param period period
#' @param season_segment season_segment
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id vs_player_id
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playervsplayer", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' ```r
#'  nba_playervsplayer(player_id = '2544', vs_player_id = '203076')
#' ```
nba_playervsplayer <- function(
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    pace_adjust = "N",
    per_mode = "Totals",
    period = 0,
    player_id = "2544",
    plus_minus = "N",
    rank = "N",
    season = year_to_season(most_recent_nba_season() - 2),
    season_segment = "",
    season_type = "Regular Season",
    vs_conference = "",
    vs_division = "",
    vs_player_id = "203076",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playervsplayer"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PerMode = per_mode,
    Period = period,
    PlayerID = player_id,
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsPlayerID = vs_player_id
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or player vs player data unavailable for the parameters selected!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Player Compare**
#' @rdname nba_infographicfanduelplayer
#' @name nba_playercompare
NULL
#' @title
#' **Get NBA Stats API Player Compare**
#' @rdname nba_infographicfanduelplayer
#' @author Saiem Gilani
#' @param conference conference
#' @param date_from date_from
#' @param date_to date_to
#' @param game_segment game_segment
#' @param last_n_games last_n_games
#' @param location location
#' @param measure_type measure_type
#' @param month month
#' @param opponent_team_id opponent_team_id
#' @param outcome outcome
#' @param period period
#' @param player_id_list Player ID
#' @param season_segment season_segment
#' @param shot_clock_range shot_clock_range
#' @param vs_conference vs_conference
#' @param vs_division vs_division
#' @param vs_player_id_list vs_player_id_list
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_playercompare", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Player Functions
#' @details
#' ```r
#'  nba_playercompare(player_id_list = '202681,203078,2544,201567,203954', vs_player_id_list = '201566,201939,201935,201142,203076')
#' ```
nba_playercompare <- function(
    conference = "",
    date_from = "",
    date_to = "",
    game_segment = "",
    last_n_games = 0,
    league_id = "00",
    location = "",
    measure_type = "Base",
    month = 0,
    opponent_team_id = 0,
    outcome = "",
    pace_adjust = "N",
    per_mode = "Totals",
    period = 0,
    player_id_list = "202681,203078,2544,201567,203954",
    plus_minus = "N",
    rank = "N",
    season = "2020-21",
    season_segment = "",
    season_type = "Regular Season",
    shot_clock_range = "",
    vs_conference = "",
    vs_division = "",
    vs_player_id_list = "201566,201939,201935,201142,203076",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  # Intentional
  # season_type <- gsub(' ', '+', season_type)
  version <- "playercompare"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    Conference = conference,
    DateFrom = date_from,
    DateTo = date_to,
    GameSegment = game_segment,
    LastNGames = last_n_games,
    Location = location,
    MeasureType = measure_type,
    Month = month,
    OpponentTeamID = opponent_team_id,
    Outcome = outcome,
    PaceAdjust = pace_adjust,
    PerMode = per_mode,
    Period = period,
    PlayerIDList = URLencode(player_id_list),
    PlusMinus = plus_minus,
    Rank = rank,
    Season = season,
    SeasonSegment = season_segment,
    SeasonType = season_type,
    ShotClockRange = shot_clock_range,
    VsConference = vs_conference,
    VsDivision = vs_division,
    VsPlayerIDList = URLencode(vs_player_id_list)
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or player comparison data unavailable for the parameters selected!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
