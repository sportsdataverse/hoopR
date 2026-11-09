#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftcombinestats
#' @name nba_draftboard
NULL
#' @title
#' **Get NBA Stats API Draft Board**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param season season
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftboard", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' ```r
#'   nba_draftboard(season = most_recent_nba_season() - 1)
#' ```
nba_draftboard <- function(
    season = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftboard"
  endpoint <- sprintf("https://content-api-prod.nba.com/public/1/leagues/nba/draft/%s/board", season)
  full_url <- endpoint

  params <- list()

  df_list <- list()

  tryCatch(
    expr = {
      res <- .retry_request(full_url, params = params)
      resp <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON() %>%
        purrr::pluck("results")

      first_round_picks <- resp %>%
        purrr::pluck("picks") %>%
        purrr::pluck("firstRound", .default = data.frame()) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names()

      second_round_picks <- resp %>%
        purrr::pluck("picks") %>%
        purrr::pluck("secondRound", .default = data.frame()) %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names()

      picks <- first_round_picks %>%
        dplyr::bind_rows(second_round_picks)

      teams_without_picks_first <- resp %>%
        purrr::pluck("teamsWithoutPicks") %>%
        purrr::pluck("firstRound") %>%
        data.frame()

      teams_without_picks_second <- resp %>%
        purrr::pluck("teamsWithoutPicks") %>%
        purrr::pluck("secondRound") %>%
        data.frame()

      teams_without_picks <- teams_without_picks_first %>%
        dplyr::bind_rows(teams_without_picks_second)

      teams_without_picks <- teams_without_picks %>%
        janitor::clean_names()

      live_details <- data.frame(
        is_draft_live = resp$isDraftLive,
        live_draft_current_pick_number = ifelse(
          is.null(resp$liveDraftCurrentPickNumber), 0, resp$liveDraftCurrentPickNumber
        )
      )

      df_list <- c(list(picks), list(teams_without_picks), list(live_details))
      names(df_list) <- c("Picks", "TeamsWithoutPicks", "LiveDetails")
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft board data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}


#' **Get NBA Stats API Draft Combine Stats**
#' @name nba_draftcombinestats
NULL
#' @title
#' **Get NBA Stats API Draft Combine Stats**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftcombinestats", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' ```r
#'  nba_draftcombinestats(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinestats <- function(
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinestats"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine stats data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Drill Results**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftcombinedrillresults", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombinedrillresults(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinedrillresults <- function(
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinedrillresults"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine drill results data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Non-Stationary Shooting**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftcombinenonstationaryshooting", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Non-stationary Shooting](https://www.nba.com/stats/draft/combine-non-stationary)
#' ```r
#'  nba_draftcombinenonstationaryshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinenonstationaryshooting <- function(
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinenonstationaryshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine stationary shooting data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine Player Anthropological Measurements**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftcombineplayeranthro", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Player Anthro](https://www.nba.com/stats/draft/combine)
#' ```r
#'  nba_draftcombineplayeranthro(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombineplayeranthro <- function(
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombineplayeranthro"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine player anthropological data available for {season_year}!",
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
#' **Get NBA Stats API Draft Combine - Spot Shooting**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param season_year season_year
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_draftcombinespotshooting", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft Combine Spot Shooting](https://www.nba.com/stats/draft/combine-spot-up)
#' ```r
#'  nba_draftcombinespotshooting(season_year = most_recent_nba_season() - 1)
#' ```
nba_draftcombinespotshooting <- function(
    league_id = "00",
    season_year = most_recent_nba_season() - 1,
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "draftcombinespotshooting"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    SeasonYear = season_year
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft combine spot shooting data available for {season_year}!",
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
#' **Get NBA Stats API Draft History**
#' @rdname nba_draftcombinestats
#' @author Saiem Gilani
#' @param league_id league_id
#' @param college college
#' @param overall_pick overall_pick
#' @param round_pick round_pick
#' @param round_num round_num
#' @param season season
#' @param team_id team_id
#' @param top_x top_x
#' @param ... Additional arguments passed to an underlying function like httr.
#' @eval .returns_rd("nba_drafthistory", class = "tibble")
#' @importFrom jsonlite fromJSON toJSON
#' @importFrom dplyr filter select rename bind_cols bind_rows as_tibble
#' @import rvest
#' @export
#' @family NBA Draft Functions
#' @details
#' [Draft History](https://www.nba.com/stats/draft/history)
#' ```r
#'  nba_drafthistory(season = most_recent_nba_season() - 1)
#' ```
nba_drafthistory <- function(
    league_id = "00",
    college = "",
    overall_pick = "",
    round_pick = "",
    round_num = "",
    season = most_recent_nba_season() - 1,
    team_id = "",
    top_x = "",
    ...) {
  .args <- mget(setdiff(names(formals()), "..."))
  version <- "drafthistory"
  endpoint <- nba_endpoint(version)
  full_url <- endpoint

  params <- list(
    LeagueID = league_id,
    College = college,
    OverallPick = overall_pick,
    RoundNum = round_num,
    RoundPick = round_pick,
    Season = season,
    TeamID = team_id,
    TopX = top_x
  )

  df_list <- list()

  tryCatch(
    expr = {
      resp <- request_with_proxy(url = full_url, params = params, ...)

      df_list <- nba_stats_map_result_sets(resp)
    },
    error = function(e) .report_api_error(
      e,
      hint = "Invalid arguments or no draft history data available for {season}!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(df_list)
}
