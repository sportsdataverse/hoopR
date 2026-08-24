#' @title
#' **Basketball-Reference Player Game Log**
#' @description
#' **Get a player's game-by-game log for a season from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' No API key is required. Basketball-Reference rate-limits aggressive scraping
#' (~20 requests/minute) -- space repeated calls with `Sys.sleep()`.
#' @param player_id (*character* required): Basketball-Reference player id slug
#'   (e.g. `jokicni01` for Nikola Jokić, `jamesle01` for LeBron James). This is
#'   the id in the player's BREF URL (`/players/j/jokicni01.html`).
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per regular-season game (column
#'   names are Basketball-Reference `data-stat` keys):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       ranker \tab integer \tab Season game number. \cr
#'       player_game_num_career \tab integer \tab Career game number. \cr
#'       date \tab character \tab Game date. \cr
#'       team \tab character \tab Team abbreviation. \cr
#'       location \tab character \tab \code{@} for away games, empty for home. \cr
#'       opp \tab character \tab Opponent abbreviation. \cr
#'       result \tab character \tab Result with final score (e.g. \code{W (+12)}). \cr
#'       is_starter \tab integer \tab 1 if the player started. \cr
#'       mp \tab character \tab Minutes played. \cr
#'       pts \tab numeric \tab Points. \cr
#'       trb \tab numeric \tab Total rebounds. \cr
#'       ast \tab numeric \tab Assists. \cr
#'       game_score \tab numeric \tab Hollinger game score. \cr
#'       plus_minus \tab numeric \tab Plus/minus. \cr
#'       player_id \tab character \tab Player id (echoes the \code{player_id} argument). \cr
#'       season \tab integer \tab Season (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   Full shooting / box columns (`fg`, `fga`, `fg_pct`, `fg3`, `ft`, `orb`,
#'   `drb`, `stl`, `blk`, `tov`, `pf`, ...) are also returned.
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_player_game_log(player_id = "jokicni01", season = 2024))
#' }
bref_player_game_log <- function(player_id, season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      letter <- substr(tolower(player_id), 1, 1)
      html <- .bref_text(paste0("/players/", letter, "/", tolower(player_id),
                                "/gamelog/", season, "/"))
      df <- .bref_table(html, "player_game_log_reg")
      # keep only real games (drop month-separator / DNP rows with no date)
      if ("date" %in% colnames(df)) df <- df[!is.na(df$date) & df$date != "", , drop = FALSE]
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c(
        "team" = "team_name_abbr", "opp" = "opp_name_abbr",
        "location" = "game_location", "result" = "game_result")))
      df[["player_id"]] <- tolower(player_id)
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Player game log from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no game log available for {player_id} {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF game log for {player_id} {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
