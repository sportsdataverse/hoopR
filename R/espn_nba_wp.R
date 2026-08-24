#' **Get NBA win probability chart data from ESPN**
#' @rdname espn_nba_wp
#'
#' @param game_id (*Integer* required): Game ID filter for querying a single game
#'
#' @return [espn_nba_wp()] - A data frame with 21 variables:
#'
#'   \if{html}{\tabular{lll}{
#'      col_name \tab types \tab description \cr
#'      game_id \tab numeric \tab Unique game identifier. \cr
#'      play_id \tab character \tab Unique play identifier within a game. \cr
#'      home_win_percentage \tab numeric \tab Home win percentage (0-1 decimal). \cr
#'      away_win_percentage \tab numeric \tab Away win percentage (0-1 decimal). \cr
#'      tie_percentage \tab numeric \tab Tie percentage (0-1 decimal). \cr
#'      sequence_number \tab character \tab Sequence number representing a shot-possession (V3 PBP). \cr
#'      text \tab character \tab Text description of the play / record. \cr
#'      away_score \tab integer \tab Away team score at the time of the play. \cr
#'      home_score \tab integer \tab Home team score at the time of the play. \cr
#'      scoring_play \tab logical \tab TRUE if the play resulted in points scored. \cr
#'      score_value \tab integer \tab Point value of the play (2 / 3 / 1). \cr
#'      participants \tab list \tab Participants. \cr
#'      shooting_play \tab logical \tab TRUE if the play was a shooting attempt. \cr
#'      type_id \tab character \tab Type identifier (numeric). \cr
#'      type_text \tab character \tab Display text for the type field. \cr
#'      period_number \tab integer \tab Numeric period (1-4 for quarters; 5+ for OT). \cr
#'      period_display_value \tab character \tab Period display label (e.g. '1st Quarter', 'OT'). \cr
#'      clock_display_value \tab character \tab Game clock display string (e.g. '8:32'). \cr
#'      team_id \tab character \tab Unique team identifier. \cr
#'      coordinate_x \tab integer \tab X coordinate on the court (half-court layout). \cr
#'      coordinate_y \tab integer \tab Y coordinate on the court (half-court layout). \cr
#'   }}
#'   \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
