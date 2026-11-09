#' @title
#' **Bart Torvik Team Four Factors**
#' @description
#' **Get team four-factor and shooting splits from [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls the season four-factors table (the `{year}_fffinal.csv` file): effective
#' field goal %, turnover %, offensive/defensive rebound %, free-throw rate, plus
#' 2P/3P/FT shooting splits and assist rates -- each paired with its national
#' rank. No API key is required. Data is available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @eval .returns_rd("torvik_team_factors", inline = FALSE, unit = "team")
#' @keywords Torvik
#' @importFrom data.table fread
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_team_factors(year = 2024))
#' }
torvik_team_factors <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/", year, "_fffinal.csv"))
      df <- data.table::fread(text = txt, fill = TRUE, showProgress = FALSE)
      df <- dplyr::as_tibble(janitor::clean_names(as.data.frame(df)))
      df[["year"]] <- as.integer(year)
      df <- make_hoopR_data(df, "Bart Torvik team four factors from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no team four factors available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching team four factors for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
