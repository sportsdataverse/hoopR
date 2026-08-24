#' @title
#' **Bart Torvik Game Stats**
#' @description
#' **Get per-game team statistics from [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls one row per team-game for a season (the `getgamestats.php` export):
#' adjusted and raw offensive/defensive efficiency, the four factors on both ends,
#' tempo, the result, pre-game win probability, and the opposing coach. No API
#' key is required. barttorvik does not publish column headers for this file, so
#' the column names below are mapped from its observed positional layout. Data is
#' available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per team-game:
#'
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       date \tab character \tab Game date (M/D/YY). \cr
#'       type \tab numeric \tab Game-type flag. \cr
#'       team \tab character \tab Team name. \cr
#'       conf \tab character \tab Team conference. \cr
#'       opp \tab character \tab Opponent name. \cr
#'       venue \tab character \tab Venue relative to \code{team} (\code{H}/\code{A}/\code{N}). \cr
#'       result \tab character \tab Result string (e.g. \verb{L, 78-73}). \cr
#'       adj_oe \tab numeric \tab Adjusted offensive efficiency. \cr
#'       adj_de \tab numeric \tab Adjusted defensive efficiency. \cr
#'       oe \tab numeric \tab Raw offensive efficiency (points/100 poss). \cr
#'       off_efg \tab numeric \tab Offensive effective field goal percentage. \cr
#'       off_to \tab numeric \tab Offensive turnover percentage. \cr
#'       off_or \tab numeric \tab Offensive rebound percentage. \cr
#'       off_ftr \tab numeric \tab Offensive free-throw rate. \cr
#'       de \tab numeric \tab Raw defensive efficiency (points allowed/100 poss). \cr
#'       def_efg \tab numeric \tab Defensive effective field goal percentage allowed. \cr
#'       def_to \tab numeric \tab Defensive turnover percentage forced. \cr
#'       def_or \tab numeric \tab Defensive (opponent) rebound percentage. \cr
#'       def_ftr \tab numeric \tab Defensive free-throw rate allowed. \cr
#'       game_score \tab numeric \tab Bart Torvik single-game quality score. \cr
#'       opp_conf \tab character \tab Opponent conference. \cr
#'       year \tab integer \tab Season (4-digit ending-year). \cr
#'       tempo \tab numeric \tab Game tempo (possessions). \cr
#'       muid \tab character \tab Matchup unique id. \cr
#'       coach \tab character \tab Team head coach. \cr
#'       opp_coach \tab character \tab Opponent head coach. \cr
#'       win_prob \tab numeric \tab Pre-game win probability for \code{team}. \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
#'
#' @keywords Torvik
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_game_stats(year = 2024))
#' }
torvik_game_stats <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  # barttorvik's getgamestats.php is headerless; these are its 31 positional
  # fields. The 'game_stats' field is a nested per-game stat array (collapsed).
  game_cols <- c(
    "date", "type", "team", "conf", "opp", "venue", "result", "adj_oe", "adj_de",
    "oe", "off_efg", "off_to", "off_or", "off_ftr", "de", "def_efg", "def_to",
    "def_or", "def_ftr", "game_score", "opp_conf", "quad", "year", "tempo",
    "muid", "coach", "opp_coach", "margin", "win_prob", "game_stats", "overtimes"
  )

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/getgamestats.php?year=", year, "&json=1"))
      raw <- jsonlite::fromJSON(txt, simplifyVector = FALSE)

      mat <- do.call(rbind, lapply(raw, function(g) {
        vapply(g, function(x) {
          if (is.null(x) || length(x) == 0) NA_character_
          else paste(unlist(x), collapse = ";")
        }, character(1))
      }))

      df <- as.data.frame(mat, stringsAsFactors = FALSE)
      if (ncol(df) == length(game_cols)) colnames(df) <- game_cols
      df <- utils::type.convert(df, as.is = TRUE)
      df <- dplyr::as_tibble(janitor::clean_names(df))
      df <- make_hoopR_data(df, "Bart Torvik game stats from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no game stats available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching Torvik game stats for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
