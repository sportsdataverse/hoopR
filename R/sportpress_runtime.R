# sportpress_runtime.R -- transport for the BNXT League wrappers (bnxt.sportpress.info/api/v1, the
# Sportpress CMS behind bnxtleague.com).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/bnxt/bnxt_runtime.py (origin/main e3d232e):
#
# * Header key: every route needs `X-Authorization: <key>` (401 without it). The key is public (hard-coded
#   in the bnxtleague.com bundle `js/app.<hash>.js`); it is read from the bundle once per R session
#   (accepted only if it is 36 letters / digits), with `.SPORTPRESS_FALLBACK_KEY` (the value of 2026-10-12)
#   when the bundle cannot be read. A 401 re-reads the bundle once, then raises `hoopR_asset_fetch`
#   ("key rotated?"). The key is never printed, logged or put in a condition: every message goes through
#   `.sportpress_scrub()`. Requests carry the key, so no request follows a redirect (`follow_redirects =
#   FALSE`, sportsdataverse-py's NOREDIRECT_SESSION, the bundle reads included).
# * Throttle and retries: `.intl_response()` (>= 1 s per host on every attempt); 429 / 500 / 502 / 503 / 504
#   are retried (`retry_500 = TRUE`, the sportsdataverse-py policy), three attempts in all.
# * Season key: the END year (`/phase/season/2026` = 2025-26), the API's own key, so the mapping is the
#   identity; the season routes are checked against the body's `competition.season`. Every other route is
#   keyed by the competition id (one per season), the competition-team id, the roster id or the game id.
# * `X-Localization: en` is always sent. Contact, social and date-of-birth keys are dropped from every
#   body (`.sportpress_scrub_personal()`); a player's `birthdate` is the one exception.
# * Refusals: HTTP 404, an empty `data` list, an empty ranking -> `hoopR_no_data`; an id or season that is
#   not an integer, HTTP 400 / 422 -> `hoopR_bad_request`; a rejected key (after one renewal), any other
#   non-200, a non-JSON or empty body, an error or changed envelope, a game that is not finished and any
#   body for another season, competition, team or game -> `hoopR_asset_fetch`. The game routes (box score,
#   film, overview) carry no echo of the game id, so each first reads `/schedule/find/{game_id}` (cached
#   once the game is finished) and refuses an unfinished game, a `competition_id` that is not the game's, a
#   team that is not one of its two sides and a film whose running score does not end on the final score.
# * Stamped request: the ids and query values asked for are added under `_request` (`season`,
#   `competition_id`, `phase_id`, `competition_team_id`, `roster_id`, `game_id`, `title_id`, `month`,
#   `type`); the parsers read them.

#' @noRd
.SPORTPRESS_SITE <- "https://bnxtleague.com"
#' @noRd
.SPORTPRESS_API <- "https://bnxt.sportpress.info/api/v1"
#' Public key from the bnxtleague.com bundle, read 2026-10-12 (sportsdataverse-py `bnxt_runtime.FALLBACK_KEY`).
#' @noRd
.SPORTPRESS_FALLBACK_KEY <- "BWSyE7sgg9QAurh2JX9cpjzjGc652BWLuNUS"
#' @noRd
.SPORTPRESS_REQUEST <- "_request"
#' League local time: `game_time` is wall-clock Brussels / Amsterdam time without an offset.
#' @noRd
.SPORTPRESS_TZ <- "Europe/Brussels"
#' The nine ranking categories, in the order the API lists them.
#' @noRd
.SPORTPRESS_RANK_KEYS <- c("efficiency", "points", "total_rebound", "block", "assist", "steal",
                           "two_point_percent", "three_point_percent", "free_throw_percent")
#' @noRd
.SPORTPRESS_ERROR_KEYS <- c("error", "errors", "message", "exception", "trace")
#' Contact, social and date-of-birth keys (dropped); a player's `birthdate` is the one exception.
#' @noRd
.SPORTPRESS_PERSONAL <- "(birth|^dob$|e_?mail|phone|mobile|^tel$|address|home_?page|website|passport|salary|facebook|twitter|instagram)"

# the header key (value, source) and the finished games (game id -> identity), once per session
.sportpress_state <- new.env(parent = emptyenv())

# ---------------------------------------------------------------------------
# Shape helpers (JSON parsed with simplifyVector = FALSE)
# ---------------------------------------------------------------------------

#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.sportpress_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.sportpress_is_array <- function(x) is.list(x) && is.null(names(x))

#' A JSON integer (not a boolean, not a float).
#' @noRd
.sportpress_is_int <- function(v) is.integer(v) && length(v) == 1L && !is.na(v)

