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
#'    |col_name          |types     |description                                       |
#'    |:-----------------|:---------|:-------------------------------------------------|
#'    |rank              |integer   |Overall T-Rank (barthag) rank.                    |
#'    |team              |character |Team name.                                        |
#'    |conf              |character |Conference abbreviation.                          |
#'    |record            |character |Overall win-loss record.                          |
#'    |adjoe             |numeric   |Adjusted offensive efficiency (pts/100 poss).     |
#'    |oe_rank           |integer   |National rank of adjusted offensive efficiency.   |
#'    |adjde             |numeric   |Adjusted defensive efficiency (pts/100 poss).     |
#'    |de_rank           |integer   |National rank of adjusted defensive efficiency.   |
#'    |barthag           |numeric   |Power rating: win probability vs. an average team.|
#'    |proj_w            |numeric   |Projected wins.                                   |
#'    |proj_l            |numeric   |Projected losses.                                 |
#'    |pro_con_w         |numeric   |Projected conference wins.                        |
#'    |pro_con_l         |numeric   |Projected conference losses.                      |
#'    |con_rec           |character |Conference record.                                |
#'    |sos               |numeric   |Strength of schedule.                             |
#'    |ncsos             |numeric   |Non-conference strength of schedule.              |
#'    |consos            |numeric   |Conference strength of schedule.                  |
#'    |qual_o            |numeric   |Quality-adjusted offensive efficiency.            |
#'    |qual_d            |numeric   |Quality-adjusted defensive efficiency.            |
#'    |qual_barthag      |numeric   |Quality-adjusted power rating.                    |
#'    |wab               |numeric   |Wins above bubble.                                |
#'    |wab_rk            |integer   |National rank of wins above bubble.               |
#'    |adjt              |numeric   |Adjusted tempo (possessions per 40 minutes).      |
#'    |year              |integer   |Season (4-digit ending-year; echoes the `year` argument). |
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
