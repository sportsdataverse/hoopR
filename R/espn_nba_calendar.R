#' **Get ESPN NBA Calendar**
#' @rdname espn_mbb_calendar
#' @name espn_nba_calendar
NULL
#' @title
#' **Get ESPN NBA Calendar**
#' @rdname espn_mbb_calendar
#' @author Saiem Gilani
#' @return Returns a tibble of calendar entries.
#'
#'    Columns as documented in the shared [espn_mbb_calendar_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr as_tibble
#' @importFrom janitor clean_names
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @details
#' Retrieve the ESPN NBA schedule calendar for a given season. The underlying
#' scoreboard response contains a `leagues[[1]]$calendar` block with season-type
#' entries (pre-season, regular, post). Uses `getOption("hoopR.proxy")` or
#' `http_proxy`/`https_proxy` environment variables for proxy configuration
#' (per-call proxy override is not supported for ESPN wrappers).
#' @examples
#' \donttest{
#'   espn_nba_calendar(season = 2025)
#' }
espn_nba_calendar <- function(season = most_recent_nba_season()) {
  .args <- mget(setdiff(names(formals()), "..."))
  .espn_basketball_calendar(
    league = "nba",
    season = season
  )
}