#' sportsdataverse-py `_same`: type-strict equality (`TRUE` is not 1, `"1"` is not 1); two nulls are equal.
#' @noRd
.sportpress_same <- function(a, b) {
  if (is.null(a) || is.null(b)) return(is.null(a) && is.null(b))
  identical(class(a), class(b)) && length(a) == 1L && length(b) == 1L && !is.na(a) && !is.na(b) && a == b
}

#' The value at a path of keys in nested objects, `NULL` when a step is missing or not an object.
#' @noRd
.sportpress_get_in <- function(d, ...) {
  for (k in c(...)) {
    if (!.sportpress_is_dict(d)) return(NULL)
    d <- d[[k]]
  }
  d
}

#' A value for a message (Python-repr-like), never an object dump.
#' @noRd
.sportpress_repr <- function(x) {
  if (is.null(x)) return("None")
  if (is.character(x) && length(x) == 1L) return(paste0("'", x, "'"))
  if (is.atomic(x) && length(x) == 1L) return(as.character(x))
  "<object>"
}

# ---------------------------------------------------------------------------
# Secrets and errors
# ---------------------------------------------------------------------------

#' `text` with the key in use and the documented fallback replaced by `<key>`.
#' @noRd
.sportpress_scrub <- function(text) {
  for (k in unique(c(.sportpress_state$key, .SPORTPRESS_FALLBACK_KEY))) {
    if (is.character(k) && nzchar(k)) text <- gsub(k, "<key>", text, fixed = TRUE)
  }
  text
}

#' Raise `hoopR_asset_fetch` with a scrubbed message (the text is shown verbatim, never interpolated).
#' @noRd
.sportpress_fail <- function(msg, call, status = NULL, transient = FALSE) {
  msg <- .sportpress_scrub(msg)
  .abort_asset_fetch("{msg}", status = status, transient = transient, call = call)
}

#' @noRd
.sportpress_valid_key <- function(value) {
  is.character(value) && length(value) == 1L && grepl("^[A-Za-z0-9]{36}$", value)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' One throttled GET (three attempts on 429 / 5xx, no redirects); the response unchecked.
#' @noRd
.sportpress_fetch <- function(url, query = list(), headers = NULL, call = rlang::caller_env()) {
  .intl_response(url, query = query, headers = headers, retry_500 = TRUE, follow_redirects = FALSE, call = call)
}

#' The first capture group of `pattern` in `text`, or `NULL`.
#' @noRd
.sportpress_match1 <- function(pattern, text) {
  m <- regmatches(text, regexec(pattern, text, perl = TRUE))[[1]]
  if (length(m) > 1L) m[[2]] else NULL
}

#' The `X-Authorization` key: the bundle's, else the documented fallback. Cached per session.
#' @noRd
.sportpress_read_key <- function(renew = FALSE, call = rlang::caller_env()) {
  if (!is.null(.sportpress_state$key) && !renew) return(.sportpress_state$key)
  found <- tryCatch({
    home <- .sportpress_fetch(paste0(.SPORTPRESS_SITE, "/"), call = call)
    js_path <- if (httr2::resp_status(home) == 200L) {
      .sportpress_match1('src="(/js/app\\.[0-9a-f]+\\.js)"', .intl_body_text(home))
    }
    key <- NULL
    if (!is.null(js_path)) {
      js <- .sportpress_fetch(paste0(.SPORTPRESS_SITE, js_path), call = call)
      if (httr2::resp_status(js) == 200L) {
        key <- .sportpress_match1('\\["X-Authorization"\\]\\s*=\\s*"([^"]{1,80})"', .intl_body_text(js))
      }
    }
    if (.sportpress_valid_key(key)) key else NULL
  }, hoopR_error = function(e) NULL) # the documented fallback answers any failure to read the bundle
  .sportpress_state$key <- found %||% .SPORTPRESS_FALLBACK_KEY
  .sportpress_state$key_source <- if (is.null(found)) "fallback" else "bundle"
  .sportpress_state$key
}

#' GET `API + path` with the key; one key renewal on a 401. Returns the parsed JSON body.
#' @noRd
.sportpress_call <- function(path, query = list(), call = rlang::caller_env()) {
  url <- paste0(.SPORTPRESS_API, path)
  where <- .intl_where(url)
  for (renew in c(FALSE, TRUE)) {
    headers <- list(`X-Authorization` = .sportpress_read_key(renew = renew, call = call),
                    `X-Localization` = "en", Accept = "application/json")
    resp <- .sportpress_fetch(url, query = query, headers = headers, call = call)
    if (httr2::resp_status(resp) != 401L) break
  }
  status <- httr2::resp_status(resp)
  if (status == 401L) {
    .sportpress_fail(paste0(
      where, " answered HTTP 401: the X-Authorization key was rejected (key rotated? re-read it from the ",
      "app.<hash>.js bundle linked from ", .SPORTPRESS_SITE, "/ and update .SPORTPRESS_FALLBACK_KEY)"
    ), call = call, status = status)
  }
  if (status == 404L) .abort_no_data("{where} answered HTTP 404.", status = status, call = call)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}.", status = status, call = call)
  }
  if (status != 200L) {
    .sportpress_fail(paste0(where, " answered HTTP ", status, ", not 200"), call = call, status = status,
                     transient = status %in% c(408L, 429L) || status >= 500)
  }
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  text <- .intl_body_text(resp)
  if (!grepl("json", ctype, fixed = TRUE)) {
    .sportpress_fail(paste0(where, " answered ", if (nzchar(ctype)) ctype else "no content type", ", not JSON"),
                     call = call)
  }
  if (!nzchar(trimws(text))) .sportpress_fail(paste0(where, " answered HTTP 200 with an empty body"), call = call)
  tryCatch(
    jsonlite::parse_json(text, simplifyVector = FALSE),
    error = function(e) .sportpress_fail(paste0(where, " answered a body that is not JSON"), call = call)
  )
}

