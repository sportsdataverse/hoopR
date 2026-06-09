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
#'    |col_name              |types     |description                              |
#'    |:---------------------|:---------|:----------------------------------------|
#'    |ranker                |integer   |Season game number.                      |
#'    |player_game_num_career|integer   |Career game number.                      |
#'    |date                  |character |Game date.                               |
#'    |team                  |character |Team abbreviation.                       |
#'    |location              |character |`@` for away games, empty for home.      |
#'    |opp                   |character |Opponent abbreviation.                   |
#'    |result                |character |Result with final score (e.g. `W (+12)`).|
#'    |is_starter            |integer   |1 if the player started.                 |
#'    |mp                    |character |Minutes played.                          |
#'    |pts                   |numeric   |Points.                                  |
#'    |trb                   |numeric   |Total rebounds.                          |
#'    |ast                   |numeric   |Assists.                                 |
#'    |game_score            |numeric   |Hollinger game score.                    |
#'    |plus_minus            |numeric   |Plus/minus.                              |
#'    |player_id             |character |Player id (echoes the `player_id` argument).|
#'    |season                |integer   |Season (echoes the `season` argument).   |
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
