#' @title
#' **Basketball-Reference Standings**
#' @description
#' **Get end-of-season conference standings from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' No API key is required. Basketball-Reference rate-limits aggressive scraping
#' (~20 requests/minute) -- space repeated calls with `Sys.sleep()`.
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per team:
#'
#'    |col_name      |types     |description                                      |
#'    |:-------------|:---------|:------------------------------------------------|
#'    |conference    |character |Conference (`E` or `W`).                         |
#'    |team          |character |Team name (with playoff-seed marker stripped).   |
#'    |wins          |integer   |Wins.                                            |
#'    |losses        |integer   |Losses.                                          |
#'    |win_loss_pct  |numeric   |Win-loss percentage.                             |
#'    |gb            |character |Games behind the conference leader.              |
#'    |pts_per_g     |numeric   |Points scored per game.                          |
#'    |opp_pts_per_g |numeric   |Opponent points per game.                        |
#'    |srs           |numeric   |Simple Rating System (point margin + SOS).       |
#'    |playoffs      |logical   |`TRUE` if the team made the playoffs (`*` marker).|
#'    |season        |integer   |Season (echoes the `season` argument).           |
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble rename any_of bind_rows
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_standings(season = 2024))
#' }
bref_standings <- function(season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/leagues/NBA_", season, "_standings.html"))
      one <- function(id, conf) {
        d <- .bref_table(html, id)
        if (nrow(d) == 0) return(NULL)
        d <- d[rowSums(!is.na(d) & d != "") > 0, , drop = FALSE]
        d[["conference"]] <- conf
        d
      }
      df <- dplyr::bind_rows(one("confs_standings_E", "E"), one("confs_standings_W", "W"))
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df <- dplyr::rename(df, dplyr::any_of(c("team" = "team_name")))
      # the trailing '*' marks playoff teams -- surface it as a flag, clean the name
      if ("team" %in% colnames(df)) {
        df[["playoffs"]] <- grepl("\\*", df[["team"]])
        df[["team"]] <- trimws(gsub("\\*", "", df[["team"]]))
      }
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Standings from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no standings available for {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF standings for {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
