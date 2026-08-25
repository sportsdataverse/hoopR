#' **Get ESPN NBA News**
#' @rdname espn_mbb_news
#' @name espn_nba_news
NULL
#' @title
#' **Get ESPN NBA News**
#' @rdname espn_mbb_news
#' @author Saiem Gilani
#' @param limit integer. Maximum number of articles to return. Default `50`.
#' @return Returns a tibble of news articles.
#'
#'    Columns as documented in the shared [espn_mbb_news_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr select as_tibble
#' @importFrom janitor clean_names
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @details
#' Retrieve ESPN NBA news. Uses `getOption("hoopR.proxy")` or
#' `http_proxy`/`https_proxy` environment variables for proxy configuration
#' (per-call proxy override is not supported for ESPN wrappers).
#' @examples
#' \donttest{
#'   espn_nba_news(limit = 5)
#' }
espn_nba_news <- function(limit = 50) {
  .args <- mget(setdiff(names(formals()), "..."))
  .espn_basketball_news(league = "nba", limit = limit)
}


#' **Get ESPN NBA Team News**
#' @rdname espn_mbb_team_news
#' @name espn_nba_team_news
NULL
#' @title
#' **Get ESPN NBA Team News**
#' @rdname espn_mbb_team_news
#' @author Saiem Gilani
#' @param limit integer. Maximum number of articles to return. Default `25`.
#' @return Returns a tibble of team news articles.
#'
#'    Columns as documented in the shared [espn_mbb_news_schema] table.
#'
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr select as_tibble
#' @importFrom janitor clean_names
#' @import rvest
#' @export
#' @family ESPN NBA Functions
#' @details
#' Retrieve ESPN NBA news for a specific team. Uses
#' `getOption("hoopR.proxy")` or `http_proxy`/`https_proxy` environment
#' variables for proxy configuration (per-call proxy override is not
#' supported for ESPN wrappers).
#' @examples
#' \donttest{
#'   espn_nba_team_news(team_id = "13", limit = 5)
#' }
espn_nba_team_news <- function(team_id, limit = 25) {
  .args <- mget(setdiff(names(formals()), "..."))
  .espn_basketball_team_news(
    league  = "nba",
    team_id = team_id,
    limit   = limit
  )
}
