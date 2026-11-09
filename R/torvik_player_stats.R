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
#'
#' Since November 2026 the file has 78 fields: barttorvik appended 11
#' undocumented fields after the original 67. Those 67 keep their names; any
#' field after them is returned under its position, `v68` to `v78`.
#' A file with fewer than 67 fields (2008 and 2009 skip the play-by-play
#' fields) keeps positional names for every column (`v1`, `v2`, ...), since
#' the documented names cannot be placed reliably.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @eval .returns_rd("torvik_player_stats", inline = FALSE, unit = "player")
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

  # barttorvik's getadvstats.php CSV is headerless; these are its first 67
  # positional fields in Bart Torvik's standard player advanced-stats order.
  # Undocumented fields appended after them keep positional names (v68, ...).
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
      # A shorter file (2008-2009 drop the play-by-play fields) keeps V1, V2, ...
      if (ncol(df) >= length(player_cols)) {
        names(df)[seq_along(player_cols)] <- player_cols
      }
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
