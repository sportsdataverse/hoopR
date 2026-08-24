#' @title
#' **Bart Torvik Player Season Stats**
#' @description
#' **Get player advanced season statistics from
#' [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls every player's advanced season stat line for a year (the
#' `getadvstats.php` CSV export). No API key is required. barttorvik does not
#' publish column headers for this file, so the column names below are mapped
#' from Bart Torvik's standard player advanced-stats layout (consistent from
#' 2010 onward). Data is available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per player (key columns shown):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       player_name \tab character \tab Player name. \cr
#'       team \tab character \tab Team name. \cr
#'       conf \tab character \tab Conference abbreviation. \cr
#'       games \tab integer \tab Games played. \cr
#'       min_pct \tab numeric \tab Percentage of available minutes played. \cr
#'       o_rtg \tab numeric \tab Offensive rating (points produced per 100 poss). \cr
#'       usage \tab numeric \tab Usage rate. \cr
#'       e_fg \tab numeric \tab Effective field goal percentage. \cr
#'       ts_pct \tab numeric \tab True shooting percentage. \cr
#'       orb_pct \tab numeric \tab Offensive rebound percentage. \cr
#'       drb_pct \tab numeric \tab Defensive rebound percentage. \cr
#'       ast_pct \tab numeric \tab Assist percentage. \cr
#'       to_pct \tab numeric \tab Turnover percentage. \cr
#'       ft_pct \tab numeric \tab Free-throw percentage. \cr
#'       two_p_pct \tab numeric \tab Two-point field goal percentage. \cr
#'       three_p_pct \tab numeric \tab Three-point field goal percentage. \cr
#'       blk_pct \tab numeric \tab Block percentage. \cr
#'       stl_pct \tab numeric \tab Steal percentage. \cr
#'       ftr \tab numeric \tab Free-throw rate. \cr
#'       class \tab character \tab Class (Fr/So/Jr/Sr). \cr
#'       height \tab character \tab Listed height. \cr
#'       porpag \tab numeric \tab Points over replacement per adjusted game. \cr
#'       adj_oe \tab numeric \tab Adjusted offensive efficiency. \cr
#'       year \tab integer \tab Season (4-digit ending-year). \cr
#'       player_id \tab integer \tab Bart Torvik player id. \cr
#'       hometown \tab character \tab Player hometown. \cr
#'       bpm \tab numeric \tab Box plus/minus. \cr
#'       obpm \tab numeric \tab Offensive box plus/minus. \cr
#'       dbpm \tab numeric \tab Defensive box plus/minus. \cr
#'       role \tab character \tab Bart Torvik player role/position label. \cr
#'       pts \tab numeric \tab Points per game. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   Additional made/attempt splits (`ftm`/`fta`, `two_pm`/`two_pa`,
#'   `three_pm`/`three_pa`), rim/mid/dunk shooting splits, defensive ratings
#'   (`drtg`, `adrtg`, `stops`), and game-box averages (`oreb`, `dreb`, `ast`,
#'   `stl`, `blk`) are also returned.
#'
#' @keywords Torvik
#' @importFrom data.table fread
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_player_stats(year = 2024))
#' }
torvik_player_stats <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  # barttorvik's getadvstats.php CSV is headerless; these are its 67 positional
  # fields in Bart Torvik's standard player advanced-stats order.
  player_cols <- c(
    "player_name", "team", "conf", "games", "min_pct", "o_rtg", "usage", "e_fg",
    "ts_pct", "orb_pct", "drb_pct", "ast_pct", "to_pct", "ftm", "fta", "ft_pct",
    "two_pm", "two_pa", "two_p_pct", "three_pm", "three_pa", "three_p_pct",
    "blk_pct", "stl_pct", "ftr", "class", "height", "number", "porpag", "adj_oe",
    "pfr", "year", "player_id", "hometown", "rec_rank", "ast_to", "rim_made",
    "rim_attempts", "mid_made", "mid_attempts", "rim_pct", "mid_pct", "dunks_made",
    "dunks_attempts", "dunks_pct", "pick", "drtg", "adrtg", "dporpag", "stops",
    "bpm", "obpm", "dbpm", "gbpm", "minutes", "ogbpm", "dgbpm", "oreb", "dreb",
    "treb", "ast", "stl", "blk", "pts", "role", "threat", "recruit_date"
  )

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/getadvstats.php?year=", year, "&csv=1"))
      df <- data.table::fread(text = txt, header = FALSE, fill = TRUE, showProgress = FALSE)
      if (ncol(df) == length(player_cols)) names(df) <- player_cols
      df <- dplyr::as_tibble(janitor::clean_names(as.data.frame(df)))
      df <- make_hoopR_data(df, "Bart Torvik player season stats from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no player stats available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching Torvik player stats for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
