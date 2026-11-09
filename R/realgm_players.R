#' @title
#' **RealGM NBA Player Index**
#' @description
#' **Get the active NBA player index from
#' RealGM (basketball.realgm.com).**
#'
#' Returns RealGM's roster of active NBA players, including position, listed
#' height/weight, age, current team, years of service and pre-draft team -- the
#' pre-draft / international detail RealGM is known for.
#'
#' **Requires a headless browser.** RealGM is behind a Cloudflare JavaScript
#' challenge, so the `realgm_*()` functions drive headless Chrome via the
#' optional \pkg{chromote} package (install it and Google Chrome). A plain HTTP
#' client receives an HTTP 403 challenge page.
#' @eval .returns_rd("realgm_players", inline = FALSE, unit = "active player")
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @concept RealGM Functions
#' @seealso [family_realgm] lists every function in this family.
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
#' RealGM (basketball.realgm.com).**
#'
#' RealGM tracks NBA draft picks, two-way and free-agent players who are on
#' international rosters -- a view no first-party NBA/ESPN endpoint provides.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @eval .returns_rd("realgm_players_abroad", inline = FALSE, unit = "player")
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @concept RealGM Functions
#' @seealso [family_realgm] lists every function in this family.
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
#' RealGM (basketball.realgm.com).**
#'
#' One row per upcoming free agent, including the free-agency season, the
#' player's Bird/veteran free-agent status, recent production and -- distinctively
#' -- the player's listed agent.
#'
#' **Requires a headless browser** (see [realgm_players()]).
#' @eval .returns_rd("realgm_future_free_agents", inline = FALSE, unit = "future free agent")
#' @keywords RealGM
#' @importFrom rvest read_html html_elements html_table
#' @importFrom janitor clean_names
#' @importFrom dplyr as_tibble
#' @concept RealGM Functions
#' @seealso [family_realgm] lists every function in this family.
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
