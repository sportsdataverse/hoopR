# cba_runtime.R -- transport for the CBA wrappers (data-server.cbaleague.com), the R mirror of sportsdataverse-py
# sportsdataverse/basketball/cba/cba_runtime.py + cba_aes.py (origin/main e3d232e).
#
# * Every body is AES-128-ECB / PKCS#7 encrypted (a JSON string literal holding base64 of the
#   ciphertext). The 16-character key is a public constant of the site's front-end bundle.
#   digest::AES(key, mode = "ECB") decrypts; the PKCS#7 padding is checked and stripped once here.
#   Anything that does not decrypt is refused: the API's unencrypted HTTP 500 envelope, an empty 200
#   body, a plain body. Note: the key is a constant; if the site rotates it every request fails
#   with hoopR_asset_fetch naming the decrypt step, and the fix is the new constant from the bundle.
# * The host blocks datacenter IPs at TCP. Proxy: getOption("hoopR.proxy"), then env CBA_PROXY (never
#   printed). Without one the request goes direct and fails FAST: a 5 s connect timeout and no retry
#   of a refused or timed-out connect (a read timeout or a reset mid-response is still retried).
#   CBA_DIRECT=1 (a residential IP): direct, the full timeout and retries.
# * HTTP 500 is NOT retried (the API answers it for a body it dislikes); 429 / 502 / 503 / 504 are,
#   three attempts in all, spaced 2 s then 4 s (or Retry-After, capped at 30 s), on top of the
#   runtime's >= 1 s per host.
# * Season: the public `season` is the END year; the API takes the START year (season - 1).
# * Game routes serve FINISHED games only: the game report header (baseInfo, cached per session) must
#   carry two integer scores and both team ids, and every game body is checked against it.
# * Operator ids (createdBy / lastModifiedBy) and any bare mobile-number string are removed from every
#   body.

#' @noRd
.CBA_API <- "https://data-server.cbaleague.com"
#' @noRd
.CBA_PROXY_ENV <- "CBA_PROXY"
#' @noRd
.CBA_DIRECT_ENV <- "CBA_DIRECT"
#' Public constant from the site bundle (function `TIe` of cbaleague.com/data/assets/index.<hash>.js).
#' @noRd
.CBA_KEY <- "uVayqL4ONKjFbVzQ"
#' @noRd
.CBA_HEADERS <- list(Referer = "https://www.cbaleague.com/data/")
#' @noRd
.CBA_ATTEMPTS <- 3L
#' @noRd
.CBA_TIMEOUT <- 60
#' @noRd
.CBA_FAST_CONNECT_TIMEOUT <- 5
#' @noRd
.CBA_RETRY_STATUSES <- c(429L, 502L, 503L, 504L)
#' @noRd
.CBA_MAX_RETRY_AFTER <- 30
#' @noRd
.CBA_POST <- c(
  "player-match-datas/data-count", "player-match-datas/advance-count", "player-match-datas/schedule-other-data",
  "schedule-quarters/getQuarterInfo", "team-match-datas/schedule-shoot-list", "teams/schedule-four-elements",
  "schedule-eventses/filterPage", "teams/basic-data", "teams/four-elements", "team-match-datas/team-entirety-list",
  "team-match-datas/team-shoot-list", "player-base-list", "player-offensive-list", "player-defensive-list",
  "player-shoot-list"
)
#' Game routes whose scheduleId is a path segment.
#' @noRd
.CBA_PATH_ID <- c(
  "schedules/getPlayersByScheduleId", "team-match-datas/getMatchDataReport/baseInfo",
  "team-match-datas/getMatchDataReport/bestPlayer", "team-match-datas/getMatchDataReport/bestDataQuota",
  "team-match-datas/getMatchDataReportStatues"
)
#' Game routes whose scheduleId is a body field.
#' @noRd
.CBA_BODY_ID <- c(
  "player-match-datas/data-count", "player-match-datas/advance-count", "player-match-datas/schedule-other-data",
  "schedule-quarters/getQuarterInfo", "team-match-datas/schedule-shoot-list", "teams/schedule-four-elements",
  "schedule-eventses/filterPage"
)
#' @noRd
.CBA_PLAYER_LISTS <- c("player-base-list", "player-offensive-list", "player-defensive-list", "player-shoot-list")
#' @noRd
.CBA_SEASON_ROUTES <- c("com-code-tables/getTeam", "team-count/season", .CBA_PLAYER_LISTS)
#' @noRd
.CBA_REDACT_KEYS <- c("createdBy", "lastModifiedBy")

