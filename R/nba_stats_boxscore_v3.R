#' **Get NBA Stats API Boxscore Traditional V3**
#' @name nba_boxscoretraditionalv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Traditional V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param game_id Game ID - 10-digit zero-padded ID (e.g., '0022200021')
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoretraditionalv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoretraditionalv3(game_id = "0022200021")
#' ```
nba_boxscoretraditionalv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoretraditionalv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreTraditional") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_starters <- home_team_data %>%
        purrr::pluck("starters") %>%
        data.frame()

      home_team_bench <- home_team_data %>%
        purrr::pluck("bench") %>%
        data.frame()

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_starters <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_starters) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Starters Boxscore Information from NBA.com", Sys.time())

      home_team_bench <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_bench) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Bench Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_starters <- away_team_data %>%
        purrr::pluck("starters") %>%
        data.frame()

      away_team_bench <- away_team_data %>%
        purrr::pluck("bench") %>%
        data.frame()

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_starters <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_starters) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Starters Boxscore Information from NBA.com", Sys.time())

      away_team_bench <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_bench) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Bench Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals),
        list(home_team_starters),
        list(away_team_starters),
        list(home_team_bench),
        list(away_team_bench)
      )
      names(df_list) <- c(
        "home_team_player_traditional",
        "away_team_player_traditional",
        "home_team_totals_traditional",
        "away_team_totals_traditional",
        "home_team_starters_totals",
        "away_team_starters_totals",
        "home_team_bench_totals",
        "away_team_bench_totals"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no traditional boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Advanced V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreadvancedv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreadvancedv3(game_id = "0022200021")
#' ```
nba_boxscoreadvancedv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoreadvancedv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreAdvanced") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_advanced",
        "away_team_player_advanced",
        "home_team_totals_advanced",
        "away_team_totals_advanced"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no advanced boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' @title
#' **Get NBA Stats API Boxscore Misc V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoremiscv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoremiscv3(game_id = "0022200021")
#' ```
nba_boxscoremiscv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoremiscv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreMisc") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_misc",
        "away_team_player_misc",
        "home_team_totals_misc",
        "away_team_totals_misc"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no misc boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Scoring V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorescoringv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorescoringv3(game_id = "0022200021")
#' ```
nba_boxscorescoringv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscorescoringv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreScoring") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_scoring",
        "away_team_player_scoring",
        "home_team_totals_scoring",
        "away_team_totals_scoring"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no scoring boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Usage V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreusagev3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreusagev3(game_id = "0022200021")
#' ```
nba_boxscoreusagev3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoreusagev3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreUsage") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_usage",
        "away_team_player_usage",
        "home_team_totals_usage",
        "away_team_totals_usage"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no usage boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Four Factors V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorefourfactorsv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorefourfactorsv3(game_id = "0022200021")
#' ```
nba_boxscorefourfactorsv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscorefourfactorsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreFourFactors") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_four_factors",
        "away_team_player_four_factors",
        "home_team_totals_four_factors",
        "away_team_totals_four_factors"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no four factors boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Player Tracking V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoreplayertrackv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoreplayertrackv3(game_id = "0022200021")
#' ```
nba_boxscoreplayertrackv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoreplayertrackv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScorePlayerTrack") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_player_track",
        "away_team_player_player_track",
        "home_team_totals_player_track",
        "away_team_totals_player_track"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no player tracking boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Matchups V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorematchupsv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorematchupsv3(game_id = "0022200021")
#' ```
nba_boxscorematchupsv3 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscorematchupsv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreMatchups") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("matchups", names_sep = "_") %>%
        tidyr::unnest("matchups_statistics")

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("matchups", names_sep = "_") %>%
        tidyr::unnest("matchups_statistics")

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players)
      )
      names(df_list) <- c(
        "home_team_player_matchups",
        "away_team_player_matchups"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no matchups boxscore v3 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' **Get NBA Stats API Boxscore Hustle V2**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_boxscorehustlev2
NULL
#' @title
#' **Get NBA Stats API Boxscore Hustle V2**
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' NBA Stats no longer returns stable data for this V2 endpoint.
#' This function is deprecated and now errors when called.
#' Use `nba_hustlestatsboxscore()` instead.
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscorehustlev2")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscorehustlev2(game_id = "0022200021")
#' ```
nba_boxscorehustlev2 <- function(
    game_id = "0022200021",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  lifecycle::deprecate_stop(
    when = "3.0.0",
    what = "nba_boxscorehustlev2()",
    with = "nba_hustlestatsboxscore()",
    details = "Live re-probe (2026-08-24, residential IP) confirms the endpoint still responds, but this wrapper's boxScoreHustle parsing errors on the current payload shape (mismatched row counts across statistics/players); not restored. Tracked as a follow-up parser fix."
  )

  version <- "boxscorehustlev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )
  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      box_score_hustle <- resp %>%
        purrr::pluck("boxScoreHustle")

      ids_df <- box_score_hustle %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_hustle <- box_score_hustle %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_hustle %>% purrr::pluck("teamId"),
        team_name = home_team_hustle %>% purrr::pluck("teamName"),
        team_city = home_team_hustle %>% purrr::pluck("teamCity"),
        team_tricode = home_team_hustle %>% purrr::pluck("teamTricode"),
        team_slug = home_team_hustle %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_hustle %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_hustle %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Hustle Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Hustle Boxscore Information from NBA.com", Sys.time())

      away_team_hustle <- box_score_hustle %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_hustle %>% purrr::pluck("teamId"),
        team_name = away_team_hustle %>% purrr::pluck("teamName"),
        team_city = away_team_hustle %>% purrr::pluck("teamCity"),
        team_tricode = away_team_hustle %>% purrr::pluck("teamTricode"),
        team_slug = away_team_hustle %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_hustle %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_hustle %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Hustle Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Hustle Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_hustle",
        "away_team_player_hustle",
        "home_team_totals_hustle",
        "away_team_totals_hustle"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no hustle stats boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}

#' @title
#' **Get NBA Stats API Boxscore Defensive V2**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param start_period Start period filter - default: 0
#' @param end_period End period filter - default: 0
#' @param start_range Start range filter (in tenths of a second) - default: 0
#' @param end_range End range filter (in tenths of a second) - default: 0
#' @param range_type Range type - 0: by half, 1: by period, 2: custom range
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoredefensivev2")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoredefensivev2(game_id = "0022200021")
#' ```
nba_boxscoredefensivev2 <- function(
    game_id = "0022200021",
    start_period = 0,
    end_period = 14,
    start_range = 0,
    end_range = 0,
    range_type = 0,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoredefensivev2"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    EndPeriod = end_period,
    EndRange = end_range,
    GameID = pad_id(game_id),
    RangeType = range_type,
    StartPeriod = start_period,
    StartRange = start_range
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      data <- resp %>%
        purrr::pluck("boxScoreDefensive") %>%
        dplyr::as_tibble()

      ids_df <- data %>%
        data.frame() %>%
        dplyr::select("gameId", "awayTeamId", "homeTeamId") %>%
        dplyr::distinct()

      home_team_data <- data %>%
        purrr::pluck("homeTeam")

      home_team_info <- data.frame(
        team_id = home_team_data %>% purrr::pluck("teamId"),
        team_name = home_team_data %>% purrr::pluck("teamName"),
        team_city = home_team_data %>% purrr::pluck("teamCity"),
        team_tricode = home_team_data %>% purrr::pluck("teamTricode"),
        team_slug = home_team_data %>% purrr::pluck("teamSlug")
      )

      home_team_totals <- home_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      home_team_players <- home_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      home_team_totals <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Team Boxscore Information from NBA.com", Sys.time())

      home_team_players <- ids_df %>%
        dplyr::bind_cols(home_team_info) %>%
        dplyr::bind_cols(home_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Home Player Boxscore Information from NBA.com", Sys.time())


      away_team_data <- data %>%
        purrr::pluck("awayTeam")

      away_team_info <- data.frame(
        team_id = away_team_data %>% purrr::pluck("teamId"),
        team_name = away_team_data %>% purrr::pluck("teamName"),
        team_city = away_team_data %>% purrr::pluck("teamCity"),
        team_tricode = away_team_data %>% purrr::pluck("teamTricode"),
        team_slug = away_team_data %>% purrr::pluck("teamSlug")
      )

      away_team_totals <- away_team_data %>%
        purrr::pluck("statistics") %>%
        data.frame(stringsAsFactors = F)

      away_team_players <- away_team_data %>%
        purrr::pluck("players") %>%
        data.frame(stringsAsFactors = F) %>%
        tidyr::unnest("statistics")

      away_team_totals <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_totals) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Team Boxscore Information from NBA.com", Sys.time())

      away_team_players <- ids_df %>%
        dplyr::bind_cols(away_team_info) %>%
        dplyr::bind_cols(away_team_players) %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Away Player Boxscore Information from NBA.com", Sys.time())

      df_list <- c(
        list(home_team_players),
        list(away_team_players),
        list(home_team_totals),
        list(away_team_totals)
      )
      names(df_list) <- c(
        "home_team_player_defensive",
        "away_team_player_defensive",
        "home_team_totals_defensive",
        "away_team_totals_defensive"
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no defensive boxscore v2 data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Game Rotation**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_gamerotation
NULL
#' @title
#' **Get NBA Stats API Game Rotation**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param league_id League ID
#' @param rotation_stat Rotation stat to provide details on: PLAYER_PTS, PT_DIFF, USG_PCT
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_gamerotation", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore Functions
#' @family NBA Lineup Functions
#' @details
#' ```r
#'  nba_gamerotation(game_id = "0022200021")
#' ```
nba_gamerotation <- function(
    game_id,
    league_id = "00",
    rotation_stat = "PLAYER_PTS",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "gamerotation"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  # stats.nba.com's edge rejects this endpoint (empty 500 / stall) unless
  # GameID precedes LeagueID in the query string; RotationStat stays last.
  params <- list(
    GameID = pad_id(game_id),
    LeagueID = league_id,
    RotationStat = rotation_stat
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- purrr::map(seq_along(resp$resultSets$name), function(x) {
        data <- resp$resultSets$rowSet[[x]] %>%
          data.frame(stringsAsFactors = F) %>%
          as_tibble()

        json_names <- resp$resultSets$headers[[x]]
        colnames(data) <- json_names
        return(data)
      })
      names(df_list) <- resp$resultSets$name
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no game rotation data for {game_id} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoretraditionalv3
#' @name nba_boxscoresummaryv3
NULL
#' @title
#' **Get NBA Stats API Boxscore Summary V3**
#' @rdname nba_boxscoretraditionalv3
#' @author Saiem Gilani
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_boxscoresummaryv3")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Boxscore V3 Functions
#' @details
#' ```r
#'  nba_boxscoresummaryv3(game_id = "0022200021")
#' ```
nba_boxscoresummaryv3 <- function(
    game_id = "0022200021",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "boxscoresummaryv3"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    GameID = pad_id(game_id)
  )

  data <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      summary_data <- resp %>%
        purrr::pluck("boxScoreSummary")

      game_id_val <- summary_data$gameId

      # GameSummary
      game_summary <- data.frame(
        gameId = game_id_val,
        gameCode = summary_data$gameCode %||% NA_character_,
        gameStatus = summary_data$gameStatus %||% NA_integer_,
        gameStatusText = summary_data$gameStatusText %||% NA_character_,
        period = summary_data$period %||% NA_integer_,
        gameClock = summary_data$gameClock %||% NA_character_,
        gameTimeUTC = summary_data$gameTimeUTC %||% NA_character_,
        gameEt = summary_data$gameEt %||% NA_character_,
        awayTeamId = summary_data$awayTeamId %||% NA_integer_,
        homeTeamId = summary_data$homeTeamId %||% NA_integer_,
        duration = summary_data$duration %||% NA_integer_,
        attendance = summary_data$attendance %||% NA_integer_,
        sellout = summary_data$sellout %||% NA_character_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Summary from NBA.com", Sys.time())

      # GameInfo
      game_info <- data.frame(
        gameId = game_id_val,
        gameDate = summary_data$gameEt %||% NA_character_,
        attendance = summary_data$attendance %||% NA_integer_,
        gameDuration = summary_data$duration %||% NA_integer_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Game Info from NBA.com", Sys.time())

      # ArenaInfo
      arena <- summary_data$arena %||% list()
      arena_info <- data.frame(
        gameId = game_id_val,
        arenaId = arena$arenaId %||% NA_integer_,
        arenaName = arena$arenaName %||% NA_character_,
        arenaCity = arena$arenaCity %||% NA_character_,
        arenaState = arena$arenaState %||% NA_character_,
        arenaCountry = arena$arenaCountry %||% NA_character_,
        arenaTimezone = arena$arenaTimezone %||% NA_character_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Arena Info from NBA.com", Sys.time())

      # Officials
      officials_list <- summary_data$officials %||% list()
      if (length(officials_list) > 0) {
        officials <- data.frame(officials_list, stringsAsFactors = FALSE) %>%
          dplyr::as_tibble() %>%
          dplyr::mutate(gameId = game_id_val) %>%
          dplyr::select("gameId", dplyr::everything()) %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Officials from NBA.com", Sys.time())
      } else {
        officials <- dplyr::tibble(
          game_id = character(),
          person_id = integer(),
          name = character(),
          name_i = character(),
          first_name = character(),
          family_name = character(),
          jersey_num = character()
        ) %>%
          make_hoopR_data("NBA Officials from NBA.com", Sys.time())
      }

      # LineScore - extract home and away
      line_score_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- summary_data[[team_key]] %||% list()
        periods <- team$periods %||% data.frame(stringsAsFactors = FALSE)
        period_scores <- c(NA_integer_, NA_integer_, NA_integer_, NA_integer_)
        if (is.data.frame(periods) && nrow(periods) > 0) {
          for (i in seq_len(nrow(periods))) {
            pnum <- periods$period[[i]] %||% 0
            if (pnum >= 1 && pnum <= 4) {
              period_scores[pnum] <- periods$score[[i]] %||% NA_integer_
            }
          }
        } else if (is.list(periods) && length(periods) > 0) {
          for (p in periods) {
            pnum <- p$period %||% 0
            if (pnum >= 1 && pnum <= 4) {
              period_scores[pnum] <- p$score %||% NA_integer_
            }
          }
        }
        line_score_rows[[team_key]] <- data.frame(
          gameId = game_id_val,
          teamId = team$teamId %||% NA_integer_,
          teamCity = team$teamCity %||% NA_character_,
          teamName = team$teamName %||% NA_character_,
          teamTricode = team$teamTricode %||% NA_character_,
          teamSlug = team$teamSlug %||% NA_character_,
          teamWins = team$teamWins %||% NA_integer_,
          teamLosses = team$teamLosses %||% NA_integer_,
          period1_score = period_scores[1],
          period2_score = period_scores[2],
          period3_score = period_scores[3],
          period4_score = period_scores[4],
          score = team$score %||% NA_integer_,
          stringsAsFactors = FALSE
        )
      }
      line_score <- dplyr::bind_rows(line_score_rows) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Line Score from NBA.com", Sys.time())

      # InactivePlayers
      inactive_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- summary_data[[team_key]] %||% list()
        team_id <- team$teamId %||% NA_integer_
        inactives <- team$inactives %||% data.frame(stringsAsFactors = FALSE)

        if (is.data.frame(inactives) && nrow(inactives) > 0) {
          inactive_df <- data.frame(
            gameId = game_id_val,
            teamId = team_id,
            personId = inactives$personId %||% rep(NA_integer_, nrow(inactives)),
            firstName = inactives$firstName %||% rep(NA_character_, nrow(inactives)),
            familyName = inactives$familyName %||% rep(NA_character_, nrow(inactives)),
            jerseyNum = inactives$jerseyNum %||% rep(NA_character_, nrow(inactives)),
            stringsAsFactors = FALSE
          )

          inactive_rows[[length(inactive_rows) + 1]] <- inactive_df
        } else if (is.list(inactives) && length(inactives) > 0) {
          for (inactive in inactives) {
            inactive_rows[[length(inactive_rows) + 1]] <- data.frame(
              gameId = game_id_val,
              teamId = team_id,
              personId = inactive$personId %||% NA_integer_,
              firstName = inactive$firstName %||% NA_character_,
              familyName = inactive$familyName %||% NA_character_,
              jerseyNum = inactive$jerseyNum %||% NA_character_,
              stringsAsFactors = FALSE
            )
          }
        }
      }
      if (length(inactive_rows) > 0) {
        inactive_players <- dplyr::bind_rows(inactive_rows) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Inactive Players from NBA.com", Sys.time())
      } else {
        inactive_players <- dplyr::tibble(
          game_id = character(),
          team_id = integer(),
          person_id = integer(),
          first_name = character(),
          family_name = character(),
          jersey_num = character()
        ) %>%
          make_hoopR_data("NBA Inactive Players from NBA.com", Sys.time())
      }

      # LastFiveMeetings
      meetings <- summary_data$lastFiveMeetings$meetings %||% data.frame(stringsAsFactors = FALSE)
      if (is.data.frame(meetings) && nrow(meetings) > 0) {
        away <- meetings$awayTeam %||% data.frame(stringsAsFactors = FALSE)
        home <- meetings$homeTeam %||% data.frame(stringsAsFactors = FALSE)
        n_meetings <- nrow(meetings)

        last_five_meetings <- data.frame(
          recencyOrder = meetings$recencyOrder %||% rep(NA_integer_, n_meetings),
          gameId = meetings$gameId %||% rep(NA_character_, n_meetings),
          gameTimeUTC = meetings$gameTimeUTC %||% rep(NA_character_, n_meetings),
          gameEt = meetings$gameEt %||% rep(NA_character_, n_meetings),
          gameStatus = meetings$gameStatus %||% rep(NA_integer_, n_meetings),
          gameStatusText = meetings$gameStatusText %||% rep(NA_character_, n_meetings),
          awayTeamId = away$teamId %||% rep(NA_integer_, n_meetings),
          awayTeamCity = away$teamCity %||% rep(NA_character_, n_meetings),
          awayTeamName = away$teamName %||% rep(NA_character_, n_meetings),
          awayTeamTricode = away$teamTricode %||% rep(NA_character_, n_meetings),
          awayTeamScore = away$score %||% rep(NA_integer_, n_meetings),
          awayTeamWins = away$wins %||% rep(NA_integer_, n_meetings),
          awayTeamLosses = away$losses %||% rep(NA_integer_, n_meetings),
          homeTeamId = home$teamId %||% rep(NA_integer_, n_meetings),
          homeTeamCity = home$teamCity %||% rep(NA_character_, n_meetings),
          homeTeamName = home$teamName %||% rep(NA_character_, n_meetings),
          homeTeamTricode = home$teamTricode %||% rep(NA_character_, n_meetings),
          homeTeamScore = home$score %||% rep(NA_integer_, n_meetings),
          homeTeamWins = home$wins %||% rep(NA_integer_, n_meetings),
          homeTeamLosses = home$losses %||% rep(NA_integer_, n_meetings),
          stringsAsFactors = FALSE
        ) %>%
          dplyr::as_tibble() %>%
          janitor::clean_names() %>%
          make_hoopR_data("NBA Last Five Meetings from NBA.com", Sys.time())
      } else {
        last_five_meetings <- dplyr::tibble() %>%
          make_hoopR_data("NBA Last Five Meetings from NBA.com", Sys.time())
      }

      # OtherStats (postgameCharts)
      postgame <- summary_data$postgameCharts %||% list()
      other_rows <- list()
      for (team_key in c("homeTeam", "awayTeam")) {
        team <- postgame[[team_key]] %||% list()
        stats <- team$statistics %||% list()
        other_rows[[team_key]] <- data.frame(
          gameId = game_id_val,
          teamId = team$teamId %||% NA_integer_,
          teamCity = team$teamCity %||% NA_character_,
          teamName = team$teamName %||% NA_character_,
          teamTricode = team$teamTricode %||% NA_character_,
          points = stats$points %||% NA_integer_,
          reboundsTotal = stats$reboundsTotal %||% NA_integer_,
          assists = stats$assists %||% NA_integer_,
          steals = stats$steals %||% NA_integer_,
          blocks = stats$blocks %||% NA_integer_,
          turnovers = stats$turnovers %||% NA_integer_,
          fieldGoalsPercentage = stats$fieldGoalsPercentage %||% NA_real_,
          threePointersPercentage = stats$threePointersPercentage %||% NA_real_,
          freeThrowsPercentage = stats$freeThrowsPercentage %||% NA_real_,
          pointsInThePaint = stats$pointsInThePaint %||% NA_integer_,
          pointsSecondChance = stats$pointsSecondChance %||% NA_integer_,
          pointsFastBreak = stats$pointsFastBreak %||% NA_integer_,
          biggestLead = stats$biggestLead %||% NA_integer_,
          leadChanges = stats$leadChanges %||% NA_integer_,
          timesTied = stats$timesTied %||% NA_integer_,
          biggestScoringRun = stats$biggestScoringRun %||% NA_integer_,
          turnoversTeam = stats$turnoversTeam %||% NA_integer_,
          turnoversTotal = stats$turnoversTotal %||% NA_integer_,
          reboundsTeam = stats$reboundsTeam %||% NA_integer_,
          pointsFromTurnovers = stats$pointsFromTurnovers %||% NA_integer_,
          benchPoints = stats$benchPoints %||% NA_integer_,
          stringsAsFactors = FALSE
        )
      }
      other_stats <- dplyr::bind_rows(other_rows) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Other Stats from NBA.com", Sys.time())

      # AvailableVideo
      available_video <- data.frame(
        gameId = game_id_val,
        videoAvailableFlag = summary_data$videoAvailableFlag %||% NA_integer_,
        ptAvailable = summary_data$ptAvailable %||% NA_integer_,
        ptXYZAvailable = summary_data$ptXYZAvailable %||% NA_integer_,
        whStatus = summary_data$whStatus %||% NA_integer_,
        hustleStatus = summary_data$hustleStatus %||% NA_integer_,
        historicalStatus = summary_data$historicalStatus %||% NA_integer_,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        janitor::clean_names() %>%
        make_hoopR_data("NBA Available Video from NBA.com", Sys.time())

      data <- list(
        GameSummary = game_summary,
        GameInfo = game_info,
        ArenaInfo = arena_info,
        Officials = officials,
        LineScore = line_score,
        InactivePlayers = inactive_players,
        LastFiveMeetings = last_five_meetings,
        OtherStats = other_stats,
        AvailableVideo = available_video
      )
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no boxscore summary V3 data for {pad_id(game_id)} available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(data)
}