# ---------------------------------------------------------------------------
# Personal data
# ---------------------------------------------------------------------------

#' `obj` without contact / social keys and without any date of birth outside a player object.
#' @noRd
.sportpress_scrub_personal <- function(obj, in_player = FALSE) {
  if (!is.list(obj)) return(obj)
  if (.sportpress_is_dict(obj)) {
    keys <- names(obj)
    drop <- grepl(.SPORTPRESS_PERSONAL, keys, ignore.case = TRUE, perl = TRUE) & !(in_player & keys == "birthdate")
    obj <- obj[!drop]
    for (i in seq_along(obj)) {
      v <- .sportpress_scrub_personal(obj[[i]], in_player || names(obj)[[i]] %in% c("player", "player2"))
      if (!is.null(v)) obj[[i]] <- v
    }
    return(obj)
  }
  for (i in seq_along(obj)) {
    v <- .sportpress_scrub_personal(obj[[i]], in_player)
    if (!is.null(v)) obj[[i]] <- v
  }
  obj
}

# ---------------------------------------------------------------------------
# Envelopes and games
# ---------------------------------------------------------------------------

#' @noRd
.sportpress_error_envelope <- function(body) {
  .sportpress_is_dict(body) && !"data" %in% names(body) && any(.SPORTPRESS_ERROR_KEYS %in% names(body))
}

#' `body$data` as a non-empty list of objects (`hoopR_no_data` when it is empty).
#' @noRd
.sportpress_data_list <- function(body, where, call) {
  if (.sportpress_error_envelope(body)) .sportpress_fail(paste0(where, ": the body is an error envelope"), call)
  if (!.sportpress_is_dict(body) || !identical(names(body), "data") || !.sportpress_is_array(body$data)) {
    .sportpress_fail(paste0(where, ": not a Sportpress list envelope"), call)
  }
  rows <- body$data
  if (!length(rows)) .abort_no_data("{where}: no rows (an unknown id or a season without data).", call = call)
  if (!all(vapply(rows, .sportpress_is_dict, logical(1)))) .sportpress_fail(paste0(where, ": a row is not an object"), call)
  rows
}

#' `body$data` as a non-empty object (`hoopR_no_data` when it is an empty list / object).
#' @noRd
.sportpress_data_obj <- function(body, where, call) {
  if (.sportpress_error_envelope(body)) .sportpress_fail(paste0(where, ": the body is an error envelope"), call)
  if (!.sportpress_is_dict(body) || !identical(names(body), "data")) {
    .sportpress_fail(paste0(where, ": not a Sportpress object envelope"), call)
  }
  d <- body$data
  if (is.list(d) && !length(d)) .abort_no_data("{where}: no data (an unknown id).", call = call)
  if (!.sportpress_is_dict(d)) .sportpress_fail(paste0(where, ": data is not an object"), call)
  d
}

#' `list(home competitor, away competitor)` of a game object (by `side` 1 / 2); `NULL` when malformed.
#' @noRd
.sportpress_sides <- function(game) {
  comps <- if (.sportpress_is_dict(game)) game$competitors
  if (!.sportpress_is_array(comps) || length(comps) != 2L || !all(vapply(comps, .sportpress_is_dict, logical(1)))) {
    return(NULL)
  }
  side <- vapply(comps, function(c) if (.sportpress_is_int(c$side)) c$side else NA_integer_, integer(1))
  if (!setequal(side, 1:2) || anyNA(side)) return(NULL)
  comps[order(side)]
}

