# atrium_utils.R -- internal layer of the Sportradar Atrium embed family (`atrium_*()`).
#
# R mirror of sdv-py sportsdataverse/basketball/atrium/atrium_runtime.py and
# atrium_parsers.py (sdv-py e3d232e): same routes, refusals, season mapping and
# frame columns. One keyless host serves every league site that embeds the
# Sportradar "Connect" widget:
#   https://embed-api.eui.connect.sportradar.com/v1/embed/{websiteId}/{type}
# `website_id` picks the site (.atrium_sites); one site carries many competitions.
#
# Seasons: the native key is an opaque seasonId (one competition in one year). The
# wrappers take the sdv END year as `season` (+ `competition_id` when a year holds
# several competitions) and atrium_season_id() maps it through the site's own season
# list (`/{websiteId}/fixtures`, cached for an hour).
#
# Refusals (hoopR_asset_fetch: the answer is unknown, never an empty frame): an error
# body, no `data` object or meta.code != 200, a links.self of another site or type,
# a body echoing another sub / seasonId / fixtureId / personId / team, a default
# fixtures page whose season is not in its own list. A well-formed body with no rows
# is hoopR_no_data. A game asked under the wrong site comes back as an empty
# `fixture` (the body an unknown id gets too): hoopR_no_data, never a wrong scope.
# A game's seasonId missing from the site's season list proves nothing (LNB lists
# only 2023-2025), so it is not checked: older games pass.

.ATRIUM_BASE <- "https://embed-api.eui.connect.sportradar.com/v1/embed"
.ATRIUM_SEASONS_TTL <- 3600

#' websiteId -> what `data.seasons.seasons[].year` means: "start" (END = year + 1),
#' "calendar" (= END) or NA (the site lists no seasons).
#' @noRd
.atrium_sites <- list(
  "12" = list(name = "LNB (France)", year = "start"),
  "14" = list(name = "LNBP (Mexico)", year = "calendar"),
  "3" = list(name = "NBL1 (Australia)", year = "calendar"),
  "13" = list(name = "Liga Mayor de Baloncesto (El Salvador)", year = "calendar"),
  "22" = list(name = "LPB / LPBF (Panama)", year = "calendar"),
  "236" = list(name = "Basketball Superliga (Austria)", year = NA_character_),
  "326" = list(name = "Montenegro (Memorial Ljubo Jovanovic)", year = "calendar")
)

.ATRIUM_SELF <- "/v1/embed/(\\d+)/([a-z_]+)(?:[?#]|$)"
# Types whose competitionId is a real filter, not just a way to pick the season.
.ATRIUM_COMPETITION_TYPES <- c("statistics_competition_persons", "statistics_competition_entities")
# Types that echo no seasonId (the player and team pages).
.ATRIUM_NO_SEASON_ECHO <- c("entity_detail", "person_detail")

.atrium_seasons_cache <- new.env(parent = emptyenv())

# --- JSON shape helpers (sdv-py _dict / _list) ---------------------------------------

#' A JSON object (named list); `{}` included, `[]` excluded.
#' @noRd
.atrium_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.ad <- function(x) if (.atrium_is_dict(x)) x else list()
#' @noRd
.al <- function(x) if (is.list(x) && is.null(names(x))) x else list()
#' `x[[key]]` for a key that may be NA / empty / absent (sdv-py `dict.get(key or "")`).
#' @noRd
.ag <- function(x, key) {
  if (!is.character(key) || length(key) != 1L || is.na(key) || !nzchar(key) || !key %in% names(x)) return(NULL)
  x[[key]]
}
#' A whole number given as one integer or double (not logical, not NA).
#' @noRd
.atrium_whole <- function(x) is.numeric(x) && length(x) == 1L && !is.na(x) && is.finite(x) && x == round(x)

# --- season mapping ------------------------------------------------------------------

#' The site's season rows (cached for an hour), from its default `/fixtures` page.
#' @noRd
.atrium_fetch_seasons <- function(website_id, call = rlang::caller_env()) {
  key <- as.character(website_id)
  hit <- .atrium_seasons_cache[[key]]
  if (!is.null(hit) && .intl_now() - hit$t < .ATRIUM_SEASONS_TTL) return(hit$rows)
  url <- paste0(.ATRIUM_BASE, "/", key, "/fixtures")
  body <- .intl_json(.intl_get(url, retry_500 = TRUE, call = call), .intl_where(url), call = call)
  .atrium_check(url, as.integer(website_id), "fixtures", list(), body, rows = FALSE, call = call)
  rows <- .atrium_parse_seasons(body)
  .atrium_seasons_cache[[key]] <- list(t = .intl_now(), rows = rows)
  rows
}

#' GET an Atrium embed route as parsed JSON; map `season` to `seasonId` and refuse
#' every wrong answer (sdv-py `atrium_runtime._get`).
#'
#' @param website_id The site.
#' @param type The route type (`fixtures`, `fixture_detail`, ...).
#' @param params Wire parameters plus the sdv `season` (END year); `NULL` entries are
#'   dropped. When `season` finds the season, a `competitionId` beside it only picked
#'   the season and is not sent (except to the two `statistics_competition_*` routes).
#' @return The parsed body (nested list).
#' @noRd
.atrium_get <- function(website_id, type, params = list(), call = rlang::caller_env()) {
  if (!.atrium_whole(website_id) || website_id < 0) {
    .abort_bad_request("{.arg website_id} must be a site id (an integer), not {.val {format(website_id)}}.", call = call)
  }
  site <- as.integer(website_id)
  url <- paste0(.ATRIUM_BASE, "/", site, "/", type)
  p <- Filter(Negate(is.null), params)
  season <- p[["season"]]
  p[["season"]] <- NULL
  if (!is.null(season)) {
    if (!is.null(p[["seasonId"]])) .abort_bad_request("Pass {.arg season} (END year) or {.arg season_id}, not both.", call = call)
    p[["seasonId"]] <- .atrium_season_id(site, season, p[["competitionId"]], call = call)
    if (!type %in% .ATRIUM_COMPETITION_TYPES) p[["competitionId"]] <- NULL
  }
  body <- .intl_json(.intl_get(url, query = p, retry_500 = TRUE, call = call), .intl_where(url), call = call)
  .atrium_check(url, site, type, p, body, call = call)
  body
}

#' True when a well-formed body has no rows of the kind the route exists to serve.
#' @noRd
.atrium_rows_missing <- function(type, p, data) {
  nonempty <- function(v) {
    v <- .al(v)
    length(v) > 0 && any(vapply(v, function(r) .atrium_is_dict(r) && length(r) > 0, logical(1)))
  }
  sub <- p[["sub"]]
  if (type %in% c("fixtures", "fixtures_ribbon")) return(!nonempty(data[["fixtures"]]))
  if (type == "fixture_detail") {
    periods <- Filter(.atrium_is_dict, .al(data[["periodData"]]))
    if (identical(sub, "statistics")) {
      base <- .ad(.ad(.ad(data[["statistics"]])[["data"]])[["base"]])
      groups <- c(.al(.ad(base[["home"]])[["persons"]]), .al(.ad(base[["away"]])[["persons"]]))
      return(!any(vapply(groups, function(g) nonempty(.ad(g)[["rows"]]), logical(1))))
    }
    if (isTRUE(sub %in% c("pbp", "shot_chart"))) {
      key <- if (sub == "pbp") "events" else "shots"
      return(!any(vapply(periods, function(x) nonempty(x[[key]]), logical(1))))
    }
    return(FALSE)
  }
  if (type %in% c("standings", "standings_fragment")) {
    return(!any(vapply(.al(data[["standings"]]), function(g) nonempty(.ad(g)[["rows"]]), logical(1))))
  }
  if (type == "entities") return(!nonempty(data[["teams"]]))
  if (type == "persons") return(!nonempty(.ad(data[["persons"]])[["rows"]]))
  if (type == "person_detail") {
    if (identical(sub, "log")) return(!nonempty(.ad(data[["log"]])[["rows"]]))
    return(!length(.ad(data[["person"]])))
  }
  if (type == "entity_detail") return(!length(.ad(data[["team"]])))
  if (startsWith(type, "statistics_")) {
    key <- if (type == "statistics_leaders") "data" else "statistics"
    return(!any(vapply(.al(data[["statistics"]]), function(t) nonempty(.ad(t)[[key]]), logical(1))))
  }
  FALSE
}

