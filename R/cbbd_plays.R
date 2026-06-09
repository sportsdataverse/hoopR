# Shared @return documentation note for play-by-play endpoints is repeated per
# function below; PlayInfo nests participants/on_floor as list-columns and
# shot_info as flattened shot_info_* columns.

#' @title
#' **CBD Plays by Game**
#' @description
#' **Get play-by-play data for a single game from the CollegeBasketballData API.**
#' @param game_id (*integer* required): CollegeBasketballData game id. See
#'   [cbbd_games()].
#' @param shooting_plays_only (*logical* optional): If `TRUE`, return only
#'   shooting plays. Defaults to `FALSE`.
#' @return A `hoopR_data` tibble with one row per play (key columns; `shot_info`
#'   is flattened to `shot_info_*`, `participants`/`on_floor` are list-columns):
#'
#'    |col_name          |types     |description                               |
#'    |:-----------------|:---------|:-----------------------------------------|
#'    |id                |integer   |Play id.                                  |
#'    |game_id           |integer   |Game id.                                  |
#'    |season            |numeric   |Season (4-digit ending-year).             |
#'    |play_type         |character |Play type description.                    |
#'    |team_id           |integer   |Team id of the team on the play.          |
#'    |team              |character |Team on the play.                         |
#'    |period            |integer   |Period number.                            |
#'    |clock             |character |Game clock.                               |
#'    |seconds_remaining |integer   |Seconds remaining in the period.          |
#'    |home_score        |integer   |Home score after the play.                |
#'    |away_score        |integer   |Away score after the play.                |
#'    |scoring_play      |logical   |Whether the play scored.                  |
#'    |shooting_play     |logical   |Whether the play was a shot.              |
#'    |score_value       |numeric   |Point value of the play.                  |
#'    |play_text         |character |Play description text.                    |
#'
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_plays_game(game_id = 401581758))
#' }
cbbd_plays_game <- function(game_id, shooting_plays_only = FALSE) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/plays/game/", game_id),
                        query = list(shootingPlaysOnly = tolower(as.character(shooting_plays_only))))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Plays by Game from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play data available for {game_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD plays for game {game_id}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Plays by Player**
#' @description
#' **Get play-by-play data for a single player from the CollegeBasketballData API.**
#' @param player_id (*integer* required): Athlete id.
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param shooting_plays_only (*logical* optional): If `TRUE`, return only
#'   shooting plays. Defaults to `FALSE`.
#' @return A `hoopR_data` tibble with one row per play (same columns as
#'   [cbbd_plays_game()]).
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_plays_player(player_id = 4433137, season = 2024))
#' }
cbbd_plays_player <- function(player_id, season = most_recent_mbb_season(), shooting_plays_only = FALSE) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get(paste0("/plays/player/", player_id),
                        query = list(season = season, shootingPlaysOnly = tolower(as.character(shooting_plays_only))))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Plays by Player from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play data available for player {player_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD plays for player {player_id}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Plays by Team**
#' @description
#' **Get play-by-play data for a team-season from the CollegeBasketballData API.**
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param team (*character* required): Team name (e.g. `Duke`).
#' @param shooting_plays_only (*logical* optional): If `TRUE`, return only
#'   shooting plays. Defaults to `FALSE`.
#' @return A `hoopR_data` tibble with one row per play (same columns as
#'   [cbbd_plays_game()]).
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_plays_team(season = 2024, team = "Duke"))
#' }
cbbd_plays_team <- function(season = most_recent_mbb_season(), team, shooting_plays_only = FALSE) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/plays/team",
                        query = list(season = season, team = team, shootingPlaysOnly = tolower(as.character(shooting_plays_only))))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Plays by Team from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play data available for {team}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD plays for team {team}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Plays by Date**
#' @description
#' **Get play-by-play data for all games on a date from the CollegeBasketballData API.**
#' @param date (*character* required): Date-time in ISO 8601 format
#'   (e.g. `2024-02-01T00:00:00.000Z`).
#' @param shooting_plays_only (*logical* optional): If `TRUE`, return only
#'   shooting plays. Defaults to `FALSE`.
#' @param utc_offset (*numeric* optional): UTC offset (hours) for the date.
#' @return A `hoopR_data` tibble with one row per play (same columns as
#'   [cbbd_plays_game()]).
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_plays_date(date = "2024-02-01T00:00:00.000Z"))
#' }
cbbd_plays_date <- function(date, shooting_plays_only = FALSE, utc_offset = NULL) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/plays/date",
                        query = list(date = date, shootingPlaysOnly = tolower(as.character(shooting_plays_only)), utcOffset = utc_offset))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Plays by Date from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play data available for {date}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD plays for date {date}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Plays by Tournament**
#' @description
#' **Get play-by-play data for a tournament from the CollegeBasketballData API.**
#' @param tournament (*character* required): Tournament name (e.g. `NCAA`).
#' @param season (*integer* required): Season, 4-digit ending-year (e.g. `2024`).
#'   Defaults to `most_recent_mbb_season()`.
#' @param shooting_plays_only (*logical* optional): If `TRUE`, return only
#'   shooting plays. Defaults to `FALSE`.
#' @return A `hoopR_data` tibble with one row per play (same columns as
#'   [cbbd_plays_game()]).
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_plays_tournament(tournament = "NCAA", season = 2024))
#' }
cbbd_plays_tournament <- function(tournament, season = most_recent_mbb_season(), shooting_plays_only = FALSE) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/plays/tournament",
                        query = list(tournament = tournament, season = season, shootingPlaysOnly = tolower(as.character(shooting_plays_only))))
      df <- janitor::clean_names(dplyr::as_tibble(jsonlite::flatten(data)))
      df <- make_hoopR_data(df, "CBD Plays by Tournament from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play data available for {tournament}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD plays for tournament {tournament}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **CBD Play Types**
#' @description
#' **Get the list of play types from the CollegeBasketballData API.**
#' @return A `hoopR_data` tibble with one row per play type:
#'
#'    |col_name |types     |description                                       |
#'    |:--------|:---------|:-------------------------------------------------|
#'    |id       |integer   |Play type id.                                     |
#'    |name     |character |Play type name.                                   |
#'
#' @keywords CBD Plays
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family CBD Plays Functions
#' @export
#' @examples
#' \donttest{
#'   try(cbbd_play_types())
#' }
cbbd_play_types <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      data <- .cbbd_get("/plays/types")
      df <- janitor::clean_names(dplyr::as_tibble(data))
      df <- make_hoopR_data(df, "CBD Play Types from collegebasketballdata.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no play types available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching CBD play types", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
