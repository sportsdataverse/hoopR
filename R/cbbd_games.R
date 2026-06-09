#' @title
#' **CBD Games**
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
#'    |col_name         |types     |description                                |
#'    |:----------------|:---------|:------------------------------------------|
#'    |id               |integer   |CollegeBasketballData game id.             |
#'    |source_id        |character |Source (ESPN) game id.                     |
#'    |season           |integer   |Season (4-digit ending-year).              |
#'    |season_type      |character |Season type.                               |
#'    |start_date       |character |Game start date (ISO 8601).                |
#'    |neutral_site     |logical   |Whether the game was at a neutral site.    |
#'    |conference_game  |logical   |Whether the game was a conference game.    |
#'    |status           |character |Game status.                               |
#'    |home_team_id     |integer   |Home team id.                              |
#'    |home_team        |character |Home team name.                            |
#'    |home_points      |integer   |Home team points.                          |
#'    |home_winner      |logical   |Whether the home team won.                 |
#'    |away_team_id     |integer   |Away team id.                              |
#'    |away_team        |character |Away team name.                            |
#'    |away_points      |integer   |Away team points.                          |
#'    |away_winner      |logical   |Whether the away team won.                 |
#'    |venue_id         |integer   |Venue id.                                  |
#'    |venue            |character |Venue name.                                |
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
#' @inheritParams cbbd_games
#' @return A `hoopR_data` tibble with one row per game. The `broadcasts` column is
#'   a nested list of broadcast outlets:
#'
#'    |col_name        |types     |description                                 |
#'    |:---------------|:---------|:-------------------------------------------|
#'    |game_id         |integer   |CollegeBasketballData game id.              |
#'    |season          |integer   |Season (4-digit ending-year).               |
#'    |season_type     |character |Season type.                                |
#'    |start_date      |character |Game start date (ISO 8601).                 |
#'    |home_team_id    |integer   |Home team id.                               |
#'    |home_team       |character |Home team name.                             |
#'    |away_team_id    |integer   |Away team id.                               |
#'    |away_team       |character |Away team name.                             |
#'    |neutral_site    |logical   |Whether the game was at a neutral site.     |
#'    |conference_game |logical   |Whether the game was a conference game.     |
#'    |broadcasts      |list      |Nested list of broadcast outlets.           |
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

#' @title
#' **CBD Team Box Scores**
#' @description
#' **Get team box score statistics from the CollegeBasketballData API.**
#' @inheritParams cbbd_games
#' @return A `hoopR_data` tibble with one row per team-game. Per-team statistic
#'   objects (`team_stats`, `opponent_stats`) are flattened into `team_stats_*` /
#'   `opponent_stats_*` columns. Key identifying columns:
#'
#'    |col_name      |types     |description                                   |
#'    |:-------------|:---------|:---------------------------------------------|
#'    |game_id       |integer   |CollegeBasketballData game id.                |
#'    |season        |integer   |Season (4-digit ending-year).                 |
#'    |start_date    |character |Game start date (ISO 8601).                   |
#'    |team_id       |integer   |Team id.                                      |
#'    |team          |character |Team name.                                    |
#'    |conference    |character |Team conference.                              |
#'    |opponent_id   |integer   |Opponent team id.                             |
#'    |opponent      |character |Opponent team name.                           |
#'    |is_home       |logical   |Whether the team was home.                    |
#'    |neutral_site  |logical   |Whether the game was at a neutral site.       |
#'    |game_minutes  |numeric   |Total team minutes.                           |
#'    |pace          |numeric   |Game pace (possessions).                      |
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

#' @title
#' **CBD Player Box Scores**
#' @description
#' **Get player box score statistics from the CollegeBasketballData API.**
#' @inheritParams cbbd_games
#' @return A `hoopR_data` tibble with one row per team-game. The `players` column
#'   is a nested list of per-player box scores. Key identifying columns:
#'
#'    |col_name      |types     |description                                   |
#'    |:-------------|:---------|:---------------------------------------------|
#'    |game_id       |integer   |CollegeBasketballData game id.                |
#'    |season        |integer   |Season (4-digit ending-year).                 |
#'    |start_date    |character |Game start date (ISO 8601).                   |
#'    |team_id       |integer   |Team id.                                      |
#'    |team          |character |Team name.                                    |
#'    |conference    |character |Team conference.                              |
#'    |opponent_id   |integer   |Opponent team id.                             |
#'    |opponent      |character |Opponent team name.                           |
#'    |is_home       |logical   |Whether the team was home.                    |
#'    |game_minutes  |numeric   |Total team minutes.                           |
#'    |game_pace     |numeric   |Game pace (possessions).                      |
#'    |players       |list      |Nested list of per-player box scores.         |
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
#' @description
#' **Get the current scoreboard from the CollegeBasketballData API.**
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per game. The `home_team`,
#'   `away_team` and `betting` objects are flattened into `home_team_*`,
#'   `away_team_*` and `betting_*` columns. Key identifying columns:
#'
#'    |col_name        |types     |description                                 |
#'    |:---------------|:---------|:-------------------------------------------|
#'    |id              |integer   |CollegeBasketballData game id.              |
#'    |start_date      |character |Game start date (ISO 8601).                 |
#'    |tv              |character |Broadcast TV network.                       |
#'    |neutral_site    |logical   |Whether the game is at a neutral site.      |
#'    |conference_game |logical   |Whether the game is a conference game.      |
#'    |status          |character |Game status.                               |
#'    |period          |integer   |Current period.                             |
#'    |clock           |character |Game clock.                                 |
#'    |venue           |character |Venue name.                                 |
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
