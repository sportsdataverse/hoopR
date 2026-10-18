# fiba_gdap_runtime.R -- transport, refusals and frame helpers of the FIBA wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/fiba_hub/fiba_runtime.py (GDAP half) and
# fiba_frames.py. The game-page half (RSC flight payload) is R/fiba_gamepage_runtime.R.
#
# GDAP JSON (digital-api.fiba.basketball/hapi/<method>): every request carries the
# Ocp-Apim-Subscription-Key header. The key is PUBLIC (fiba.basketball ships it in every page
# as NEXT_CLIENT_APIM_SUBSCRIPTION_KEY): .fiba_api_key() reads it from the live page once per
# session and falls back to the documented value. It is never logged or put in a condition.
# A 401 re-reads the key once. A missing key is 401, an unknown method 404, a missing
# parameter HTTP 500 with an empty body (NOT retried: retry_500 = FALSE), an unknown id HTTP
# 200 with {} or [] (hoopR_no_data).
#
# Refusals (hoopR_asset_fetch): an APIM error envelope ({"statusCode", "message"}), a
# {"Error": ...} object, a body for another game / competition / team / player / federation /
# family / season than asked (type-strict id comparison; a row without the field to check is
# refused, never skipped), a getgdapgamesbetweentwodates row outside [dateFrom, dateTo) on its
# local gameDateTime.
#
# Personal data: officials' contact details and coaches' / officials' dates of birth are
# dropped from every body (.fiba_scrub). Players' dates of birth are public and kept.
#
# Seasons: FIBA's native key equals the sdv key (END year for clubs, event year for national
# events, target tournament year for qualifiers), so .fiba_season() validates and passes it on.

.FIBA_GDAP_URL <- "https://digital-api.fiba.basketball/hapi"
.FIBA_SITE_URL <- "https://www.fiba.basketball"
.FIBA_KEY_PAGE <- "https://www.fiba.basketball/en"
.FIBA_KEY_HEADER <- "Ocp-Apim-Subscription-Key"
# The public key on 2026-10-12: only used when the live page cannot be read.
.FIBA_FALLBACK_KEY <- "898cd5e7389140028ecb42943c47eb74"
.FIBA_KEY_RE <- 'NEXT_CLIENT_APIM_SUBSCRIPTION_KEY\\\\*"\\s*:\\s*\\\\*"([0-9a-f]{32})\\\\*"'
.FIBA_ERROR_KEYS <- c("error", "errors", "message", "code", "detail", "status", "statusCode")
.FIBA_FIRST_SEASON <- 1950L
# fiba.basketball pages: sdv-py needs Chrome TLS against HTTP 403; libcurl with this User-Agent is served
.FIBA_UA <- "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0 Safari/537.36"

# Session caches: the key, competition families, schedules' team codes, minted edition lookups.
.fiba_cache <- new.env(parent = emptyenv())

#' @noRd
.fiba_cache_reset <- function() {
  rm(list = ls(.fiba_cache, all.names = TRUE), envir = .fiba_cache)
  invisible()
}

# ---------------------------------------------------------------------------
# JSON shape helpers (jsonlite::parse_json(simplifyVector = FALSE)):
# an object is a named list (`{}` is a named empty list), an array an unnamed list.
# ---------------------------------------------------------------------------

#' @noRd
.fiba_is_obj <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.fiba_is_arr <- function(x) is.list(x) && is.null(names(x))
#' @noRd
.fiba_dict <- function(x) if (.fiba_is_obj(x)) x else stats::setNames(list(), character())
#' @noRd
.fiba_list <- function(x) if (.fiba_is_arr(x)) x else list()
#' @noRd
.fiba_is_int <- function(x) is.integer(x) && length(x) == 1L && !is.na(x)

#' Equality that also requires equal types (sdv-py `_strict`: TRUE != 1, "5" != 5).
#' @noRd
.fiba_strict <- function(a, b) {
  !is.null(a) && !is.null(b) && length(a) == 1L && length(b) == 1L && identical(typeof(a), typeof(b)) &&
    !is.na(a) && !is.na(b) && a == b
}