# finished games (header and box) of this session, keyed "info:<id>" / "box:<id>"
.cba_cache <- new.env(parent = emptyenv())

# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

#' @noRd
.cba_is_obj <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.cba_is_arr <- function(x) is.list(x) && is.null(names(x))
#' @noRd
.cba_is_int <- function(x) is.integer(x) && length(x) == 1L && !is.na(x)

#' A whole number as plain digits (`100105799`, never `1.00105799e+08`).
#' @noRd
.cba_num_text <- function(x) format(x, scientific = FALSE, trim = TRUE)

#' sportsdataverse-py `_int_arg`: an integer, or a string of digits; anything else is `hoopR_bad_request`.
#' @noRd
.cba_int_arg <- function(value, what, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) &&
    ((is.numeric(value) && is.finite(value) && value == trunc(value)) ||
       (is.character(value) && grepl("^\\s*-?[0-9]+\\s*$", value)))
  if (!ok) .abort_bad_request("{what} must be an integer; got {.val {format(value)}}.", call = call)
  as.numeric(value)
}

#' The API's START-year `season` for the public END year (2026 -> 2025).
#' @noRd
.cba_wire_season <- function(season, call = rlang::caller_env()) {
  as.integer(.cba_int_arg(season, "season", call) - 1)
}

#' One comparable key per scalar, keeping Python's int-vs-str distinction (`29128` != `"29128"`).
#' @noRd
.cba_key <- function(v) {
  if (is.null(v) || length(v) != 1L || is.list(v)) return(NA_character_)
  if (is.character(v)) return(paste0("s:", v))
  if (is.logical(v)) return(paste0("b:", v))
  paste0("n:", .cba_num_text(v))
}

#' sportsdataverse-py `_ids`: the keys of the non-null `key` values of the object rows.
#' @noRd
.cba_ids <- function(rows, key) {
  vals <- lapply(Filter(.cba_is_obj, if (is.list(rows)) rows else list()), function(r) r[[key]])
  unique(vapply(Filter(Negate(is.null), vals), .cba_key, character(1)))
}

#' Drop operator ids and replace bare mobile-number strings, recursively.
#' @noRd
.cba_redact <- function(x) {
  if (is.list(x)) {
    if (!is.null(names(x))) x <- x[!names(x) %in% .CBA_REDACT_KEYS]
    return(lapply(x, .cba_redact))
  }
  if (is.character(x) && length(x) == 1L && grepl("^1[3-9][0-9]{9}$", x)) return("<redacted>")
  x
}

# ---------------------------------------------------------------------------
# AES-128-ECB / PKCS#7 (digest::AES)
# ---------------------------------------------------------------------------

#' @noRd
.cba_undecryptable <- function(message) rlang::abort(message, class = "hoopR_cba_undecryptable")

