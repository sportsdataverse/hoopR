#' Reduce NBA Stats API result sets
#'
#' Convenience helpers to munge hoopR's structure-faithful named-list result sets
#' into a single tibble. hoopR's `nba_*()` wrappers return the endpoint's
#' `resultSets` verbatim as a named list of tibbles (lossless, no munging); these
#' reduce that list on demand, making explicit -- and composable -- the three
#' reductions older scrapers tended to hard-code inside each task function.
#'
#' @details
#' `nba_bind_sets()` row-binds the sets into one long tibble, tagging each row
#' with its origin (tactic **B**). Use when the sets share a schema, or you simply
#' want them stacked with an origin column (e.g. draft rounds, per-mode stat
#' blocks). Columns absent from a given set fill with `NA`.
#'
#' `nba_join_sets()` successively left-joins the sets into one wide tibble on a
#' shared key (tactic **C**). Use when the sets are different facets of the same
#' entity (e.g. player stats + team stats keyed on a game or player id).
#'
#' `nba_nest_sets()` keeps `keep_cols` (plus the set name) wide and nests every
#' other column into a list-column, preserving all data when no single flat
#' schema can hold it (tactic **D**). Use for incompatible sets (e.g. a player
#' profile's season totals + career totals + awards). Recover a set with
#' `tidyr::unnest()`.
#'
#' All three accept a named list of tibbles -- an `nba_*()` return, or the output
#' of `nba_stats_map_result_sets()` -- and return a single tibble.
#'
#' @param result_sets A named list of tibbles (an `nba_*()` return).
#' @param tag_column Name of the origin column `nba_bind_sets()` adds (holds the
#'   set names). Defaults to `"set_name"`.
#' @param join_key Single shared column name `nba_join_sets()` joins the sets on.
#' @param keep_cols Grouping key column(s) `nba_nest_sets()` keeps wide; every
#'   other column is nested.
#' @param nest_col Name of the list-column `nba_nest_sets()` creates. Defaults to
#'   `".data"`.
#'
#' @return A single `tbl_df` (bound, joined, or nested).
#'
#' @examples
#' sets <- list(
#'   PlayerStats = data.frame(GAME_ID = "1", PERSON_ID = c(1, 2), PTS = c(10, 20)),
#'   TeamStats   = data.frame(GAME_ID = "1", TEAM_ID = 99, PTS = 30)
#' )
#' nba_bind_sets(sets, tag_column = "set")          # B: row-bind + tag
#' nba_join_sets(sets, join_key = "GAME_ID")        # C: join/widen on a key
#' nba_nest_sets(sets, keep_cols = "GAME_ID")       # D: nest into a list-column
#'
#' @family NBA Result-Set Helpers
#' @importFrom dplyr bind_rows left_join as_tibble all_of
#' @importFrom purrr reduce map_lgl
#' @importFrom tidyr nest
#' @importFrom cli cli_abort
#' @export
nba_bind_sets <- function(result_sets, tag_column = "set_name") {
  if (!is.list(result_sets) || length(result_sets) == 0) {
    cli::cli_abort("{.arg result_sets} must be a named list of at least one tibble.")
  }
  dplyr::as_tibble(dplyr::bind_rows(result_sets, .id = tag_column))
}

#' @export
#' @rdname nba_bind_sets
nba_join_sets <- function(result_sets, join_key) {
  if (!is.list(result_sets) || length(result_sets) == 0) {
    cli::cli_abort("{.arg result_sets} must be a named list of at least one tibble.")
  }
  if (!is.character(join_key) || length(join_key) != 1) {
    cli::cli_abort("{.arg join_key} must be a single column name (character).")
  }
  has_key <- purrr::map_lgl(result_sets, function(s) join_key %in% names(s))
  if (!all(has_key)) {
    cli::cli_abort("{.arg join_key} {.val {join_key}} is missing in sets: {names(has_key)[!has_key]}")
  }
  dplyr::as_tibble(purrr::reduce(result_sets, dplyr::left_join, by = join_key))
}

#' @export
#' @rdname nba_bind_sets
nba_nest_sets <- function(result_sets, keep_cols, nest_col = ".data") {
  if (!is.list(result_sets) || length(result_sets) == 0) {
    cli::cli_abort("{.arg result_sets} must be a named list of at least one tibble.")
  }
  if (!is.character(keep_cols) || length(keep_cols) == 0) {
    cli::cli_abort("{.arg keep_cols} must be a character vector of at least one column name.")
  }

  bound <- dplyr::bind_rows(result_sets, .id = "set_name")
  missing_keep <- setdiff(keep_cols, names(bound))
  if (length(missing_keep)) {
    cli::cli_abort("{.arg keep_cols} not found in the result sets: {missing_keep}")
  }

  # Keep `set_name` (origin) + keep_cols wide; nest everything else. Using the
  # classic name-the-nested-column interface keeps this tidyr >= 1.0 compatible.
  nest_cols <- setdiff(names(bound), c("set_name", keep_cols))
  nested <- tidyr::nest(bound, placeholder___ = dplyr::all_of(nest_cols))
  names(nested)[names(nested) == "placeholder___"] <- nest_col
  dplyr::as_tibble(nested)
}
