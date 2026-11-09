#' **Get NBA win probability chart data from ESPN**
#' @rdname espn_mbb_wp
#'
#' @param game_id (*Integer* required): Game ID filter for querying a single game
#'
#' @eval .returns_rd("espn_nba_wp", unit = "play")
#' @importFrom jsonlite fromJSON
#' @importFrom httr2 request req_headers req_timeout req_retry req_perform resp_body_string
#' @importFrom utils URLencode URLdecode
#' @importFrom cli cli_abort
#' @importFrom janitor clean_names
#' @importFrom stringr str_sub str_length
#' @import dplyr
#' @export
#' @keywords NBA Win Probability Chart Data
#' @concept ESPN NBA Functions
#' @seealso [family_espn_nba] lists every function in this family.
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
