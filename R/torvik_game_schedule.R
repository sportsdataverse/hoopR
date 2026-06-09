#' @title
#' **Bart Torvik Season Schedule & Results**
#' @description
#' **Get the full game-by-game schedule and results for a season from
#' [barttorvik.com](https://barttorvik.com).**
#'
#' Pulls Bart Torvik's "super schedule" (the `{year}_super_sked.json` file): one
#' row per game with the pre-game prediction, both teams' adjusted efficiencies
#' and tempo, the final result, and post-game game-quality metrics. No API key is
#' required. Data is available from 2008 to present.
#' @param year (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_mbb_season()`.
#' @return A `hoopR_data` tibble with one row per game (key columns shown; the
#'   `_1`/`_2` suffixes denote `team1` and `team2`):
#'
#'    |col_name    |types     |description                                          |
#'    |:-----------|:---------|:----------------------------------------------------|
#'    |muid        |character |Matchup unique id.                                   |
#'    |date        |character |Game date (M/D/YY).                                  |
#'    |conmatch    |character |Conference matchup descriptor.                       |
#'    |matchup     |character |Ranked-matchup descriptor.                           |
#'    |prediction  |character |Pre-game prediction (favorite, score, win %).        |
#'    |ttq         |numeric   |Torvik Thrill Quotient (game excitement).            |
#'    |conf        |numeric   |Conference-game flag.                                |
#'    |venue       |numeric   |Venue / neutral-site flag.                           |
#'    |team1       |character |Team 1 name.                                         |
#'    |t1oe        |numeric   |Team 1 offensive efficiency in the game.             |
#'    |t1de        |numeric   |Team 1 defensive efficiency in the game.             |
#'    |team2       |character |Team 2 name.                                         |
#'    |t2oe        |numeric   |Team 2 offensive efficiency in the game.             |
#'    |t2de        |numeric   |Team 2 defensive efficiency in the game.             |
#'    |gp          |numeric   |Game-played flag (1 if completed).                   |
#'    |result      |character |Final result string.                                 |
#'    |tempo       |numeric   |Game tempo (possessions).                            |
#'    |possessions |numeric   |Possessions in the game.                             |
#'    |t1pts       |numeric   |Team 1 points.                                       |
#'    |t2pts       |numeric   |Team 2 points.                                       |
#'    |winner      |character |Winning team.                                        |
#'    |loser       |character |Losing team.                                         |
#'    |gamevalue   |numeric   |Game quality value.                                  |
#'    |t1ppp       |numeric   |Team 1 points per possession.                        |
#'    |t2ppp       |numeric   |Team 2 points per possession.                        |
#'    |overtimes   |numeric   |Number of overtimes.                                 |
#'    |year        |integer   |Season (echoes the `year` argument).                 |
#'
#'   Additional adjusted-efficiency, quality, and ranking columns (`t1adjo`,
#'   `t2adjd`, `t1qual`, `mismatch`, `t1rk`, ...) are also returned.
#'
#' @keywords Torvik
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Torvik Functions
#' @export
#' @examples
#' \donttest{
#'   try(torvik_game_schedule(year = 2024))
#' }
torvik_game_schedule <- function(year = most_recent_mbb_season()) {
  .args <- .capture_args()

  # The 55 positional fields of barttorvik's {year}_super_sked.json, per Torvik's
  # documentation (https://adamcwisports.blogspot.com/p/data.html).
  field_names <- c(
    "muid", "date", "conmatch", "matchup", "prediction", "ttq", "conf", "venue",
    "team1", "t1oe", "t1de", "t1py", "t1wp", "t1propt",
    "team2", "t2oe", "t2de", "t2py", "t2wp", "t2propt",
    "tpro", "t1qual", "t2qual", "gp", "result", "tempo", "possessions", "t1pts",
    "t2pts", "winner", "loser", "t1adjt", "t2adjt", "t1adjo", "t1adjd", "t2adjo",
    "t2adjd", "gamevalue", "mismatch", "blowout", "t1elite", "t2elite", "ord_date",
    "t1ppp", "t2ppp", "gameppp", "t1rk", "t2rk", "t1gs", "t2gs", "gamestats",
    "overtimes", "t1fun", "t2fun", "results"
  )

  df <- data.frame()

  tryCatch(
    expr = {
      txt <- .torvik_text(paste0("/", year, "_super_sked.json"))
      raw <- jsonlite::fromJSON(txt, simplifyVector = FALSE)

      # Coerce each game's 55 elements to scalar character (collapsing any nested
      # game-stat sub-arrays), then build a rectangular frame and type-convert.
      mat <- do.call(rbind, lapply(raw, function(g) {
        vapply(g, function(x) {
          if (is.null(x) || length(x) == 0) NA_character_
          else paste(unlist(x), collapse = ";")
        }, character(1))
      }))

      df <- as.data.frame(mat, stringsAsFactors = FALSE)
      if (ncol(df) == length(field_names)) colnames(df) <- field_names
      df <- utils::type.convert(df, as.is = TRUE)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df[["year"]] <- as.integer(year)
      df <- make_hoopR_data(df, "Bart Torvik season schedule from barttorvik.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no schedule available for {year}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching Torvik schedule for {year}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
