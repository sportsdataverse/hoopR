#' @title
#' **Basketball-Reference Team Roster**
#' @description
#' **Get a team's season roster from
#' [Basketball-Reference](https://www.basketball-reference.com).**
#'
#' No API key is required. Basketball-Reference rate-limits aggressive scraping
#' (~20 requests/minute) -- space repeated calls with `Sys.sleep()`.
#' @param team (*character* required): Basketball-Reference team abbreviation
#'   (e.g. `BOS`, `LAL`, `GSW`). Historical franchises use their era code
#'   (e.g. `NJN`, `SEA`).
#' @param season (*integer* required): Season, in 4-digit ending-year format
#'   (e.g. `2024`). Defaults to `most_recent_nba_season()`.
#' @return A `hoopR_data` tibble with one row per player on the roster:
#'
#'    |col_name         |types     |description                                   |
#'    |:----------------|:---------|:---------------------------------------------|
#'    |number           |character |Jersey number.                                |
#'    |player           |character |Player name.                                  |
#'    |pos              |character |Position.                                     |
#'    |height           |character |Height.                                       |
#'    |weight           |integer   |Weight (lbs).                                 |
#'    |birth_date       |character |Birth date.                                   |
#'    |years_experience |character |Years of NBA experience (`R` for rookies).    |
#'    |college          |character |College.                                      |
#'    |team             |character |Team abbreviation (echoes the `team` argument).|
#'    |season           |integer   |Season (echoes the `season` argument).        |
#'
#' @keywords Basketball-Reference
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family Basketball-Reference Functions
#' @export
#' @examples
#' \donttest{
#'   try(bref_team_roster(team = "BOS", season = 2024))
#' }
bref_team_roster <- function(team, season = most_recent_nba_season()) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      html <- .bref_text(paste0("/teams/", toupper(team), "/", season, ".html"))
      df <- .bref_table(html, "roster")
      df <- df[rowSums(!is.na(df) & df != "") > 0, , drop = FALSE]
      df <- .bref_type_convert(df)
      df <- janitor::clean_names(dplyr::as_tibble(df))
      df[["team"]] <- toupper(team)
      df[["season"]] <- as.integer(season)
      df <- make_hoopR_data(df, "Team roster from basketball-reference.com", Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no roster available for {team} {season}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching BREF roster for {team} {season}", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