#' Raise unless `body` is a real answer to the request (see the file header).
#' @noRd
.atrium_check <- function(url, site, type, p, body, rows = TRUE, call = rlang::caller_env()) {
  where <- .intl_where(url)
  if (!.atrium_is_dict(body)) .abort_asset_fetch("{where}: the answer is not a JSON object.", call = call)
  if ("error" %in% names(body)) {
    err <- substr(.atrium_text(body[["error"]]), 1, 120)
    .abort_asset_fetch("{where}: the API answered an error object: {err}", call = call)
  }
  data <- body[["data"]]
  code <- .ad(body[["meta"]])[["code"]]
  if (!.atrium_is_dict(data) || !(is.integer(code) && length(code) == 1L && isTRUE(code == 200L))) {
    shown <- if (is.null(code)) "NULL" else .atrium_text(code)
    .abort_asset_fetch("{where}: no data object / meta.code {shown} (a stub or an answer of unknown meaning).",
                       call = call)
  }
  self <- .ad(body[["links"]])[["self"]]
  self <- if (is.character(self) && length(self) == 1L && !is.na(self)) self else ""
  m <- regmatches(self, regexec(.ATRIUM_SELF, self, perl = TRUE))[[1]]
  if (!length(m)) .abort_asset_fetch("{where}: the body does not echo its request in links.self (scope unknown).", call = call)
  if (as.integer(m[[2]]) != site || m[[3]] != type) {
    .abort_asset_fetch("{where}: asked for /{site}/{type}, the body is /{m[[2]]}/{m[[3]]}.", call = call)
  }
  echo <- function(field, got, want) {
    if (!is.null(want) && !identical(got, want)) {
      shown <- if (is.null(got)) "NULL" else .atrium_text(got)
      .abort_asset_fetch("{where}: asked for {field}={want}, the body has {shown}.", call = call)
    }
  }
  echo("sub", data[["sub"]], p[["sub"]])
  if (!type %in% .ATRIUM_NO_SEASON_ECHO) echo("seasonId", data[["seasonId"]], p[["seasonId"]])
  fixture <- .ad(data[["fixture"]])
  if (type == "fixture_detail" && !is.null(p[["fixtureId"]]) && !length(fixture)) {
    fid <- p[["fixtureId"]]
    .abort_no_data(paste0("{where}: site {site} has no fixture {fid} (an unknown id, or a game of another site: ",
                          "the API answers both with an empty fixture)."), call = call)
  }
  echo("fixtureId", fixture[["fixtureId"]], p[["fixtureId"]])
  echo("personId", .ad(data[["person"]])[["id"]], p[["personId"]])
  if (type == "entity_detail" && !is.null(p[["entityId"]])) {
    tabs <- .al(data[["tabs"]])
    echo("entityId", if (length(tabs)) .atrium_link_ids(.ad(tabs[[1]])[["link"]])[["e"]], p[["entityId"]])
  }
  if (type == "fixtures" && is.null(p[["seasonId"]])) {
    listed <- unlist(lapply(Filter(.atrium_is_dict, .al(.ad(data[["seasons"]])[["seasons"]])), function(s) s[["seasonId"]]))
    if (length(listed) && !isTRUE(data[["seasonId"]] %in% listed)) {
      sid <- .atrium_text(data[["seasonId"]])
      .abort_asset_fetch("{where}: the default season {sid} is not in the site's own season list.", call = call)
    }
  }
  if (rows && .atrium_rows_missing(type, p, data)) .abort_no_data("{where}: the site has no rows for this request.", call = call)
  invisible(body)
}

# --- value helpers (sdv-py atrium_parsers._id / _text / _int / ...) --------------------

#' A scalar JSON value of one atomic type, or NULL.
#' @noRd
.atrium_scalar <- function(v) is.atomic(v) && length(v) == 1L && !is.na(v)

#' An id as character: a non-empty string as is, an integer by its digits, else NA.
#' @noRd
.atrium_id <- function(v) {
  if (is.character(v) && .atrium_scalar(v)) return(if (nzchar(v)) v else NA_character_)
  if (is.integer(v) && .atrium_scalar(v)) return(as.character(v))
  NA_character_
}

#' Any value as text: "" -> NA, 123.0 -> "123", TRUE -> "True", objects as JSON.
#' @noRd
.atrium_text <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (is.list(v)) {
    # ponytail: jsonlite separators, not json.dumps(sort_keys=True); no route has hit it
    return(as.character(jsonlite::toJSON(v, auto_unbox = TRUE, null = "null")))
  }
  if (!.atrium_scalar(v)) return(NA_character_)
  if (is.character(v)) return(if (nzchar(v)) v else NA_character_)
  if (is.logical(v)) return(if (v) "True" else "False")
  if (is.double(v)) {
    if (!is.finite(v)) return(NA_character_)
    return(if (v == round(v)) sprintf("%.0f", v) else format(v, digits = 15))
  }
  as.character(v)
}

#' @noRd
.atrium_num <- function(v) if (is.numeric(v) && .atrium_scalar(v)) as.double(v) else NA_real_

#' An integer from an int, a whole double or a digit string (scores arrive as "87"); else NA.
#' @noRd
.atrium_int <- function(v) {
  if (!.atrium_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) return(if (is.finite(v) && v == round(v) && abs(v) < .Machine$integer.max) as.integer(v) else NA_integer_)
  if (is.character(v) && grepl("^-?[0-9]+$", trimws(v))) return(suppressWarnings(as.integer(trimws(v))))
  NA_integer_
}

#' ISO 8601 duration `PT{h}H{m}M{s}S` -> whole seconds (NA when not a duration).
#' @noRd
.atrium_seconds <- function(v) {
  if (!is.character(v) || !.atrium_scalar(v)) return(NA_integer_)
  m <- regmatches(v, regexec("^PT(?:([0-9]+)H)?(?:([0-9]+)M)?(?:([0-9]+(?:\\.[0-9]+)?)S)?$", v, perl = TRUE))[[1]]
  if (!length(m) || all(m[-1] == "")) return(NA_integer_)
  n <- suppressWarnings(as.numeric(m[-1]))
  n[is.na(n)] <- 0
  as.integer(n[1] * 3600 + n[2] * 60 + trunc(n[3]))
}

