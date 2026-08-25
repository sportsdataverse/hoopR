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
#' @return A `hoopR_data` tibble with one row per game (key columns; period-point
#'   arrays are returned as list-columns):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData game id. \cr
#'       source_id \tab character \tab Source (ESPN) game id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       season_type \tab character \tab Season type. \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       neutral_site \tab logical \tab Whether the game was at a neutral site. \cr
#'       conference_game \tab logical \tab Whether the game was a conference game. \cr
#'       status \tab character \tab Game status. \cr
#'       home_team_id \tab integer \tab Home team id. \cr
#'       home_team \tab character \tab Home team name. \cr
#'       home_points \tab integer \tab Home team points. \cr
#'       home_winner \tab logical \tab Whether the home team won. \cr
#'       away_team_id \tab integer \tab Away team id. \cr
#'       away_team \tab character \tab Away team name. \cr
#'       away_points \tab integer \tab Away team points. \cr
#'       away_winner \tab logical \tab Whether the away team won. \cr
#'       venue_id \tab integer \tab Venue id. \cr
#'       venue \tab character \tab Venue name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
#' @return A `hoopR_data` tibble with one row per game. The `broadcasts` column is
#'   a nested list of broadcast outlets:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab integer \tab CollegeBasketballData game id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       season_type \tab character \tab Season type. \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       home_team_id \tab integer \tab Home team id. \cr
#'       home_team \tab character \tab Home team name. \cr
#'       away_team_id \tab integer \tab Away team id. \cr
#'       away_team \tab character \tab Away team name. \cr
#'       neutral_site \tab logical \tab Whether the game was at a neutral site. \cr
#'       conference_game \tab logical \tab Whether the game was a conference game. \cr
#'       broadcasts \tab list \tab Nested list of broadcast outlets. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
#' @return A `hoopR_data` tibble with one row per team-game. Per-team statistic
#'   objects (`team_stats`, `opponent_stats`) are flattened into `team_stats_*` /
#'   `opponent_stats_*` columns. Key identifying columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab integer \tab CollegeBasketballData game id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       team_id \tab integer \tab Team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Team conference. \cr
#'       opponent_id \tab integer \tab Opponent team id. \cr
#'       opponent \tab character \tab Opponent team name. \cr
#'       is_home \tab logical \tab Whether the team was home. \cr
#'       neutral_site \tab logical \tab Whether the game was at a neutral site. \cr
#'       game_minutes \tab numeric \tab Total team minutes. \cr
#'       pace \tab numeric \tab Game pace (possessions). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
#' @return A `hoopR_data` tibble with one row per team-game. The `players` column
#'   is a nested list of per-player box scores. Key identifying columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       game_id \tab integer \tab CollegeBasketballData game id. \cr
#'       season \tab integer \tab Season (4-digit ending-year). \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       team_id \tab integer \tab Team id. \cr
#'       team \tab character \tab Team name. \cr
#'       conference \tab character \tab Team conference. \cr
#'       opponent_id \tab integer \tab Opponent team id. \cr
#'       opponent \tab character \tab Opponent team name. \cr
#'       is_home \tab logical \tab Whether the team was home. \cr
#'       game_minutes \tab numeric \tab Total team minutes. \cr
#'       game_pace \tab numeric \tab Game pace (possessions). \cr
#'       players \tab list \tab Nested list of per-player box scores. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
#' @return A `hoopR_data` tibble with one row per game. The `home_team`,
#'   `away_team` and `betting` objects are flattened into `home_team_*`,
#'   `away_team_*` and `betting_*` columns. Key identifying columns:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       id \tab integer \tab CollegeBasketballData game id. \cr
#'       start_date \tab character \tab Game start date (ISO 8601). \cr
#'       tv \tab character \tab Broadcast TV network. \cr
#'       neutral_site \tab logical \tab Whether the game is at a neutral site. \cr
#'       conference_game \tab logical \tab Whether the game is a conference game. \cr
#'       status \tab character \tab Game status. \cr
#'       period \tab integer \tab Current period. \cr
#'       clock \tab character \tab Game clock. \cr
#'       venue \tab character \tab Venue name. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
