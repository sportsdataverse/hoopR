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
#'    |col_name    |types     |description                                       |
#'    |:-----------|:---------|:-------------------------------------------------|
#'    |player_name |character |Player name.                                      |
#'    |team        |character |Team name.                                        |
#'    |conf        |character |Conference abbreviation.                          |
#'    |games       |integer   |Games played.                                     |
#'    |min_pct     |numeric   |Percentage of available minutes played.           |
#'    |o_rtg       |numeric   |Offensive rating (points produced per 100 poss).  |
#'    |usage       |numeric   |Usage rate.                                       |
#'    |e_fg        |numeric   |Effective field goal percentage.                  |
#'    |ts_pct      |numeric   |True shooting percentage.                          |
#'    |orb_pct     |numeric   |Offensive rebound percentage.                     |
#'    |drb_pct     |numeric   |Defensive rebound percentage.                     |
#'    |ast_pct     |numeric   |Assist percentage.                                |
#'    |to_pct      |numeric   |Turnover percentage.                              |
#'    |ft_pct      |numeric   |Free-throw percentage.                            |
#'    |two_p_pct   |numeric   |Two-point field goal percentage.                  |
#'    |three_p_pct |numeric   |Three-point field goal percentage.                |
#'    |blk_pct     |numeric   |Block percentage.                                 |
#'    |stl_pct     |numeric   |Steal percentage.                                 |
#'    |ftr         |numeric   |Free-throw rate.                                  |
#'    |class       |character |Class (Fr/So/Jr/Sr).                              |
#'    |height      |character |Listed height.                                    |
#'    |porpag      |numeric   |Points over replacement per adjusted game.        |
#'    |adj_oe      |numeric   |Adjusted offensive efficiency.                    |
#'    |year        |integer   |Season (4-digit ending-year).                     |
#'    |player_id   |integer   |Bart Torvik player id.                            |
#'    |hometown    |character |Player hometown.                                  |
#'    |bpm         |numeric   |Box plus/minus.                                   |
#'    |obpm        |numeric   |Offensive box plus/minus.                         |
#'    |dbpm        |numeric   |Defensive box plus/minus.                         |
#'    |role        |character |Bart Torvik player role/position label.           |
#'    |pts         |numeric   |Points per game.                                  |
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
