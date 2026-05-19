# espn_basketball_event_helpers.R
# Internal helpers shared by MBB and NBA event-detail wrappers.
# Each helper accepts `league = "nba"` or `league = "mens-college-basketball"`.
# None of these are exported.

# ---------------------------------------------------------------------------
# Shared league validation (reuses the one already defined in
# espn_basketball_team_helpers.R -- defined there as .espn_bball_validate_league)
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# .espn_basketball_event_odds
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event odds
#'
#' Fetches
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/odds`
#' and returns a tidy tibble (one row per provider). MBB will typically return
#' an empty tibble because ESPN does not carry NCAA basketball odds lines.
#'
#' @param league character. `"nba"` or `"mens-college-basketball"`.
#' @param event_id character or numeric. ESPN event/game identifier.
#' @param ... Unused; absorbed for forward compatibility.
#' @return A `hoopR_data` tibble or `NULL` on error.
#' @noRd
.espn_basketball_event_odds <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)

  result <- NULL

  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league,
    "/events/",
    event_id,
    "/competitions/",
    event_id,
    "/odds"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>% jsonlite::fromJSON(simplifyDataFrame = TRUE)

      items <- raw[["items"]]

      if (is.null(items) || !is.data.frame(items) || nrow(items) == 0) {
        result <- data.frame(
          event_id              = character(0),
          provider_id           = character(0),
          provider_name         = character(0),
          details               = character(0),
          over_under            = numeric(0),
          spread                = numeric(0),
          home_money_line       = integer(0),
          away_money_line       = integer(0),
          home_team_odds_open   = numeric(0),
          home_team_odds_close  = numeric(0),
          away_team_odds_open   = numeric(0),
          away_team_odds_close  = numeric(0),
          stringsAsFactors      = FALSE
        ) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Odds (event_id=", event_id, ") from ESPN.com"),
            Sys.time()
          )
        return(result)
      }

      n <- nrow(items)

      provider_id   <- rep(NA_character_, n)
      provider_name <- rep(NA_character_, n)

      if (!is.null(items[["provider"]]) && is.data.frame(items[["provider"]])) {
        prov <- items[["provider"]]
        provider_id   <- as.character(prov[["id"]] %||% NA_character_)
        provider_name <- as.character(prov[["name"]] %||% NA_character_)
      }

      details         <- as.character(items[["details"]] %||% NA_character_)
      over_under      <- suppressWarnings(as.numeric(items[["overUnder"]] %||% NA_real_))
      spread          <- suppressWarnings(as.numeric(items[["spread"]] %||% NA_real_))
      home_money_line <- suppressWarnings(as.integer(items[["homeTeamOdds.moneyLine"]] %||%
                           items[["homeMoneyLine"]] %||% NA_integer_))
      away_money_line <- suppressWarnings(as.integer(items[["awayTeamOdds.moneyLine"]] %||%
                           items[["awayMoneyLine"]] %||% NA_integer_))

      # Team-odds open/close -- nested under homeTeamOdds / awayTeamOdds
      home_open  <- rep(NA_real_, n)
      home_close <- rep(NA_real_, n)
      away_open  <- rep(NA_real_, n)
      away_close <- rep(NA_real_, n)

      if (!is.null(items[["homeTeamOdds"]]) && is.data.frame(items[["homeTeamOdds"]])) {
        hto <- items[["homeTeamOdds"]]
        home_open  <- suppressWarnings(as.numeric(hto[["open.value"]] %||%
                        hto[["openLine"]] %||% NA_real_))
        home_close <- suppressWarnings(as.numeric(hto[["close.value"]] %||%
                        hto[["closeLine"]] %||% NA_real_))
      }
      if (!is.null(items[["awayTeamOdds"]]) && is.data.frame(items[["awayTeamOdds"]])) {
        ato <- items[["awayTeamOdds"]]
        away_open  <- suppressWarnings(as.numeric(ato[["open.value"]] %||%
                        ato[["openLine"]] %||% NA_real_))
        away_close <- suppressWarnings(as.numeric(ato[["close.value"]] %||%
                        ato[["closeLine"]] %||% NA_real_))
      }

      odds_df <- data.frame(
        event_id             = as.character(event_id),
        provider_id          = provider_id,
        provider_name        = provider_name,
        details              = details,
        over_under           = over_under,
        spread               = spread,
        home_money_line      = home_money_line,
        away_money_line      = away_money_line,
        home_team_odds_open  = home_open,
        home_team_odds_close = home_close,
        away_team_odds_open  = away_open,
        away_team_odds_close = away_close,
        stringsAsFactors     = FALSE
      )

      result <- odds_df %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Odds (event_id=", event_id, ") from ESPN.com"),
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = paste0("Failed to retrieve ESPN ", league, " event odds for event_id=", event_id),
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = paste0("Warning retrieving ESPN ", league, " event odds for event_id=", event_id),
      args = .args
    ),
    finally = {}
  )
  return(result)
}


# ---------------------------------------------------------------------------
# .espn_basketball_event_probabilities
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event win probabilities
#'
#' Fetches
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/probabilities`
#' with pagination. Loops over pages while `pageIndex < pageCount` and
#' accumulated row count is below `limit`. Sleeps ~250ms between pages.
#' Capped at 50 pages as a defensive upper bound.
#'
#' @param league character. `"nba"` or `"mens-college-basketball"`.
#' @param event_id character or numeric. ESPN event/game identifier.
#' @param limit integer. Maximum rows to return (default `200`).
#' @param ... Unused; absorbed for forward compatibility.
#' @return A `hoopR_data` tibble or `NULL` on error.
#' @noRd
.espn_basketball_event_probabilities <- function(league, event_id, limit = 200, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, limit = limit)

  result <- NULL

  base_url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league,
    "/events/",
    event_id,
    "/competitions/",
    event_id,
    "/probabilities"
  )

  tryCatch(
    expr = {
      all_rows  <- list()
      total_rows <- 0L
      page_idx   <- 1L
      page_count <- 1L  # will be updated after first fetch
      max_pages  <- 50L

      repeat {
        if (page_idx > page_count || page_idx > max_pages || total_rows >= limit) break

        page_url <- paste0(base_url, "?limit=", as.integer(limit), "&page=", page_idx)

        res <- .retry_request(page_url)
        check_status(res)
        raw <- res %>% .resp_text() %>% jsonlite::fromJSON(simplifyDataFrame = TRUE)

        # Update pagination counters from first (or any) page
        if (!is.null(raw[["pageCount"]])) {
          page_count <- as.integer(raw[["pageCount"]])
        }
        if (!is.null(raw[["pageIndex"]])) {
          # pageIndex in ESPN API is 1-based
          page_idx_resp <- as.integer(raw[["pageIndex"]])
        } else {
          page_idx_resp <- page_idx
        }

        items <- raw[["items"]]

        if (is.null(items) || !is.data.frame(items) || nrow(items) == 0) {
          break
        }

        n <- nrow(items)

        sequence_number <- as.character(items[["sequenceNumber"]] %||% NA_character_)
        play_id         <- as.character(items[["playId"]] %||% NA_character_)

        # period -- nested under period.number or period block
        period <- rep(NA_integer_, n)
        if (!is.null(items[["period"]]) && is.data.frame(items[["period"]])) {
          period <- suppressWarnings(as.integer(items[["period"]][["number"]] %||% NA_integer_))
        } else if (!is.null(items[["period"]])) {
          period <- suppressWarnings(as.integer(items[["period"]] %||% NA_integer_))
        }

        clock <- as.character(items[["clock.displayValue"]] %||%
                   items[["clockValue"]] %||% NA_character_)

        home_win_pct  <- suppressWarnings(as.numeric(items[["homeWinPercentage"]] %||% NA_real_))
        away_win_pct  <- suppressWarnings(as.numeric(items[["awayWinPercentage"]] %||% NA_real_))
        tie_pct       <- suppressWarnings(as.numeric(items[["tiePercentage"]] %||% NA_real_))

        secs_period <- suppressWarnings(as.numeric(
          items[["secondsUntilEndOfPeriod"]] %||% NA_real_
        ))
        secs_game   <- suppressWarnings(as.numeric(
          items[["secondsUntilEndOfGame"]] %||% NA_real_
        ))

        page_df <- data.frame(
          event_id                  = as.character(event_id),
          sequence_number           = sequence_number,
          play_id                   = play_id,
          period                    = period,
          clock                     = clock,
          home_win_percentage       = home_win_pct,
          away_win_percentage       = away_win_pct,
          tie_percentage            = tie_pct,
          secs_to_end_of_period     = secs_period,
          secs_to_end_of_game       = secs_game,
          stringsAsFactors          = FALSE
        )

        all_rows[[length(all_rows) + 1L]] <- page_df
        total_rows <- total_rows + n

        # Advance page counter
        page_idx <- page_idx + 1L

        # Sleep between pages to respect rate limits
        if (page_idx <= page_count && page_idx <= max_pages && total_rows < limit) {
          Sys.sleep(0.25)
        }
      }

      if (length(all_rows) == 0L) {
        result <- data.frame(
          event_id              = character(0),
          sequence_number       = character(0),
          play_id               = character(0),
          period                = integer(0),
          clock                 = character(0),
          home_win_percentage   = numeric(0),
          away_win_percentage   = numeric(0),
          tie_percentage        = numeric(0),
          secs_to_end_of_period = numeric(0),
          secs_to_end_of_game   = numeric(0),
          stringsAsFactors      = FALSE
        ) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0(
              "ESPN ", toupper(league),
              " Event Probabilities (event_id=", event_id, ") from ESPN.com"
            ),
            Sys.time()
          )
        return(result)
      }

      combined <- dplyr::bind_rows(all_rows)

      # Respect the user-supplied limit
      if (nrow(combined) > limit) {
        combined <- combined[seq_len(limit), , drop = FALSE]
      }

      result <- combined %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0(
            "ESPN ", toupper(league),
            " Event Probabilities (event_id=", event_id, ") from ESPN.com"
          ),
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = paste0(
        "Failed to retrieve ESPN ", league,
        " event probabilities for event_id=", event_id
      ),
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = paste0(
        "Warning retrieving ESPN ", league,
        " event probabilities for event_id=", event_id
      ),
      args = .args
    ),
    finally = {}
  )
  return(result)
}


