#' @title
#' **Basketball-Reference Team Season Stats**
#' @description
#' **Get team season statistics from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' Scrapes a team stat table from the league season page. No API key is required.
#' Basketball-Reference rate-limits aggressive scraping (~20 requests/minute) --
#' space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @param table (*character* optional): Which team table to return. One of
#'   `per_game` (default, team per-game), `totals`, `per_poss` (per 100 poss),
#'   `advanced`, or `opponent` (opponent per-game).
#' @return A `hoopR_data` tibble with one row per team (columns vary by `table`;
#'   common identifying columns shown -- names are Basketball-Reference
#'   `data-stat` keys):
#'
#'    |col_name |types     |description                                          |
#'    |:--------|:---------|:----------------------------------------------------|
#'    |ranker   |integer   |Row rank.                                            |
#'    |team     |character |Team name.                                           |
#'    |g        |integer   |Games played.                                        |
#'    |mp       |numeric   |Minutes played.                                      |
#'    |pts      |numeric   |Points (scaled to the chosen `table`).              |
#'    |season   |integer   |Season (echoes the `season` argument).               |
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of
#' @importFrom cli cli_abort
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_teams_stats(season = 2024, table = "per_game"))
#' }
bref_teams_stats <- function(season = most_recent_nba_season(), table = "per_game") {
  .args <- .capture_args()

  valid <- c("per_game", "totals", "per_poss", "advanced", "opponent")
  if (!table %in% valid) {
    cli::cli_abort(c(
      "Unsupported {.arg table}.",
      "i" = "{.arg table} must be one of: {.val {valid}}.",
      "x" = "You called {.code table = {.val {table}}}."
    ))
  }

  table_id <- switch(table,
    per_game = "per_game-team",
    totals   = "totals-team",
    per_poss = "per_poss-team",
    advanced = "advanced-team",
    opponent = "per_game-opponent"
  )

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/leagues/NBA_", season, ".html"))
      df <- .bref_table(html, table_id)
      df <- df[rowSums(!is.na(df) & df != "") > 0, , drop = FALSE]
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c("team" = "team_name", "g" = "games")))
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Team season stats from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team stats available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF team stats for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
