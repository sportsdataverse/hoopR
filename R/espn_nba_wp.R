#' **Get NBA win probability chart data from ESPN**
#' @rdname espn_nba_wp
#'
#' @param game_id (*Integer* required): Game ID filter for querying a single game
#'
#' @return [espn_nba_wp()] - A data frame with 21 variables:
#'
#'   |col_name             |types     |description                                              |
#'   |:--------------------|:---------|:--------------------------------------------------------|
#'   |game_id              |numeric   |Unique game identifier.                                  |
#'   |play_id              |character |Unique play identifier within a game.                    |
#'   |home_win_percentage  |numeric   |Home win percentage (0-1 decimal).                       |
#'   |away_win_percentage  |numeric   |Away win percentage (0-1 decimal).                       |
#'   |tie_percentage       |numeric   |Tie percentage (0-1 decimal).                            |
#'   |sequence_number      |character |Sequence number representing a shot-possession (V3 PBP). |
#'   |text                 |character |Text description of the play / record.                   |
#'   |away_score           |integer   |Away team score at the time of the play.                 |
#'   |home_score           |integer   |Home team score at the time of the play.                 |
#'   |scoring_play         |logical   |TRUE if the play resulted in points scored.              |
#'   |score_value          |integer   |Point value of the play (2 / 3 / 1).                     |
#'   |participants         |list      |Participants.                                            |
#'   |shooting_play        |logical   |TRUE if the play was a shooting attempt.                 |
#'   |type_id              |character |Type identifier (numeric).                               |
#'   |type_text            |character |Display text for the type field.                         |
#'   |period_number        |integer   |Numeric period (1-4 for quarters; 5+ for OT).            |
#'   |period_display_value |character |Period display label (e.g. '1st Quarter', 'OT').         |
#'   |clock_display_value  |character |Game clock display string (e.g. '8:32').                 |
#'   |team_id              |character |Unique team identifier.                                  |
#'   |coordinate_x         |integer   |X coordinate on the court (half-court layout).           |
#'   |coordinate_y         |integer   |Y coordinate on the court (half-court layout).           |
#'
#' @importFrom jsonlite fromJSON
#' @importFrom httr2 request req_headers req_timeout req_retry req_perform resp_body_string
#' @importFrom utils URLencode URLdecode
#' @importFrom cli cli_abort
#' @importFrom janitor clean_names
#' @importFrom stringr str_sub str_length
#' @import dplyr
#' @export
#' @keywords NBA Win Probability Chart Data
#' @family ESPN NBA Functions
#' @examples
#' \donttest{
#' espn_nba_wp(game_id = 401283399)
#' }
#'
espn_nba_wp <- function(game_id) {
  .args <- mget(setdiff(names(formals()), "..."))
  if (!is.null(game_id) && !is.numeric(game_id)) {
    # Check if game_id is numeric, if not NULL
    cli::cli_abort("Enter valid game_id value (Integer)")
  }

  espn_game_id <- game_id

  espn_wp <- data.frame()

  tryCatch(
    expr = {
      espn_wp <-
        .retry_request(sprintf("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?event=%s", espn_game_id)) %>%
        .resp_text() %>%
        jsonlite::fromJSON(flatten = TRUE)

      espn_wp_vals <- espn_wp %>%
        purrr::pluck("winprobability") %>%
        janitor::clean_names()
      espn_plays <- espn_wp$plays %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          "play_id" = "id"
        )
      espn_wp <- espn_wp_vals %>%
        dplyr::left_join(espn_plays, by = "play_id") %>%
        dplyr::mutate(
          away_win_percentage = 1 - .data$home_win_percentage - .data$tie_percentage,
          game_id = espn_game_id
        ) %>%
        dplyr::select(
          dplyr::any_of(c("game_id", "play_id", "home_win_percentage", "away_win_percentage", "tie_percentage")),
          tidyr::everything()
        ) %>%
        janitor::clean_names() %>%
        make_hoopR_data("ESPN NBA Win Probability Information from ESPN.com", Sys.time())
    },
    error = function(e) .report_api_error(
      e,
      hint = "game_id '{espn_game_id}' invalid or no ESPN win probability data available!",
      args = .args
    ),
    warning = function(w) {
    },
    finally = {
    }
  )
  return(espn_wp)
}