#' @noRd
.fiba_dig <- function(obj, path) {
  for (key in path) obj <- if (.fiba_is_obj(obj)) obj[[key]] else NULL
  obj
}

# ---------------------------------------------------------------------------
# Argument transforms (the sdv-py YAML `transform:` names)
# ---------------------------------------------------------------------------

#' An id as integer: an integer, a whole number or a digit string; `NULL` passes through.
#'
#' sdv-py `_int_id` refuses every float (`123.0` is never an id); in R a typed `208182` is a
#' double, so a whole double is accepted and anything fractional, logical or non-numeric is
#' `hoopR_bad_request`.
#' @noRd
.fiba_int_id <- function(value, arg = "id", call = rlang::caller_env()) {
  if (is.null(value)) return(NULL)
  ok <- length(value) == 1L && !is.na(value) && !is.logical(value)
  if (ok && is.character(value)) {
    txt <- trimws(value)
    ok <- grepl("^[0-9]+$", txt) && as.numeric(txt) <= .Machine$integer.max
    if (ok) return(as.integer(txt))
  } else if (ok && is.numeric(value)) {
    ok <- value == round(value) && abs(value) <= .Machine$integer.max
    if (ok) return(as.integer(value))
  } else {
    ok <- FALSE
  }
  shown <- if (length(value) == 1L) format(value) else paste0("a length-", length(value), " value")
  .abort_bad_request("{.arg {arg}} must be an integer id; got {shown}.", call = call)
}

#' A season year from 1950, passed through unchanged (FIBA's key equals the sdv key).
#' @noRd
.fiba_season <- function(season, arg = "season", call = rlang::caller_env()) {
  if (is.null(season)) return(NULL)
  year <- .fiba_int_id(season, arg, call = call)
  if (year < .FIBA_FIRST_SEASON || year > 2100L) {
    .abort_bad_request(
      "{.arg {arg}} must be a year from {(.FIBA_FIRST_SEASON)} (END year for clubs, event year for national teams).",
      call = call
    )
  }
  year
}

#' A date (Date, POSIXct or `YYYY-MM-DD` string) as the API's `YYYY-MM-DDT00:00:00Z`.
#'
#' GDAP compares the venue-local `gameDateTime` and ignores the `Z`; `dateTo` is exclusive.
#' @noRd
.fiba_window_date <- function(value, arg = "date", call = rlang::caller_env()) {
  if (is.null(value)) return(NULL)
  day <- NA
  if (inherits(value, "Date") && length(value) == 1L) day <- value
  if (inherits(value, "POSIXt") && length(value) == 1L) day <- as.Date(value)
  if (is.character(value) && length(value) == 1L && grepl("^\\d{4}-\\d{2}-\\d{2}", trimws(value))) {
    day <- tryCatch(as.Date(substr(trimws(value), 1, 10), format = "%Y-%m-%d"), error = function(e) NA)
  }
  if (length(day) != 1L || is.na(day)) {
    .abort_bad_request("{.arg {arg}} must be a date, YYYY-MM-DD.", call = call)
  }
  paste0(format(day, "%Y-%m-%d"), "T00:00:00Z")
}

# ---------------------------------------------------------------------------
# Personal data
# ---------------------------------------------------------------------------

.FIBA_CONTACT_KEYS <- c("contactDetails", "email", "emailAddress", "phone", "mobile", "skype", "fax",
                        "preferredAirportName")
.FIBA_STAFF_CONTAINERS <- c("coaches", "nominations", "officials", "Officials", "staff")
.FIBA_STAFF_KEYS <- c("dateOfBirth", "birthDate")

#' `obj` without contact details and without coaches' / officials' dates of birth (sdv-py `_scrub`).
#'
#' Contact keys go wherever they sit; `dateOfBirth` / `birthDate` go under a `coaches`,
#' `nominations`, `officials` or `staff` container, and on every top-level row when `root_staff`.
#' @noRd
.fiba_scrub <- function(obj, staff = FALSE, root_staff = FALSE) {
  if (.fiba_is_obj(obj)) {
    keys <- names(obj)
    drop <- keys %in% .FIBA_CONTACT_KEYS | ((staff || root_staff) & keys %in% .FIBA_STAFF_KEYS)
    obj <- obj[!drop]
    for (k in names(obj)) {
      if (is.list(obj[[k]])) obj[k] <- list(.fiba_scrub(obj[[k]], staff || k %in% .FIBA_STAFF_CONTAINERS, FALSE))
    }
    return(obj)
  }
  if (.fiba_is_arr(obj)) return(lapply(obj, .fiba_scrub, staff = staff, root_staff = root_staff))
  obj
}

