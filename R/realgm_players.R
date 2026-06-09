#' @title
#' **RealGM NBA Player Index**
#' @description
#' **Get the active NBA player index from
#' [RealGM](https://basketball.realgm.com).**
#'
#' Returns RealGM's roster of active NBA players, including position, listed
#' height/weight, age, current team, years of service and pre-draft team -- the
#' pre-draft / international detail RealGM is known for.
#'
#' **Requires a headless browser.** RealGM is behind a Cloudflare JavaScript
#' challenge, so the `realgm_*()` functions drive headless Chrome via the
#' optional \pkg{chromote} package (install it and Google Chrome). A plain HTTP
#' client receives an HTTP 403 challenge page.
#' @return A `hoopR_data` tibble with one row per active player:
#'
#'    |col_name       |types     |description                                     |
#'    |:--------------|:---------|:-----------------------------------------------|
#'    |number         |integer   |Row number.                                     |
#'    |player         |character |Player name.                                    |
#'    |pos            |character |Position.                                       |
#'    |ht             |character |Listed height.                                  |
#'    |wt             |integer   |Listed weight (lbs).                            |
#'    |age            |numeric   |Age.                                            |
#'    |current_team   |character |Current NBA team.                               |
#'    |yos            |integer   |Years of service.                              |
#'    |pre_draft_team |character |Pre-draft team / school.                        |
#'    |draft_status   |character |Draft pick / undrafted status.                  |
#'    |nationality    |character |Player nationality.                             |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_players())
#' }
realgm_players <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/players")), must_have = "player")
      if (is.null(cand)) stop("RealGM player table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA player index from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "Invalid arguments or no RealGM player data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM players", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM NBA Players Abroad**
#' @description
#' **Get the list of NBA-affiliated players currently playing overseas from
#' [RealGM](https://basketball.realgm.com).**
#'
#' RealGM tracks NBA draft picks, two-way and free-agent players who are on
#' international rosters -- a view no first-party NBA/ESPN endpoint provides.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per player:
#'
#'    |col_name   |types     |description                                     |
#'    |:----------|:---------|:-----------------------------------------------|
#'    |player     |character |Player name.                                    |
#'    |pos        |character |Position.                                       |
#'    |ht         |character |Listed height.                                  |
#'    |wt         |integer   |Listed weight (lbs).                            |
#'    |nba_status |character |NBA contract / rights status.                   |
#'    |team_s     |character |Current overseas team(s) and NBA affiliation.   |
#'    |gp         |integer   |Games played.                                   |
#'    |mpg        |numeric   |Minutes per game.                               |
#'    |ppg        |numeric   |Points per game.                                |
#'    |rpg        |numeric   |Rebounds per game.                              |
#'    |apg        |numeric   |Assists per game.                               |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_players_abroad())
#' }
realgm_players_abroad <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/players-abroad")),
                           must_have = c("player", "nba_status"))
      if (is.null(cand)) stop("RealGM players-abroad table not found", call. = FALSE)
      df <- .realgm_finish(cand, "NBA players abroad from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM players-abroad data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM players abroad", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title
#' **RealGM Future NBA Free Agents**
#' @description
#' **Get RealGM's projected future NBA free-agent class from
#' [RealGM](https://basketball.realgm.com).**
#'
#' One row per upcoming free agent, including the free-agency season, the
#' player's Bird/veteran free-agent status, recent production and -- distinctively
#' -- the player's listed agent.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @return A `hoopR_data` tibble with one row per future free agent:
#'
#'    |col_name           |types     |description                              |
#'    |:------------------|:---------|:----------------------------------------|
#'    |player             |character |Player name.                             |
#'    |pos                |character |Position.                                |
#'    |team               |character |Current team abbreviation.               |
#'    |season             |character |Free-agency season (e.g. `2026-2027`).   |
#'    |age                |integer   |Age.                                     |
#'    |yos                |integer   |Years of service.                        |
#'    |veteran_fa_status  |character |Bird / Non-Bird / veteran FA status.     |
#'    |gp                 |integer   |Games played.                            |
#'    |pts                |numeric   |Points per game.                         |
#'    |reb                |numeric   |Rebounds per game.                       |
#'    |ast                |numeric   |Assists per game.                        |
#'    |per                |numeric   |Player Efficiency Rating.                |
#'    |agent              |character |Listed player agent.                     |
#'
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @family RealGM Functions
#' @export
#' @examples
#' \dontrun{
#'   try(realgm_future_free_agents())
#' }
realgm_future_free_agents <- function() {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      cand <- .realgm_pick(.realgm_tables(.realgm_doc("/nba/future_free_agents")),
                           must_have = c("player", "agent"))
      if (is.null(cand)) stop("RealGM future-free-agents table not found", call. = FALSE)
      df <- .realgm_finish(cand, "Future NBA free agents from basketball.realgm.com")
    },
    error = function(e) {
      .report_api_error(e, hint = "No RealGM future-free-agent data available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning fetching RealGM future free agents", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
