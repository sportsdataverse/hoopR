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
#'    |col_name          |types     |description                                       |
#'    |:-----------------|:---------|:-------------------------------------------------|
#'    |team_name         |character |Team name.                                        |
#'    |e_fg_percent      |numeric   |Effective field goal percentage (offense).        |
#'    |e_fg_percent_def  |numeric   |Effective field goal percentage allowed (defense).|
#'    |ftr               |numeric   |Free-throw rate (offense).                         |
#'    |ftr_def           |numeric   |Free-throw rate allowed (defense).                |
#'    |or_percent        |numeric   |Offensive rebound percentage.                     |
#'    |dr_percent        |numeric   |Defensive rebound percentage.                     |
#'    |to_percent        |numeric   |Turnover percentage (offense).                    |
#'    |to_percent_def    |numeric   |Turnover percentage forced (defense).             |
#'    |x3p_percent       |numeric   |Three-point percentage (offense).                 |
#'    |x3p_d_percent     |numeric   |Three-point percentage allowed (defense).         |
#'    |x2p_percent       |numeric   |Two-point percentage (offense).                   |
#'    |x2p_percent_d     |numeric   |Two-point percentage allowed (defense).           |
#'    |ft_percent        |numeric   |Free-throw percentage (offense).                  |
#'    |ft_percent_d      |numeric   |Free-throw percentage allowed (defense).          |
#'    |x3p_rate          |numeric   |Three-point attempt rate (offense).               |
#'    |x3p_rate_d        |numeric   |Three-point attempt rate allowed (defense).       |
#'    |arate             |numeric   |Assist rate (offense).                            |
#'    |arate_d           |numeric   |Assist rate allowed (defense).                    |
#'    |year              |integer   |Season (echoes the `year` argument).              |
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
