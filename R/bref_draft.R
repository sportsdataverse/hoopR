#' @title
#' **Basketball-Reference Draft**
#' @description
#' **Get NBA draft results with career stats from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' Returns every pick of a draft, paired with the player's career totals and
#' advanced metrics. No API key is required. Basketball-Reference rate-limits
#' aggressive scraping (~20 requests/minute) -- space repeated calls with
#' `Sys.sleep()`.
#' @param season (*integer* required): Draft year (e.g. `2024`). Defaults to
#'   `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per draft pick (career columns
#'   shown -- column names are Basketball-Reference `data-stat` keys):
#'
#'    |col_name     |types     |description                                       |
#'    |:------------|:---------|:-------------------------------------------------|
#'    |pick_overall |integer   |Overall draft pick number.                        |
#'    |round        |integer   |Draft round.                                      |
#'    |team         |character |Drafting team abbreviation.                       |
#'    |player       |character |Player name.                                      |
#'    |college_name |character |College / pre-draft team.                         |
#'    |seasons      |integer   |NBA seasons played.                               |
#'    |g            |integer   |Career games.                                     |
#'    |pts          |numeric   |Career points.                                    |
#'    |trb          |numeric   |Career total rebounds.                            |
#'    |ast          |numeric   |Career assists.                                   |
#'    |ws           |numeric   |Career win shares.                                |
#'    |bpm          |numeric   |Career box plus/minus.                            |
#'    |vorp         |numeric   |Career value over replacement player.             |
#'    |season       |integer   |Draft year (echoes the `season` argument).        |
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_draft(season = 2024))
#' }
bref_draft <- function(season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/draft/NBA_", season, ".html"))
      df <- .bref_table(html, "stats")
      df <- df[rowSums(!is.na(df) & df != "") > 0, , drop = FALSE]
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c(
        "player" = "name_display", "team" = "team_id")))
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Draft results from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no draft data available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF draft for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
