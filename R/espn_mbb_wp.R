#' **Men's College Basketball win probability chart data from ESPN**
#' @rdname espn_mbb_wp
#'
#' @param game_id (*Integer* required): Game ID filter for querying a single game
#'
#' @return [espn_mbb_wp()] - A data frame with 9 variables:
#' \describe{
#'   \item{`game_id`: character.}{Referencing game ID (should be same as `game_id` from other functions).}
#'   \item{`play_id`: character.}{Referencing play ID.}
#'   \item{`period`: integer.}{Clock (time) left in the game.}
#'   \item{`time_left`: character.}{Clock (time) left in the game.}
#'   \item{`period_seconds_left`: integer.}{Seconds left in the period.}
#'   \item{`game_seconds_left`: integer.}{Seconds left in the game.}
#'   \item{`home_win_percentage`: double.}{The probability of the home team winning the game.}
#'   \item{`away_win_percentage`: double.}{The probability of the away team winning the game (calculated as 1 - `home_win_percentage` - `tie_percentage`).}
#'   \item{`tie_percentage`: double.}{The probability of the game ending the final period in a tie.}
#' }
#' @keywords MBB Win Probability Chart Data
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
#'   espn_mbb_wp(game_id = 401256760)
#' }
#'
espn_mbb_wp <- function(game_id) {

  if (!is.null(game_id) && !is.numeric(game_id)) {
    # Check if game_id is numeric, if not NULL
    cli::cli_abort("Enter valid game_id value (Integer)")
  }

  espn_game_id <- game_id

  espn_wp <- data.frame()

  tryCatch(
    expr = {
      espn_wp <-
        httr::GET(url = glue::glue("http://site.api.espn.com/apis/site/v2/sports/basketball/mens-college-basketball/summary?event={espn_game_id}")) %>%
        httr::content(as = "text", encoding = "UTF-8") %>%
        jsonlite::fromJSON(flatten = TRUE) %>%
        purrr::pluck("winprobability") %>%
        janitor::clean_names() %>%
        dplyr::mutate(
          espn_game_id = stringr::str_sub(.data$play_id, end = stringr::str_length(espn_game_id)),
          period = dplyr::case_when(
            as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3))<2000000 ~ 1,
            as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3))<3000000 ~ 2,
            as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3))<4000000 ~ 3,
            TRUE ~ NA_real_
          ),
          seconds_left = ifelse(as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3))<2000000,
                                20000 - as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3, end = stringr::str_length(.data$play_id)-2))-1,
                                30000 - as.integer(stringr::str_sub(.data$play_id, start = stringr::str_length(espn_game_id)+3, end = stringr::str_length(.data$play_id)-2))-1),
          period_seconds_left = ifelse(stringr::str_length(.data$seconds_left)>2,
                           as.integer(stringr::str_sub(.data$seconds_left,  end = stringr::str_length(.data$seconds_left)-2))*60+
                             as.integer(stringr::str_sub(.data$seconds_left,  start = stringr::str_length(.data$seconds_left)-1)),
                           as.integer(stringr::str_sub(.data$seconds_left,  start = stringr::str_length(.data$seconds_left)-1))),
          game_seconds_left = ifelse(.data$period == 1,
                                     .data$period_seconds_left + 1200,
                                     .data$period_seconds_left)
        ) %>%
        dplyr::rename(
          "home_win_percentage" = "home_win_percentage",
          "time_left" = "seconds_left",
          "play_id" = "play_id",
          "game_id" = "espn_game_id"
        ) %>%
        dplyr::mutate(
          away_win_percentage = 1 - .data$home_win_percentage - .data$tie_percentage
        )
        espn_wp$time_left <- purrr::map_dfr(1:length(espn_wp$time_left), function(x){
          data.frame(time_left = sub("(.{2})(.*)", "\\1:\\2", as.character(pad_time(espn_wp$time_left[[x]]))))
        })$time_left

        espn_wp <- espn_wp %>%
          dplyr::select(
            "game_id",
            "play_id",
            "period",
            "time_left",
            "period_seconds_left",
            "game_seconds_left",
            "home_win_percentage",
            "away_win_percentage",
            "tie_percentage") %>%
          make_hoopR_data("ESPN MBB Win Probability Information from ESPN.com",Sys.time())
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