#' Wire text -> parsed JSON (the JSON-string-literal form the API sends, or bare base64).
#'
#' Refuses a plain-JSON body (the API's 500 envelope is not encrypted), non-base64 text, a wrong key
#' (bad PKCS#7 padding), a non-UTF-8 or non-JSON plaintext. Large integers keep their digits
#' (`bigint_as_char`), so a 19-digit id is never rounded through a double.
#' @noRd
.cba_decrypt_body <- function(text, key = .CBA_KEY) {
  t <- trimws(text %||% "")
  if (startsWith(t, "\"")) {
    t <- tryCatch(jsonlite::parse_json(t), error = function(e) NULL)
    if (!is.character(t)) .cba_undecryptable("body starts with a quote but is not a JSON string")
  }
  if (!is.character(t) || length(t) != 1L || !nzchar(t)) .cba_undecryptable("body is not a base64 string")
  if (nchar(t) %% 4L != 0L || !grepl("^[A-Za-z0-9+/]*={0,2}$", t)) {
    .cba_undecryptable("body is not base64 (plain / error body?)")
  }
  cipher <- jsonlite::base64_dec(t)
  n <- length(cipher)
  if (n == 0L || n %% 16L != 0L) .cba_undecryptable(paste0("ciphertext length ", n, " is not a positive multiple of 16"))
  rlang::check_installed("digest", "to decrypt CBA responses")
  plain <- digest::AES(charToRaw(key), mode = "ECB")$decrypt(cipher, raw = TRUE)
  pad <- as.integer(plain[[n]])
  if (pad < 1L || pad > 16L || !all(plain[(n - pad + 1L):n] == as.raw(pad))) {
    .cba_undecryptable("bad PKCS7 padding (wrong key?)")
  }
  txt <- tryCatch(rawToChar(plain[seq_len(n - pad)]), error = function(e) NA_character_)
  if (is.na(txt) || !validUTF8(txt)) .cba_undecryptable("plaintext is not UTF-8 JSON (wrong key?)")
  Encoding(txt) <- "UTF-8"
  tryCatch(
    jsonlite::parse_json(txt, simplifyVector = FALSE, bigint_as_char = TRUE),
    error = function(e) .cba_undecryptable("plaintext is not UTF-8 JSON (wrong key?)")
  )
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' TRUE when a transport failure happened while OPENING the connection (a connect timeout, a refused
#' or unreachable connect, an unresolvable host): how the host turns away a datacenter IP.
#' @noRd
.cba_dropped_at_connect <- function(err) {
  while (!is.null(err)) {
    cls <- class(err)
    if (any(cls %in% c("curl_error_couldnt_connect", "curl_error_couldnt_resolve_host"))) return(TRUE)
    if ("curl_error_operation_timedout" %in% cls &&
        grepl("Connect(ion)? tim(ed out|eout)|Failed to connect", conditionMessage(err), ignore.case = TRUE)) {
      return(TRUE)
    }
    err <- err$parent
  }
  FALSE
}

#' The innermost condition class of a transport failure (never its message: it can quote a proxy URL).
#' @noRd
.cba_cause <- function(err) {
  cause <- class(err)[[1]]
  while (!is.null(err$parent)) {
    err <- err$parent
    cause <- class(err)[[1]]
  }
  cause
}

#' One CBA request (every attempt throttled per host); returns the decrypted, redacted JSON.
#'
#' @param route Path under `/api/` (a game id appended for the path-id routes).
#' @param query Named list of query parameters.
#' @param body Named list: the JSON body of a POST route; `NULL` sends a GET.
#' @noRd
.cba_fetch <- function(route, query = list(), body = NULL, call = rlang::caller_env()) {
  url <- paste0(.CBA_API, "/api/", route)
  where <- .intl_where(url)
  px <- .intl_proxy(NULL, .CBA_PROXY_ENV)
  fast <- is.null(px) && trimws(Sys.getenv(.CBA_DIRECT_ENV, "")) != "1"
  if (!is.null(body) && !length(body)) body <- structure(list(), names = character()) # {} not []
  req <- .intl_request(url, query = query, body = body, body_type = if (is.null(body)) "none" else "json",
                       headers = .CBA_HEADERS, proxy = px$value, timeout = .CBA_TIMEOUT)
  if (fast) req <- httr2::req_options(req, connecttimeout = .CBA_FAST_CONNECT_TIMEOUT)
  resp <- NULL
  for (attempt in seq_len(.CBA_ATTEMPTS)) {
    resp <- tryCatch(.intl_perform(req, max_tries = 1, proxy_label = px$source, call = call),
                     hoopR_asset_fetch = function(e) e)
    if (inherits(resp, "condition")) {
      dropped <- fast && .cba_dropped_at_connect(resp$parent)
      if (attempt == .CBA_ATTEMPTS || dropped) {
        hint <- if (is.null(px)) {
          paste0(" (set ", .CBA_PROXY_ENV, ": the host blocks datacenter IPs; ", .CBA_DIRECT_ENV,
                 "=1 if direct access works here)")
        } else {
          ""
        }
        tries <- if (dropped) "on the first attempt" else paste("after", .CBA_ATTEMPTS, "attempts")
        cause <- if (is.null(resp$parent)) "transport failure" else .cba_cause(resp$parent)
        .abort_asset_fetch("{where}: fetch failed {tries}: {cause}{hint}", transient = TRUE, call = call)
      }
      next
    }
    status <- httr2::resp_status(resp)
    if (status %in% .CBA_RETRY_STATUSES && attempt < .CBA_ATTEMPTS) {
      ra <- suppressWarnings(as.numeric(httr2::resp_header(resp, "Retry-After", default = "0")))
      ra <- if (length(ra) == 1L && !is.na(ra)) min(max(ra, 0), .CBA_MAX_RETRY_AFTER) else 0
      .intl_sleep(max(ra, min(2 * 2^(attempt - 1), .CBA_MAX_RETRY_AFTER)))
      next
    }
    break
  }
  status <- httr2::resp_status(resp)
  if (status == 404L) .abort_no_data("{where} answered HTTP 404.", status = status, call = call)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}.", status = status, call = call)
  }
  if (status == 500L) {
    .abort_asset_fetch("{where} answered HTTP 500 (the API refuses a body it dislikes; not retried).",
                       status = status, call = call)
  }
  if (status != 200L) {
    .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status,
                       transient = status %in% c(408L, 429L) || status >= 500L, call = call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) {
    .abort_asset_fetch("{where} answered HTTP 200 with an empty body (missing or invalid request fields?).",
                       call = call)
  }
  out <- tryCatch(.cba_decrypt_body(text), hoopR_cba_undecryptable = function(e) e)
  if (inherits(out, "hoopR_cba_undecryptable")) {
    why <- conditionMessage(out)
    .abort_asset_fetch("{where}: the body did not decrypt ({why}); an error envelope or a rotated key.",
                       call = call)
  }
  .cba_redact(out)
}