#' `YYYY-MM-DDTHH:MM:SS` -> seconds since the epoch as a naive (UTC-tagged) time; an
#' offset, if any, is converted to UTC. NA when it does not parse.
#' @noRd
.atrium_dt <- function(v) {
  if (!is.character(v) || !.atrium_scalar(v)) return(NA_real_)
  re <- paste0("^([0-9]{4})-([0-9]{2})-([0-9]{2})(?:[T ]([0-9]{2}):([0-9]{2})(?::([0-9]{2}(?:\\.[0-9]+)?))?)?",
               "(Z|[+-][0-9]{2}:?[0-9]{2})?$")
  m <- regmatches(trimws(v), regexec(re, trimws(v), perl = TRUE))[[1]]
  if (!length(m)) return(NA_real_)
  n <- suppressWarnings(as.numeric(m[2:7]))
  n[is.na(n)] <- 0
  t <- as.double(ISOdatetime(n[1], n[2], n[3], n[4], n[5], n[6], tz = "UTC"))
  off <- m[[8]]
  if (nzchar(off) && off != "Z") {
    d <- gsub(":", "", off, fixed = TRUE)
    t <- t - (if (startsWith(d, "-")) -1 else 1) * (as.numeric(substr(d, 2, 3)) * 3600 + as.numeric(substr(d, 4, 5)) * 60)
  }
  t
}

