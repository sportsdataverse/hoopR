#' @title
#' **Bart Torvik T-Rank Ratings**
#' @description
#' **Get year-end / current T-Rank team ratings and adjusted efficiencies from
#' [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls the full T-Rank team table for a season (the `{year}_team_results.csv`
#' file). No API key is required. Data is available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024` for the 2023-24 season). Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       rank \tab integer \tab Overall T-Rank (barthag) rank. \cr
#'       team \tab character \tab Team name. \cr
#'       conf \tab character \tab Conference abbreviation. \cr
#'       record \tab character \tab Overall win-loss record. \cr
#'       adjoe \tab numeric \tab Adjusted offensive efficiency (pts/100 poss). \cr
#'       oe_rank \tab integer \tab National rank of adjusted offensive efficiency. \cr
#'       adjde \tab numeric \tab Adjusted defensive efficiency (pts/100 poss). \cr
#'       de_rank \tab integer \tab National rank of adjusted defensive efficiency. \cr
#'       barthag \tab numeric \tab Power rating: win probability vs. an average team. \cr
#'       proj_w \tab numeric \tab Projected wins. \cr
#'       proj_l \tab numeric \tab Projected losses. \cr
#'       pro_con_w \tab numeric \tab Projected conference wins. \cr
#'       pro_con_l \tab numeric \tab Projected conference losses. \cr
#'       con_rec \tab character \tab Conference record. \cr
#'       sos \tab numeric \tab Strength of schedule. \cr
#'       ncsos \tab numeric \tab Non-conference strength of schedule. \cr
#'       consos \tab numeric \tab Conference strength of schedule. \cr
#'       qual_o \tab numeric \tab Quality-adjusted offensive efficiency. \cr
#'       qual_d \tab numeric \tab Quality-adjusted defensive efficiency. \cr
#'       qual_barthag \tab numeric \tab Quality-adjusted power rating. \cr
#'       wab \tab numeric \tab Wins above bubble. \cr
#'       wab_rk \tab integer \tab National rank of wins above bubble. \cr
#'       adjt \tab numeric \tab Adjusted tempo (possessions per 40 minutes). \cr
#'       year \tab integer \tab Season (4-digit ending-year; echoes the \code{year} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   Additional projected / opponent / conference split columns (`proj_sos`,
#'   `opp_oe`, `con_adj_oe`, `con_pf`, `fun`, ...) are also returned.
#'
#' @keywords Torvik
#' @importFrom data.table fread
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble mutate
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_ratings(year = 2024))
#' }
torvik_ratings <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/", year, "_team_results.csv"))
      df <- data.table::fread(text = txt, showProgress = FALSE)
      df <- dplyr::as_tibble(janitor::clean_names(as.data.frame(df)))
      df[["year"]] <- as.integer(year)
      df <- make_hoopR_data(df, "Bart Torvik T-Rank ratings from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no T-Rank ratings available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching T-Rank ratings for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