#' @noRd
.sportpress_team_id <- function(competitor) .sportpress_get_in(competitor, "competition_team", "id")

#' @noRd
.sportpress_ident <- function(g) {
  s <- .sportpress_sides(g)
  list(competition_id = .sportpress_get_in(g, "competition", "id"), home = .sportpress_team_id(s[[1]]),
       away = .sportpress_team_id(s[[2]]), score = list(s[[1]]$finalScore, s[[2]]$finalScore))
}

#' Identity of FINISHED game `gid` from `/schedule/find`; cached once finished.
#' @noRd
.sportpress_game <- function(gid, call) {
  key <- as.character(gid)
  if (is.null(.sportpress_state$finished[[key]])) {
    path <- paste0("/schedule/find/", gid)
    where <- paste0(httr2::url_parse(.SPORTPRESS_API)$hostname, path)
    .sportpress_c_game_find(.sportpress_call(path, call = call), list(game_id = gid), list(), where, call)
    if (is.null(.sportpress_state$finished[[key]])) {
      .sportpress_fail(paste0(where, ": game ", gid, " is not finished: no box score or film yet"), call)
    }
  }
  .sportpress_state$finished[[key]]
}

# ---------------------------------------------------------------------------
# Per-route checks: (body, ids, query, where, call), validate scope and shape, return nothing
# ---------------------------------------------------------------------------

#' @noRd
.sportpress_c_server_config <- function(body, ids, q, where, call) {
  langs <- if (.sportpress_is_dict(body)) body$available_lang_array
  alpha <- if (.sportpress_is_array(langs)) unlist(lapply(langs, .sportpress_get_in, "alpha2"))
  if (!.sportpress_is_array(langs) || !all(c("en", "fr", "nl") %in% alpha)) {
    .sportpress_fail(paste0(where, ": no en / fr / nl language tables"), call)
  }
  full <- vapply(langs, function(x) {
    r <- .sportpress_get_in(x, "resources")
    .sportpress_is_dict(r) && length(r) > 0L
  }, logical(1))
  if (!all(full)) .sportpress_fail(paste0(where, ": an empty language table"), call)
}

#' @noRd
.sportpress_c_club_seasons <- function(body, ids, q, where, call) {
  rows <- .sportpress_data_list(body, where, call)
  if (!all(vapply(rows, function(r) .sportpress_is_int(r$season), logical(1)))) {
    .sportpress_fail(paste0(where, ": a row without an integer season"), call)
  }
}

#' @noRd
.sportpress_c_referees <- function(body, ids, q, where, call) {
  rows <- .sportpress_data_list(body, where, call)
  want <- q$title_id
  if (!is.null(want) && any(!vapply(rows, function(r) .sportpress_same(.sportpress_get_in(r, "title", "id"), want), logical(1)))) {
    .sportpress_fail(paste0(where, ": out of scope: a staff member is not of title ", want), call)
  }
}

#' @noRd
.sportpress_c_phase_season <- function(body, ids, q, where, call) {
  for (r in .sportpress_data_list(body, where, call)) {
    if (!.sportpress_same(.sportpress_get_in(r, "competition", "season"), ids$season)) {
      .sportpress_fail(paste0(where, ": out of scope: a competition is not of season ", ids$season), call)
    }
    if (!.sportpress_is_array(r$phases)) .sportpress_fail(paste0(where, ": a competition without a phases list"), call)
  }
}

#' @noRd
.sportpress_c_competition_teams <- function(body, ids, q, where, call) {
  cid <- q$competition_id
  for (r in .sportpress_data_list(body, where, call)) {
    if (!(.sportpress_same(r$competition_id, cid) && .sportpress_same(.sportpress_get_in(r, "competition", "id"), cid))) {
      .sportpress_fail(paste0(where, ": out of scope: team ", .sportpress_repr(r$id), " is not of competition ", cid), call)
    }
  }
}

#' @noRd
.sportpress_c_standings <- function(body, ids, q, where, call) {
  for (r in .sportpress_data_list(body, where, call)) {
    if (!(.sportpress_is_int(.sportpress_get_in(r, "team", "id")) && .sportpress_is_int(r$played))) {
      .sportpress_fail(paste0(where, ": a standings row without team.id / played"), call)
    }
  }
}