#' `YYYY-MM-DD` (the first 10 characters) -> days since the epoch; NA otherwise.
#' @noRd
.atrium_date <- function(v) {
  if (!is.character(v) || !.atrium_scalar(v)) return(NA_real_)
  d <- substr(trimws(v), 1, 10)
  if (!grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", d)) return(NA_real_)
  as.double(as.Date(d, format = "%Y-%m-%d"))
}

#' A statistic key as a snake column (sdv-py `_col`: underscore(), non-word runs to `_`).
#' @noRd
.atrium_col <- function(key) {
  x <- gsub("(*UCP)\\W+", "_", .intl_clean_names(key), perl = TRUE)
  tolower(gsub("^_+|_+$", "", x))
}

#' Decode a widget link (`queryParams[["~w"]]` or `"&~w=p~<token>"`) into its state:
#' base64url(zlib(JSON)) of `{s: seasonId, p: personId, e: entityId, f: fixtureId}`.
#' Anything undecodable is `list()`.
#' @noRd
.atrium_link_ids <- function(link) {
  tok <- if (.atrium_is_dict(link)) .ad(link[["queryParams"]])[["~w"]] else link
  if (!is.character(tok) || !.atrium_scalar(tok) || !grepl("~", tok, fixed = TRUE)) return(list())
  tok <- sub(".*~w=", "", tok)
  if (grepl("~", tok, fixed = TRUE)) tok <- sub("^[^~]*~", "", tok)
  out <- tryCatch({
    b64 <- chartr("-_", "+/", tok)
    b64 <- paste0(b64, strrep("=", (4 - nchar(b64) %% 4) %% 4))
    raw <- memDecompress(jsonlite::base64_dec(b64), type = "gzip")
    # ponytail: sdv-py stops inflating at 64 KiB; a bigger state is refused, not truncated
    if (length(raw) > 64 * 1024) list() else jsonlite::parse_json(rawToChar(raw))
  }, error = function(e) list())
  .ad(out)
}

#' `[{key, value}, ...]` -> `list(<snake key> = value)` (items without a string key skipped).
#' @noRd
.atrium_kv <- function(items) {
  out <- list()
  for (item in .al(items)) {
    item <- .ad(item)
    key <- item[["key"]]
    if (is.character(key) && .atrium_scalar(key)) out[.atrium_col(key)] <- list(item[["value"]])
  }
  out
}

#' A `{statKey: value}` map -> snake columns, with `seconds_*` beside every ISO duration.
#' @noRd
.atrium_statcols <- function(stats, prefix = "") {
  stats <- .ad(stats)
  out <- list()
  for (i in seq_along(stats)) {
    k <- names(stats)[[i]]
    out[paste0(prefix, .atrium_col(k))] <- list(stats[[i]])
    if (k %in% c("minutes", "timeInLead")) {
      out[paste0(prefix, if (k == "minutes") "seconds_played" else "time_in_lead_seconds")] <- list(.atrium_seconds(stats[[i]]))
    }
  }
  out
}

#' Zip a positional `statistics` array with `headers[].key` -> `list(<snake key> = value)`.
#' @noRd
.atrium_positional <- function(headers, values) {
  keys <- lapply(.al(headers), function(h) .ad(h)[["key"]])
  values <- .al(values)
  out <- list()
  for (i in seq_len(min(length(keys), length(values)))) {
    k <- keys[[i]]
    if (is.character(k) && .atrium_scalar(k)) out[.atrium_col(k)] <- list(values[[i]])
  }
  out
}

#' `list(home, away)` competitor objects: by `isHome`, else by list order.
#' @noRd
.atrium_pick_sides <- function(competitors) {
  comps <- Filter(.atrium_is_dict, .al(competitors))
  h <- which(vapply(comps, function(c) isTRUE(c[["isHome"]]), logical(1)))[1]
  a <- setdiff(which(vapply(comps, function(c) isFALSE(c[["isHome"]]), logical(1))), h)[1]
  rest <- setdiff(seq_along(comps), c(h, a))
  if (is.na(h)) {
    h <- rest[1]
    rest <- rest[-1]
  }
  if (is.na(a)) a <- rest[1]
  list(home = if (is.na(h)) list() else comps[[h]], away = if (is.na(a)) list() else comps[[a]])
}

#' `website_id` from the body's links.self.
#' @noRd
.atrium_site <- function(raw) {
  self <- .ad(.ad(raw)[["links"]])[["self"]]
  if (!is.character(self) || !.atrium_scalar(self)) return(NA_integer_)
  m <- regmatches(self, regexec(.ATRIUM_SELF, self, perl = TRUE))[[1]]
  if (length(m)) as.integer(m[[2]]) else NA_integer_
}

#' @noRd
.atrium_data_of <- function(raw) .ad(.ad(raw)[["data"]])

#' @noRd
.atrium_end_year1 <- function(site, year) {
  kind <- if (.atrium_whole(site)) .atrium_sites[[as.character(as.integer(site))]]$year else NULL
  if (is.null(kind) || is.na(kind) || !.atrium_whole(year)) return(NA_integer_)
  as.integer(year) + if (kind == "start") 1L else 0L
}

#' `list(<season_id> = list(competition_id, competition_name, season_name, abbreviation_local, year))`.
#' @noRd
.atrium_season_index <- function(data) {
  seasons <- .ad(data[["seasons"]])
  comps <- .ad(seasons[["competitions"]])
  out <- list()
  for (s in .al(seasons[["seasons"]])) {
    s <- .ad(s)
    sid <- .atrium_id(s[["seasonId"]])
    if (is.na(sid)) next
    cid <- .atrium_id(s[["competitionId"]])
    out[[sid]] <- list(
      competition_id = cid, competition_name = .atrium_text(.ad(.ag(comps, cid))[["name"]]),
      season_name = .atrium_text(s[["nameLocal"]]), abbreviation_local = .atrium_text(s[["abbreviationLocal"]]),
      year = .atrium_int(s[["year"]])
    )
  }
  out
}

#' @noRd
.atrium_fixture_id <- function(data) .atrium_id(.ad(data[["fixture"]])[["fixtureId"]])
#' @noRd
.atrium_season_id_of <- function(data) {
  sid <- .atrium_id(data[["seasonId"]])
  if (is.na(sid)) .atrium_id(.ad(data[["fixture"]])[["seasonId"]]) else sid
}

# --- frames ----------------------------------------------------------------------------

#' The documented columns (name -> type, in order) of every frame (sdv-py `SCHEMAS`).
#' @noRd
.atrium_schemas <- list(
  seasons = c(
    website_id = "integer", season_id = "character", competition_id = "character", competition_name = "character",
    season_name = "character", abbreviation_local = "character", year = "integer", season_end_year = "integer",
    is_default_season = "logical"
  ),
  fixtures = c(
    website_id = "integer", season_id = "character", competition_id = "character", competition_name = "character",
    season_end_year = "integer", fixture_id = "character", fixture_type = "character", name = "character",
    round = "character", round_code = "character", pool = "character", series = "character", stage_code = "character",
    status = "character", status_label = "character", start_time_utc = "POSIXct", start_time_local = "character",
    timezone = "character", times_unconfirmed = "logical", venue = "character", venue_id = "character",
    attendance = "integer", home_entity_id = "character", home_code = "character", home_name = "character",
    home_score = "integer", home_result_place = "integer", home_result_status = "character", home_draw = "logical",
    home_shootout_attempts = "character", home_secondary_score = "character", away_entity_id = "character",
    away_code = "character", away_name = "character", away_score = "integer", away_result_place = "integer",
    away_result_status = "character", away_draw = "logical", away_shootout_attempts = "character",
    away_secondary_score = "character"
  ),
  fixtures_ribbon = c(
    website_id = "integer", season_id = "character", season_name = "character", fixture_id = "character",
    series = "character", stage_name = "character", status = "character", status_label = "character",
    is_final = "logical", is_live = "logical", times_unconfirmed = "logical", start_time_utc = "POSIXct",
    start_time_local = "character", home_entity_id = "character", home_name = "character", home_score = "integer",
    home_result_status = "character", home_is_leading = "logical", away_entity_id = "character",
    away_name = "character", away_score = "integer", away_result_status = "character", away_is_leading = "logical"
  ),
  fixture = c(
    website_id = "integer", fixture_id = "character", season_id = "character", competition_name = "character",
    name = "character", fixture_type = "character", age_group = "character", status = "character",
    status_label = "character", start_time_utc = "POSIXct", start_time_local = "character", timezone = "character",
    venue = "character", venue_id = "character", attendance = "integer", external_id = "character", updated = "POSIXct",
    live_data_available = "logical", live_video_available = "logical", discipline = "character", series = "character",
    number_of_periods = "integer", period_length = "integer", overtime_allowed = "logical",
    overtime_length = "integer", shot_clock = "integer", max_fouls_personal = "integer",
    fouls_before_bonus = "integer", maximum_players_on_court = "integer", maximum_roster_size = "integer",
    home_entity_id = "character", home_code = "character", home_name = "character", home_score = "integer",
    home_result_status = "character", away_entity_id = "character", away_code = "character", away_name = "character",
    away_score = "integer", away_result_status = "character", home_captain_person_id = "character",
    away_captain_person_id = "character"
  ),
  fixture_periods = c(
    website_id = "integer", fixture_id = "character", season_id = "character", period_id = "integer",
    label = "character", is_overtime = "logical", is_shootout = "logical", started = "logical", ended = "logical",
    duration_minutes = "integer", elapsed_minutes_before_period = "integer", home_entity_id = "character",
    away_entity_id = "character", home_points = "integer", away_points = "integer"
  ),
  box_score = c(
    website_id = "integer", fixture_id = "character", season_id = "character", entity_id = "character",
    side = "character", person_id = "character", person_name = "character", bib = "character", position = "character",
    starter = "logical", active = "logical", participated = "logical", did_not_play_reason = "character",
    minutes = "character", seconds_played = "integer", points = "integer", rebounds = "integer",
    rebounds_offensive = "integer", rebounds_defensive = "integer", assists = "integer", steals = "integer",
    blocks = "integer", blocks_received = "integer", turnovers = "integer", fouls_total = "integer",
    fouls_drawn = "integer", plus_minus = "integer", efficiency = "integer", field_goals_made = "integer",
    field_goals_attempted = "integer", field_goals_percentage = "double", points_two_made = "integer",
    points_two_attempted = "integer", points_two_percentage = "double", points_three_made = "integer",
    points_three_attempted = "integer", points_three_percentage = "double", free_throws_made = "integer",
    free_throws_attempted = "integer", free_throws_percentage = "double", points_fast_break = "integer"
  ),
  team_box_score = c(
    website_id = "integer", fixture_id = "character", season_id = "character", entity_id = "character",
    side = "character", minutes = "character", seconds_played = "integer", points = "integer", rebounds = "integer",
    rebounds_offensive = "integer", rebounds_defensive = "integer", assists = "integer", steals = "integer",
    blocks = "integer", blocks_received = "integer", turnovers = "integer", fouls_total = "integer",
    fouls_drawn = "integer", plus_minus = "integer", efficiency = "integer", field_goals_made = "integer",
    field_goals_attempted = "integer", field_goals_percentage = "double", points_two_made = "integer",
    points_two_attempted = "integer", points_two_percentage = "double", points_three_made = "integer",
    points_three_attempted = "integer", points_three_percentage = "double", free_throws_made = "integer",
    free_throws_attempted = "integer", free_throws_percentage = "double", points_fast_break = "integer",
    extra_fouls_total = "integer", extra_rebounds = "integer", extra_rebounds_defensive = "integer",
    extra_rebounds_offensive = "integer", extra_turnovers = "integer", total_biggest_lead = "integer",
    total_biggest_scoring_run = "integer", total_field_goals_percentage = "double",
    total_free_throws_percentage = "double", total_lead_changes = "integer", total_points_fast_break = "integer",
    total_points_from_bench = "integer", total_points_from_turnover = "integer", total_time_in_lead = "character",
    total_time_in_lead_seconds = "integer", total_turnovers = "integer"
  ),
  pbp = c(
    website_id = "integer", fixture_id = "character", season_id = "character", sequence = "integer",
    event_id = "character", period_id = "integer", clock = "character", clock_seconds = "integer",
    entity_id = "character", side = "character", person_id = "character", person_name = "character", bib = "character",
    event_type = "character", event_sub_type = "character", description = "character", success = "logical",
    success_label = "character", x = "double", y = "double", home_score = "integer", away_score = "integer"
  ),
  shots = c(
    website_id = "integer", fixture_id = "character", season_id = "character", sequence = "integer",
    event_id = "character", period_id = "integer", clock = "character", clock_seconds = "integer",
    entity_id = "character", side = "character", person_id = "character", person_name = "character", bib = "character",
    event_type = "character", event_sub_type = "character", description = "character", success = "logical",
    success_label = "character", x = "double", y = "double", home_score = "integer", away_score = "integer"
  ),
  standings = c(
    website_id = "integer", season_id = "character", season_end_year = "integer", group = "character",
    position = "integer", entity_id = "character", team_name = "character", is_current_team = "logical",
    logo_url = "character", wins = "integer", losses = "integer", played = "integer", standing_points = "integer",
    win_percentage = "double", scored_for = "integer", scored_against = "integer", point_difference = "integer",
    result_string_home = "character", scored_for_home = "integer", scored_against_home = "integer",
    point_difference_home = "integer", result_string_away = "character", scored_for_away = "integer",
    scored_against_away = "integer", point_difference_away = "integer", streak = "integer", streak_home = "integer",
    streak_away = "integer"
  ),
  teams = c(
    website_id = "integer", season_id = "character", entity_id = "character", name = "character",
    image_url = "character"
  ),
  team = c(
    website_id = "integer", entity_id = "character", name = "character", color = "character", logo_url = "character",
    previous_fixture_id = "character", previous_round = "character", previous_status = "character",
    previous_start_time_utc = "POSIXct", previous_start_time_local = "character", previous_venue = "character",
    previous_attendance = "integer", previous_home_entity_id = "character", previous_home_name = "character",
    previous_home_score = "integer", previous_away_entity_id = "character", previous_away_name = "character",
    previous_away_score = "integer", next_fixture_id = "character", next_round = "character",
    next_status = "character", next_start_time_utc = "POSIXct", next_start_time_local = "character",
    next_venue = "character", next_attendance = "integer", next_home_entity_id = "character",
    next_home_name = "character", next_home_score = "integer", next_away_entity_id = "character",
    next_away_name = "character", next_away_score = "integer"
  ),
  players = c(
    website_id = "integer", season_id = "character", person_id = "character", name = "character", bib = "character",
    entity_id = "character", team_name = "character", position_code = "character", position_name = "character",
    nationality = "character", date_of_birth = "Date", age = "integer", height = "integer", status = "character",
    image_url = "character"
  ),
  player = c(
    website_id = "integer", person_id = "character", name = "character", bib = "character", team_id = "character",
    team_name = "character", image_url = "character", date_of_birth = "Date", age = "integer",
    nationality = "character", points_per_game = "double", rebounds_offensive_per_game = "double",
    rebounds_defensive_per_game = "double"
  ),
  player_seasons = c(
    website_id = "integer", person_id = "character", season_name = "character", season_year = "integer",
    season_end_year = "integer", team_id = "character", team_name = "character", minutes_per_game = "character",
    points_per_game = "double", rebounds_per_game = "double", rebounds_offensive_per_game = "double",
    rebounds_defensive_per_game = "double", assists_per_game = "double", steals_per_game = "double",
    blocks_per_game = "double", turnovers_per_game = "double", fouls_personal_per_game = "double",
    dunks_per_game = "double", efficiency = "integer"
  ),
  player_game_log = c(
    website_id = "integer", person_id = "character", season_id = "character", date = "character",
    opponent_entity_id = "character", opponent_name = "character", result = "character", result_label = "character",
    score = "character", minutes = "character", seconds_played = "integer", points = "integer", rebounds = "integer",
    rebounds_offensive = "integer", rebounds_defensive = "integer", assists = "integer", steals = "integer",
    blocks = "integer", blocks_received = "integer", turnovers = "integer", fouls_total = "integer",
    fouls_drawn = "integer", plus_minus = "integer", efficiency = "integer", field_goals_made = "integer",
    field_goals_attempted = "integer", field_goals_percentage = "double", points_two_made = "integer",
    points_two_attempted = "integer", points_two_percentage = "double", points_three_made = "integer",
    points_three_attempted = "integer", points_three_percentage = "double", free_throws_made = "integer",
    free_throws_attempted = "integer", free_throws_percentage = "double", points_fast_break = "integer",
    dunks = "integer", fouls_personal = "integer"
  ),
  leaders = c(
    website_id = "integer", season_id = "character", stat_key = "character", stat_name = "character",
    stat_label = "character", rank = "integer", entity_id = "character", entity_name = "character",
    person_id = "character", person_name = "character", value = "double", value_text = "character"
  ),
  stat_tables = c(
    website_id = "integer", season_id = "character", table_key = "character", table_label = "character",
    person_id = "character", person_name = "character", entity_id = "character", entity_name = "character",
    stat_key = "character", stat_name = "character", stat_label = "character", value = "double",
    value_text = "character"
  )
)

#' The kind of one value: "null", "int", "dbl", "lgl", "chr" or "other" (objects, arrays).
#' @noRd
.atrium_kind <- function(v) {
  if (is.null(v) || (is.atomic(v) && length(v) == 1L && is.na(v))) return("null")
  if (!is.atomic(v) || length(v) != 1L) return("other")
  if (is.logical(v)) return("lgl")
  if (is.integer(v)) return("int")
  if (is.double(v)) return("dbl")
  if (is.character(v)) return("chr")
  "other"
}

#' One column of `type`, widened the way sdv-py `_series` widens a strict polars
#' column: integer -> double -> text, any other type -> text; never nulled.
#' `type = NULL` infers (all ints integer, all doubles double, all logical logical,
#' all strings character, all null logical; any mix text).
#' @noRd
.atrium_series <- function(values, type = NULL) {
  kinds <- vapply(values, .atrium_kind, character(1))
  k <- setdiff(unique(kinds), "null")
  ok <- function(allowed) all(k %in% allowed)
  if (is.null(type)) {
    type <- if (!length(k)) "logical" else if (length(k) > 1L) "text" else
      switch(k, int = "integer", dbl = "double", lgl = "logical", chr = "character", "text")
  }
  if (type == "integer" && !ok(c("int", "lgl"))) type <- if (ok(c("int", "dbl", "lgl"))) "double" else "text"
  if (type == "double" && !ok(c("int", "dbl", "lgl"))) type <- "text"
  if (type == "logical" && !ok("lgl")) type <- "text"
  if (type == "character" && !ok("chr")) type <- "text"
  fill <- function(proto, f) {
    out <- rep(proto, length(values))
    keep <- kinds != "null"
    out[keep] <- vapply(values[keep], f, proto)
    out
  }
  switch(type,
    integer = fill(NA_integer_, as.integer),
    double = fill(NA_real_, as.double),
    logical = fill(NA, as.logical),
    character = fill(NA_character_, as.character),
    POSIXct = .POSIXct(fill(NA_real_, as.double), tz = "UTC"),
    Date = structure(fill(NA_real_, as.double), class = "Date"),
    text = vapply(values, .atrium_text, character(1))
  )
}

#' Rows (named lists) -> the documented columns (NA-padded, typed) followed by any
#' column the schema lacks, in first-seen order (sdv-py `_frame`).
#' @noRd
.atrium_frame <- function(rows, schema) {
  if (!length(rows)) return(.empty_tibble(schema))
  cols <- c(names(schema), setdiff(unique(unlist(lapply(rows, names))), names(schema)))
  out <- lapply(cols, function(col) {
    .atrium_series(lapply(rows, function(r) if (col %in% names(r)) r[[col]]), if (col %in% names(schema)) schema[[col]])
  })
  names(out) <- cols
  dplyr::as_tibble(out)
}

#' Wrap a frame as the family's `hoopR_data` tibble.
#' @noRd
.atrium_data <- function(df, what) {
  make_hoopR_data(df, paste0("Atrium ", what, " from embed-api.eui.connect.sportradar.com"), Sys.time())
}

# --- parsers (sdv-py parse_atrium_*; internal) -----------------------------------------

#' @noRd
.atrium_parse_seasons <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  default <- .atrium_id(data[["seasonId"]])
  idx <- .atrium_season_index(data)
  rows <- lapply(names(idx), function(sid) {
    s <- idx[[sid]]
    c(list(website_id = site, season_id = sid), s,
      list(season_end_year = .atrium_end_year1(site, s$year), is_default_season = identical(sid, default)))
  })
  .atrium_frame(rows, .atrium_schemas$seasons)
}

