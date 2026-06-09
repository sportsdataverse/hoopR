# ---------------------------------------------------------------------------
# Dataset-specific result-set reducers ("per-function munging")
# ---------------------------------------------------------------------------
#
# Some scrapers hard-code a canonical reduction inside each task function. These
# wrappers do the equivalent for hoopR: they fetch a multi-resultSet `nba_*()`
# endpoint and apply the right reduction (delegating to nba_bind_sets() /
# nba_join_sets() / nba_nest_sets()), so you get the munged single tibble in one
# call instead of the raw named list. Each is resilient to the empty / partial
# sets stats.nba.com occasionally returns.

#' @title **NBA Franchise History (active + defunct)**
#' @description
#' One tidy franchise timeline. [nba_franchisehistory()] returns the active
#' (`FranchiseHistory`) and `DefunctTeams` sets separately; these share a schema,
#' so this row-binds them (tactic **B**) and tags each row `active` / `defunct`.
#' @param ... Additional arguments passed to [nba_franchisehistory()] (e.g. `proxy`).
#' @return A `hoopR_data` tibble, one row per franchise era, with a leading
#'   `franchise_status` column (`active` / `defunct`).
#' @keywords NBA Combined Datasets
#' @importFrom dplyr as_tibble relocate all_of
#' @family NBA Combined Datasets
#' @export
#' @examples
#' \donttest{
#'   try(nba_tidy_franchise_history())
#' }
nba_tidy_franchise_history <- function(...) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      res <- nba_franchisehistory(...)
      sets <- res[intersect(c("FranchiseHistory", "DefunctTeams"), names(res))]
      sets <- Filter(function(d) is.data.frame(d) && nrow(d) > 0, sets)
      if (!length(sets)) stop("No franchise history returned", call. = FALSE)
      out <- nba_bind_sets(sets, tag_column = "set_name")
      out$franchise_status <- ifelse(out$set_name == "DefunctTeams", "defunct", "active")
      out$set_name <- NULL
      out <- dplyr::relocate(out, dplyr::all_of("franchise_status"))
      df <- make_hoopR_data(dplyr::as_tibble(out),
                            "NBA franchise history (active + defunct) from stats.nba.com",
                            Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No NBA franchise history available!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning building NBA franchise history", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title **NBA Player Box Score with Team Context**
#' @description
#' A traditional player box score with each player's team totals joined on
#' (tactic **C**). [nba_boxscoretraditionalv2()] returns player-grain
#' `PlayerStats` and team-grain `TeamStats` separately; this left-joins the team
#' totals onto every player row by `GAME_ID` + `TEAM_ID`, suffixing the team
#' columns with `_team`.
#' @param game_id Game ID (10-digit, zero-padded e.g. `"0022300061"`).
#' @param ... Additional arguments passed to [nba_boxscoretraditionalv2()].
#' @return A `hoopR_data` tibble, one row per player, with the player's stats and
#'   their team's totals (team columns suffixed `_team`).
#' @keywords NBA Combined Datasets
#' @importFrom dplyr as_tibble left_join
#' @family NBA Combined Datasets
#' @export
#' @examples
#' \donttest{
#'   try(nba_tidy_boxscore(game_id = "0022300061"))
#' }
nba_tidy_boxscore <- function(game_id, ...) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      res <- nba_boxscoretraditionalv2(game_id = game_id, ...)
      players <- res[["PlayerStats"]]
      teams <- res[["TeamStats"]]
      if (is.null(players) || !is.data.frame(players) || nrow(players) == 0) {
        stop("No player box score returned", call. = FALSE)
      }
      key <- intersect(c("GAME_ID", "TEAM_ID"), names(players))
      if (!is.null(teams) && is.data.frame(teams) && nrow(teams) > 0 &&
          length(key) && all(key %in% names(teams))) {
        out <- dplyr::left_join(players, teams, by = key, suffix = c("", "_team"))
      } else {
        out <- players
      }
      df <- make_hoopR_data(dplyr::as_tibble(out),
                            "NBA player box score with team context from stats.nba.com",
                            Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No NBA box score for {game_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning building NBA box score", args = .args)
    },
    finally = {
    }
  )
  return(df)
}

#' @title **NBA Player Profile (nested by table)**
#' @description
#' A player's full profile collapsed to one self-describing tibble (tactic **D**).
#' [nba_playerprofilev2()] returns many heterogeneous, `PLAYER_ID`-keyed sets
#' (season totals, career totals, season/career highs, rankings, next game);
#' this nests each populated set into a `.data` list-column, one row per
#' `(set_name, PLAYER_ID)`. Recover a table with `tidyr::unnest()`.
#' @param player_id Player ID (e.g. `201939`).
#' @param ... Additional arguments passed to [nba_playerprofilev2()].
#' @return A `hoopR_data` tibble with `set_name`, `PLAYER_ID` and a `.data`
#'   list-column.
#' @keywords NBA Combined Datasets
#' @family NBA Combined Datasets
#' @export
#' @examples
#' \donttest{
#'   prof <- try(nba_tidy_player_profile(player_id = 201939))
#' }
nba_tidy_player_profile <- function(player_id, ...) {
  .args <- .capture_args()

  df <- data.frame()

  tryCatch(
    expr = {
      res <- nba_playerprofilev2(player_id = player_id, ...)
      sets <- Filter(
        function(d) is.data.frame(d) && nrow(d) > 0 && "PLAYER_ID" %in% names(d),
        res
      )
      if (!length(sets)) stop("No player profile data returned", call. = FALSE)
      out <- nba_nest_sets(sets, keep_cols = "PLAYER_ID", nest_col = ".data")
      df <- make_hoopR_data(out,
                            "NBA player profile (nested by table) from stats.nba.com",
                            Sys.time())
    },
    error = function(e) {
      .report_api_error(e, hint = "No NBA player profile for {player_id}!", args = .args)
    },
    warning = function(w) {
      .report_api_warning(w, hint = "Warning building NBA player profile", args = .args)
    },
    finally = {
    }
  )
  return(df)
}