#' @noRd
.sportpress_c_schedule_club <- function(body, ids, q, where, call) {
  seen <- integer()
  for (g in .sportpress_data_list(body, where, call)) {
    gid <- .sportpress_repr(g$id)
    if (!.sportpress_same(.sportpress_get_in(g, "competition", "season"), ids$season)) {
      .sportpress_fail(paste0(where, ": out of scope: game ", gid, " is not of season ", ids$season), call)
    }
    if (!is.null(q$phase_id) && !.sportpress_same(.sportpress_get_in(g, "phase", "id"), q$phase_id)) {
      .sportpress_fail(paste0(where, ": out of scope: game ", gid, " is not of phase ", q$phase_id), call)
    }
    if (is.null(.sportpress_sides(g)) || !.sportpress_is_int(g$id) || g$id %in% seen) {
      .sportpress_fail(paste0(where, ": a duplicate, id-less or side-less game"), call)
    }
    seen <- c(seen, g$id)
  }
}

#' @noRd
.sportpress_c_game_slider <- function(body, ids, q, where, call) {
  for (g in .sportpress_data_list(body, where, call)) {
    if (!.sportpress_same(.sportpress_get_in(g, "competition", "id"), ids$competition_id)) {
      .sportpress_fail(paste0(where, ": out of scope: game ", .sportpress_repr(g$id), " is not of competition ",
                              ids$competition_id), call)
    }
    if (!is.null(g$genius_id) && !.sportpress_is_int(g$genius_id)) {
      .sportpress_fail(paste0(where, ": genius_id is neither null nor an integer"), call)
    }
  }
}

#' The ranking check (`who` = "team" or "player"): the nine categories, each a list of rows.
#' @noRd
.sportpress_c_ranking <- function(who) {
  function(body, ids, q, where, call) {
    if (.sportpress_is_array(body) && !length(body)) {
      .abort_no_data("{where}: no ranking (a competition without statistics).", call = call)
    }
    if (.sportpress_error_envelope(body)) .sportpress_fail(paste0(where, ": the body is an error envelope"), call)
    one <- !is.null(q$type) && !identical(q$type, "all")
    keys <- if (.sportpress_is_dict(body)) names(body) else character()
    if (!length(keys) || (!one && !identical(keys, .SPORTPRESS_RANK_KEYS)) ||
          (one && !all(keys %in% .SPORTPRESS_RANK_KEYS))) {
      .sportpress_fail(paste0(where, ": the categories are not the nine ranking categories"), call)
    }
    need <- if (who == "team") c("team", "value") else c("team", "value", "player", "roster_id")
    for (cat in keys) {
      rows <- body[[cat]]
      if (!.sportpress_is_array(rows) || !all(vapply(rows, .sportpress_is_dict, logical(1)))) {
        .sportpress_fail(paste0(where, ": ", cat, " is not a list of rows"), call)
      }
      if (!all(vapply(rows, function(r) all(need %in% names(r)), logical(1)))) {
        .sportpress_fail(paste0(where, ": a ", cat, " row without (", paste0("'", need, "'", collapse = ", "), ")"), call)
      }
    }
  }
}

#' The roster-rows check; `key` = c(row field, id name) when the rows echo the asked id.
#' @noRd
.sportpress_c_roster_rows <- function(key = NULL) {
  function(body, ids, q, where, call) {
    for (r in .sportpress_data_list(body, where, call)) {
      if (!is.null(key) && !.sportpress_same(r[[key[[1]]]], ids[[key[[2]]]])) {
        .sportpress_fail(paste0(where, ": out of scope: roster ", .sportpress_repr(r$id), " is not of competition team ",
                                ids[[key[[2]]]]), call)
      }
      if (!(.sportpress_is_int(r$id) && .sportpress_is_dict(r$player))) {
        .sportpress_fail(paste0(where, ": a roster row without id / player"), call)
      }
    }
  }
}

#' @noRd
.sportpress_c_nationality_codes <- function(body, ids, q, where, call) {
  if (.sportpress_is_array(body) && !length(body)) {
    .abort_no_data("{where}: no nationality codes for the season.", call = call)
  }
  if (!.sportpress_is_array(body) ||
        !all(vapply(body, function(x) is.character(x) && length(x) == 1L, logical(1)))) {
    .sportpress_fail(paste0(where, ": not a list of codes"), call)
  }
}

#' @noRd
.sportpress_c_team_find <- function(body, ids, q, where, call) {
  d <- .sportpress_data_obj(body, where, call)
  if (!.sportpress_same(d$id, ids$competition_team_id)) {
    .sportpress_fail(paste0(where, ": out of scope: the body is team ", .sportpress_repr(d$id), ", asked for ",
                            ids$competition_team_id), call)
  }
}

