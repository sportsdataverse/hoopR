# espn_basketball_draft_helpers.R
# Internal helper for single-draft-pick endpoint.

# ---------------------------------------------------------------------------
# .espn_basketball_draft_pick (single pick detail)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single draft pick detail
#' @noRd
.espn_basketball_draft_pick <- function(league, season, round, pick, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season, round = round, pick = pick)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season, "/draft/rounds/", round,
    "/picks/", pick, "?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      aref <- if (is.list(raw[["athlete"]]))
        raw[["athlete"]][["$ref"]] %||% NA_character_ else NA_character_
      tref <- if (is.list(raw[["team"]]))
        raw[["team"]][["$ref"]] %||% NA_character_ else NA_character_
      aid <- if (!is.na(aref))
        sub(".*/athletes/([0-9]+).*", "\\1", aref) else NA_character_
      tid <- if (!is.na(tref))
        sub(".*/teams/([0-9]+).*", "\\1", tref) else NA_character_
      status_obj <- raw[["status"]]
      status_name <- if (is.list(status_obj))
        status_obj[["name"]] %||% NA_character_ else NA_character_
      row <- list(
        league       = league,
        season       = as.integer(season),
        round        = as.integer(raw[["round"]] %||% round),
        pick         = as.integer(raw[["pick"]] %||% pick),
        overall      = as.integer(raw[["overall"]] %||% NA),
        traded       = isTRUE(raw[["traded"]]),
        trade_note   = raw[["tradeNote"]] %||% NA_character_,
        status       = status_name,
        athlete_id   = aid,
        team_id      = tid,
        athlete_ref  = aref,
        team_ref     = tref
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Draft Pick Detail"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} draft pick for season={season}, round={round}, pick={pick}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} draft pick",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_draft_rounds (per-round summary)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball draft rounds index
#'
#' Returns one row per round with metadata + pick count. The picks
#' themselves are nested but better accessed individually via
#' `.espn_basketball_draft_pick()`.
#'
#' @noRd
.espn_basketball_draft_rounds <- function(league, season, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season,
    "/draft/rounds?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      rows <- list()
      for (it in items) {
        status_obj <- it[["status"]]
        status_type <- if (is.list(status_obj)) {
          tp <- status_obj[["type"]]
          if (is.list(tp)) tp[["name"]] %||% NA_character_
          else as.character(tp %||% NA_character_)
        } else NA_character_
        rows[[length(rows) + 1L]] <- list(
          league             = league,
          season             = as.integer(season),
          round              = as.integer(it[["number"]] %||% NA),
          display_name       = it[["displayName"]] %||% NA_character_,
          short_display_name = it[["shortDisplayName"]] %||% NA_character_,
          n_picks            = length(it[["picks"]] %||% list()),
          status             = status_type
        )
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), season = integer(0),
          round = integer(0), display_name = character(0),
          short_display_name = character(0), n_picks = integer(0),
          status = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Draft Rounds"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Draft Rounds"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} draft rounds for season={season}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} draft rounds",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_draft_athletes (paginated draftee index)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball draft-athletes index
#' @noRd
.espn_basketball_draft_athletes <- function(league, season, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season,
    "/draft/athletes?limit=200&lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      refs <- if (length(items) == 0L) character(0) else
        vapply(items, function(x) x[["$ref"]] %||% NA_character_,
               character(1))
      ids <- if (length(refs) == 0L) character(0) else
        sub(".*/draft/athletes/([0-9]+).*", "\\1", refs)
      result <- data.frame(
        league     = rep(league, length(refs)),
        season     = rep(as.integer(season), length(refs)),
        athlete_id = ids,
        ref        = refs,
        stringsAsFactors = FALSE
      ) %>% dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Draft Athletes"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} draft athletes for season={season}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} draft athletes",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_draft_status (single-row draft status snapshot)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball draft status
#' @noRd
.espn_basketball_draft_status <- function(league, season, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season,
    "/draft/status?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      tp <- raw[["type"]]
      row <- list(
        league      = league,
        season      = as.integer(season),
        round       = as.integer(raw[["round"]] %||% NA),
        type_id     = if (is.list(tp)) as.character(tp[["id"]] %||% NA) else NA_character_,
        type_name   = if (is.list(tp)) tp[["name"]] %||% NA_character_ else NA_character_,
        type_state  = if (is.list(tp)) tp[["state"]] %||% NA_character_ else NA_character_,
        description = if (is.list(tp)) tp[["description"]] %||% NA_character_ else NA_character_
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Draft Status"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} draft status for season={season}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} draft status",
      args = .args),
    finally = {}
  )
  result
}
