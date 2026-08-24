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
#'    \if{html}{\tabular{lll}{
#'       col_name \tab types \tab description \cr
#'       number \tab character \tab Jersey number. \cr
#'       player \tab character \tab Player name. \cr
#'       pos \tab character \tab Position. \cr
#'       height \tab character \tab Height. \cr
#'       weight \tab integer \tab Weight (lbs). \cr
#'       birth_date \tab character \tab Birth date. \cr
#'       years_experience \tab character \tab Years of NBA experience (\code{R} for rookies). \cr
#'       college \tab character \tab College. \cr
#'       team \tab character \tab Team abbreviation (echoes the \code{team} argument). \cr
#'       season \tab integer \tab Season (echoes the \code{season} argument). \cr
#'    }}
#'    \if{latex}{See the HTML help or pkgdown reference for the column table.}
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