#' @noRd
.sportpress_c_player_averages <- function(body, ids, q, where, call) {
  ok <- vapply(.sportpress_data_list(body, where, call),
               function(r) .sportpress_is_int(r$roster_id) && .sportpress_is_dict(r$player), logical(1))
  if (!all(ok)) .sportpress_fail(paste0(where, ": a row without roster_id / player"), call)
}

#' @noRd
.sportpress_c_team_games <- function(body, ids, q, where, call) {
  tid <- ids$competition_team_id
  for (g in .sportpress_data_list(body, where, call)) {
    plays <- any(vapply(.sportpress_sides(g) %||% list(), function(c) .sportpress_same(.sportpress_team_id(c), tid), logical(1)))
    if (!plays || !identical(g$status, "finished")) {
      .sportpress_fail(paste0(where, ": out of scope: game ", .sportpress_repr(g$id), " is not a finished game of team ",
                              tid), call)
    }
    if (!.sportpress_is_dict(g$total)) .sportpress_fail(paste0(where, ": game ", .sportpress_repr(g$id), " has no team total"), call)
  }
}

#' @noRd
.sportpress_c_roster_find <- function(body, ids, q, where, call) {
  d <- .sportpress_data_obj(body, where, call)
  if (!.sportpress_same(d$id, ids$roster_id)) {
    .sportpress_fail(paste0(where, ": out of scope: the body is roster ", .sportpress_repr(d$id), ", asked for ",
                            ids$roster_id), call)
  }
}

#' @noRd
.sportpress_c_player_career <- function(body, ids, q, where, call) {
  ok <- vapply(.sportpress_data_list(body, where, call),
               function(r) .sportpress_is_dict(r$competition) && .sportpress_is_dict(r$team), logical(1))
  if (!all(ok)) .sportpress_fail(paste0(where, ": a career row without competition / team"), call)
}

#' @noRd
.sportpress_c_player_games <- function(body, ids, q, where, call) {
  for (r in .sportpress_data_list(body, where, call)) {
    s <- .sportpress_sides(r$game)
    played <- !is.null(s) &&
      any(vapply(s, function(c) .sportpress_same(.sportpress_team_id(c), r$competition_team_id), logical(1)))
    if (!played) .sportpress_fail(paste0(where, ": a line whose team did not play its game"), call)
  }
}

#' @noRd
.sportpress_c_game_find <- function(body, ids, q, where, call) {
  g <- .sportpress_data_obj(body, where, call)
  gid <- ids$game_id
  if (!.sportpress_same(g$id, gid)) {
    .sportpress_fail(paste0(where, ": out of scope: the body is game ", .sportpress_repr(g$id), ", asked for ", gid), call)
  }
  s <- .sportpress_sides(g)
  if (is.null(s) || !all(vapply(s, function(c) .sportpress_is_int(.sportpress_team_id(c)), logical(1)))) {
    .sportpress_fail(paste0(where, ": game ", gid, " has no two sides"), call)
  }
  if (identical(g$status, "finished")) {
    if (is.null(.sportpress_state$finished)) .sportpress_state$finished <- list()
    .sportpress_state$finished[[as.character(gid)]] <- .sportpress_ident(g)
  }
}

#' @noRd
.sportpress_c_overview <- function(body, ids, q, where, call) {
  ident <- .sportpress_game(ids$game_id, call)
  d <- if (.sportpress_is_dict(body)) body$data
  keys <- c("team_totals", "top_performer", "game_leaders")
  if (!.sportpress_is_dict(d) || !setequal(names(d), keys) || length(names(d)) != 3L ||
        !all(vapply(keys, function(k) .sportpress_is_array(d[[k]]), logical(1)))) {
    .sportpress_fail(paste0(where, ": not the overview envelope"), call)
  }
  if (!any(lengths(d[keys]) > 0L)) .abort_no_data("{where}: an overview without statistics.", call = call)
  want_team <- list(ident$home, ident$away)
  want_home <- c(TRUE, FALSE)
  for (k in keys) {
    if (length(d[[k]]) != 2L) .sportpress_fail(paste0(where, ": ", k, " is not two rows"), call)
    for (r in d[[k]]) {
      c <- if (.sportpress_is_dict(r)) r$competitor
      side <- .sportpress_get_in(c, "side")
      ok <- .sportpress_is_int(side) && side %in% 1:2
      if (!ok || !.sportpress_same(.sportpress_team_id(c), want_team[[side]]) ||
            !.sportpress_same(r$is_home, want_home[[side]])) {
        .sportpress_fail(paste0(where, ": out of scope: ", k, " side / team does not match game ", ids$game_id), call)
      }
      if (!.sportpress_same(.sportpress_get_in(c, "finalScore"), ident$score[[side]])) {
        .sportpress_fail(paste0(where, ": out of scope: ", k, " final score differs from game ", ids$game_id), call)
      }
    }
  }
}

