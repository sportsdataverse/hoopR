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

# ===========================================================================
# Competitor sub-resource helpers
# ===========================================================================

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_linescores
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor linescores (per-quarter)
#' @noRd
.espn_basketball_event_competitor_linescores <- function(league, event_id,
                                                          team_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/linescores?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      rows <- list()
      for (it in items) {
        rows[[length(rows) + 1L]] <- list(
          league        = league,
          event_id      = as.character(event_id),
          team_id       = as.character(team_id),
          period        = as.integer(it[["period"]] %||% NA),
          value         = suppressWarnings(as.numeric(it[["value"]] %||% NA)),
          display_value = as.character(it[["displayValue"]] %||% NA),
          source        = as.character(it[["source"]] %||% NA)
        )
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          team_id = character(0), period = integer(0),
          value = numeric(0), display_value = character(0),
          source = character(0), stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Linescores"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Linescores"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor linescores for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor linescores",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_leaders
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor leaders (per-game top performers)
#' @noRd
.espn_basketball_event_competitor_leaders <- function(league, event_id,
                                                       team_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/leaders?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      cats <- raw[["categories"]] %||% list()
      rows <- list()
      for (cat in cats) {
        cat_name <- cat[["name"]] %||% NA_character_
        cat_disp <- cat[["displayName"]] %||% NA_character_
        cat_abbr <- cat[["abbreviation"]] %||% NA_character_
        leaders <- cat[["leaders"]] %||% list()
        for (i in seq_along(leaders)) {
          l <- leaders[[i]]
          a <- l[["athlete"]]
          aref <- if (is.list(a)) a[["$ref"]] %||% NA_character_ else NA_character_
          aid <- if (!is.na(aref)) sub(".*/athletes/([0-9]+).*", "\\1", aref) else NA_character_
          rows[[length(rows) + 1L]] <- list(
            league           = league,
            event_id         = as.character(event_id),
            team_id          = as.character(team_id),
            category_name    = cat_name,
            category_display = cat_disp,
            category_abbrev  = cat_abbr,
            rank             = i,
            athlete_id       = aid,
            display_value    = as.character(l[["displayValue"]] %||% NA),
            value            = suppressWarnings(as.numeric(l[["value"]] %||% NA)),
            athlete_ref      = aref
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          team_id = character(0), category_name = character(0),
          category_display = character(0), category_abbrev = character(0),
          rank = integer(0), athlete_id = character(0),
          display_value = character(0), value = numeric(0),
          athlete_ref = character(0), stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Leaders"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Leaders"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor leaders for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor leaders",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_roster (paginated $refs)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor game-day roster index
#' @noRd
.espn_basketball_event_competitor_roster <- function(league, event_id,
                                                      team_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/roster?limit=100&lang=en&region=us"
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
      aids <- if (length(refs) == 0L) character(0) else
        sub(".*/roster/([0-9]+).*", "\\1", refs)
      result <- data.frame(
        league     = rep(league, length(refs)),
        event_id   = rep(as.character(event_id), length(refs)),
        team_id    = rep(as.character(team_id), length(refs)),
        athlete_id = aids,
        ref        = refs,
        stringsAsFactors = FALSE
      ) %>% dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Competitor Roster"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor roster for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor roster",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_statistics (long-format team box)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor team statistics (long format)
#' @noRd
.espn_basketball_event_competitor_statistics <- function(league, event_id,
                                                          team_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/statistics?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      splits <- raw[["splits"]]
      cats <- if (is.list(splits)) splits[["categories"]] %||% list() else list()
      rows <- list()
      for (cat in cats) {
        cat_name <- cat[["name"]] %||% NA_character_
        cat_disp <- cat[["displayName"]] %||% NA_character_
        stats <- cat[["stats"]] %||% list()
        for (s in stats) {
          rows[[length(rows) + 1L]] <- list(
            league           = league,
            event_id         = as.character(event_id),
            team_id          = as.character(team_id),
            category_name    = cat_name,
            category_display = cat_disp,
            stat_name        = s[["name"]] %||% NA_character_,
            stat_abbrev      = s[["abbreviation"]] %||% NA_character_,
            stat_display     = s[["displayName"]] %||% NA_character_,
            value            = suppressWarnings(as.numeric(s[["value"]] %||% NA)),
            display_value    = as.character(s[["displayValue"]] %||% NA)
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          team_id = character(0), category_name = character(0),
          category_display = character(0), stat_name = character(0),
          stat_abbrev = character(0), stat_display = character(0),
          value = numeric(0), display_value = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Statistics"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Statistics"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor statistics for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor statistics",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_records (per-game record types)
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor records (at-game record breakdown)
#' @noRd
.espn_basketball_event_competitor_records <- function(league, event_id,
                                                       team_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/records?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      items <- raw[["items"]] %||% list()
      rows <- list()
      for (it in items) {
        rows[[length(rows) + 1L]] <- list(
          league             = league,
          event_id           = as.character(event_id),
          team_id            = as.character(team_id),
          record_id          = as.character(it[["id"]] %||% NA),
          name               = it[["name"]] %||% NA_character_,
          abbreviation       = it[["abbreviation"]] %||% NA_character_,
          display_name       = it[["displayName"]] %||% NA_character_,
          short_display_name = it[["shortDisplayName"]] %||% NA_character_,
          type               = it[["type"]] %||% NA_character_,
          summary            = it[["summary"]] %||% NA_character_,
          value              = suppressWarnings(as.numeric(it[["value"]] %||% NA))
        )
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          team_id = character(0), record_id = character(0),
          name = character(0), abbreviation = character(0),
          display_name = character(0), short_display_name = character(0),
          type = character(0), summary = character(0),
          value = numeric(0), stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Records"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Competitor Records"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor records for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor records",
      args = .args),
    finally = {}
  )
  result
}

# ===========================================================================
# Tier 2E.1 — event-scoped player + play deep dives
# ===========================================================================

# ---------------------------------------------------------------------------
# .espn_basketball_event_player_box
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball per-game player box score (long format)
#'
#' Wraps `events/{eid}/competitions/{cid}/competitors/{tid}/roster/{aid}/statistics/{type}`.
#' One row per (category x stat) — same shape as `event_competitor_statistics`
#' but scoped to a single athlete-in-event instead of the full team.
#'
#' @noRd
.espn_basketball_event_player_box <- function(league, event_id, team_id,
                                                athlete_id, stat_type = 0L,
                                                ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id,
                athlete_id = athlete_id, stat_type = stat_type)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/roster/", athlete_id,
    "/statistics/", as.integer(stat_type),
    "?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      splits <- raw[["splits"]]
      cats <- if (is.list(splits)) splits[["categories"]] %||% list() else list()
      rows <- list()
      for (cat in cats) {
        cat_name <- cat[["name"]] %||% NA_character_
        cat_disp <- cat[["displayName"]] %||% NA_character_
        stats <- cat[["stats"]] %||% list()
        for (s in stats) {
          rows[[length(rows) + 1L]] <- list(
            league           = league,
            event_id         = as.character(event_id),
            team_id          = as.character(team_id),
            athlete_id       = as.character(athlete_id),
            stat_type        = as.integer(stat_type),
            category_name    = cat_name,
            category_display = cat_disp,
            stat_name        = s[["name"]] %||% NA_character_,
            stat_abbrev      = s[["abbreviation"]] %||% NA_character_,
            stat_display     = s[["displayName"]] %||% NA_character_,
            value            = suppressWarnings(as.numeric(s[["value"]] %||% NA)),
            display_value    = as.character(s[["displayValue"]] %||% NA)
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          team_id = character(0), athlete_id = character(0),
          stat_type = integer(0), category_name = character(0),
          category_display = character(0), stat_name = character(0),
          stat_abbrev = character(0), stat_display = character(0),
          value = numeric(0), display_value = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Player Box"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Player Box"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event player box for event_id={event_id}, team_id={team_id}, athlete_id={athlete_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event player box",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_roster_entry
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single roster entry for an athlete-in-event
#'
#' Wraps `events/{eid}/competitions/{cid}/competitors/{tid}/roster/{aid}`.
#' Single-row tibble with starter flag, DNP reason, ejection flag, period
#' of entry, and athlete + position $refs.
#'
#' @noRd
.espn_basketball_event_competitor_roster_entry <- function(league, event_id,
                                                             team_id, athlete_id,
                                                             ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id,
                athlete_id = athlete_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/roster/", athlete_id,
    "?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      athlete_ref <- if (is.list(raw[["athlete"]]))
        raw[["athlete"]][["$ref"]] %||% NA_character_ else NA_character_
      position_ref <- if (is.list(raw[["position"]]))
        raw[["position"]][["$ref"]] %||% NA_character_ else NA_character_

      row <- list(
        league       = league,
        event_id     = as.character(event_id),
        team_id      = as.character(team_id),
        athlete_id   = as.character(athlete_id),
        player_id    = as.character(raw[["playerId"]] %||% NA),
        period       = as.integer(raw[["period"]] %||% NA),
        active       = as.logical(raw[["active"]] %||% NA),
        starter      = as.logical(raw[["starter"]] %||% NA),
        did_not_play = as.logical(raw[["didNotPlay"]] %||% NA),
        reason       = as.character(raw[["reason"]] %||% NA_character_),
        ejected      = as.logical(raw[["ejected"]] %||% NA),
        for_player_id = as.character(raw[["forPlayerId"]] %||% NA_character_),
        jersey       = as.character(raw[["jersey"]] %||% NA_character_),
        display_name = as.character(raw[["displayName"]] %||% NA_character_),
        athlete_ref  = athlete_ref,
        position_ref = position_ref
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league),
                 " Event Competitor Roster Entry"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event roster entry for event_id={event_id}, team_id={team_id}, athlete_id={athlete_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event roster entry",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_play
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball single play detail
#'
#' Wraps `events/{eid}/competitions/{cid}/plays/{pid}`. Single-row tibble
#' with sequence, period, clock, text, scoring flag, score, team `$ref`,
#' and shot coordinates if applicable.
#'
#' @noRd
.espn_basketball_event_play <- function(league, event_id, play_id, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, play_id = play_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/plays/", play_id,
    "?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)

      team_ref <- if (is.list(raw[["team"]]))
        raw[["team"]][["$ref"]] %||% NA_character_ else NA_character_
      type_obj <- raw[["type"]]
      type_id <- if (is.list(type_obj)) as.character(type_obj[["id"]] %||% NA) else NA_character_
      type_text <- if (is.list(type_obj)) as.character(type_obj[["text"]] %||% NA) else NA_character_
      period_n <- if (is.list(raw[["period"]]))
        as.integer(raw[["period"]][["number"]] %||% NA) else NA_integer_
      clock_disp <- if (is.list(raw[["clock"]]))
        as.character(raw[["clock"]][["displayValue"]] %||% NA) else NA_character_
      coord <- raw[["coordinate"]]
      coord_x <- if (is.list(coord)) suppressWarnings(as.numeric(coord[["x"]] %||% NA)) else NA_real_
      coord_y <- if (is.list(coord)) suppressWarnings(as.numeric(coord[["y"]] %||% NA)) else NA_real_

      row <- list(
        league             = league,
        event_id           = as.character(event_id),
        play_id            = as.character(play_id),
        sequence_number    = as.character(raw[["sequenceNumber"]] %||% NA),
        type_id            = type_id,
        type_text          = type_text,
        text               = as.character(raw[["text"]] %||% NA_character_),
        short_text         = as.character(raw[["shortText"]] %||% NA_character_),
        period             = period_n,
        clock              = clock_disp,
        scoring_play       = as.logical(raw[["scoringPlay"]] %||% NA),
        score_value        = suppressWarnings(as.numeric(raw[["scoreValue"]] %||% NA)),
        away_score         = suppressWarnings(as.integer(raw[["awayScore"]] %||% NA)),
        home_score         = suppressWarnings(as.integer(raw[["homeScore"]] %||% NA)),
        shooting_play      = as.logical(raw[["shootingPlay"]] %||% NA),
        coordinate_x       = coord_x,
        coordinate_y       = coord_y,
        team_ref           = team_ref,
        wallclock          = as.character(raw[["wallclock"]] %||% NA_character_)
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Play Detail"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} event play detail for event_id={event_id}, play_id={play_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} event play detail",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_event_play_personnel
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball play personnel (players on court at a play)
#'
#' Wraps `events/{eid}/competitions/{cid}/plays/{pid}/personnel`. Long-format
#' tibble: one row per (competitor x athlete entry). When ESPN has not
#' populated personnel for a play, returns a typed empty tibble.
#'
#' @noRd
.espn_basketball_event_play_personnel <- function(league, event_id, play_id,
                                                    ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, play_id = play_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/plays/", play_id, "/personnel?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      pp <- raw[["playPersonnel"]] %||% list()
      rows <- list()
      for (block in pp) {
        comp <- block[["competitor"]]
        comp_ref <- if (is.list(comp)) comp[["$ref"]] %||% NA_character_ else NA_character_
        team_id <- if (!is.na(comp_ref))
          sub(".*/competitors/([0-9]+).*", "\\1", comp_ref) else NA_character_
        entries <- block[["entries"]] %||% list()
        if (length(entries) == 0L) next
        for (e in entries) {
          ath <- e[["athlete"]]
          ath_ref <- if (is.list(ath)) ath[["$ref"]] %||% NA_character_ else NA_character_
          aid <- if (!is.na(ath_ref))
            sub(".*/athletes/([0-9]+).*", "\\1", ath_ref) else NA_character_
          rows[[length(rows) + 1L]] <- list(
            league      = league,
            event_id    = as.character(event_id),
            play_id     = as.character(play_id),
            team_id     = team_id,
            athlete_id  = aid,
            athlete_ref = ath_ref,
            competitor_ref = comp_ref
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), event_id = character(0),
          play_id = character(0), team_id = character(0),
          athlete_id = character(0), athlete_ref = character(0),
          competitor_ref = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Play Personnel"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Event Play Personnel"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} play personnel for event_id={event_id}, play_id={play_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} play personnel",
      args = .args),
    finally = {}
  )
  result
}

# ===========================================================================
# Tier 2E.2 — team-season stats + quick lookups
# ===========================================================================

# ---------------------------------------------------------------------------
# .espn_basketball_event_competitor_score
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball competitor final score (single-row)
#'
#' Wraps `events/{eid}/competitions/{cid}/competitors/{tid}/score`. Returns a
#' one-row tibble with the team's final score, display value, winner flag,
#' and source.
#'
#' @noRd
.espn_basketball_event_competitor_score <- function(league, event_id, team_id,
                                                      ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, event_id = event_id, team_id = team_id)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/events/", event_id, "/competitions/", event_id,
    "/competitors/", team_id, "/score?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      source <- raw[["source"]]
      source_id <- if (is.list(source)) as.character(source[["id"]] %||% NA) else
        if (is.character(source)) source else NA_character_
      source_desc <- if (is.list(source)) as.character(source[["description"]] %||% NA) else NA_character_
      row <- list(
        league        = league,
        event_id      = as.character(event_id),
        team_id       = as.character(team_id),
        value         = suppressWarnings(as.numeric(raw[["value"]] %||% NA)),
        display_value = as.character(raw[["displayValue"]] %||% NA_character_),
        winner        = as.logical(raw[["winner"]] %||% NA),
        source_id     = source_id,
        source_description = source_desc
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Event Competitor Score"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} competitor score for event_id={event_id}, team_id={team_id}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} competitor score",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_team_season_statistics
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball team-season statistics (long format with rank)
#'
#' Wraps `seasons/{y}/types/{t}/teams/{tid}/statistics`. One row per
#' (category x stat) for the team's season-type aggregate stats. Each
#' row also carries the team's league-rank for that stat where ESPN
#' provides it.
#'
#' @noRd
.espn_basketball_team_season_statistics <- function(league, team_id, season,
                                                      season_type = 2L, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, team_id = team_id, season = season,
                season_type = season_type)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season,
    "/types/", as.integer(season_type),
    "/teams/", team_id, "/statistics?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      splits <- raw[["splits"]]
      cats <- if (is.list(splits)) splits[["categories"]] %||% list() else list()
      rows <- list()
      for (cat in cats) {
        cat_name <- cat[["name"]] %||% NA_character_
        cat_disp <- cat[["displayName"]] %||% NA_character_
        stats <- cat[["stats"]] %||% list()
        for (s in stats) {
          rows[[length(rows) + 1L]] <- list(
            league             = league,
            season             = as.integer(season),
            season_type        = as.integer(season_type),
            team_id            = as.character(team_id),
            category_name      = cat_name,
            category_display   = cat_disp,
            stat_name          = s[["name"]] %||% NA_character_,
            stat_abbrev        = s[["abbreviation"]] %||% NA_character_,
            stat_display       = s[["displayName"]] %||% NA_character_,
            value              = suppressWarnings(as.numeric(s[["value"]] %||% NA)),
            display_value      = as.character(s[["displayValue"]] %||% NA_character_),
            rank               = suppressWarnings(as.integer(s[["rank"]] %||% NA)),
            rank_display_value = as.character(s[["rankDisplayValue"]] %||% NA_character_)
          )
        }
      }
      if (length(rows) == 0L) {
        result <- data.frame(
          league = character(0), season = integer(0),
          season_type = integer(0), team_id = character(0),
          category_name = character(0), category_display = character(0),
          stat_name = character(0), stat_abbrev = character(0),
          stat_display = character(0), value = numeric(0),
          display_value = character(0), rank = integer(0),
          rank_display_value = character(0),
          stringsAsFactors = FALSE
        ) %>% dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Team Season Statistics"),
            Sys.time()
          )
      } else {
        result <- do.call(rbind, lapply(rows, as.data.frame,
                                          stringsAsFactors = FALSE)) %>%
          dplyr::as_tibble() %>%
          make_hoopR_data(
            paste0("ESPN ", toupper(league), " Team Season Statistics"),
            Sys.time()
          )
      }
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} team season statistics for team_id={team_id}, season={season}, season_type={season_type}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} team season statistics",
      args = .args),
    finally = {}
  )
  result
}

# ---------------------------------------------------------------------------
# .espn_basketball_season_draft
# ---------------------------------------------------------------------------

#' Internal: ESPN basketball draft year top-level metadata
#'
#' Wraps `seasons/{y}/draft`. Single-row tibble with year, numberOfRounds,
#' displayName, shortDisplayName, plus `$ref`s for the deeper sub-resources
#' (athletes, rounds, positions, status) that are already wrapped by
#' [.espn_basketball_draft_athletes()], [.espn_basketball_draft_rounds()],
#' and [.espn_basketball_draft_status()].
#'
#' @noRd
.espn_basketball_season_draft <- function(league, season, ...) {
  .espn_bball_validate_league(league)
  .args <- list(league = league, season = season)
  result <- NULL
  url <- paste0(
    "https://sports.core.api.espn.com/v2/sports/basketball/leagues/",
    league, "/seasons/", season, "/draft?lang=en&region=us"
  )
  tryCatch(
    expr = {
      res <- .retry_request(url); check_status(res)
      raw <- res %>% .resp_text() %>%
        jsonlite::fromJSON(simplifyVector = FALSE)
      sub_ref <- function(k) {
        v <- raw[[k]]
        if (is.list(v)) as.character(v[["$ref"]] %||% NA_character_) else
          if (is.character(v)) v else NA_character_
      }
      row <- list(
        league             = league,
        season             = as.integer(season),
        year               = suppressWarnings(as.integer(raw[["year"]] %||% NA)),
        uid                = as.character(raw[["uid"]] %||% NA_character_),
        number_of_rounds   = suppressWarnings(as.integer(raw[["numberOfRounds"]] %||% NA)),
        display_name       = as.character(raw[["displayName"]] %||% NA_character_),
        short_display_name = as.character(raw[["shortDisplayName"]] %||% NA_character_),
        status_ref         = sub_ref("status"),
        athletes_ref       = sub_ref("athletes"),
        rounds_ref         = sub_ref("rounds")
      )
      result <- data.frame(row, stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        make_hoopR_data(
          paste0("ESPN ", toupper(league), " Season Draft (top-level)"),
          Sys.time()
        )
    },
    error   = function(e) .report_api_error(e,
      hint = "Failed to retrieve ESPN {league} season draft top-level for season={season}",
      args = .args),
    warning = function(w) .report_api_warning(w,
      hint = "Warning retrieving ESPN {league} season draft top-level",
      args = .args),
    finally = {}
  )
  result
}