# ---------------------------------------------------------------------------
# .espn_basketball_event_officials
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event officials
#'
#' Fetches
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/officials`
#' and returns a tidy tibble (one row per official).
#'
#' @param league character. `"nba"` or `"mens-college-basketball"`.
#' @param event_id character or numeric. ESPN event/game identifier.
#' @param ... Unused; absorbed for forward compatibility.
#' @return A `hoopR_data` tibble or `NULL` on error.
#' @noRd
.espn_basketball_event_officials <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)

  result <- NULL

  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league,
    "/events/",
    event_id,
    "/competitions/",
    event_id,
    "/officials"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>% jsonlite::fromJSON(simplifyDataFrame = TRUE)

      items <- raw[["items"]]

      if (is.null(items) || !is.data.frame(items) || nrow(items) == 0) {
        result <- data.frame(
          event_id       = character(0),
          official_id    = character(0),
          full_name      = character(0),
          display_name   = character(0),
          position_id    = character(0),
          position_name  = character(0),
          position_type  = character(0),
          order          = integer(0),
          stringsAsFactors = FALSE
        ) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Officials (event_id=", event_id, ") from ESPN.com"),
            Sys.time()
          )
        return(result)
      }

      n <- nrow(items)

      order_col <- suppressWarnings(as.integer(items[["order"]] %||% NA_integer_))

      # Official identity -- may be nested under "official" sub-object or flat
      official_id  <- rep(NA_character_, n)
      full_name    <- rep(NA_character_, n)
      display_name <- rep(NA_character_, n)

      if (!is.null(items[["official"]]) && is.data.frame(items[["official"]])) {
        off <- items[["official"]]
        official_id  <- as.character(off[["id"]] %||% NA_character_)
        full_name    <- as.character(off[["fullName"]] %||% NA_character_)
        display_name <- as.character(off[["displayName"]] %||% NA_character_)
      } else {
        official_id  <- as.character(items[["id"]] %||% NA_character_)
        full_name    <- as.character(items[["fullName"]] %||% NA_character_)
        display_name <- as.character(items[["displayName"]] %||% NA_character_)
      }

      # Position -- may be nested under "position" sub-object
      position_id   <- rep(NA_character_, n)
      position_name <- rep(NA_character_, n)
      position_type <- rep(NA_character_, n)

      if (!is.null(items[["position"]]) && is.data.frame(items[["position"]])) {
        pos <- items[["position"]]
        position_id   <- as.character(pos[["id"]] %||% NA_character_)
        position_name <- as.character(pos[["name"]] %||% NA_character_)
        position_type <- as.character(pos[["type"]] %||% NA_character_)
      }

      officials_df <- data.frame(
        event_id      = as.character(event_id),
        official_id   = official_id,
        full_name     = full_name,
        display_name  = display_name,
        position_id   = position_id,
        position_name = position_name,
        position_type = position_type,
        order         = order_col,
        stringsAsFactors = FALSE
      )

      result <- officials_df %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Officials (event_id=", event_id, ") from ESPN.com"),
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = paste0(
        "Failed to retrieve ESPN ", league,
        " event officials for event_id=", event_id
      ),
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = paste0(
        "Warning retrieving ESPN ", league,
        " event officials for event_id=", event_id
      ),
      args = .args
    ),
    finally = {}
  )
  return(result)
}


# ---------------------------------------------------------------------------
# .espn_basketball_event_broadcasts
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event broadcasts
#'
#' Fetches
#' `sports.core.api.espn.com/v2/sports/basketball/leagues/{league}/events/{event_id}/competitions/{event_id}/broadcasts`
#' and returns a tidy tibble (one row per broadcast outlet).
#'
#' @param league character. `"nba"` or `"mens-college-basketball"`.
#' @param event_id character or numeric. ESPN event/game identifier.
#' @param ... Unused; absorbed for forward compatibility.
#' @return A `hoopR_data` tibble or `NULL` on error.
#' @noRd
.espn_basketball_event_broadcasts <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)

  result <- NULL

  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league,
    "/events/",
    event_id,
    "/competitions/",
    event_id,
    "/broadcasts"
  )

  tryCatch(
    expr = {
      res <- .retry_request(url)
      check_status(res)
      raw <- res %>% .resp_text() %>% jsonlite::fromJSON(simplifyDataFrame = TRUE)

      items <- raw[["items"]]

      if (is.null(items) || !is.data.frame(items) || nrow(items) == 0) {
        result <- data.frame(
          event_id        = character(0),
          broadcast_id    = character(0),
          type_id         = character(0),
          type_short_name = character(0),
          type_long_name  = character(0),
          market_id       = character(0),
          market_type     = character(0),
          names           = character(0),
          lang            = character(0),
          region          = character(0),
          stringsAsFactors = FALSE
        ) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Broadcasts (event_id=", event_id, ") from ESPN.com"),
            Sys.time()
          )
        return(result)
      }

      n <- nrow(items)

      broadcast_id    <- as.character(items[["id"]] %||% NA_character_)
      lang            <- as.character(items[["lang"]] %||% NA_character_)
      region          <- as.character(items[["region"]] %||% NA_character_)

      # names -- may be a list column of character vectors; collapse to string
      names_col <- rep(NA_character_, n)
      if (!is.null(items[["names"]])) {
        names_raw <- items[["names"]]
        if (is.list(names_raw)) {
          names_col <- vapply(names_raw, function(nm) {
            if (is.null(nm) || length(nm) == 0) return(NA_character_)
            paste(as.character(nm), collapse = ", ")
          }, character(1))
        } else {
          names_col <- as.character(names_raw)
        }
      }

      # type -- nested under "type" sub-object
      type_id         <- rep(NA_character_, n)
      type_short_name <- rep(NA_character_, n)
      type_long_name  <- rep(NA_character_, n)

      if (!is.null(items[["type"]]) && is.data.frame(items[["type"]])) {
        typ <- items[["type"]]
        type_id         <- as.character(typ[["id"]] %||% NA_character_)
        type_short_name <- as.character(typ[["shortName"]] %||% NA_character_)
        type_long_name  <- as.character(typ[["longName"]] %||% NA_character_)
      }

      # market -- nested under "market" sub-object
      market_id   <- rep(NA_character_, n)
      market_type <- rep(NA_character_, n)

      if (!is.null(items[["market"]]) && is.data.frame(items[["market"]])) {
        mkt <- items[["market"]]
        market_id   <- as.character(mkt[["id"]] %||% NA_character_)
        market_type <- as.character(mkt[["type"]] %||% NA_character_)
      }

      broadcasts_df <- data.frame(
        event_id        = as.character(event_id),
        broadcast_id    = broadcast_id,
        type_id         = type_id,
        type_short_name = type_short_name,
        type_long_name  = type_long_name,
        market_id       = market_id,
        market_type     = market_type,
        names           = names_col,
        lang            = lang,
        region          = region,
        stringsAsFactors = FALSE
      )

      result <- broadcasts_df %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Broadcasts (event_id=", event_id, ") from ESPN.com"),
          Sys.time()
        )
    },
    error = function(e) .report_api_error(
      e,
      hint = paste0(
        "Failed to retrieve ESPN ", league,
        " event broadcasts for event_id=", event_id
      ),
      args = .args
    ),
    warning = function(w) .report_api_warning(
      w,
      hint = paste0(
        "Warning retrieving ESPN ", league,
        " event broadcasts for event_id=", event_id
      ),
      args = .args
    ),
    finally = {}
  )
  return(result)
}
# ---------------------------------------------------------------------------
# .espn_basketball_event_situation (live game state)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball live game situation
#' @noRd
.espn_basketball_event_situation <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/situation?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      ht <- raw[["homeTimeouts"]]
      at <- raw[["awayTimeouts"]]
      hf <- raw[["homeFouls"]]
      af <- raw[["awayFouls"]]
      get_n <- function(x, k) {
        if (is.list(x)) as.integer(x[[k]] %||% NA) else NA_integer_
      }
      get_c <- function(x, k) {
        if (is.list(x)) as.character(x[[k]] %||% NA) else NA_character_
      }
      lp_ref <- if (is.list(raw[["lastPlay"]]))
        raw[["lastPlay"]][["$ref"]] %||% NA_character_ else NA_character_
      row <- list(
        league                       = league,
        event_id                     = as.character(event_id),
        home_timeouts_current        = get_n(ht, "timeoutsCurrent"),
        home_timeouts_remaining      = get_n(ht, "timeoutsRemainingCurrent"),
        away_timeouts_current        = get_n(at, "timeoutsCurrent"),
        away_timeouts_remaining      = get_n(at, "timeoutsRemainingCurrent"),
        home_team_fouls              = get_n(hf, "teamFouls"),
        home_team_fouls_current      = get_n(hf, "teamFoulsCurrent"),
        home_fouls_to_give           = get_n(hf, "foulsToGive"),
        home_bonus_state             = get_c(hf, "bonusState"),
        away_team_fouls              = get_n(af, "teamFouls"),
        away_team_fouls_current      = get_n(af, "teamFoulsCurrent"),
        away_fouls_to_give           = get_n(af, "foulsToGive"),
        away_bonus_state             = get_c(af, "bonusState"),
        last_play_ref                = lp_ref
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Situation"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event situation for event_id={event_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event situation",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_predictor (pre-game predictor; long-format)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event predictor (long format)
#' @noRd
.espn_basketball_event_predictor <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/predictor?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      name <- raw[["name"]] %||% NA_character_
      short_name <- raw[["shortName"]] %||% NA_character_
      last_modified <- raw[["lastModified"]] %||% NA_character_
      rows <- list()
      for (side in c("homeTeam", "awayTeam")) {
        side_obj <- raw[[side]]
        if (!is.list(side_obj)) next
        team_ref <- if (is.list(side_obj[["team"]]))
          side_obj[["team"]][["$ref"]] %||% NA_character_ else NA_character_
        team_id <- if (!is.na(team_ref))
          sub(".*/teams/([0-9]+).*", "\\1", team_ref) else NA_character_
        for (s in (side_obj[["statistics"]] %||% list())) {
          rows[[length(rows) + 1L]] <- list(
            league         = league,
            event_id       = as.character(event_id),
            name           = name,
            short_name     = short_name,
            last_modified  = last_modified,
            side           = if (side == "homeTeam") "home" else "away",
            team_id        = team_id,
            stat_name      = s[["name"]] %||% NA_character_,
            stat_display   = s[["displayName"]] %||% NA_character_,
            description    = s[["description"]] %||% NA_character_,
            value          = suppressWarnings(as.numeric(s[["value"]] %||% NA)),
            display_value  = as.character(s[["displayValue"]] %||% NA),
            team_ref       = team_ref
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          name = character(0), short_name = character(0),
          last_modified = character(0), side = character(0),
          team_id = character(0), stat_name = character(0),
          stat_display = character(0), description = character(0),
          value = numeric(0), display_value = character(0),
          team_ref = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Predictor"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Predictor"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event predictor for event_id={event_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event predictor",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_powerindex (paginated $refs to team-game BPI)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event powerindex index
#' @noRd
.espn_basketball_event_powerindex <- function(league, event_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/powerindex?limit=200&lang=en&region=us"
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
      tids <- if (length(refs) == 0L) character(0) else
        sub(".*/powerindex/([0-9]+).*", "\\1", refs)
      result <- data.frame(
        league   = rep(league, length(refs)),
        event_id = rep(as.character(event_id), length(refs)),
        team_id  = tids,
        ref      = refs,
        stringsAsFactors = FALSE
      ) %>% dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Power Index"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event powerindex for event_id={event_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event powerindex",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_propbets (long-format prop bets)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball event prop bets (long format)
#' @noRd
.espn_basketball_event_propbets <- function(league, event_id, provider_id,
                                             page_limit = 100L, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id,
                provider_id = provider_id)
  result <- NULL
  rows <- list()
  page <- 1L
  page_count <- NA_integer_
  tryCatch(
    expr = {
      repeat {
        url <- paste0(
          "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
          league, "/events/", event_id, "/competitions/", event_id,
          "/odds/", provider_id, "/propBets?limit=", page_limit,
          "&page=", page, "&lang=en&region=us"
        )
        res <- tryCatch(.retry_request(url), error = function(e) NULL)
        if (is.null(res) || httr2::resp_status(res) != 200L) break
        raw <- res %>% .resp_text() %>%
          jsonlite::fromJSON(simplifyVector = FALSE)
        if (is.na(page_count)) {
          page_count <- as.integer(raw[["pageCount"]] %||% 1L)
        }
        items <- raw[["items"]] %||% list()
        for (it in items) {
          aref <- if (is.list(it[["athlete"]]))
            it[["athlete"]][["$ref"]] %||% NA_character_ else NA_character_
          aid <- if (!is.na(aref))
            sub(".*/athletes/([0-9]+).*", "\\1", aref) else NA_character_
          tp <- it[["type"]]
          odds <- it[["odds"]]
          cur <- it[["current"]]
          rows[[length(rows) + 1L]] <- list(
            league          = league,
            event_id        = as.character(event_id),
            provider_id     = as.character(provider_id),
            athlete_id      = aid,
            prop_type_id    = if (is.list(tp)) as.character(tp[["id"]] %||% NA) else NA_character_,
            prop_type_name  = if (is.list(tp)) tp[["name"]] %||% NA_character_ else NA_character_,
            american        = if (is.list(odds)) as.character(odds[["american"]] %||% NA) else NA_character_,
            decimal         = if (is.list(odds)) suppressWarnings(as.numeric(odds[["decimal"]] %||% NA)) else NA_real_,
            fraction        = if (is.list(odds)) as.character(odds[["fraction"]] %||% NA) else NA_character_,
            total           = if (is.list(odds)) suppressWarnings(as.numeric(odds[["total"]] %||% NA)) else NA_real_,
            current_target  = if (is.list(cur)) suppressWarnings(as.numeric(cur[["target"]] %||% NA)) else NA_real_,
            last_updated    = it[["lastUpdated"]] %||% NA_character_,
            athlete_ref     = aref
          )
        }
        if (page >= page_count) break
        page <- page + 1L
        Sys.sleep(0.4)
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          provider_id = character(0), athlete_id = character(0),
          prop_type_id = character(0), prop_type_name = character(0),
          american = character(0), decimal = numeric(0),
          fraction = character(0), total = numeric(0),
          current_target = numeric(0), last_updated = character(0),
          athlete_ref = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Prop Bets"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Prop Bets"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event prop bets for event_id={event_id}, provider_id={provider_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event prop bets",
      args = .args),
    finally = {}
  )
  result
}