# ---------------------------------------------------------------------------
# Game scope
# ---------------------------------------------------------------------------

#' The game report header of a FINISHED game (cached); anything else raises.
#' @noRd
.cba_info <- function(sid, call = rlang::caller_env()) {
  slot <- paste0("info:", .cba_num_text(sid))
  if (!is.null(.cba_cache[[slot]])) return(.cba_cache[[slot]])
  route <- paste0("team-match-datas/getMatchDataReport/baseInfo/", .cba_num_text(sid))
  body <- .cba_fetch(route, call = call)
  where <- .intl_where(paste0(.CBA_API, "/api/", route))
  if (!.cba_is_obj(body)) .abort_asset_fetch("{where}: the body is not an object.", call = call)
  ints <- lapply(c("hostScore", "guestScore", "hostTeamId", "guestTeamId"), function(k) body[[k]])
  if (!all(vapply(ints, .cba_is_int, logical(1))) || (ints[[1]] == 0L && ints[[2]] == 0L)) {
    game <- .cba_num_text(sid)
    .abort_asset_fetch(paste0("{where}: game {game} is not final (no two integer scores / team ids); ",
                              "CBA game wrappers serve finished games only."), call = call)
  }
  .cba_cache[[slot]] <- body
  body
}

#' The (cached) player box of a finished game, for the advanced / extras / leaders scope checks.
#' @noRd
.cba_box <- function(sid, call = rlang::caller_env()) {
  slot <- paste0("box:", .cba_num_text(sid))
  if (is.null(.cba_cache[[slot]])) {
    .cba_cache[[slot]] <- .cba_checked("player-match-datas/data-count", sid,
                                       list(scheduleId = .cba_num_text(sid)), call = call)
  }
  .cba_cache[[slot]]
}

#' @noRd
.cba_box_ids <- function(sid, call) {
  box <- .cba_box(sid, call)
  .cba_ids(c(box[["homeCounts"]] %||% list(), box[["visitingCounts"]] %||% list()), "playerId")
}

