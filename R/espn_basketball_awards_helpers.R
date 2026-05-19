# espn_basketball_awards_helpers.R
# Internal helpers shared by MBB and NBA season-awards wrappers.
# Each helper accepts `league = "nba"` or `league = "mens-college-basketball"`.
# None of these are exported.

# ---------------------------------------------------------------------------
# .espn_basketball_season_awards
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball season awards index
#'
#' Fetches the paginated award index for a season:
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/awards`.
#' Each item is a `$ref` to `/awards/{award_id}`. Award names + winners
#' are only available in the per-award detail call.
#'
#' @param league character.
#' @param season numeric. Season year.
#' @param ... Unused.
#' @return A `hoopR_data` tibble with one row per award, or `NULL` on error.
#' @noRd
.espn_basketball_season_awards <- function(league, season, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season)

  result <- NULL

  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season, "/awards?lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      items <- raw[["items"]] %||% list()
      refs <- if (length(items) == 0L) character(0) else
        vapply(items, function(x) x[["$ref"]] %||% NA_character_,
               character(1))
      ids <- if (length(refs) == 0L) character(0) else
        sub(".*/awards/([0-9]+).*", "\\1", refs)
      result <- data.frame(
        season   = rep(as.integer(season), length(refs)),
        award_id = ids,
        ref      = refs,
        league   = rep(league, length(refs)),
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league),
                 " Season Awards Index"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} season awards for season={season}",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} season awards for season={season}",
      args = .args
    ),
    finally = {}
  )
  return(result)
}

# ---------------------------------------------------------------------------
# .espn_basketball_award
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single award detail (with winners)
#'
#' Fetches one season-award detail:
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/seasons/{season}/awards/{award_id}`.
#' Returns a tibble with one row per winner (most awards have a single
#' winner; All-League teams have 5 each).
#'
#' @param league character.
#' @param season numeric.
#' @param award_id character or numeric.
#' @param ... Unused.
#' @return A `hoopR_data` tibble with one row per winner, or `NULL` on error.
#' @noRd
.espn_basketball_award <- function(league, season, award_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season, award_id = award_id)

  result <- NULL

  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season, "/awards/", award_id,
    "?lang=en&region=us"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>%
        .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      winners <- raw[["winners"]] %||% list()
      n <- length(winners)

      if (n == 0L) {
        # No winners (some awards just have metadata). Return one row of
        # award metadata with NA winner fields so the column shape is stable.
        athlete_refs <- NA_character_
        team_refs    <- NA_character_
        n <- 1L
      } else {
        athlete_refs <- vapply(winners, function(w) {
          a <- w[["athlete"]]
          if (is.list(a)) a[["$ref"]] %||% NA_character_ else NA_character_
        }, character(1))
        team_refs <- vapply(winners, function(w) {
          t <- w[["team"]]
          if (is.list(t)) t[["$ref"]] %||% NA_character_ else NA_character_
        }, character(1))
      }

      athlete_ids <- ifelse(is.na(athlete_refs), NA_character_,
                            sub(".*/athletes/([0-9]+).*", "\\1", athlete_refs))
      team_ids <- ifelse(is.na(team_refs), NA_character_,
                         sub(".*/teams/([0-9]+).*", "\\1", team_refs))

      result <- data.frame(
        league      = rep(league, n),
        season      = rep(as.integer(season), n),
        award_id    = rep(as.character(award_id), n),
        name        = rep(raw[["name"]] %||% NA_character_, n),
        description = rep(raw[["description"]] %||% NA_character_, n),
        athlete_id  = athlete_ids,
        team_id     = team_ids,
        athlete_ref = athlete_refs,
        team_ref    = team_refs,
        stringsAsFactors = FALSE
      ) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league),
                 " Season Award Detail from ESPN.com"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(
      e,
      hint = "Failed to retrieve ESPN {league} award {award_id} for season={season}",
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = "Warning retrieving ESPN {league} award {award_id} for season={season}",
      args = .args
    ),
    finally = {}
  )
  return(result)
}
