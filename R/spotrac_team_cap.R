#' @title
#' **Spotrac NBA Team Salary Cap**
#' @description
#' **Get team salary-cap allocations from Spotrac (spotrac.com).**
#'
#' Returns one row per team with cap allocations, cap space, active-player
#' counts and average age for a season. No API key is required.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @eval .returns_rd("spotrac_team_cap", inline = FALSE, unit = "team")
#' @keywords Salaries
#' @importFrom rvest html_element html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble mutate across where
#' @family Salary & Draft Functions
#' @export
#' @examples
#' \donttest{
#'   try(spotrac_team_cap(season = 2024))
#' }
spotrac_team_cap <- function(season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      doc <- .ext_html(paste0("https://www.spotrac.com/nba/cap/_/year/", season, "/"))
      tb <- rvest::html_table(rvest::html_element(doc, "table"))
      df <- janitor::clean_names(dplyr::as_tibble(tb))
      # team cell duplicates the abbreviation (logo alt + text) -> keep first token
      if ("team" %in% colnames(df)) {
        df[["team"]] <- sub("\\s.*$", "", trimws(df[["team"]]))
      }
      # parse any currency-looking character columns to numeric
      dollar <- vapply(df, function(col) is.character(col) && any(grepl("\\$", col)), logical(1))
      for (j in which(dollar)) df[[j]] <- .parse_currency(df[[j]])
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Team salary cap from spotrac.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no Spotrac cap data available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching Spotrac cap data for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
