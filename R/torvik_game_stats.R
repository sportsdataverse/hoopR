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
#'    |col_name  |types     |description                                          |
#'    |:---------|:---------|:----------------------------------------------------|
#'    |date      |character |Game date (M/D/YY).                                  |
#'    |type      |numeric   |Game-type flag.                                      |
#'    |team      |character |Team name.                                           |
#'    |conf      |character |Team conference.                                     |
#'    |opp       |character |Opponent name.                                       |
#'    |venue     |character |Venue relative to `team` (`H`/`A`/`N`).              |
#'    |result    |character |Result string (e.g. `L, 78-73`).                     |
#'    |adj_oe    |numeric   |Adjusted offensive efficiency.                       |
#'    |adj_de    |numeric   |Adjusted defensive efficiency.                       |
#'    |oe        |numeric   |Raw offensive efficiency (points/100 poss).          |
#'    |off_efg   |numeric   |Offensive effective field goal percentage.           |
#'    |off_to    |numeric   |Offensive turnover percentage.                       |
#'    |off_or    |numeric   |Offensive rebound percentage.                        |
#'    |off_ftr   |numeric   |Offensive free-throw rate.                           |
#'    |de        |numeric   |Raw defensive efficiency (points allowed/100 poss).  |
#'    |def_efg   |numeric   |Defensive effective field goal percentage allowed.   |
#'    |def_to    |numeric   |Defensive turnover percentage forced.                |
#'    |def_or    |numeric   |Defensive (opponent) rebound percentage.             |
#'    |def_ftr   |numeric   |Defensive free-throw rate allowed.                   |
#'    |game_score|numeric   |Bart Torvik single-game quality score.               |
#'    |opp_conf  |character |Opponent conference.                                 |
#'    |year      |integer   |Season (4-digit ending-year).                        |
#'    |tempo     |numeric   |Game tempo (possessions).                            |
#'    |muid      |character |Matchup unique id.                                   |
#'    |coach     |character |Team head coach.                                     |
#'    |opp_coach |character |Opponent head coach.                                 |
#'    |win_prob  |numeric   |Pre-game win probability for `team`.                 |
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
