#' @title
#' **CBD Games**
#' @rdname cbbd_games_media
#' @description
#' **Get college basketball games from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @param status (*character* optional): One of `scheduled`, `in_progress`,
#'   `final`, `postponed`, `cancelled`.
#' @param tournament (*character* optional): Tournament filter.
#' @eval .returns_rd("cbbd_games", inline = FALSE, unit = "game")
#' @keywords CBD Games
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Games Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_games(season = 2024, team = "Duke"))
#' }
cbbd_games <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                       conference = NULL, start_date_range = NULL, end_date_range = NULL,
                       status = NULL, tournament = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/games", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range,
        status = status, tournament = tournament))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Games from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no games data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD games", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Game Media**
#' @description
#' **Get game broadcast media information from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_games_media", inline = FALSE, unit = "game")
#' @keywords CBD Games
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Games Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_games_media(season = 2024, team = "Duke"))
#' }
cbbd_games_media <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                             conference = NULL, start_date_range = NULL, end_date_range = NULL,
                             tournament = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/games/media", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range, tournament = tournament))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Game Media from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no game media available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD game media", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_games_media
#' @title
#' **CBD Team Box Scores**
#' @description
#' **Get team box score statistics from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_games_teams", inline = FALSE, unit = "team-game")
#' @keywords CBD Games
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Games Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_games_teams(season = 2024, team = "Duke"))
#' }
cbbd_games_teams <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                             conference = NULL, start_date_range = NULL, end_date_range = NULL,
                             tournament = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/games/teams", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range, tournament = tournament))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Team Box Scores from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team box score data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD team box scores", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @rdname cbbd_games_media
#' @title
#' **CBD Player Box Scores**
#' @description
#' **Get player box score statistics from the CollegeBasketballData API.**
#' @eval .returns_rd("cbbd_games_players", inline = FALSE, unit = "team-game")
#' @keywords CBD Games
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Games Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_games_players(season = 2024, team = "Duke"))
#' }
cbbd_games_players <- function(season = most_recent_mbb_season(), season_type = NULL, team = NULL,
                               conference = NULL, start_date_range = NULL, end_date_range = NULL,
                               tournament = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/games/players", query = list(
        season = season, seasonType = season_type, team = team, conference = conference,
        startDateRange = start_date_range, endDateRange = end_date_range, tournament = tournament))
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Player Box Scores from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no player box score data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD player box scores", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Scoreboard**
#' @rdname cbbd_games_media
#' @description
#' **Get the current scoreboard from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter.
#' @eval .returns_rd("cbbd_scoreboard", inline = FALSE, unit = "game")
#' @keywords CBD Games
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Games Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_scoreboard(conference = "ACC"))
#' }
cbbd_scoreboard <- function(conference = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/scoreboard", query = list(conference = conference))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Scoreboard from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no scoreboard data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD scoreboard", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