#' @noRd
.sportpress_c_box <- function(body, ids, q, where, call) {
  ident <- .sportpress_game(ids$game_id, call)
  if (!.sportpress_same(ident$competition_id, ids$competition_id)) {
    .sportpress_fail(paste0(where, ": out of scope: game ", ids$game_id, " is of competition ",
                            .sportpress_repr(ident$competition_id)), call)
  }
  rows <- .sportpress_data_list(body, where, call)
  home <- vapply(rows, function(r) isTRUE(r$is_home), logical(1))
  if (length(rows) != 2L || sum(home) != 1L || !all(vapply(rows, function(r) is.logical(r$is_home), logical(1)))) {
    .sportpress_fail(paste0(where, ": not two teams, one home and one away"), call)
  }
  for (r in rows) {
    tid <- .sportpress_get_in(r, "team", "id")
    if (!.sportpress_same(tid, if (isTRUE(r$is_home)) ident$home else ident$away)) {
      .sportpress_fail(paste0(where, ": out of scope: team ", .sportpress_repr(tid), " is not a side of game ",
                              ids$game_id), call)
    }
    players <- r$players
    if (!.sportpress_is_array(players) || !length(players) || !.sportpress_is_dict(r$total)) {
      .sportpress_fail(paste0(where, ": a team without player lines / total"), call)
    }
    if (any(!vapply(players, function(p) .sportpress_same(p$competition_team_id, tid), logical(1)))) {
      .sportpress_fail(paste0(where, ": a player line is of another team"), call)
    }
  }
}

#' @noRd
.sportpress_c_film <- function(body, ids, q, where, call) {
  ident <- .sportpress_game(ids$game_id, call)
  if (!.sportpress_same(ident$competition_id, ids$competition_id)) {
    .sportpress_fail(paste0(where, ": out of scope: game ", ids$game_id, " is of competition ",
                            .sportpress_repr(ident$competition_id)), call)
  }
  rows <- .sportpress_data_list(body, where, call)
  ok <- vapply(rows, function(r) .sportpress_is_int(r$order), logical(1))
  orders <- vapply(rows, function(r) if (.sportpress_is_int(r$order)) r$order else NA_integer_, integer(1))
  if (!all(ok) || is.unsorted(orders, strictly = TRUE)) {
    .sportpress_fail(paste0(where, ": event order is not strictly increasing"), call)
  }
  for (r in rows) {
    home <- r$is_home
    if (!is.logical(home) || length(home) != 1L || is.na(home) ||
          !.sportpress_same(.sportpress_get_in(r, "team", "id"), if (home) ident$home else ident$away)) {
      .sportpress_fail(paste0(where, ": out of scope: event ", .sportpress_repr(r$order), " is of a team outside game ",
                              ids$game_id), call)
    }
  }
  top_of <- function(k) max(vapply(rows, function(r) {
    v <- r[[k]]
    if (is.numeric(v) && length(v) == 1L && !is.na(v)) as.numeric(v) else 0
  }, numeric(1)))
  top <- c(top_of("current_home_score"), top_of("current_away_score"))
  final <- vapply(ident$score, function(v) if (is.numeric(v) && length(v) == 1L) as.numeric(v) else NA_real_, numeric(1))
  if (anyNA(final) || any(top != final)) {
    .sportpress_fail(paste0(
      where, ": the running score ends ", top[[1]], "-", top[[2]], " but the game finished ",
      .sportpress_repr(ident$score[[1]]), "-", .sportpress_repr(ident$score[[2]]), ": a truncated or foreign play-by-play"
    ), call)
  }
}

# ---------------------------------------------------------------------------
# Routes and the getter
# ---------------------------------------------------------------------------