#' Why `body` is not game `sid`'s answer, or `NULL`. Fails closed.
#' @noRd
.cba_scope_error <- function(route, body, sid, info, call = rlang::caller_env()) {
  host <- .cba_key(info[["hostTeamId"]])
  guest <- .cba_key(info[["guestTeamId"]])
  short <- if (route %in% .CBA_PATH_ID) route else sub("^.*/", "", route)
  if (route == "team-match-datas/getMatchDataReport/baseInfo") return(NULL)
  if (route == "team-match-datas/getMatchDataReportStatues") {
    ok <- .cba_is_obj(body) && is.logical(body[["isReport"]]) && length(body[["isReport"]]) == 1L &&
      !is.na(body[["isReport"]])
    return(if (ok) NULL else "no isReport flag")
  }
  if (route == "team-match-datas/getMatchDataReport/bestPlayer") {
    ok <- .cba_is_obj(body) && (.cba_is_obj(body[["hostBestPlayer"]]) || .cba_is_obj(body[["guestBestPlayer"]]))
    return(if (ok) NULL else "no hostBestPlayer / guestBestPlayer object")
  }
  if (short == "data-count") {
    if (!.cba_is_obj(body)) return("the body is not an object")
    for (side in list(c("homeCounts", "hostScore"), c("visitingCounts", "guestScore"))) {
      rows <- body[[side[[1]]]]
      if (!.cba_is_arr(rows) || !length(rows)) return(paste("no", side[[1]], "rows"))
      pts <- sum(vapply(Filter(function(r) .cba_is_obj(r) && !is.null(r[["playerId"]]), rows), function(r) {
        p <- suppressWarnings(as.numeric(r[["points"]] %||% 0))
        if (length(p) == 1L && !is.na(p)) p else 0
      }, numeric(1)))
      score <- info[[side[[2]]]]
      if (pts != score) return(sprintf("out of scope: %s points %s != the game score %s", side[[1]], pts, score))
    }
    return(NULL)
  }
  if (short == "getQuarterInfo") {
    for (side in list(c("home", "hostScore"), c("visiting", "guestScore"))) {
      blk <- if (.cba_is_obj(body)) body[[side[[1]]]] else NULL
      score <- info[[side[[2]]]]
      if (!.cba_is_obj(blk) || sum(unlist(Filter(.cba_is_int, blk))) != score) {
        return(sprintf("out of scope: %s period points do not sum to the game score %s", side[[1]], score))
      }
    }
    return(NULL)
  }
  if (short %in% c("advance-count", "schedule-other-data")) {
    keys <- if (short == "advance-count") c("homes", "visitings") else c("homePlayers", "visitingPlayers")
    box <- .cba_box_ids(sid, call)
    if (!.cba_is_obj(body)) return("the body is not an object")
    teams <- c(host, guest)
    for (i in 1:2) {
      rows <- body[[keys[[i]]]]
      if (!.cba_is_arr(rows) || !length(rows)) return(paste("no", keys[[i]], "rows"))
      if (length(setdiff(.cba_ids(rows, "playerId"), box))) {
        return(paste0("out of scope: a ", keys[[i]], " player is not in the game box score"))
      }
      if (short == "advance-count" && length(setdiff(.cba_ids(rows, "teamId"), teams[[i]]))) {
        return(paste0("out of scope: a ", keys[[i]], " row is not team ", sub("^.:", "", teams[[i]]), "'s"))
      }
    }
    return(NULL)
  }
  if (route == "schedules/getPlayersByScheduleId") {
    teams <- c(host, guest)
    keys <- c("hostPlayers", "guestPlayers")
    for (i in 1:2) {
      rows <- if (.cba_is_obj(body)) body[[keys[[i]]]] else NULL
      if (!.cba_is_arr(rows) || !length(rows) || length(setdiff(.cba_ids(rows, "teamId"), teams[[i]]))) {
        return(paste0("out of scope: ", keys[[i]], " is empty or not team ", sub("^.:", "", teams[[i]]), "'s"))
      }
    }
    return(NULL)
  }
  if (route == "team-match-datas/getMatchDataReport/bestDataQuota") {
    if (!.cba_is_obj(body)) return("the body is not an object")
    box <- sub("^n:", "s:", .cba_box_ids(sid, call)) # the leaders send playerId as a string
    for (key in c("hostTeamBestData", "guestTeamBestData")) {
      if (length(setdiff(.cba_ids(body[[key]] %||% list(), "playerId"), box))) {
        return(paste0("out of scope: a ", key, " player is not in the game box score"))
      }
    }
    return(NULL)
  }
  if (short == "schedule-shoot-list") {
    rows <- if (.cba_is_arr(body)) body else NULL
    if (!length(rows) || length(setdiff(.cba_ids(rows, "teamId"), c(host, guest)))) {
      return("out of scope: rows are not the two teams of the game")
    }
    return(NULL)
  }
  if (short == "schedule-four-elements") { # unscoped: the previous-season team table
    return(if (.cba_is_arr(body) && length(body)) NULL else "no rows")
  }
  NULL
}

#' Fetch a game route (after the finished-game check) and refuse a body that is not this game's.
#' @noRd
.cba_checked <- function(route, sid, fields, path_id = NULL, qkeys = character(), call = rlang::caller_env()) {
  info <- .cba_info(sid, call)
  full <- if (!is.null(path_id)) paste0(route, "/", .cba_num_text(path_id)) else route
  got <- if (route %in% .CBA_POST) {
    .cba_fetch(full, fields[names(fields) %in% qkeys], fields[!names(fields) %in% qkeys], call = call)
  } else {
    .cba_fetch(full, fields, NULL, call = call)
  }
  why <- .cba_scope_error(route, got, sid, info, call)
  if (!is.null(why)) {
    where <- .intl_where(paste0(.CBA_API, "/api/", full))
    .abort_asset_fetch("{where}: {why}", call = call)
  }
  got
}