#' @noRd
.atrium_side_cols <- function(prefix, c) {
  out <- list(.atrium_id(c[["entityId"]]), .atrium_text(c[["code"]]), .atrium_text(c[["name"]]),
              .atrium_int(c[["score"]]), .atrium_text(c[["resultStatus"]]))
  names(out) <- paste0(prefix, "_", c("entity_id", "code", "name", "score", "result_status"))
  out
}

#' @noRd
.atrium_parse_fixtures <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  sid <- .atrium_id(data[["seasonId"]])
  info <- .ad(.ag(.atrium_season_index(data), sid))
  rows <- lapply(.al(data[["fixtures"]]), function(f) {
    f <- .ad(f)
    sides <- .atrium_pick_sides(f[["competitors"]])
    st <- .ad(f[["status"]])
    row <- list(
      website_id = site, season_id = sid, competition_id = info$competition_id %||% NA_character_,
      competition_name = info$competition_name %||% NA_character_,
      season_end_year = .atrium_end_year1(site, info$year), fixture_id = .atrium_id(f[["fixtureId"]]),
      fixture_type = .atrium_text(f[["fixtureType"]]), name = .atrium_text(f[["name"]]),
      round = .atrium_text(f[["round"]]), round_code = .atrium_text(f[["roundCode"]]), pool = .atrium_text(f[["pool"]]),
      series = .atrium_text(f[["series"]]), stage_code = .atrium_text(f[["stageCode"]]),
      status = .atrium_text(st[["value"]]), status_label = .atrium_text(st[["label"]]),
      start_time_utc = .atrium_dt(f[["startTimeUTC"]]), start_time_local = .atrium_text(f[["startTimeLocal"]]),
      timezone = .atrium_text(f[["timezone"]]), times_unconfirmed = f[["timesUnconfirmed"]],
      venue = .atrium_text(f[["venue"]]), venue_id = .atrium_id(f[["venueId"]]), attendance = .atrium_int(f[["attendance"]])
    )
    for (p in c("home", "away")) {
      c <- sides[[p]]
      extra <- list(.atrium_int(c[["resultPlace"]]), c[["draw"]], .atrium_text(c[["shootOutAttempts"]]),
                    .atrium_text(c[["secondaryScore"]]))
      names(extra) <- paste0(p, "_", c("result_place", "draw", "shootout_attempts", "secondary_score"))
      row <- c(row, .atrium_side_cols(p, c), extra)
    }
    row
  })
  .atrium_frame(rows, .atrium_schemas$fixtures)
}