# ---------------------------------------------------------------------------
# GDAP
# ---------------------------------------------------------------------------

#' The subscription key from the live fiba.basketball page (cached); the documented key otherwise.
#' @noRd
.fiba_api_key <- function() {
  if (!is.null(.fiba_cache[["key"]])) return(.fiba_cache[["key"]])
  page <- tryCatch(.intl_get(.FIBA_KEY_PAGE, headers = list(`User-Agent` = .FIBA_UA)),
                   hoopR_error = function(e) "")
  hit <- regmatches(page, regexec(.FIBA_KEY_RE, page, perl = TRUE))[[1]]
  .fiba_cache[["key"]] <- if (length(hit) == 2L) hit[[2]] else .FIBA_FALLBACK_KEY
  .fiba_cache[["key"]]
}

# method -> alternatives; a row passes when every (path, request param) of ONE alternative equals
# the request's (integer) value. Routes absent here carry no field to check and are unscoped:
# rounds, team staff, national teams, medal count, ranking zones, the gateway's competition ids.
.FIBA_SCOPES <- list(
  getgdapgamesbycompetitionid = list(list(list(c("competition", "competitionId"), "gdapCompetitionId"))),
  getgdapgamebyid = list(list(list("gameId", "gdapGameId"))),
  getGdapCompetitionById = list(list(list("competitionId", "gdapCompetitionId"))),
  getgdapcompetitionteamsbycompetitionid = list(list(list(c("profile", "competitionId"), "gdapCompetitionId"))),
  getgdapcompetitionfinalstandingbycompetitionid = list(list(list(c("competition", "competitionId"), "gdapCompetitionId"))),
  getgdapcompetitionroundgamedaysbyid = list(list(list(c("competition", "competitionId"), "gdapCompetitionId"))),
  getgdapcompetitionawardsbyid = list(list(list("competitionId", "gdapCompetitionId"))),
  getgdapcompetitionnominationsbyid = list(list(list("competitionLevelId", "gdapCompetitionId"))),
  getgdapcompetitionteamrosterbyteamid = list(list(list("teamId", "gdapTeamId"))),
  getgdapcompetitionteamlatestrosterbyteamid = list(list(list("teamId", "gdapTeamId"))),
  getgdapcompetitionteamstatisticsbyteamid = list(list(list("teamId", "gdapTeamId"))),
  getgdapgameswithleaderdetailsbyteamid = list(
    list(list(c("teamA", "teamId"), "gdapTeamId")),
    list(list(c("teamB", "teamId"), "gdapTeamId"))
  ),
  getgdapplayerinfobycompetitionid = list(
    list(list("playerId", "gdapPlayerId"), list("competitionId", "gdapCompetitionId"))
  ),
  getgdapplayercompetitionstatisticsbyplayerid = list(
    list(list("playerId", "gdapPlayerId"), list("competitionId", "gdapCompetitionId"))
  ),
  getgdapplayergamestatisticsbyplayerid = list(
    list(list("playerId", "gdapPlayerId"), list("competitionId", "gdapCompetitionId"))
  ),
  getgdapfederationgamesbyfederationid = list(
    list(list(c("teamA", "organisationId"), "gdapFederationId")),
    list(list(c("teamB", "organisationId"), "gdapFederationId"))
  ),
  getgdapcompetitionsbyseasonsandcompetitionmarketingname = list(
    list(list(c("competitionMarketingName", "competitionMarketingNameId"), "competitionMarketingNameId"))
  )
)

