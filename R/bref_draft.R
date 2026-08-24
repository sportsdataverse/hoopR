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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       pick_overall \tab integer \tab Overall draft pick number. \cr
#'       round \tab integer \tab Draft round. \cr
#'       team \tab character \tab Drafting team abbreviation. \cr
#'       player \tab character \tab Player name. \cr
#'       college_name \tab character \tab College / pre-draft team. \cr
#'       seasons \tab integer \tab NBA seasons played. \cr
#'       g \tab integer \tab Career games. \cr
#'       pts \tab numeric \tab Career points. \cr
#'       trb \tab numeric \tab Career total rebounds. \cr
#'       ast \tab numeric \tab Career assists. \cr
#'       ws \tab numeric \tab Career win shares. \cr
#'       bpm \tab numeric \tab Career box plus/minus. \cr
#'       vorp \tab numeric \tab Career value over replacement player. \cr
#'       season \tab integer \tab Draft year (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
