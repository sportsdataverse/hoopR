# espn_basketball_coach_helpers.R
# Internal helpers shared by MBB and NBA single-coach wrappers.

# ---------------------------------------------------------------------------
# .espn_basketball_coach
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single coach detail
#'
#' Fetches `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/coaches/{coach_id}`
#' and returns a single-row tibble with name, biography, current team /
#' college refs, and a count of career-record and coach-season entries.
#'
#' @noRd
.espn_basketball_coach <- function(league, coach_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, coach_id = coach_id)

  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/coaches/", coach_id, "?lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      bp <- raw[["birthPlace"]]
      birth_city  <- if (is.list(bp)) bp[["city"]]  %||% NA_character_ else NA_character_
      birth_state <- if (is.list(bp)) bp[["state"]] %||% NA_character_ else NA_character_

      coll  <- raw[["college"]]
      team  <- raw[["team"]]

      row <- list(
        coach_id        = as.character(raw[["id"]] %||% coach_id),
        uid             = raw[["uid"]] %||% NA_character_,
        first_name      = raw[["firstName"]] %||% NA_character_,
        last_name       = raw[["lastName"]] %||% NA_character_,
        date_of_birth   = raw[["dateOfBirth"]] %||% NA_character_,
        birth_city      = birth_city,
        birth_state     = birth_state,
        n_career_records = length(raw[["careerRecords"]] %||% list()),
        n_coach_seasons  = length(raw[["coachSeasons"]] %||% list()),
        college_ref     = if (is.list(coll)) coll[["$ref"]] %||% NA_character_ else NA_character_,
        team_ref        = if (is.list(team)) team[["$ref"]] %||% NA_character_ else NA_character_,
        league          = league
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Coach Detail"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} coach {coach_id}",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} coach {coach_id}",
      args = .args
    ),
    finally = {}
  )
  result
}
