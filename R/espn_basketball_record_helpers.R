# espn_basketball_record_helpers.R
# Internal helpers shared by MBB and NBA team-record wrappers.

# ---------------------------------------------------------------------------
# .espn_basketball_team_record
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball per-season-type team record
#'
#' Fetches `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/types/{season_type}/teams/{team_id}/record`
#' and returns a tibble with one row per record type (overall, home, away,
#' vs conference, etc).
#'
#' @keywords internal
.espn_basketball_team_record <- function(league, team_id, season,
                                          season_type = 2L, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, team_id = team_id, season = season,
                season_type = season_type)

  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season, "/types/", season_type,
    "/teams/", team_id, "/record?lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      if (length(items) == 0L) {
        result <- data.frame(
          league = character(0), team_id = character(0),
          season = integer(0), season_type = integer(0),
          record_id = character(0), name = character(0),
          abbreviation = character(0), display_name = character(0),
          short_display_name = character(0), description = character(0),
          type = character(0), summary = character(0),
          display_value = character(0), value = numeric(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Team Record"),
            Sys.time()
          )
      } else {
        rows <- lapply(items, function(it) {
          list(
            league             = league,
            team_id            = as.character(team_id),
            season             = as.integer(season),
            season_type        = as.integer(season_type),
            record_id          = as.character(it[["id"]] %||% NA),
            name               = it[["name"]] %||% NA_character_,
            abbreviation       = it[["abbreviation"]] %||% NA_character_,
            display_name       = it[["displayName"]] %||% NA_character_,
            short_display_name = it[["shortDisplayName"]] %||% NA_character_,
            description        = it[["description"]] %||% NA_character_,
            type               = it[["type"]] %||% NA_character_,
            summary            = it[["summary"]] %||% NA_character_,
            display_value      = it[["displayValue"]] %||% NA_character_,
            value              = as.numeric(it[["value"]] %||% NA)
          )
        })
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Team Record"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} team record for team_id={team_id}, season={season}",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} team record for team_id={team_id}",
      args = .args
    ),
    finally = {}
  )
  result
}
