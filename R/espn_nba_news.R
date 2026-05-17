#' **Get ESPN NBA News**
#' @name espn_nba_news
NULL
#' @title
#' **Get ESPN NBA News**
#' @rdname espn_nba_news
#' @author Saiem Gilani
#' @param limit integer. Maximum number of articles to return. Default `50`.
#' @return Returns a tibble of news articles.
#'
#'    |col_name    |types     |description                       |
#'    |:-----------|:---------|:---------------------------------|
#'    |id          |character |Id.                               |
#'    |type        |character |Record type / category.           |
#'    |headline    |character |News headline.                    |
#'    |description |character |Long-form description text.       |
#'    |published   |character |Publication timestamp (ISO 8601). |
#'    |premium     |logical   |                                  |
#'    |byline      |character |News article byline / author.     |
#'    |link_web    |character |Web link / URL.                   |
#'    |league_id   |character |League identifier ('10' = WNBA).  |
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
#' @name espn_nba_team_news
NULL
#' @title
#' **Get ESPN NBA Team News**
#' @rdname espn_nba_team_news
#' @author Saiem Gilani
#' @param team_id character or integer. ESPN team ID (e.g. `17` for
#'   Las Vegas Aces).
#' @param limit integer. Maximum number of articles to return. Default `25`.
#' @return Returns a tibble of team news articles.
#'
#'    |col_name    |types     |description                       |
#'    |:-----------|:---------|:---------------------------------|
#'    |id          |character |Id.                               |
#'    |type        |character |Record type / category.           |
#'    |headline    |character |News headline.                    |
#'    |description |character |Long-form description text.       |
#'    |published   |character |Publication timestamp (ISO 8601). |
#'    |premium     |logical   |                                  |
#'    |byline      |character |News article byline / author.     |
#'    |link_web    |character |Web link / URL.                   |
#'    |league_id   |character |League identifier ('10' = WNBA).  |
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
#'   espn_nba_team_news(team_id = "17", limit = 5)
#' }
espn_nba_team_news <- function(team_id, limit = 25) {
  .args <- mget(setdiff(names(formals()), "..."))
  .espn_basketball_team_news(
    league  = "nba",
    team_id = team_id,
    limit   = limit
  )
}
