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
#' @return A `hoopR_data` tibble with one row per team. Each statistic is paired
#'   with an interspersed national-rank column (`rk`, `rk_2`, ...):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       team_name \tab character \tab Team name. \cr
#'       e_fg_percent \tab numeric \tab Effective field goal percentage (offense). \cr
#'       e_fg_percent_def \tab numeric \tab Effective field goal percentage allowed (defense). \cr
#'       ftr \tab numeric \tab Free-throw rate (offense). \cr
#'       ftr_def \tab numeric \tab Free-throw rate allowed (defense). \cr
#'       or_percent \tab numeric \tab Offensive rebound percentage. \cr
#'       dr_percent \tab numeric \tab Defensive rebound percentage. \cr
#'       to_percent \tab numeric \tab Turnover percentage (offense). \cr
#'       to_percent_def \tab numeric \tab Turnover percentage forced (defense). \cr
#'       x3p_percent \tab numeric \tab Three-point percentage (offense). \cr
#'       x3p_d_percent \tab numeric \tab Three-point percentage allowed (defense). \cr
#'       x2p_percent \tab numeric \tab Two-point percentage (offense). \cr
#'       x2p_percent_d \tab numeric \tab Two-point percentage allowed (defense). \cr
#'       ft_percent \tab numeric \tab Free-throw percentage (offense). \cr
#'       ft_percent_d \tab numeric \tab Free-throw percentage allowed (defense). \cr
#'       x3p_rate \tab numeric \tab Three-point attempt rate (offense). \cr
#'       x3p_rate_d \tab numeric \tab Three-point attempt rate allowed (defense). \cr
#'       arate \tab numeric \tab Assist rate (offense). \cr
#'       arate_d \tab numeric \tab Assist rate allowed (defense). \cr
#'       year \tab integer \tab Season (echoes the \code{year} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
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