#' @noRd
.atrium_parse_fixtures_ribbon <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  rows <- lapply(.al(data[["fixtures"]]), function(item) {
    item <- .ad(item)
    f <- .ad(item[["fixture"]])
    st <- .ad(f[["status"]])
    sides <- .atrium_pick_sides(item[["competitors"]])
    row <- list(
      website_id = site, season_id = .atrium_id(f[["seasonId"]]), season_name = .atrium_text(f[["season"]]),
      fixture_id = .atrium_id(f[["fixtureId"]]), series = .atrium_text(f[["series"]]),
      stage_name = .atrium_text(f[["stageName"]]), status = .atrium_text(st[["value"]]),
      status_label = .atrium_text(st[["label"]]), is_final = f[["isFinal"]], is_live = f[["isLive"]],
      times_unconfirmed = f[["timesUnconfirmed"]], start_time_utc = .atrium_dt(f[["startTimeUTC"]]),
      start_time_local = .atrium_text(f[["date"]])
    )
    for (p in c("home", "away")) {
      c <- sides[[p]]
      side <- list(.atrium_id(c[["entityId"]]), .atrium_text(c[["name"]]), .atrium_int(c[["score"]]),
                   .atrium_text(c[["resultStatus"]]), c[["isLeading"]])
      names(side) <- paste0(p, "_", c("entity_id", "name", "score", "result_status", "is_leading"))
      row <- c(row, side)
    }
    row
  })
  .atrium_frame(rows, .atrium_schemas$fixtures_ribbon)
}

#' @noRd
.atrium_parse_fixture <- function(raw) {
  data <- .atrium_data_of(raw)
  f <- .ad(data[["fixture"]])
  if (!length(f)) return(.atrium_frame(list(), .atrium_schemas$fixture))
  prof <- .ad(f[["profile"]])
  sides <- .atrium_pick_sides(f[["competitors"]])
  caps <- .ad(f[["captains"]])
  row <- c(
    list(
      website_id = .atrium_site(raw), fixture_id = .atrium_id(f[["fixtureId"]]), season_id = .atrium_season_id_of(data),
      competition_name = .atrium_text(f[["competitionName"]]), name = .atrium_text(f[["name"]]),
      fixture_type = .atrium_text(f[["fixtureType"]]), age_group = .atrium_text(f[["ageGroup"]]),
      status = .atrium_text(f[["status"]]), status_label = .atrium_text(f[["statusLabel"]]),
      start_time_utc = .atrium_dt(f[["startTimeUTC"]]), start_time_local = .atrium_text(f[["startTimeLocal"]]),
      timezone = .atrium_text(f[["timezone"]]), venue = .atrium_text(f[["venue"]]), venue_id = .atrium_id(f[["venueId"]]),
      attendance = .atrium_int(f[["attendance"]]), external_id = .atrium_text(f[["externalId"]]),
      updated = .atrium_dt(f[["updated"]]), live_data_available = f[["liveDataAvailable"]],
      live_video_available = f[["liveVideoAvailable"]], discipline = .atrium_text(f[["discipline"]]),
      series = .atrium_text(f[["series"]]), number_of_periods = .atrium_int(prof[["numberOfPeriods"]]),
      period_length = .atrium_int(prof[["periodLength"]]), overtime_allowed = prof[["overtimeAllowed"]],
      overtime_length = .atrium_int(prof[["overtimeLength"]]), shot_clock = .atrium_int(prof[["shotClock"]]),
      max_fouls_personal = .atrium_int(prof[["maxFoulsPersonal"]]),
      fouls_before_bonus = .atrium_int(prof[["foulsBeforeBonus"]]),
      maximum_players_on_court = .atrium_int(prof[["maximumPlayersOnCourt"]]),
      maximum_roster_size = .atrium_int(prof[["maximumRosterSize"]])
    ),
    .atrium_side_cols("home", sides$home), .atrium_side_cols("away", sides$away),
    list(
      home_captain_person_id = .atrium_id(.ag(caps, .atrium_id(sides$home[["entityId"]]))),
      away_captain_person_id = .atrium_id(.ag(caps, .atrium_id(sides$away[["entityId"]])))
    )
  )
  .atrium_frame(list(row), .atrium_schemas$fixture)
}

#' @noRd
.atrium_parse_fixture_periods <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  sides <- .atrium_pick_sides(.ad(data[["fixture"]])[["competitors"]])
  hid <- .atrium_id(sides$home[["entityId"]])
  aid <- .atrium_id(sides$away[["entityId"]])
  rows <- lapply(.al(data[["periodData"]]), function(p) {
    p <- .ad(p)
    score <- .ad(p[["teamScore"]])
    list(
      website_id = site, fixture_id = .atrium_fixture_id(data), season_id = .atrium_season_id_of(data),
      period_id = .atrium_int(p[["periodId"]]), label = .atrium_text(.ad(p[["labels"]])[["shortLabel"]]),
      is_overtime = p[["isOvertime"]], is_shootout = p[["isShootout"]], started = p[["started"]], ended = p[["ended"]],
      duration_minutes = .atrium_int(p[["durationMinutes"]]),
      elapsed_minutes_before_period = .atrium_int(p[["elapsedMinutesBeforePeriod"]]),
      home_entity_id = hid, away_entity_id = aid,
      home_points = .atrium_int(.ag(score, hid)), away_points = .atrium_int(.ag(score, aid))
    )
  })
  .atrium_frame(rows, .atrium_schemas$fixture_periods)
}

