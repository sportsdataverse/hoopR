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
#' @return A `hoopR_data` tibble with one row per team-season. The `team_stats`
#'   and `opponent_stats` objects are flattened into `team_stats_*` /
#'   `opponent_stats_*` columns. Key identifying columns:
#'
#'    |col_name      |types     |description                                   |
#'    |:-------------|:---------|:---------------------------------------------|
#'    |season        |integer   |Season (4-digit ending-year).                 |
#'    |team_id       |integer   |Team id.                                       |
#'    |team          |character |Team name.                                     |
#'    |conference    |character |Conference name.                               |
#'    |games         |integer   |Games played.                                  |
#'    |wins          |numeric   |Wins.                                          |
#'    |losses        |numeric   |Losses.                                        |
#'    |total_minutes |numeric   |Total minutes played.                          |
#'    |pace          |numeric   |Average pace (possessions).                    |
#'
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
#' @description
#' **Get the team statistics leaderboard from the CollegeBasketballData API.**
#' @param season (*integer* optional): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @return A `hoopR_data` tibble with one row per team. Nested statistic objects
#'   (`record`, `summary`, `team_stats`, `opponent_stats`, `shot_profile`,
#'   `adjusted_efficiency`) are flattened into prefixed columns. Key identifying
#'   columns:
#'
#'    |col_name   |types     |description                                      |
#'    |:----------|:---------|:------------------------------------------------|
#'    |season     |integer   |Season (4-digit ending-year).                    |
#'    |team_id    |integer   |Team id.                                          |
#'    |team       |character |Team name.                                        |
#'
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

#' @title
#' **CBD Team Shooting Stats**
#' @description
#' **Get team season shooting statistics from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @return A `hoopR_data` tibble with one row per team-season. Shot-type objects
#'   (`dunks`, `layups`, `tip_ins`, `two_point_jumpers`, `three_point_jumpers`,
#'   `free_throws`, `attempts_breakdown`) are flattened into prefixed columns.
#'   Key identifying columns:
#'
#'    |col_name      |types     |description                                   |
#'    |:-------------|:---------|:---------------------------------------------|
#'    |season        |integer   |Season (4-digit ending-year).                 |
#'    |team_id       |integer   |Team id.                                       |
#'    |team          |character |Team name.                                     |
#'    |conference    |character |Conference name.                               |
#'    |tracked_shots |integer   |Number of tracked shots.                       |
#'    |assisted_pct  |numeric   |Assisted field-goal percentage.                |
#'
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

#' @title
#' **CBD Player Season Stats**
#' @description
#' **Get player season statistics from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param season_type (*character* optional): One of `regular`, `postseason`,
#'   `preseason`.
#' @param team (*character* optional): Team name filter.
#' @param conference (*character* optional): Conference abbreviation filter.
#' @param start_date_range (*character* optional): ISO 8601 start of date range.
#' @param end_date_range (*character* optional): ISO 8601 end of date range.
#' @return A `hoopR_data` tibble with one row per player-season. Nested
#'   statistic objects (`field_goals`, `two_point_field_goals`,
#'   `three_point_field_goals`, `free_throws`, `rebounds`, `win_shares`) are
#'   flattened into prefixed columns. Key identifying columns:
#'
#'    |col_name    |types     |description                                     |
#'    |:-----------|:---------|:-----------------------------------------------|
#'    |season      |integer   |Season (4-digit ending-year).                   |
#'    |team_id     |integer   |Team id.                                         |
#'    |team        |character |Team name.                                       |
#'    |conference  |character |Conference name.                                 |
#'    |athlete_id  |integer   |Athlete id.                                      |
#'    |name        |character |Player name.                                     |
#'    |position    |character |Player position.                                 |
#'    |games       |numeric   |Games played.                                    |
#'    |minutes     |numeric   |Minutes played.                                  |
#'    |points      |numeric   |Total points.                                    |
#'
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

#' @title
#' **CBD Player Shooting Stats**
#' @description
#' **Get player season shooting statistics from the CollegeBasketballData API.**
#' @inheritParams cbbd_stats_team_shooting_season
#' @return A `hoopR_data` tibble with one row per player-season. Shot-type
#'   objects are flattened into prefixed columns. Key identifying columns:
#'
#'    |col_name      |types     |description                                   |
#'    |:-------------|:---------|:---------------------------------------------|
#'    |season        |integer   |Season (4-digit ending-year).                 |
#'    |team_id       |integer   |Team id.                                       |
#'    |team          |character |Team name.                                     |
#'    |conference    |character |Conference name.                               |
#'    |athlete_id    |integer   |Athlete id.                                    |
#'    |athlete_name  |character |Player name.                                   |
#'    |tracked_shots |integer   |Number of tracked shots.                       |
#'    |assisted_pct  |numeric   |Assisted field-goal percentage.                |
#'
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
