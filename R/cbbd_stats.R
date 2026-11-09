#' @title
#' **CBD Team Season Stats**
#' @description
#' **Get team season statistics from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @eval .returns_rd("cbbd_stats_team_season", inline = FALSE, unit = "team-season")
#' @keywords CBD Stats
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Stats Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_stats_team_season(season = 2024, team = "Duke"))
#' }
cbbd_stats_team_season <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                                   conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/stats/team/season", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Team Season Stats from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team season stats available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team season stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Team Stats Leaderboard**
#' @rdname cbbd_stats_team_season
#' @description
#' **Get the team statistics leaderboard from the CollegeBasketballData API.**
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @eval .returns_rd("cbbd_stats_team_leaderboard", inline = FALSE, unit = "team")
#' @keywords CBD Stats
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Stats Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_stats_team_leaderboard(season = 2024))
#' }
cbbd_stats_team_leaderboard <- function(season = most_recent_mbb_season(), team = NULL, conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/stats/team/leaderboard", query = list(season = season, team = team, conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Team Stats Leaderboard from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team stats leaderboard available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team stats leaderboard", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_stats_team_season
#' @title
#' **CBD Team Shooting Stats**
#' @description
#' **Get team season shooting statistics from the CollegeBasketballData API.**
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @eval .returns_rd("cbbd_stats_team_shooting_season", inline = FALSE, unit = "team-season")
#' @keywords CBD Stats
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Stats Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_stats_team_shooting_season(season = 2024, team = "Duke"))
#' }
cbbd_stats_team_shooting_season <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                                            conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/stats/team/shooting/season", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Team Shooting Stats from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team shooting stats available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team shooting stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_stats_team_season
#' @title
#' **CBD Player Season Stats**
#' @description
#' **Get player season statistics from the CollegeBasketballData API.**
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @eval .returns_rd("cbbd_stats_player_season", inline = FALSE, unit = "player-season")
#' @keywords CBD Stats
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Stats Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_stats_player_season(season = 2024, team = "Duke"))
#' }
cbbd_stats_player_season <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                                     conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/stats/player/season", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Player Season Stats from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no player season stats available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD player season stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_stats_team_season
#' @title
#' **CBD Player Shooting Stats**
#' @description
#' **Get player season shooting statistics from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_stats_player_shooting_season", inline = FALSE, unit = "player-season")
#' @keywords CBD Stats
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Stats Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_stats_player_shooting_season(season = 2024, team = "Duke"))
#' }
cbbd_stats_player_shooting_season <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                                              conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/stats/player/shooting/season", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Player Shooting Stats from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no player shooting stats available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD player shooting stats", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