#' Play-by-play: one period per request; every period (from the period scores) unless `quarter`.
#' @noRd
.cba_pbp <- function(sid, quarter = NULL, call = rlang::caller_env()) {
  info <- .cba_info(sid, call)
  route <- "schedule-eventses/filterPage"
  where <- .intl_where(paste0(.CBA_API, "/api/", route))
  game <- .cba_num_text(sid)
  if (is.null(quarter)) {
    periods <- .cba_checked("schedule-quarters/getQuarterInfo", sid, list(scheduleId = game), call = call)
    quarters <- seq_len(sum(vapply(periods[["home"]], .cba_is_int, logical(1))))
  } else {
    quarters <- as.integer(quarter)
  }
  rows <- list()
  for (q in quarters) {
    page <- .cba_fetch(route, list(startNum = 0L), list(scheduleId = game, quarterNum = q), call = call)
    recs <- if (.cba_is_obj(page)) page[["records"]] else NULL
    if (!is.list(recs) || (length(recs) && !.cba_is_arr(recs))) {
      .abort_asset_fetch("{where}: period {q} has no records list.", call = call)
    }
    if (!length(recs)) {
      if (is.null(quarter) && q == 1L) {
        .abort_no_data("{where}: game {game} has no play-by-play (the site has none for 2009-10).", call = call)
      }
      if (!is.null(quarter)) .abort_no_data("{where}: game {game} has no plays in period {q}.", call = call)
      .abort_asset_fetch("{where}: period {q} is empty but period 1 is not (partial play-by-play).", call = call)
    }
    total <- page[["total"]]
    n <- length(recs)
    if (!is.null(total) && !.cba_key(total) %in% c("n:0", .cba_key(n))) {
      .abort_asset_fetch("{where}: period {q} page is truncated ({n} of {total} rows).", call = call)
    }
    if (!all(vapply(recs, function(r) identical(.cba_key(r[["quarterNum"]]), .cba_key(q)), logical(1)))) {
      .abort_asset_fetch("{where}: out of scope: a row of period {q} echoes another period.", call = call)
    }
    mins <- lapply(recs, function(r) r[["minutes"]])
    secs <- lapply(recs, function(r) r[["seconds"]])
    ok <- all(vapply(c(mins, secs), .cba_is_int, logical(1)))
    if (ok && length(recs) > 1L) {
      m <- unlist(mins)
      s <- unlist(secs)
      i <- seq_len(length(m) - 1L)
      ok <- all(m[i] > m[i + 1L] | (m[i] == m[i + 1L] & s[i] >= s[i + 1L]))
    }
    if (!ok) .abort_asset_fetch("{where}: period {q} clock does not count down.", call = call)
    rows <- c(rows, recs)
  }
  if (is.null(quarter)) {
    top <- function(k) max(vapply(rows, function(r) as.numeric(r[[k]] %||% 0), numeric(1)))
    home <- top("homeScore")
    away <- top("visitorScore")
    if (home != info[["hostScore"]] || away != info[["guestScore"]]) {
      final <- paste0(info[["hostScore"]], "-", info[["guestScore"]])
      .abort_asset_fetch("{where}: the plays reach {home}-{away}, not the final {final}.", call = call)
    }
  }
  list(records = rows, total = length(rows))
}

# ---------------------------------------------------------------------------
# The getter
# ---------------------------------------------------------------------------