#' Why `body` is not about what was asked, or `NULL` (sdv-py `_scope_error`).
#' @noRd
.fiba_scope_error <- function(method, body, params) {
  rows <- if (.fiba_is_arr(body)) body else list(body)
  alts <- .FIBA_SCOPES[[method]]
  if (length(alts)) {
    for (row in rows) {
      ok <- any(vapply(alts, function(alt) {
        all(vapply(alt, function(pn) .fiba_strict(.fiba_dig(row, pn[[1]]), params[[pn[[2]]]]), logical(1)))
      }, logical(1)))
      if (!ok) {
        want <- paste(vapply(alts, function(alt) {
          paste(vapply(alt, function(pn) paste0(paste(pn[[1]], collapse = "."), "=", format(params[[pn[[2]]]] %||% "NULL")),
                       character(1)), collapse = ", ")
        }, character(1)), collapse = " or ")
        return(paste0("a row is outside the request (", want, ")"))
      }
    }
  }
  if (method == "getgdapgamesbetweentwodates") {
    lo <- substr(as.character(params[["dateFrom"]] %||% "None"), 1, 19)
    hi <- substr(as.character(params[["dateTo"]] %||% "None"), 1, 19)
    for (row in rows) {
      at <- if (.fiba_is_obj(row)) row[["gameDateTime"]] else NULL
      if (!is.character(at) || length(at) != 1L || !(lo <= substr(at, 1, 19) && substr(at, 1, 19) < hi)) {
        return(paste0("a game starts at ", format(at %||% "NULL"), ", outside [", lo, ", ", hi, ")"))
      }
    }
  }
  if (method == "getgdapcompetitionsbyseasonsandcompetitionmarketingname") {
    lo_s <- params[["fromSeason"]]
    hi_s <- params[["toSeason"]]
    for (row in rows) {
      season <- if (.fiba_is_obj(row)) row[["season"]] else NULL
      if (!.fiba_is_int(season) || (!is.null(lo_s) && season < lo_s) || (!is.null(hi_s) && season > hi_s)) {
        return(paste0("an edition has season ", format(season %||% "NULL"), ", outside ",
                      format(lo_s %||% "None"), "..", format(hi_s %||% "None")))
      }
    }
  }
  NULL
}

#' `body` (scrubbed) when it is a complete, in-scope GDAP answer; raise otherwise.
#' @noRd
.fiba_check_gdap <- function(method, body, params, where = method, call = rlang::caller_env()) {
  if (is.null(body) || (is.list(body) && length(body) == 0L)) {
    .abort_no_data("{where} answered an empty body (an unknown id or nothing there).", call = call)
  }
  if (.fiba_is_obj(body) && all(names(body) %in% .FIBA_ERROR_KEYS)) {
    keys <- paste(sort(names(body)), collapse = ", ")
    .abort_asset_fetch("{where} answered an error envelope [{keys}].", call = call)
  }
  if (.fiba_is_obj(body) && "Error" %in% names(body)) {
    .abort_asset_fetch("{where} answered a GDAP Error object.", call = call)
  }
  if (.fiba_is_arr(body) && !all(vapply(body, .fiba_is_obj, logical(1)))) {
    scalar <- vapply(body, function(r) (is.integer(r) || is.character(r)) && length(r) == 1L, logical(1))
    if (!all(scalar)) .abort_asset_fetch("{where}: the rows are not objects.", call = call)
  }
  why <- .fiba_scope_error(method, body, params)
  if (!is.null(why)) .abort_asset_fetch("{where}: {why}", call = call)
  .fiba_scrub(body, root_staff = identical(method, "getgdapcompetitionnominationsbyid"))
}

