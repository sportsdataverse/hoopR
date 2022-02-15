#' **Get NBA win probability chart data from ESPN**
#' @rdname espn_nba_wp
#'
#' @param game_id (*Integer* required): Game ID filter for querying a single game
#'
#' @return [espn_nba_wp()] - A data frame with 21 variables:
#'   |col_name             |types     |
#'   |:--------------------|:---------|
#'   |game_id              |numeric   |
#'   |play_id              |character |
#'   |home_win_percentage  |numeric   |
#'   |away_win_percentage  |numeric   |
#'   |tie_percentage       |numeric   |
#'   |sequence_number      |character |
#'   |text                 |character |
#'   |away_score           |integer   |
#'   |home_score           |integer   |
#'   |scoring_play         |logical   |
#'   |score_value          |integer   |
#'   |participants         |list      |
#'   |shooting_play        |logical   |
#'   |type_id              |character |
#'   |type_text            |character |
#'   |period_number        |integer   |
#'   |period_display_value |character |
#'   |clock_display_value  |character |
#'   |team_id              |character |
#'   |coordinate_x         |integer   |
#'   |coordinate_y         |integer   |
#' @keywords NBA Win Probability Chart Data
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET RETRY
#' @importFrom utils URLencode URLdecode
#' @importFrom cli cli_abort
#' @importFrom janitor clean_names
#' @importFrom stringr str_sub str_length
#' @import dplyr
#' @export
#' @examples
#' \donttest{
#'   espn_nba_wp(game_id = 401283399)
#' }
#'
espn_nba_wp <- function(game_id) {

  if (!is.null(game_id) && !is.numeric(game_id)) {
    # Check if game_id is numeric, if not NULL
    cli::cli_abort("Enter valid game_id value (Integer)\nCan be found using the `cfbd_game_info()` function")
  }

  espn_game_id <- game_id

  espn_wp <- data.frame()

  tryCatch(
    expr = {
      espn_wp <-
        httr::GET(url = glue::glue("http://site.api.espn.com/apis/site/v2/sports/basketball/nba/summary?event={espn_game_id}")) %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(flatten = TRUE)

      espn_wp_vals <- espn_wp %>%
        purrr::pluck("winprobability") %>%
        janitor::clean_names()
      espn_plays <- espn_wp$plays %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        janitor::clean_names() %>%
        dplyr::rename(
          play_id = .data$id
        )
      espn_wp <- espn_wp_vals %>%
        dplyr::left_join(espn_plays, by = "play_id")%>%
        dplyr::mutate(
          away_win_percentage = 1 - .data$home_win_percentage - .data$tie_percentage,
          game_id = espn_game_id) %>%
        dplyr::select(dplyr::any_of(c("game_id","play_id","home_win_percentage", "away_win_percentage", "tie_percentage")),
                      tidyr::everything()) %>%
        janitor::clean_names()


    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: game_id '{espn_game_id}' invalid or no ESPN win probability data available!"))
    },
    warning = function(w) {
    },
    finally = {
    }
  )
  return(espn_wp)
}