#' Season / team / day echo checks for the non-game routes.
#' @noRd
.cba_scope_list <- function(route, body, q, call = rlang::caller_env()) {
  where <- .intl_where(paste0(.CBA_API, "/api/", route))
  rows <- if (.cba_is_obj(body)) body[["records"]] else body
  team_lists <- c("team-match-datas/team-entirety-list", "team-match-datas/team-shoot-list")
  if (route %in% c(.CBA_PLAYER_LISTS, team_lists) && !(.cba_is_arr(rows) || identical(rows, list()))) {
    .abort_asset_fetch("{where}: no records list.", call = call)
  }
  if (route %in% .CBA_PLAYER_LISTS) {
    season <- q[["season"]]
    if (any(vapply(rows, function(r) !identical(.cba_key(r[["season"]]), .cba_key(season)), logical(1)))) {
      .abort_asset_fetch("{where}: out of scope: a row echoes another season than {season}.", call = call)
    }
    team <- q[["teamId"]]
    if (!is.null(team) && length(setdiff(.cba_ids(rows, "teamId"), .cba_key(team)))) {
      .abort_asset_fetch("{where}: out of scope: a row is another team than {team}.", call = call)
    }
  } else if (route %in% team_lists) {
    team <- q[["teamId"]]
    if (length(setdiff(.cba_ids(rows, "teamId"), .cba_key(team)))) {
      team <- format(team %||% "None")
      .abort_asset_fetch("{where}: out of scope: a row is another team than {team}.", call = call)
    }
  } else if (route %in% c("teams/basic-data", "teams/four-elements")) {
    team <- q[["targetId"]]
    if (!is.list(rows) || .cba_is_obj(rows) || length(setdiff(.cba_ids(rows, "teamId"), .cba_key(team)))) {
      team <- format(team %||% "None")
      .abort_asset_fetch("{where}: out of scope: a row is another team than {team}.", call = call)
    }
  } else if (route == "schedules/day") {
    day <- as.character(q[["day"]] %||% "None")
    off <- !is.list(rows) || .cba_is_obj(rows) || any(vapply(rows, function(r) {
      st <- r[["scheduleTime"]]
      is.null(st) || substr(as.character(st), 1L, 10L) != day
    }, logical(1)))
    if (off) .abort_asset_fetch("{where}: out of scope: a game is on another day than {day} (auto mode?).", call = call)
  }
  invisible()
}

#' GET or POST a CBA route, decrypt it, refuse every wrong answer, return the JSON with the request
#' stamped (sportsdataverse-py `cba_runtime._get`).
#'
#' @param route Path under `/api/` without the game id.
#' @param params Wire keys for the query string (`pageNumber` / `pageSize` / `startNum` on a POST
#'   route; every key on a GET route). `NULL` values are dropped.
#' @param json The JSON body fields of a POST route (`NULL` values dropped). `season` (END year) is
#'   sent as the START year on the routes that take one; `scheduleId` is sent as a string.
#' @param path_id The game id of a path-id route.
#' @return The decrypted JSON. A game route that answers an object carries `_request` =
#'   `list(schedule_id = id)`; play-by-play is merged over every period into `list(records, total)`.
#' @noRd
.cba_get <- function(route, params = list(), json = NULL, path_id = NULL, call = rlang::caller_env()) {
  params <- Filter(Negate(is.null), params)
  q <- params
  for (k in names(json)) q[k] <- list(json[[k]])
  q <- Filter(Negate(is.null), q)
  qkeys <- names(params)
  if (route %in% .CBA_SEASON_ROUTES && !is.null(q[["season"]])) q[["season"]] <- .cba_wire_season(q[["season"]], call)
  sid <- NULL
  if (!is.null(path_id)) {
    sid <- .cba_int_arg(path_id, "schedule_id", call)
  } else if (route %in% .CBA_BODY_ID) {
    if (is.null(q[["scheduleId"]])) .abort_bad_request("a CBA game route needs a schedule id.", call = call)
    sid <- .cba_int_arg(q[["scheduleId"]], "schedule_id", call)
    q[["scheduleId"]] <- .cba_num_text(sid)
  }
  if (route == "schedule-eventses/filterPage") {
    quarter <- if (!is.null(q[["quarterNum"]])) as.integer(.cba_int_arg(q[["quarterNum"]], "quarter_num", call))
    out <- .cba_pbp(sid, quarter, call)
  } else if (!is.null(sid)) {
    out <- .cba_checked(route, sid, q, path_id = if (!is.null(path_id)) sid, qkeys = qkeys, call = call)
  } else {
    out <- if (route %in% .CBA_POST) {
      .cba_fetch(route, q[names(q) %in% qkeys], q[!names(q) %in% qkeys], call = call)
    } else {
      .cba_fetch(route, q, NULL, call = call)
    }
    .cba_scope_list(route, out, q, call)
  }
  if (!is.null(sid) && .cba_is_obj(out)) out[["_request"]] <- list(schedule_id = sid)
  out
}