#' GET one GDAP method with the subscription key, under the family's refusal vocabulary.
#'
#' HTTP 500 is NOT retried (GDAP's 500 means a parameter is missing, which retrying cannot fix).
#' @param method The GDAP method (the URL's last path segment).
#' @param params Named list of query parameters; `NULL` entries are dropped.
#' @return The checked, scrubbed body (a nested list).
#' @noRd
.fiba_gdap <- function(method, params = list(), call = rlang::caller_env()) {
  params <- Filter(Negate(is.null), params)
  if (identical(method, "getgdapcompetitionsbyseasonsandcompetitionmarketingname") &&
      !is.null(params[["fromSeason"]]) && is.null(params[["toSeason"]])) {
    params[["toSeason"]] <- params[["fromSeason"]] # one season asked: the API would run to the latest
  }
  url <- paste0(.FIBA_GDAP_URL, "/", method)
  where <- .intl_where(url)
  for (attempt in 1:2) {
    headers <- list(.fiba_api_key(), "application/json")
    names(headers) <- c(.FIBA_KEY_HEADER, "Accept")
    resp <- .intl_response(url, query = params, headers = headers, retry_500 = FALSE, call = call)
    if (httr2::resp_status(resp) == 401L && attempt == 1L) {
      .fiba_cache[["key"]] <- NULL # the key rotated: read the page again, once
      next
    }
    break
  }
  .intl_check_status(resp, where = where, call = call)
  body <- .intl_json(.intl_body_text(resp), where = where, call = call)
  .fiba_check_gdap(method, body, params, where = where, call = call)
}

# ---------------------------------------------------------------------------
# Frames (sdv-py fiba_frames.py). Dtypes are pinned per route (.FIBA_DTYPES): a populated column
# takes its pinned type when the cast loses nothing, an all-null column always, a zero-row frame
# carries every documented column typed. A column no fixture carries is typed by its name.
# ---------------------------------------------------------------------------

.FIBA_RATE_RE <- "(per_game|percentage|average|_pct$|^pct_)"

#' The dtype code of a column no fixture carries, from its name (sdv-py `_code_for`).
#' @noRd
.fiba_code_for <- function(col) {
  if (grepl(.FIBA_RATE_RE, col, perl = TRUE)) return("f")
  if (grepl("(^|_)(id|ids)$", col, perl = TRUE)) return("i")
  if (grepl("^(is|has)_", col, perl = TRUE)) return("b")
  "s"
}

#' JSON text of a list cell (sdv-py `json.dumps(..., ensure_ascii=False, separators=(",", ":"))`).
#' @noRd
.fiba_json_cell <- function(x) {
  as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", na = "null", digits = NA))
}

#' One flat row: nested objects join their keys with `_`, a non-empty list becomes a JSON string.
#' @noRd
.fiba_flatten <- function(obj, prefix = "") {
  out <- list()
  if (!.fiba_is_obj(obj)) return(out)
  for (key in names(obj)) {
    name <- if (nzchar(prefix)) paste0(prefix, "_", key) else key
    value <- obj[[key]]
    if (.fiba_is_obj(value)) {
      out <- .fiba_put(out, .fiba_flatten(value, name))
    } else if (is.list(value)) {
      out[name] <- list(if (length(value)) .fiba_json_cell(value) else NULL)
    } else {
      out[name] <- list(value)
    }
  }
  out
}

#' `a` updated by `b` (a Python dict update: an existing key keeps its place, takes the new value).
#' @noRd
.fiba_put <- function(a, b) {
  for (k in names(b)) a[k] <- list(b[[k]])
  a
}

#' One snake_case row: `head` values first, then `obj` flattened (sdv-py `_row` + `_snake`).
#' A later key that snake-cases to an earlier one never overwrites it.
#' @noRd
.fiba_row <- function(obj, head = list()) {
  row <- .fiba_put(head, .fiba_flatten(obj))
  snake <- .intl_clean_names(names(row))
  keep <- !duplicated(snake)
  row <- row[keep]
  names(row) <- snake[keep]
  row
}

#' `obj` without `keys`.
#' @noRd
.fiba_without <- function(obj, ...) {
  obj <- .fiba_dict(obj)
  obj[setdiff(names(obj), c(...))]
}

#' One column vector from the row values (NULL = null), typed the way polars infers it: one
#' kind stays that kind, integers and doubles give double, any other mix gives character.
#' @noRd
.fiba_column <- function(vals) {
  present <- !vapply(vals, is.null, logical(1))
  out <- rep(NA, length(vals))
  if (!any(present)) return(out)
  v <- vals[present]
  kinds <- unique(vapply(v, function(x) {
    if (is.logical(x)) "b" else if (is.numeric(x)) "n" else "s"
  }, character(1)))
  if (length(kinds) > 1L) v <- lapply(v, function(x) if (is.logical(x)) tolower(as.character(x)) else as.character(x))
  out[present] <- unlist(v, use.names = FALSE)
  out
}