#' Route -> path template (`{id}` placeholders, the R argument names), the check, and whether the route
#' is gated on a finished game (the box score, film and overview).
#' @noRd
.SPORTPRESS_ROUTES <- list(
  server_config = list("/server-config", .sportpress_c_server_config),
  club_seasons = list("/competition-team/club/seasons", .sportpress_c_club_seasons),
  staff_list = list("/staff/list", .sportpress_c_referees),
  phase_season = list("/phase/season/{season}", .sportpress_c_phase_season),
  competition_teams = list("/competition-team/all", .sportpress_c_competition_teams),
  standings = list("/standings/competition/{competition_id}/phase/{phase_id}", .sportpress_c_standings),
  schedule_club = list("/schedule/club/{season}", .sportpress_c_schedule_club),
  game_slider = list("/schedule/game-slider/{competition_id}", .sportpress_c_game_slider),
  team_rankings = list("/competition-team/average-rankings/{competition_id}", .sportpress_c_ranking("team")),
  player_rankings = list("/player/average-rankings/{competition_id}", .sportpress_c_ranking("player")),
  season_players = list("/roster/season-players/{season}", .sportpress_c_roster_rows()),
  nationality_codes = list("/roster/season-nationality-codes/{season}", .sportpress_c_nationality_codes),
  team_players = list("/roster/team-players/{competition_team_id}",
                      .sportpress_c_roster_rows(c("competition_team_id", "competition_team_id"))),
  team_find = list("/competition-team/find/{competition_team_id}", .sportpress_c_team_find),
  player_averages = list("/competition-team/player-averages/{competition_team_id}", .sportpress_c_player_averages),
  team_games = list("/competition-team/statistics-by-game/total/{competition_team_id}", .sportpress_c_team_games),
  roster_find = list("/roster/find/{roster_id}", .sportpress_c_roster_find),
  player_career = list("/player/career-averages/{roster_id}", .sportpress_c_player_career),
  player_games = list("/boxscore/player/season-games/{roster_id}", .sportpress_c_player_games),
  game_find = list("/schedule/find/{game_id}", .sportpress_c_game_find),
  overview = list("/schedule/overview/{game_id}", .sportpress_c_overview, TRUE),
  box = list("/boxscore/game/{competition_id}/{game_id}", .sportpress_c_box, TRUE),
  film = list("/film/game/{competition_id}/{game_id}", .sportpress_c_film, TRUE)
)

#' sportsdataverse-py `_int_arg`: an integer, a whole double or a digit string; anything else is `hoopR_bad_request`.
#' @noRd
.sportpress_int_arg <- function(value, what, call) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) &&
    ((is.numeric(value) && is.finite(value) && value == trunc(value) && abs(value) <= .Machine$integer.max) ||
       (is.character(value) && grepl("^\\s*-?[0-9]{1,9}\\s*$", value)))
  if (!ok) {
    shown <- if (is.atomic(value) && length(value) == 1L) .sportpress_repr(value) else paste0("<", class(value)[[1]], ">")
    .abort_bad_request("{.arg {what}} must be an integer; got {shown}.", call = call)
  }
  as.integer(value)
}

#' GET a Sportpress route, refuse every wrong answer, return the body with the request stamped.
#'
#' @param route Name in `.SPORTPRESS_ROUTES`.
#' @param ids Named list of the path ids (R argument names: `season`, `competition_id`, `phase_id`,
#'   `competition_team_id`, `roster_id`, `game_id`).
#' @param query Named list of query parameters; `NULL` entries are dropped. `competition_id`, `phase_id`,
#'   `title_id` and `month` must be integers.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The parsed body without contact fields (`list(data = ...)`, the settings object, or the
#'   nine-category ranking object), plus `_request`.
#' @noRd
.sportpress_get <- function(route, ids = list(), query = list(), call = rlang::caller_env()) {
  rt <- .SPORTPRESS_ROUTES[[route]]
  ids <- lapply(stats::setNames(nm = names(ids)), function(n) .sportpress_int_arg(ids[[n]], n, call))
  query <- Filter(Negate(is.null), query)
  for (n in intersect(names(query), c("competition_id", "phase_id", "title_id", "month"))) {
    query[[n]] <- .sportpress_int_arg(query[[n]], n, call)
  }
  path <- rt[[1]]
  for (n in names(ids)) path <- sub(paste0("{", n, "}"), ids[[n]], path, fixed = TRUE)
  if (length(rt) > 2L && isTRUE(rt[[3]])) .sportpress_game(ids$game_id, call) # an unfinished game costs one request
  body <- .sportpress_scrub_personal(.sportpress_call(path, query, call = call))
  where <- paste0(httr2::url_parse(.SPORTPRESS_API)$hostname, path)
  rt[[2]](body, ids, query, where, call)
  if (.sportpress_is_array(body)) body <- list(data = body)
  body[[.SPORTPRESS_REQUEST]] <- c(ids, query[intersect(names(query), c("competition_id", "phase_id", "title_id", "month",
                                                                         "type"))])
  body
}