#' @noRd
.atrium_parse_box_score <- function(raw) {
  data <- .atrium_data_of(raw)
  base <- .ad(.ad(.ad(data[["statistics"]])[["data"]])[["base"]])
  rows <- list()
  for (side in c("home", "away")) {
    for (group in .al(.ad(base[[side]])[["persons"]])) {
      for (r in .al(.ad(group)[["rows"]])) {
        r <- .ad(r)
        pos <- r[["position"]]
        rows[[length(rows) + 1L]] <- c(
          list(
            website_id = .atrium_site(raw), fixture_id = .atrium_fixture_id(data), season_id = .atrium_season_id_of(data),
            entity_id = .atrium_id(r[["entityId"]]), side = side, person_id = .atrium_id(r[["personId"]]),
            person_name = .atrium_text(r[["personName"]]), bib = .atrium_text(r[["bib"]]),
            position = .atrium_text(if (.atrium_is_dict(pos)) pos[["code"]] else pos),
            starter = r[["starter"]], active = r[["active"]], participated = r[["participated"]],
            did_not_play_reason = .atrium_text(r[["didNotPlayReason"]])
          ),
          .atrium_statcols(r[["statistics"]])
        )
      }
    }
  }
  .atrium_frame(rows, .atrium_schemas$box_score)
}

#' @noRd
.atrium_parse_team_box_score <- function(raw) {
  data <- .atrium_data_of(raw)
  base <- .ad(.ad(.ad(data[["statistics"]])[["data"]])[["base"]])
  comps <- .atrium_pick_sides(.ad(data[["fixture"]])[["competitors"]])
  rows <- list()
  for (side in c("home", "away")) {
    blk <- .ad(base[[side]])
    if (!length(blk)) next
    first <- list()
    for (g in .al(blk[["persons"]])) {
      r <- .al(.ad(g)[["rows"]])
      if (length(r)) {
        first <- r[[1]]
        break
      }
    }
    eid <- .atrium_id(comps[[side]][["entityId"]])
    if (is.na(eid)) eid <- .atrium_id(.ad(first)[["entityId"]])
    rows[[length(rows) + 1L]] <- c(
      list(website_id = .atrium_site(raw), fixture_id = .atrium_fixture_id(data), season_id = .atrium_season_id_of(data),
           entity_id = eid, side = side),
      .atrium_statcols(blk[["entity"]]), .atrium_statcols(blk[["extra"]], "extra_"),
      .atrium_statcols(blk[["totalEntityStats"]], "total_")
    )
  }
  .atrium_frame(rows, .atrium_schemas$team_box_score)
}

#' Play-by-play events (`key = "events"`) or shots (`key = "shots"`) of a game.
#' @noRd
.atrium_events <- function(raw, key, schema) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  sides <- .atrium_pick_sides(.ad(data[["fixture"]])[["competitors"]])
  hid <- .atrium_id(sides$home[["entityId"]])
  aid <- .atrium_id(sides$away[["entityId"]])
  rows <- list()
  for (p in .al(data[["periodData"]])) {
    for (e in .al(.ad(p)[[key]])) {
      e <- .ad(e)
      ent <- .atrium_id(e[["entityId"]])
      sc <- .ad(e[["scores"]])
      rows[[length(rows) + 1L]] <- list(
        website_id = site, fixture_id = .atrium_fixture_id(data), season_id = .atrium_season_id_of(data),
        sequence = length(rows) + 1L, event_id = .atrium_id(e[["eventId"]]), period_id = .atrium_int(e[["periodId"]]),
        clock = .atrium_text(e[["clock"]]), clock_seconds = .atrium_seconds(e[["clock"]]), entity_id = ent,
        side = if (!is.na(ent) && identical(ent, hid)) "home" else if (!is.na(ent) && identical(ent, aid)) "away" else NA_character_,
        person_id = .atrium_id(e[["personId"]]), person_name = .atrium_text(e[["name"]]), bib = .atrium_text(e[["bib"]]),
        event_type = .atrium_text(e[["eventType"]]), event_sub_type = .atrium_text(e[["eventSubType"]]),
        description = .atrium_text(e[["desc"]]), success = e[["success"]], success_label = .atrium_text(e[["successString"]]),
        x = .atrium_num(e[["x"]]), y = .atrium_num(e[["y"]]),
        home_score = .atrium_int(.ag(sc, hid)), away_score = .atrium_int(.ag(sc, aid))
      )
    }
  }
  .atrium_frame(rows, .atrium_schemas[[schema]])
}

#' @noRd
.atrium_parse_pbp <- function(raw) .atrium_events(raw, "events", "pbp")
#' @noRd
.atrium_parse_shots <- function(raw) .atrium_events(raw, "shots", "shots")

#' @noRd
.atrium_parse_standings <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  sid <- .atrium_id(data[["seasonId"]])
  year <- .ad(.ag(.atrium_season_index(data), sid))$year
  rows <- list()
  for (g in .al(data[["standings"]])) {
    g <- .ad(g)
    for (r in .al(g[["rows"]])) {
      r <- .ad(r)
      t <- .ad(r[["team"]])
      res <- .ad(r[["results"]])
      results <- list()
      for (i in seq_along(res)) results[.atrium_col(names(res)[[i]])] <- list(res[[i]])
      rows[[length(rows) + 1L]] <- c(
        list(website_id = site, season_id = sid, season_end_year = .atrium_end_year1(site, year),
             group = .atrium_text(g[["label"]]), position = .atrium_int(r[["position"]]),
             entity_id = .atrium_id(t[["entityId"]]), team_name = .atrium_text(t[["name"]]),
             is_current_team = t[["isCurrentTeam"]], logo_url = .atrium_text(t[["logoURL"]])),
        results
      )
    }
  }
  .atrium_frame(rows, .atrium_schemas$standings)
}

#' @noRd
.atrium_parse_teams <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  rows <- lapply(.al(data[["teams"]]), function(t) {
    t <- .ad(t)
    list(website_id = site, season_id = .atrium_id(data[["seasonId"]]), entity_id = .atrium_id(t[["entityId"]]),
         name = .atrium_text(t[["name"]]), image_url = .atrium_text(t[["imageURL"]]))
  })
  .atrium_frame(rows, .atrium_schemas$teams)
}

#' @noRd
.atrium_parse_team <- function(raw) {
  data <- .atrium_data_of(raw)
  team <- .ad(data[["team"]])
  if (!length(team)) return(.atrium_frame(list(), .atrium_schemas$team))
  banner <- .ad(team[["banner"]])
  tabs <- .al(data[["tabs"]])
  feat <- .ad(.ad(team[["summary"]])[["featuredFixtures"]])
  row <- list(
    website_id = .atrium_site(raw),
    entity_id = if (length(tabs)) .atrium_id(.atrium_link_ids(.ad(tabs[[1]])[["link"]])[["e"]]) else NA_character_,
    name = .atrium_text(banner[["name"]]), color = .atrium_text(banner[["color"]]),
    logo_url = .atrium_text(banner[["logoURL"]])
  )
  for (k in c("previous", "next")) {
    f <- .ad(feat[[k]])
    comp <- .ad(f[["competitors"]])
    h <- .ad(comp[["home"]])
    a <- .ad(comp[["away"]])
    part <- list(
      .atrium_id(f[["fixtureId"]]), .atrium_text(f[["round"]]), .atrium_text(f[["status"]]),
      .atrium_dt(f[["startTimeUTC"]]), .atrium_text(f[["startTimeLocal"]]), .atrium_text(.ad(f[["venue"]])[["name"]]),
      .atrium_int(f[["attendance"]]), .atrium_id(h[["entityId"]]), .atrium_text(h[["name"]]), .atrium_int(h[["score"]]),
      .atrium_id(a[["entityId"]]), .atrium_text(a[["name"]]), .atrium_int(a[["score"]])
    )
    names(part) <- paste0(k, "_", c("fixture_id", "round", "status", "start_time_utc", "start_time_local", "venue",
                                    "attendance", "home_entity_id", "home_name", "home_score", "away_entity_id",
                                    "away_name", "away_score"))
    row <- c(row, part)
  }
  .atrium_frame(list(row), .atrium_schemas$team)
}

