# espn_basketball_tournaments_helpers.R
# Internal helpers shared by MBB and NBA tournament wrappers.

# ---------------------------------------------------------------------------
# .espn_basketball_tournaments (index)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball tournaments index
#'
#' Fetches the tournament index for a league:
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/tournaments`.
#' Returns a tibble of tournament IDs (each refs a separate detail).
#'
#' @keywords internal
.espn_basketball_tournaments <- function(league, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league)

  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/tournaments?limit=200&lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      refs <- if (length(items) == 0L) character(0) else
        vapply(items, function(x) x[["$ref"]] %||% NA_character_,
               character(1))
      ids <- if (length(refs) == 0L) character(0) else
        sub(".*/tournaments/([0-9]+).*", "\\1", refs)
      result <- data.frame(
        tournament_id = ids,
        ref           = refs,
        league        = rep(league, length(refs)),
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Tournaments Index"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e, hint = "Failed to retrieve ESPN {league} tournaments",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w, hint = "Warning retrieving ESPN {league} tournaments",
      args = .args
    ),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_tournament (detail)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single tournament detail
#'
#' Fetches one tournament's metadata + its seasons-list `$ref`:
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/tournaments/{tournament_id}`.
#'
#' @keywords internal
.espn_basketball_tournament <- function(league, tournament_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, tournament_id = tournament_id)

  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/tournaments/", tournament_id, "?lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      seasons_ref <- if (is.list(raw[["seasons"]]))
        raw[["seasons"]][["$ref"]] %||% NA_character_ else NA_character_

      row <- list(
        tournament_id = as.character(raw[["id"]] %||% tournament_id),
        display_name  = raw[["displayName"]] %||% NA_character_,
        seasons_ref   = seasons_ref,
        league        = league
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Tournament Detail"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} tournament {tournament_id}",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} tournament {tournament_id}",
      args = .args
    ),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_tournament_seasons (per-tournament season index)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball tournament seasons list
#'
#' Fetches the seasons in which a tournament was held:
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/tournaments/{tournament_id}/seasons`.
#' Each item is a `$ref` to a per-season tournament resource. Year is
#' parsed from the URL.
#'
#' @keywords internal
.espn_basketball_tournament_seasons <- function(league, tournament_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, tournament_id = tournament_id)

  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/tournaments/", tournament_id, "/seasons?limit=200&lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      items <- raw[["items"]] %||% list()
      refs <- if (length(items) == 0L) character(0) else
        vapply(items, function(x) x[["$ref"]] %||% NA_character_,
               character(1))
      seasons <- if (length(refs) == 0L) integer(0) else
        suppressWarnings(as.integer(
          sub(".*/seasons/([0-9]+).*", "\\1", refs)
        ))
      result <- data.frame(
        league        = rep(league, length(refs)),
        tournament_id = rep(as.character(tournament_id), length(refs)),
        season        = seasons,
        ref           = refs,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league),
                 " Tournament Seasons"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} tournament {tournament_id} seasons",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} tournament {tournament_id} seasons",
      args = .args
    ),
    finally = {}
  )
  result
}
