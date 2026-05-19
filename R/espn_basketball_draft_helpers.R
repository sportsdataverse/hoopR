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