#' @noRd
.atrium_parse_players <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  rows <- lapply(.al(.ad(data[["persons"]])[["rows"]]), function(p) {
    p <- .ad(p)
    pos <- .ad(p[["position"]])
    list(
      website_id = site, season_id = .atrium_id(data[["seasonId"]]), person_id = .atrium_id(p[["id"]]),
      name = .atrium_text(p[["name"]]), bib = .atrium_text(p[["bib"]]), entity_id = .atrium_id(p[["entityId"]]),
      team_name = .atrium_text(p[["teamName"]]), position_code = .atrium_text(pos[["code"]]),
      position_name = .atrium_text(pos[["name"]]), nationality = .atrium_text(p[["nationality"]]),
      date_of_birth = .atrium_date(p[["Date of birth"]]), age = .atrium_int(p[["age"]]),
      height = .atrium_int(p[["height"]]), status = .atrium_text(p[["status"]]), image_url = .atrium_text(p[["imageURL"]])
    )
  })
  .atrium_frame(rows, .atrium_schemas$players)
}

#' @noRd
.atrium_parse_player <- function(raw) {
  p <- .ad(.atrium_data_of(raw)[["person"]])
  if (!length(p)) return(.atrium_frame(list(), .atrium_schemas$player))
  info <- .atrium_kv(p[["info"]])
  dob <- .atrium_date(info[["date_of_birth"]])
  info[["date_of_birth"]] <- NULL
  info["date_of_birth"] <- list(dob)
  info["age"] <- list(.atrium_int(info[["age"]]))
  row <- list(
    website_id = .atrium_site(raw), person_id = .atrium_id(p[["id"]]), name = .atrium_text(p[["name"]]),
    bib = .atrium_text(p[["bib"]]), team_id = .atrium_id(p[["teamId"]]), team_name = .atrium_text(p[["teamName"]]),
    image_url = .atrium_text(p[["imageURL"]])
  )
  row[names(info)] <- info
  avgs <- .atrium_kv(p[["averages"]])
  row[names(avgs)] <- avgs
  .atrium_frame(list(row), .atrium_schemas$player)
}

#' @noRd
.atrium_parse_player_seasons <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  stats <- .ad(data[["statistics"]])
  rows <- lapply(.al(stats[["rows"]]), function(r) {
    r <- .ad(r)
    t <- .ad(r[["team"]])
    c(
      list(website_id = site, person_id = .atrium_id(.ad(data[["person"]])[["id"]]),
           season_name = .atrium_text(r[["seasonName"]]), season_year = .atrium_int(r[["seasonYear"]]),
           season_end_year = .atrium_end_year1(site, .atrium_int(r[["seasonYear"]])), team_id = .atrium_id(t[["id"]]),
           team_name = .atrium_text(t[["name"]])),
      .atrium_positional(stats[["headers"]], r[["statistics"]])
    )
  })
  .atrium_frame(rows, .atrium_schemas$player_seasons)
}

#' @noRd
.atrium_parse_player_game_log <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  log <- .ad(data[["log"]])
  rows <- lapply(.al(log[["rows"]]), function(r) {
    r <- .ad(r)
    res <- .ad(r[["result"]])
    c(
      list(website_id = site, person_id = .atrium_id(.ad(data[["person"]])[["id"]]),
           season_id = .atrium_id(log[["activeSeason"]]), date = .atrium_text(r[["date"]]),
           opponent_entity_id = .atrium_id(r[["entityId"]]), opponent_name = .atrium_text(r[["name"]]),
           result = .atrium_text(res[["value"]]), result_label = .atrium_text(res[["label"]]),
           score = .atrium_text(r[["score"]])),
      .atrium_positional(log[["headers"]], r[["statistics"]])
    )
  })
  .atrium_frame(rows, .atrium_schemas$player_game_log)
}

#' `list(value, value_text)`: a number goes to `value`, anything else (ISO durations) to `value_text`.
#' @noRd
.atrium_value <- function(v) {
  if (is.numeric(v) && .atrium_scalar(v)) list(as.double(v), NA_character_) else list(NA_real_, .atrium_text(v))
}

#' @noRd
.atrium_parse_leaders <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  rows <- list()
  for (table in .al(data[["statistics"]])) {
    table <- .ad(table)
    h <- .ad(table[["header"]])
    entries <- .al(table[["data"]])
    for (i in seq_along(entries)) {
      d <- .ad(entries[[i]])
      ent <- .ad(d[["entity"]])
      per <- .ad(d[["person"]])
      val <- .atrium_value(d[["value"]])
      rows[[length(rows) + 1L]] <- list(
        website_id = site, season_id = .atrium_id(data[["seasonId"]]), stat_key = .atrium_text(h[["key"]]),
        stat_name = .atrium_text(h[["name"]]), stat_label = .atrium_text(h[["code"]]), rank = i,
        entity_id = .atrium_id(ent[["entityId"]]), entity_name = .atrium_text(ent[["name"]]),
        person_id = .atrium_id(per[["personId"]]), person_name = .atrium_text(per[["name"]]),
        value = val[[1]], value_text = val[[2]]
      )
    }
  }
  .atrium_frame(rows, .atrium_schemas$leaders)
}

#' @noRd
.atrium_parse_stat_tables <- function(raw) {
  data <- .atrium_data_of(raw)
  site <- .atrium_site(raw)
  rows <- list()
  for (table in .al(data[["statistics"]])) {
    table <- .ad(table)
    label <- .ad(table[["label"]])
    heads <- lapply(.al(table[["headers"]]), .ad)
    for (subj in .al(table[["statistics"]])) {
      subj <- .ad(subj)
      per <- .ad(subj[["person"]])
      ent <- .ad(subj[["entity"]])
      pid <- .atrium_id(per[["personId"]])
      if (is.na(pid)) pid <- .atrium_id(.atrium_link_ids(per[["link"]])[["p"]])
      eid <- .atrium_id(ent[["entityId"]])
      if (is.na(eid)) eid <- .atrium_id(.atrium_link_ids(ent[["link"]])[["e"]])
      vals <- .al(subj[["statistics"]])
      for (j in seq_len(min(length(heads), length(vals)))) {
        h <- heads[[j]]
        val <- .atrium_value(vals[[j]])
        rows[[length(rows) + 1L]] <- list(
          website_id = site, season_id = .atrium_id(data[["seasonId"]]), table_key = .atrium_text(label[["key"]]),
          table_label = .atrium_text(label[["text"]]), person_id = pid, person_name = .atrium_text(per[["name"]]),
          entity_id = eid, entity_name = .atrium_text(ent[["name"]]), stat_key = .atrium_text(h[["key"]]),
          stat_name = .atrium_text(h[["name"]]), stat_label = .atrium_text(h[["code"]]),
          value = val[[1]], value_text = val[[2]]
        )
      }
    }
  }
  .atrium_frame(rows, .atrium_schemas$stat_tables)
}