#' Columns from row lists (sdv-py `_frame`): the union of keys in first-seen order; empty rows dropped.
#' @noRd
.fiba_frame <- function(rows) {
  rows <- Filter(function(r) length(r) > 0L, rows)
  if (!length(rows)) return(list())
  nm <- unique(unlist(lapply(rows, names), use.names = FALSE))
  cols <- lapply(nm, function(n) .fiba_column(lapply(rows, function(r) r[[n]])))
  names(cols) <- nm
  cols
}

#' A typed all-NA vector of dtype `code`.
#' @noRd
.fiba_na <- function(code, n = 0L) {
  switch(code, i = rep(NA_integer_, n), f = rep(NA_real_, n), b = rep(NA, n), s = rep(NA_character_, n))
}

#' `x` cast to dtype `code` when the cast loses nothing (polars strict cast), else `NULL`.
#' @noRd
.fiba_cast <- function(x, code) {
  ok <- !is.na(x)
  if (code == "i") {
    if (is.integer(x)) return(x)
    if (is.logical(x)) return(as.integer(x))
    num <- if (is.character(x)) {
      if (!all(grepl("^[+-]?[0-9]+$", x[ok]))) return(NULL)
      as.numeric(x)
    } else x
    if (any(num[ok] != round(num[ok]))) return(NULL) # a fractional number is not an id
    # ponytail: an Int64 beyond R's 32-bit range stays double (only wall_time_ms, pinned "f")
    if (any(abs(num[ok]) > .Machine$integer.max)) return(as.double(num))
    return(as.integer(num))
  }
  if (code == "f") {
    if (is.numeric(x) || is.logical(x)) return(as.double(x))
    num <- suppressWarnings(as.numeric(x))
    return(if (any(is.na(num[ok]))) NULL else num)
  }
  if (code == "b") {
    if (is.logical(x)) return(x)
    if (is.numeric(x)) return(x != 0)
    return(NULL) # polars casts no String to Boolean
  }
  if (is.character(x)) return(x)
  if (is.logical(x)) return(ifelse(ok, tolower(as.character(x)), NA_character_))
  if (is.double(x)) {
    return(ifelse(ok, ifelse(x == round(x) & abs(x) < 1e15, sprintf("%.1f", x), as.character(x)), NA_character_))
  }
  as.character(x)
}

#' Apply the route's pinned dtypes and documented columns (sdv-py `_finish`); a tibble.
#' @noRd
.fiba_finish <- function(cols, route) {
  pinned <- .FIBA_DTYPES[[route]]
  names_doc <- names(pinned)
  code_of <- function(c) if (!is.na(pinned[c])) pinned[[c]] else .fiba_code_for(c)
  if (!length(cols)) {
    out <- lapply(names_doc, function(c) .fiba_na(code_of(c)))
    names(out) <- names_doc
    return(dplyr::as_tibble(out))
  }
  n <- length(cols[[1]])
  for (col in names(cols)) {
    x <- cols[[col]]
    allnull <- all(is.na(x))
    code <- if (col %in% names_doc) pinned[[col]] else NA_character_
    if (is.na(code)) {
      guess <- .fiba_code_for(col)
      if (allnull || (guess == "f" && is.numeric(x))) code <- guess else next
    }
    if (allnull) {
      cols[[col]] <- .fiba_na(code, n)
      next
    }
    cast <- .fiba_cast(x, code)
    if (!is.null(cast)) cols[[col]] <- cast
  }
  for (c in setdiff(names_doc, names(cols))) cols[[c]] <- .fiba_na(code_of(c), n)
  cols <- cols[c(intersect(names_doc, names(cols)), setdiff(names(cols), names_doc))]
  dplyr::as_tibble(cols)
}

#' The `hoopR_data` result of a route.
#' @noRd
.fiba_data <- function(df, route) {
  make_hoopR_data(df, paste0("FIBA ", sub("^fiba_", "", route), " from fiba.basketball"), Sys.time())
}
