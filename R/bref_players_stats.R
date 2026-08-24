#' @title
#' **Basketball-Reference Player Season Stats**
#' @description
#' **Get player season statistics from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' Scrapes the league-wide player stat table for a season. No API key is
#' required. Choose the stat table with `table`. Data is available back to the
#' 1947 (BAA) season for most tables.
#'
#' Basketball-Reference rate-limits aggressive scraping (~20 requests/minute) --
#' space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024` for the 2023-24 season). Defaults to `most_recent_nba_season()`.
#' @param table (*character* optional): Which stat table to return. One of
#'   `per_game` (default), `totals`, `advanced`, `per_minute` (per 36 minutes),
#'   or `per_poss` (per 100 possessions).
#' @return A `hoopR_data` tibble with one row per player (columns vary by
#'   `table`; common identifying columns shown -- column names are
#'   Basketball-Reference `data-stat` keys):
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       ranker \tab integer \tab Row rank. \cr
#'       player \tab character \tab Player name. \cr
#'       age \tab integer \tab Player age on Feb 1 of the season. \cr
#'       team_id \tab character \tab Team abbreviation (\code{TOT} for players on >1 team). \cr
#'       pos \tab character \tab Position. \cr
#'       g \tab integer \tab Games played. \cr
#'       gs \tab integer \tab Games started. \cr
#'       mp_per_g \tab numeric \tab Minutes (per_game table) / \code{mp} total (totals table). \cr
#'       pts_per_g \tab numeric \tab Points (scaled to the chosen \code{table}). \cr
#'       season \tab integer \tab Season (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#'   The `advanced` table adds `per`, `ts_pct`, `usg_pct`, `ws`, `bpm`, `vorp`,
#'   etc.; `totals`/`per_minute`/`per_poss` return the same box categories scaled
#'   accordingly.
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of
#' @importFrom cli cli_abort
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_players_stats(season = 2024, table = "per_game"))
#' }
bref_players_stats <- function(season = most_recent_nba_season(), table = "per_game") {
  .args <- .capture_args()

  valid <- c("per_game", "totals", "advanced", "per_minute", "per_poss")
  if (!table %in% valid) {
    cli::cli_abort(c(
      "Unsupported {.arg table}.",
      "i" = "{.arg table} must be one of: {.val {valid}}.",
      "x" = "You called {.code table = {.val {table}}}."
    ))
  }

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/leagues/NBA_", season, "_", table, ".html"))
      df <- .bref_table(html)
      # drop fully-empty separator rows
      df <- df[rowSums(!is.na(df) & df != "") > 0, , drop = FALSE]
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c(
        "player" = "name_display", "team" = "team_name_abbr",
        "g" = "games", "gs" = "games_started")))
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Player season stats from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no player stats available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF player stats for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
