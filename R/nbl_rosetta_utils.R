# nbl_rosetta_utils.R -- transport, refusals and parsers of the NBL Rosetta family.
#
# R mirror of sdv-py sportsdataverse/basketball/nbl_au/nbl_rosetta_runtime.py and
# nbl_rosetta_parsers.py. Rosetta (prod.rosetta.nbl.com.au/get) is the JSON proxy behind
# nbl.com.au; one host serves the NBL, the WNBL and NBL1 (the `org` path segment).
#
# Runtime (see the sdv-py module docstring for the measurements behind each rule):
# * the referer gate: Origin / Referer set to nbl.com.au, or every route answers 403
#   {"error": "Access Denied", "code": "MISSING_API_KEY"} (refused, never data);
# * season = END year at the API, mapped to Rosetta's `year`: START year for the NBL and WNBL
#   from 1998-99, calendar year for NBL1 and the 1979-1997 winter seasons (.nbl_rosetta_start_year);
# * `data: []` -> hoopR_no_data; a body that is not the {type, ..., data} envelope, or an error
#   envelope -> hoopR_asset_fetch;
# * scope: every row of a scoped route must prove it answers the request (type-strict, a row
#   without the field is refused) -> hoopR_asset_fetch "out of scope";
# * truncated pages: when the runtime supplied `limit`, a row count equal to it or to a known page
#   size is a page cut by Rosetta's path cache -> hoopR_asset_fetch;
# * HTTP 500 is retried (retry_500 = TRUE: the nbl_au policy of the shared runtime).
#
# Parsers: one generic flattener. Nested objects become `<parent>_<child>` columns (keys through
# .intl_clean_names, the sdv-py underscore() port), lists become JSON text, presentation and
# betting fields are dropped, entity objects give `<entity>_id` (DataCore) and
# `rosetta_<entity>_id` (Rosetta's own). Column types follow the polars rules sdv-py applies
# (infer, then the name rules of `_typed`, then the returns-schema of `_finish`), so the tibble
# matches the sdv-py frame column for column.

.NBL_ROSETTA_HOST <- "https://prod.rosetta.nbl.com.au/get"
.NBL_ROSETTA_GATE <- c(Origin = "https://www.nbl.com.au", Referer = "https://www.nbl.com.au/")
.NBL_ROSETTA_REQUEST_KEY <- "_request"
.NBL_ROSETTA_ORGS <- c("nbl", "wnbl", "nbl1")
.NBL_ROSETTA_TYPES <- c("all", "regular", "preseason", "in_season", "test")

# route -> list(limit sent when the caller sends none, page sizes that mean a cut page). Measured 2026-10-12.
.NBL_ROSETTA_PAGING <- list(
  seasons = list(1000L, 100L),
  teams = list(5000L, 100L),
  matches = list(2000L, c(100L, 500L)),
  standings = list(1000L, 100L),
  players = list(5000L, 500L),
  team_stats = list(5000L, 500L),
  leaders = list(5000L, c(5L, 50L, 150L)),
  team_leaders = list(150L, c(5L, 50L))
)

.NBL_SHORTCODE <- "competition.league.organisation.shortcode"
.NBL_SEASON_SHORTCODE <- paste0("season.", .NBL_SHORTCODE)
# route -> list of c(dotted row field ("|" = accepted alternatives), request group it must equal)
.NBL_ROSETTA_SCOPES <- list(
  seasons = list(c(.NBL_SHORTCODE, "org")),
  matches = list(c("season.year", "year"), c(.NBL_SEASON_SHORTCODE, "org")),
  match = list(c("id", "match_id")),
  standings = list(c("season.year", "year"), c(.NBL_SEASON_SHORTCODE, "org")),
  team_players = list(c("team.id|team.external_id", "team_id"), c(.NBL_SEASON_SHORTCODE, "org")),
  player_boxscores = list(c("match.season.year", "year"), c("player.id|player.external_id", "player_id")),
  player_statistics = list(c("player.id|player.external_id", "player_id"), c(.NBL_SEASON_SHORTCODE, "org")),
  leaders = list(c("season.id|season.external_id", "season_id"), c(.NBL_SEASON_SHORTCODE, "org")),
  team_leaders = list(
    c("season.id|season.external_id", "season_id"),
    c("team.team_code", "team_code"),
    c(.NBL_SEASON_SHORTCODE, "org")
  ),
  team_stats = list(c("season.year", "year"), c(.NBL_SEASON_SHORTCODE, "org")),
  next_match = list(c("season.year", "year"), c(.NBL_SEASON_SHORTCODE, "org")),
  next_match_team = list(c("season.year", "year"), c(.NBL_SEASON_SHORTCODE, "org"))
)

# ---------------------------------------------------------------------------
# Season key
# ---------------------------------------------------------------------------

#' Rosetta's `year` for a season END year (sdv-py `start_year`).
#' @noRd
.nbl_rosetta_start_year <- function(org, season) {
  if (org == "nbl1" || season <= 1998) season else season - 1
}

#' The season END year of a Rosetta `year` (sdv-py `end_year`); `NULL` when year 1998 has no date.
#' @noRd
.nbl_rosetta_end_year <- function(org, year, start_date = NULL) {
  if (org == "nbl1" || year <= 1997) return(year)
  if (year >= 1999) return(year + 1)
  month <- regmatches(start_date %||% "", regexec("^[0-9]{4}-([0-9]{2})", start_date %||% ""))[[1]]
  if (length(month) < 2) return(NULL)
  if (as.integer(month[[2]]) >= 7) 1999 else 1998
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' Python-style `repr` of a scalar for messages (`'nba'`, `None`).
#' @noRd
.nbl_repr <- function(x) {
  if (is.null(x) || length(x) == 0) return("None")
  if (is.character(x)) return(paste0("'", x[[1]], "'"))
  as.character(x[[1]])
}

#' Null-safe nested get: `NULL` when any hop is missing or not an object.
#' @noRd
.nbl_dig <- function(row, dotted) {
  for (key in strsplit(dotted, ".", fixed = TRUE)[[1]]) {
    row <- if (.nbl_is_obj(row)) row[[key]] else NULL
  }
  row
}

#' Refuse unless every row proves it answers the request (type-strict, fail-closed).
#' @noRd
.nbl_rosetta_scope <- function(where, route, groups, rows, call) {
  for (rule in .NBL_ROSETTA_SCOPES[[route]] %||% list()) {
    field <- rule[[1]]
    want <- groups[[rule[[2]]]]
    if (rule[[2]] == "year") want <- as.character(as.integer(want)) # Rosetta writes the year as a string
    for (row in rows) {
      got <- lapply(strsplit(field, "|", fixed = TRUE)[[1]], function(f) .nbl_dig(row, f))
      ok <- any(vapply(got, function(g) is.character(g) && length(g) == 1 && identical(g, want), logical(1)))
      if (!ok) {
        got1 <- .nbl_repr(got[[1]])
        want1 <- .nbl_repr(want)
        .abort_asset_fetch("{where}: out of scope: {field}={got1}, asked for {want1}", call = call)
      }
    }
  }
  invisible()
}

#' Validate an envelope (sdv-py `_check`); return its rows.
#' @noRd
.nbl_rosetta_check <- function(where, route, groups, body, sent_limit, call) {
  if (.nbl_is_obj(body) && ("error" %in% names(body) || identical(body[["code"]], "MISSING_API_KEY"))) {
    code <- .nbl_repr(.nbl_or(body[["code"]], body[["error"]]))
    .abort_asset_fetch("{where}: Rosetta error envelope: {code}", call = call)
  }
  if (!.nbl_is_obj(body) || !all(c("data", "type") %in% names(body))) {
    .abort_asset_fetch("{where}: not the Rosetta {{type, ..., data}} envelope", call = call)
  }
  data <- body[["data"]]
  if (!is.list(data)) {
    kind <- if (is.null(data)) "NoneType" else class(data)[[1]]
    .abort_asset_fetch("{where}: data is a {kind}, not rows", call = call)
  }
  rows <- unname(data)
  if (!length(rows)) {
    .abort_no_data("{where}: Rosetta answered data: [] (an unknown id, org or type, or nothing yet)", call = call)
  }
  if (!all(vapply(rows, .nbl_is_obj, logical(1)))) {
    .abort_asset_fetch("{where}: data rows are not objects", call = call)
  }
  .nbl_rosetta_scope(where, route, groups, rows, call)
  paging <- .NBL_ROSETTA_PAGING[[route]]
  if (!is.null(paging) && !is.null(sent_limit) && !.nbl_is_obj(data)) {
    sizes <- sort(unique(c(paging[[2]], sent_limit)))
    if (length(rows) %in% sizes) {
      n <- length(rows)
      ttl <- .nbl_repr(body[["ttlRemaining"]])
      sz <- paste(sizes, collapse = ", ")
      .abort_asset_fetch(paste0(
        "{where}: {n} rows is a page size [{sz}]: a page cut by a cached request; ",
        "retry after the cache entry expires (ttlRemaining={ttl}s)"
      ), call = call)
    }
  }
  rows
}

#' GET one Rosetta route as JSON: gate headers, END -> Rosetta year, refusals, request stamp.
#'
#' @param route Runtime route key (`.NBL_ROSETTA_PAGING`, `.NBL_ROSETTA_SCOPES`).
#' @param path Path template under the host, `{name}` tokens filled from `groups`; a
#'   `{season}` token takes Rosetta's year.
#' @param groups Named list of the path values (`org`, `season`, `type`, ids).
#' @param query Named list of query parameters; `NULL` entries are dropped.
#' @return The parsed envelope with the request stamped under `_request`.
#' @noRd
.nbl_rosetta_get <- function(route, path, groups, query = list(), call = rlang::caller_env()) {
  stamp <- groups[intersect(c("org", "match_id"), names(groups))]
  if (!is.null(groups[["season"]])) {
    end <- groups[["season"]]
    year <- .nbl_rosetta_start_year(groups[["org"]] %||% "nbl", end)
    stamp[["season"]] <- end
    stamp[["year"]] <- year
    groups[["year"]] <- year
    groups[["season"]] <- year
  }
  for (name in names(groups)) path <- gsub(paste0("{", name, "}"), groups[[name]], path, fixed = TRUE)
  url <- paste0(.NBL_ROSETTA_HOST, path)
  sent_limit <- NULL
  if (!is.null(.NBL_ROSETTA_PAGING[[route]]) && is.null(query[["limit"]])) {
    sent_limit <- .NBL_ROSETTA_PAGING[[route]][[1]]
    query["limit"] <- list(sent_limit)
  }
  query <- Filter(Negate(is.null), query)
  text <- .intl_get(url, query = query, headers = .NBL_ROSETTA_GATE, retry_500 = TRUE, call = call)
  where <- .intl_where(url)
  body <- .intl_json(text, where = where, simplifyVector = FALSE, call = call)
  .nbl_rosetta_check(where, route, groups, body, sent_limit, call)
  body[[.NBL_ROSETTA_REQUEST_KEY]] <- stamp
  body
}

#' A whole number, one value (a season END year).
#' @noRd
.nbl_is_year <- function(x) {
  is.numeric(x) && length(x) == 1 && !is.na(x) && x == round(x) && x > 0
}

#' The body of every exported wrapper: check the arguments, fetch, parse, wrap.
#'
#' @param short Endpoint key (`.NBL_ROSETTA_COLUMNS`, `.NBL_ROSETTA_PARSER`).
#' @param route Runtime route key.
#' @param path Path template (the sdv-py endpoint path).
#' @param path_args Named list of the wrapper's path arguments.
#' @param query Named list of query parameters.
#' @noRd
.nbl_rosetta_call <- function(short, route, path, path_args, query = list(), call = rlang::caller_env()) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  org <- path_args[["org"]]
  if ("org" %in% names(path_args) && !(is.character(org) && length(org) == 1 && org %in% .NBL_ROSETTA_ORGS)) {
    got <- .nbl_repr(org)
    .abort_bad_request("org must be one of ('nbl', 'wnbl', 'nbl1'); got {got}", call = call)
  }
  st <- path_args[["season_type"]]
  if ("season_type" %in% names(path_args) &&
      !(is.character(st) && length(st) == 1 && st %in% .NBL_ROSETTA_TYPES)) {
    got <- .nbl_repr(st)
    .abort_bad_request(
      "season_type must be one of ('all', 'regular', 'preseason', 'in_season', 'test'); got {got}",
      call = call
    )
  }
  if ("season" %in% names(path_args) && !.nbl_is_year(path_args[["season"]])) {
    .abort_bad_request("{.arg season} must be one whole number (the season END year, 2026 = 2025-26).",
                       call = call)
  }
  for (name in setdiff(names(path_args), c("org", "season_type", "season"))) {
    v <- path_args[[name]]
    if (!(is.character(v) && length(v) == 1 && !is.na(v) && grepl("^[^/?#[:space:]]+$", v))) {
      .abort_bad_request("{.arg {name}} must be one id string (no slash or space).", call = call)
    }
  }
  groups <- path_args
  names(groups)[names(groups) == "season_type"] <- "type"
  path <- sub("{season_type}", "{type}", path, fixed = TRUE)
  raw <- .nbl_rosetta_get(route, path, groups, query, call = call)
  df <- .nbl_rosetta_parse(raw, short)
  make_hoopR_data(df, paste0("NBL Rosetta ", short, " from prod.rosetta.nbl.com.au"), Sys.time())
}

# ---------------------------------------------------------------------------
# JSON values (parse_json(simplifyVector = FALSE) shapes)
# ---------------------------------------------------------------------------

#' A JSON object (a named list, `{}` included).
#' @noRd
.nbl_is_obj <- function(x) is.list(x) && !is.null(names(x))

#' A JSON array (an unnamed list).
#' @noRd
.nbl_is_arr <- function(x) is.list(x) && is.null(names(x))

#' Python truthiness of a JSON scalar (`None`, `""`, `0`, `False` are false).
#' @noRd
.nbl_truthy <- function(x) {
  if (is.null(x) || length(x) == 0) return(FALSE)
  if (is.list(x)) return(TRUE)
  if (is.na(x[[1]])) return(FALSE)
  if (is.character(x)) return(nzchar(x[[1]]))
  if (is.logical(x)) return(isTRUE(x[[1]]))
  x[[1]] != 0
}

#' `a or b` (Python): `a` when truthy, else `b`.
#' @noRd
.nbl_or <- function(a, b) if (.nbl_truthy(a)) a else b

#' A double that stands for a JSON integer: whole and beyond int32 (jsonlite gives those as double).
#' Note: a whole float literal >= 2^31 in a body (3e9) reads as an int too; none is kept by the parsers.
#' @noRd
.nbl_big_int <- function(x) is.double(x) && !is.na(x) && x == round(x) && abs(x) >= 2^31

#' Python `x == y` for JSON scalars (strings vs strings, numbers and booleans vs each other).
#' @noRd
.nbl_py_eq <- function(x, y) {
  if (is.null(x) || is.null(y)) return(is.null(x) && is.null(y))
  if (is.character(x) != is.character(y)) return(FALSE)
  isTRUE(x == y)
}

#' Python `repr()` of a float (shortest round-trip digits; `1.0`, `0.1`, `1e-05`, `1e+16`).
#' @noRd
.nbl_float_str <- function(x) {
  if (x == round(x) && abs(x) < 1e16) return(sprintf("%.1f", x))
  for (d in 15:17) {
    s <- sprintf(paste0("%.", d, "g"), x)
    if (as.numeric(s) == x) break
  }
  s
}

#' Number -> text the way polars casts it to String (`1`, `1.0`, `2.5`).
#' @noRd
.nbl_num_str <- function(x) {
  if (is.integer(x) || .nbl_big_int(x)) return(format(x, scientific = FALSE, trim = TRUE))
  .nbl_float_str(x)
}

#' Python `json.dumps(value, ensure_ascii = False)` of a parsed JSON value.
#' @noRd
.nbl_dumps <- function(x) {
  if (is.null(x)) return("null")
  if (.nbl_is_obj(x)) {
    if (!length(x)) return("{}")
    parts <- vapply(names(x), function(k) paste0(.nbl_json_str(k), ": ", .nbl_dumps(x[[k]])), character(1))
    return(paste0("{", paste(parts, collapse = ", "), "}"))
  }
  if (is.list(x)) {
    if (!length(x)) return("[]")
    return(paste0("[", paste(vapply(x, .nbl_dumps, character(1)), collapse = ", "), "]"))
  }
  if (is.character(x)) return(.nbl_json_str(x))
  if (is.logical(x)) return(if (x) "true" else "false")
  .nbl_num_str(x)
}

#' A JSON string literal as Python writes it with `ensure_ascii = False`.
#' @noRd
.nbl_json_str <- function(s) {
  s <- gsub("\\", "\\\\", s, fixed = TRUE)
  s <- gsub("\"", "\\\"", s, fixed = TRUE)
  s <- gsub("\n", "\\n", s, fixed = TRUE)
  s <- gsub("\r", "\\r", s, fixed = TRUE)
  s <- gsub("\t", "\\t", s, fixed = TRUE)
  s <- gsub("\b", "\\b", s, fixed = TRUE)
  s <- gsub("\f", "\\f", s, fixed = TRUE)
  ctl <- gregexpr("[\001-\037]", s, perl = TRUE)[[1]]
  if (ctl[[1]] > 0) {
    chars <- regmatches(s, list(ctl))[[1]]
    for (ch in unique(chars)) s <- gsub(ch, sprintf("\\u%04x", utf8ToInt(ch)), s, fixed = TRUE)
  }
  paste0("\"", s, "\"")
}

#' `out.update(new)` (Python dict): existing names keep their position, new ones append.
#' @noRd
.nbl_upd <- function(out, new) {
  for (k in names(new)) out[k] <- list(new[[k]])
  out
}

# ---------------------------------------------------------------------------
# Flattening (sdv-py nbl_rosetta_parsers helpers)
# ---------------------------------------------------------------------------

.NBL_ENTITY_KEYS <- c("season", "team", "home_team", "away_team", "player", "venue", "match")
.NBL_DROP <- paste0(
  "blurhash|logo|colou?r|socials?_|ticket|broadcaster|betting|odds|override|match_bg|image|shop_url|",
  "membership_url|nickname|user_created|user_updated|date_created|biography|(^|_)sort$|mqtt_|nexus_|",
  "db_call|latest_play|boxscore_field|(^|_)on_court$|(^|_)match_video"
)
.NBL_DROP_KEYS <- c(
  "matches", "season_statistics", "rosters", "marquee_players", "override_seasons",
  "player_match_statistics", "team_match_statistics", "calculated_player_statistics",
  "calculated_team_statistics", "play_by_play"
)
.NBL_ID_COL <- "(^|_)(id|external_media_id)$"
.NBL_FLOAT_COL <- "percentage|_average$|(^|_)minutes$|(^|_)(x|y)$|latitude|longitude|(^|_)(height|weight)$"
.NBL_INT_COL <- paste0(
  "(^|_)(points|rebounds|assists|blocks|steals|turnovers|fouls|games|wins|losses|won|lost|played|streak|",
  "efficiency|plus_minus|points_for|points_against|attempted|made|score|period|attendance|capacity|",
  "total_score|action_id|season_year|season_end_year)$|^position$"
)
.NBL_RENAME <- c(
  sc_total_score_without_d_dand_td = "sc_total_score_without_dd_and_td",
  `_synthetic_from_roster` = "synthetic_from_roster"
)

#' Drop the presentation / internals keys of a flat row.
#' @noRd
.nbl_keep <- function(flat) flat[!grepl(.NBL_DROP, names(flat), perl = TRUE)]

#' Rename (`.NBL_RENAME` plus `extra`) the keys of a flat row; a later duplicate wins in the first slot.
#' @noRd
.nbl_rename <- function(flat, extra = NULL) {
  map <- c(.NBL_RENAME, extra)
  out <- list()
  for (k in names(flat)) {
    nk <- if (k %in% names(map)) map[[k]] else k
    out[nk] <- list(flat[[k]])
  }
  out
}

#' An entity object -> `<name>_id` (DataCore) / `rosetta_<name>_id` + its other fields prefixed.
#' @noRd
.nbl_entity <- function(name, value) {
  ext <- value[["external_id"]]
  rid <- value[["id"]]
  out <- list()
  if (!is.null(ext)) out[[paste0(name, "_id")]] <- ext
  if (!is.null(rid) && !.nbl_py_eq(rid, ext)) out[[paste0("rosetta_", name, "_id")]] <- rid
  rest <- value[setdiff(names(value), c("id", "external_id"))]
  parts <- strsplit(name, "_", fixed = TRUE)[[1]]
  .nbl_upd(out, .nbl_flatten(rest, paste0(name, "_"), base = parts[[length(parts)]]))
}

#' One flat row: nested objects as `<parent>_<child>`, lists as JSON, entity ids normalised.
#' @noRd
.nbl_flatten <- function(obj, prefix = "", base = "") {
  out <- list()
  for (key in names(obj)) {
    if (key == .NBL_ROSETTA_REQUEST_KEY || key %in% .NBL_DROP_KEYS) next
    value <- obj[[key]]
    leaf <- .intl_clean_names(key)
    if (nzchar(base) && startsWith(leaf, paste0(base, "_"))) leaf <- substring(leaf, nchar(base) + 2)
    name <- paste0(prefix, leaf)
    if (key %in% .NBL_ENTITY_KEYS && .nbl_is_obj(value) && any(c("id", "external_id") %in% names(value))) {
      out <- .nbl_upd(out, .nbl_entity(name, value))
    } else if (key %in% .NBL_ENTITY_KEYS && is.null(value)) {
      next
    } else if (key == "match" && is.character(value)) {
      out["rosetta_match_id"] <- list(value)
    } else if (.nbl_is_obj(value)) {
      out <- .nbl_upd(out, .nbl_flatten(value, paste0(name, "_"), base = leaf))
    } else if (is.list(value)) {
      out[name] <- list(.nbl_dumps(value))
    } else {
      out[name] <- list(value)
    }
  }
  out
}

#' `(rows, request stamp)` of an envelope, a bare `data` list, or the outcomes map.
#' @noRd
.nbl_rows <- function(raw) {
  if (.nbl_is_arr(raw)) return(list(rows = Filter(.nbl_is_obj, raw), req = list()))
  if (!.nbl_is_obj(raw)) return(list(rows = list(), req = list()))
  req <- raw[[.NBL_ROSETTA_REQUEST_KEY]]
  if (!.nbl_is_obj(req)) req <- list()
  data <- raw[["data"]]
  if (.nbl_is_arr(data)) return(list(rows = Filter(.nbl_is_obj, data), req = req))
  if (.nbl_is_obj(data) && length(data) && all(vapply(data, .nbl_is_obj, logical(1)))) {
    rows <- lapply(names(data), function(k) .nbl_upd(list(team_name = k), data[[k]]))
    return(list(rows = rows, req = req))
  }
  list(rows = list(), req = req)
}

#' Add `org` and `season_end_year` (the sdv key) to a flat row; fold the org shortcode into `org`.
#' @noRd
.nbl_enrich <- function(flat, req) {
  org <- NULL
  for (key in grep("competition_league_organisation_shortcode$", names(flat), value = TRUE)) {
    if (!.nbl_truthy(org)) {
      org <- flat[[key]]
      flat[key] <- NULL
    }
  }
  org <- .nbl_or(org, req[["org"]])
  out <- if (.nbl_truthy(org)) list(org = org) else list()
  out <- .nbl_upd(out, flat)
  year_col <- NULL
  for (col in c("season_year", "match_season_year")) {
    v <- out[[col]]
    if (!is.null(v) && !identical(v, "")) {
      year_col <- col
      break
    }
  }
  start <- NULL
  for (col in c("start_date", "start_time_datetime", "start_time", "match_start_time_datetime")) {
    if (.nbl_truthy(out[[col]])) {
      start <- out[[col]]
      break
    }
  }
  if (!is.null(year_col) && .nbl_truthy(org)) {
    year <- .nbl_py_int(out[[year_col]])
    sdate <- if (is.null(start)) NULL else .nbl_py_str(start)
    out["season_end_year"] <- list(if (is.null(year)) NULL else .nbl_rosetta_end_year(.nbl_py_str(org), year, sdate))
  } else if (!is.null(req[["season"]])) {
    out["season_end_year"] <- list(req[["season"]])
  }
  out
}

#' Python `int(x)` of a JSON scalar; `NULL` where Python raises.
#' @noRd
.nbl_py_int <- function(x) {
  if (is.logical(x)) return(as.integer(x))
  if (is.numeric(x)) return(trunc(x))
  if (is.character(x) && grepl("^\\s*[+-]?[0-9]+\\s*$", x)) return(as.numeric(x))
  NULL
}

#' Python `str(x)` of a JSON scalar.
#' @noRd
.nbl_py_str <- function(x) {
  if (is.character(x)) return(x)
  if (is.logical(x)) return(if (x) "True" else "False")
  .nbl_num_str(x)
}

#' The row's own `id` / `external_id` as `<entity>_id` / `rosetta_<entity>_id`, then the rest, flat.
#' @noRd
.nbl_flat_row <- function(row, entity, req, rename = NULL) {
  if (is.null(entity)) {
    ids <- list()
    rest <- row
  } else {
    ids <- .nbl_entity(entity, list(id = row[["id"]], external_id = row[["external_id"]]))
    rest <- row[setdiff(names(row), c("id", "external_id"))]
  }
  flat <- .nbl_keep(.nbl_upd(ids, .nbl_flatten(rest)))
  .nbl_enrich(.nbl_rename(flat, rename), req)
}

# ---------------------------------------------------------------------------
# Shapes (one per sdv-py parser)
# ---------------------------------------------------------------------------

#' @noRd
.nbl_list_shape <- function(entity, rename = NULL) {
  function(raw) {
    r <- .nbl_rows(raw)
    lapply(r$rows, .nbl_flat_row, entity = entity, req = r$req, rename = rename)
  }
}

#' @noRd
.nbl_matches_shape <- function(raw) {
  r <- .nbl_rows(raw)
  out <- lapply(r$rows, .nbl_flat_row, entity = "match", req = r$req)
  asked <- r$req[["season"]]
  if (!is.null(asked)) {
    out <- Filter(function(x) is.null(x[["season_end_year"]]) || isTRUE(x[["season_end_year"]] == asked), out)
  }
  out
}

#' @noRd
.nbl_next_matches_shape <- function(raw) {
  r <- .nbl_rows(raw)
  out <- list()
  for (team in r$rows) {
    head <- list(
      rosetta_team_id = team[["id"]], team_name = team[["name"]], team_code = team[["team_code"]],
      division = team[["division"]], conference = team[["conference"]]
    )
    nxts <- team[["nextMatches"]]
    if (!.nbl_truthy(nxts)) nxts <- list(stats::setNames(list(), character()))
    if (!.nbl_is_arr(nxts)) next # Note: Python iterates a dict's keys here (all skipped); same result
    for (nxt in nxts) {
      if (!.nbl_is_obj(nxt)) next
      flat <- .nbl_keep(.nbl_flatten(nxt))
      ext <- flat[["external_id"]]
      flat["external_id"] <- NULL
      flat["match_id"] <- list(ext)
      rid <- flat[["id"]]
      flat["id"] <- NULL
      flat["rosetta_match_id"] <- list(rid)
      opp <- flat[["opponent_id"]]
      flat["opponent_id"] <- NULL
      flat["rosetta_opponent_id"] <- list(opp)
      out[[length(out) + 1]] <- .nbl_enrich(.nbl_upd(head, flat), r$req)
    }
  }
  out
}

#' The match object of a match body (`data[0]`).
#' @noRd
.nbl_match_of <- function(raw) {
  r <- .nbl_rows(raw)
  list(match = if (length(r$rows)) r$rows[[1]] else list(), req = r$req)
}

#' @noRd
.nbl_match_id <- function(match) {
  mid <- .nbl_or(match[["external_id"]], match[["id"]])
  if (is.character(mid)) mid else NULL
}

#' @noRd
.nbl_match_shape <- function(raw) {
  m <- .nbl_match_of(raw)
  if (length(m$match)) list(.nbl_flat_row(m$match, "match", m$req)) else list()
}

#' Rows of one list block of the match body, each tagged with the match's id and status.
#' @noRd
.nbl_block_shape <- function(key, line) {
  function(raw) {
    match <- .nbl_match_of(raw)$match
    head <- list(match_id = .nbl_match_id(match), match_status = match[["match_status"]])
    block <- match[[key]]
    if (!.nbl_is_arr(block)) return(list())
    lapply(Filter(.nbl_is_obj, block), function(r) .nbl_upd(head, line(r)))
  }
}

#' A box-score line: its own ids are the line's (`stat_line_id`), not an entity's.
#' @noRd
.nbl_stat_line <- function(row) {
  out <- .nbl_entity("stat_line", list(id = row[["id"]], external_id = row[["external_id"]]))
  out <- .nbl_upd(out, .nbl_flatten(row[setdiff(names(row), c("id", "external_id"))]))
  .nbl_rename(.nbl_keep(out))
}

#' `"MM:SS"` / `"HH:MM:SS"` / a number -> seconds; anything else -> `NULL`.
#' @noRd
.nbl_seconds <- function(value) {
  if (is.logical(value) || is.null(value)) return(NULL)
  if (is.numeric(value)) return(as.numeric(value))
  if (!is.character(value)) return(NULL)
  parts <- strsplit(trimws(value), ":", fixed = TRUE)[[1]]
  if (!length(parts) || grepl(":$", trimws(value))) return(NULL)
  nums <- suppressWarnings(as.numeric(parts))
  if (anyNA(nums)) return(NULL)
  switch(length(nums), nums[[1]], nums[[1]] * 60 + nums[[2]], nums[[1]] * 3600 + nums[[2]] * 60 + nums[[3]])
}

#' `"Driving Layup"` and `"drivingLayup"` -> `"driving_layup"`.
#' @noRd
.nbl_sub_type_key <- function(value) {
  if (!is.character(value) || !nzchar(trimws(value))) return(NULL)
  s <- gsub("(?<=[a-z0-9])(?=[A-Z])", "_", trimws(value), perl = TRUE)
  tolower(gsub("[\\s\\-]+", "_", s, perl = TRUE))
}

#' One play-by-play event.
#' @noRd
.nbl_event <- function(e, match) {
  obj <- function(x) if (.nbl_is_obj(x)) x else list()
  player <- obj(e[["player"]])
  team <- obj(e[["team"]])
  coords <- obj(e[["coordinates"]])
  home_team <- obj(match[["home_team"]])
  home <- .nbl_or(home_team[["external_id"]], home_team[["id"]])
  team_id <- .nbl_or(.nbl_or(team[["external_id"]], team[["id"]]), NULL)
  person <- .nbl_or(.nbl_or(e[["personId"]], player[["external_id"]]), NULL)
  jersey <- player[["jersey_number"]]
  success <- e[["success"]]
  list(
    match_id = .nbl_or(e[["fixtureId"]], .nbl_match_id(match)),
    rosetta_match_id = if (is.character(e[["match"]])) e[["match"]] else NULL,
    match_status = match[["match_status"]],
    action_id = e[["action_id"]],
    period = e[["period"]],
    period_type = e[["period_type"]],
    clock = e[["clock"]],
    clock_seconds = .nbl_seconds(e[["clock"]]),
    shot_clock = e[["shot_clock"]],
    shot_clock_seconds = .nbl_seconds(e[["shot_clock"]]),
    score_home = e[["score_1"]],
    score_away = e[["score_2"]],
    action_type = e[["action_type"]],
    sub_type = e[["sub_type"]],
    sub_type_key = .nbl_sub_type_key(e[["sub_type"]]),
    success = if (is.logical(success)) success else NULL,
    team_id = team_id,
    team_code = team[["team_code"]],
    team_name = team[["name"]],
    is_home = if (.nbl_truthy(team_id) && .nbl_truthy(home)) .nbl_py_eq(team_id, home) else NULL,
    player_id = person,
    player_name = .nbl_or(player[["full_name"]], NULL),
    jersey_number = if (is.null(jersey)) NULL else .nbl_py_str(jersey),
    x = coords[["x"]],
    y = coords[["y"]],
    readable_action_type = e[["readable_action_type"]],
    system_action_type = e[["system_action_type"]],
    timestamp = e[["timestamp"]],
    feed = if (.nbl_truthy(e[["fixtureId"]])) "datacore" else "backfill"
  )
}

#' @noRd
.nbl_pbp_shape <- function(raw) {
  match <- .nbl_match_of(raw)$match
  block <- match[["play_by_play"]]
  if (!.nbl_is_arr(block)) return(list())
  events <- lapply(Filter(.nbl_is_obj, block), .nbl_event, match = match)
  if (!length(events)) return(events)
  aid <- lapply(events, `[[`, "action_id")
  missing <- vapply(aid, is.null, logical(1))
  key <- vapply(aid, function(a) if (is.null(a)) 0 else as.numeric(a), numeric(1))
  events[order(missing, key, method = "radix")]
}

.NBL_SHAPES <- list(
  parse_nbl_rosetta_seasons = .nbl_list_shape("season", c(year = "season_year")),
  parse_nbl_rosetta_matches = .nbl_matches_shape,
  parse_nbl_rosetta_teams = .nbl_list_shape("team"),
  parse_nbl_rosetta_standings = .nbl_list_shape("standing"),
  parse_nbl_rosetta_players = .nbl_list_shape(NULL),
  parse_nbl_rosetta_outcomes = .nbl_list_shape(NULL),
  parse_nbl_rosetta_player_game_log = .nbl_list_shape(NULL),
  parse_nbl_rosetta_player_season_stats = .nbl_list_shape(NULL),
  parse_nbl_rosetta_team_season_stats = .nbl_list_shape(NULL),
  parse_nbl_rosetta_next_match = .nbl_list_shape("match"),
  parse_nbl_rosetta_next_matches = .nbl_next_matches_shape,
  parse_nbl_rosetta_match = .nbl_match_shape,
  parse_nbl_rosetta_match_player_box = .nbl_block_shape("player_match_statistics", .nbl_stat_line),
  parse_nbl_rosetta_match_team_box = .nbl_block_shape("team_match_statistics", .nbl_stat_line),
  parse_nbl_rosetta_match_player_period_box = .nbl_block_shape(
    "calculated_player_statistics", function(r) .nbl_keep(.nbl_flatten(r))
  ),
  parse_nbl_rosetta_match_pbp = .nbl_pbp_shape
)

# ---------------------------------------------------------------------------
# Frame building and typing (polars `from_dicts`, `_typed`, `_finish`)
# ---------------------------------------------------------------------------

#' The polars dtype `from_dicts(strict = FALSE)` infers for a column of JSON scalars.
#' @noRd
.nbl_infer <- function(vals) {
  vals <- Filter(Negate(is.null), vals)
  if (!length(vals)) return("n")
  kind <- vapply(vals, function(v) {
    if (is.character(v)) "s" else if (is.logical(v)) "b" else if (is.integer(v) || .nbl_big_int(v)) "i" else "f"
  }, character(1))
  if ("s" %in% kind) return("s")
  if ("f" %in% kind) return("f")
  if ("i" %in% kind) return("i")
  "b"
}

#' A column of JSON scalars (`NULL` = missing) as one typed vector of polars dtype `type`.
#' @noRd
.nbl_column <- function(vals, type) {
  pick <- function(proto, f) vapply(vals, function(v) if (is.null(v)) proto else f(v), proto)
  switch(type,
    n = rep(NA, length(vals)),
    b = pick(NA, as.logical),
    i = .nbl_int(pick(NA_real_, as.numeric)),
    f = pick(NA_real_, as.numeric),
    s = pick(NA_character_, function(v) {
      if (is.character(v)) v else if (is.logical(v)) (if (v) "true" else "false") else .nbl_num_str(v)
    })
  )
}

#' Whole doubles -> integer (sdv-py Int64); values beyond int32 stay double.
#' Note: R has no int64 here; a count past 2^31 keeps its value as double instead of overflowing.
#' @noRd
.nbl_int <- function(x) {
  if (is.integer(x)) return(x)
  if (any(abs(x) >= 2^31, na.rm = TRUE)) return(x)
  as.integer(x)
}

#' polars `cast(to, strict = FALSE)` of a typed column (`from` = its dtype code).
#' @noRd
.nbl_cast <- function(x, from, to) {
  if (from == to) return(x)
  if (from == "n") return(.nbl_column(rep(list(NULL), length(x)), to))
  switch(to,
    s = switch(from,
      b = ifelse(is.na(x), NA_character_, ifelse(x, "true", "false")),
      i = ifelse(is.na(x), NA_character_, sprintf("%.0f", as.numeric(x))),
      vapply(x, function(v) if (is.na(v)) NA_character_ else .nbl_float_str(v), character(1))
    ),
    f = if (from == "s") .nbl_str_num(x) else as.numeric(x),
    i = if (from == "s") .nbl_int(.nbl_str_int(x)) else .nbl_int(trunc(as.numeric(x))),
    b = if (from == "s") unname(c(true = TRUE, false = FALSE)[tolower(x)]) else as.logical(x),
    n = x
  )
}

#' polars String -> Float64 (non-strict): a decimal number or null.
#' @noRd
.nbl_str_num <- function(x) {
  ok <- grepl("^[+-]?([0-9]+\\.?[0-9]*|\\.[0-9]+)([eE][+-]?[0-9]+)?$", x) | tolower(x) %in% c("nan", "inf", "-inf")
  out <- rep(NA_real_, length(x))
  out[ok & !is.na(x)] <- suppressWarnings(as.numeric(x[ok & !is.na(x)]))
  out
}

#' polars String -> Int64 (non-strict): an integer literal or null ("3.0" is null).
#' @noRd
.nbl_str_int <- function(x) {
  ok <- !is.na(x) & grepl("^[+-]?[0-9]+$", x)
  out <- rep(NA_real_, length(x))
  out[ok] <- as.numeric(x[ok])
  out
}

#' `"MM:SS"` (or a numeric string) -> decimal minutes; unparseable -> NA (sdv-py `_minutes`).
#' @noRd
.nbl_minutes <- function(x) {
  m <- regmatches(x, regexec("^\\s*([0-9]+):([0-9]{2})(?::([0-9]{2}))?\\s*$", x, perl = TRUE))
  vapply(seq_along(x), function(i) {
    g <- m[[i]]
    if (is.na(x[[i]])) return(NA_real_)
    if (length(g) == 4 && nzchar(g[[4]])) return(NA_real_)
    if (length(g) >= 3) return(as.numeric(g[[2]]) + as.numeric(g[[3]]) / 60)
    .nbl_str_num(x[[i]])
  }, numeric(1))
}

#' A column's dtype without a value to go by: the schema, else the name rules (sdv-py `_dtype_for`).
#' @noRd
.nbl_dtype_for <- function(col, schema = NULL) {
  if (!is.null(schema) && col %in% names(schema)) return(schema[[col]])
  if (col == "action_id") return("i")
  if (grepl(.NBL_ID_COL, col, perl = TRUE)) return("s")
  if (grepl(.NBL_FLOAT_COL, col, perl = TRUE)) return("f")
  if (grepl(.NBL_INT_COL, col, perl = TRUE)) return("i")
  "s"
}

#' sdv-py `_typed`: ids -> text, rates and minutes -> double, counts -> integer.
#' @noRd
.nbl_typed <- function(col, x, type) {
  if (type == "n") return(list(.nbl_cast(x, "n", .nbl_dtype_for(col)), .nbl_dtype_for(col)))
  if (col == "action_id") return(list(.nbl_cast(x, type, "i"), "i"))
  if (grepl(.NBL_ID_COL, col, perl = TRUE)) {
    if (type == "f") x <- .nbl_cast(x, "f", "i")
    return(list(.nbl_cast(x, if (type == "f") "i" else type, "s"), "s"))
  }
  if (endsWith(col, "minutes") && type == "s") return(list(.nbl_minutes(x), "f"))
  if (grepl(.NBL_FLOAT_COL, col, perl = TRUE)) {
    if (type %in% c("s", "i")) return(list(.nbl_cast(x, type, "f"), "f"))
    return(list(x, type))
  }
  if (grepl(.NBL_INT_COL, col, perl = TRUE) && type == "s") return(list(.nbl_cast(x, "s", "i"), "i"))
  if (endsWith(col, "jersey_number") && type != "s") return(list(.nbl_cast(x, type, "s"), "s"))
  list(x, type)
}

#' Rows (named lists of JSON scalars) -> typed columns (polars `from_dicts` + `_typed`).
#' @noRd
.nbl_frame <- function(rows) {
  rows <- Filter(function(r) length(r) > 0, rows)
  if (!length(rows)) return(list(cols = list(), types = character()))
  names_all <- unique(unlist(lapply(rows, names), use.names = FALSE))
  cols <- list()
  types <- character()
  for (col in names_all) {
    vals <- lapply(rows, function(r) r[[col]])
    vals <- lapply(vals, function(v) if (is.list(v)) .nbl_dumps(v) else v)
    type <- .nbl_infer(vals)
    typed <- .nbl_typed(col, .nbl_column(vals, type), type)
    cols[[col]] <- typed[[1]]
    types[[col]] <- typed[[2]]
  }
  list(cols = cols, types = types)
}

#' sdv-py `_finish`: returns-schema dtypes, the documented columns first (missing ones as NA).
#' @noRd
.nbl_finish <- function(frame, columns, parser) {
  schema <- .NBL_ROSETTA_DTYPES[[parser]]
  cols <- frame$cols
  types <- frame$types
  for (col in intersect(names(cols), names(schema))) {
    want <- schema[[col]]
    have <- types[[col]]
    if (have == want) next
    if (all(is.na(cols[[col]])) || want == "s" || (want %in% c("i", "f") && have %in% c("s", "i", "f"))) {
      cols[[col]] <- .nbl_cast(cols[[col]], have, want)
      types[[col]] <- want
    }
  }
  n <- if (length(cols)) length(cols[[1]]) else 0L
  for (col in setdiff(columns, names(cols))) {
    cols[[col]] <- .nbl_column(rep(list(NULL), n), .nbl_dtype_for(col, schema))
  }
  cols <- cols[c(columns, setdiff(names(cols), columns))]
  dplyr::as_tibble(cols)
}

#' Parse a Rosetta envelope as endpoint `short` (sdv-py `parse_nbl_rosetta_*` with the endpoint's columns).
#' @noRd
.nbl_rosetta_parse <- function(raw, short) {
  parser <- .NBL_ROSETTA_PARSER[[short]]
  rows <- tryCatch(.NBL_SHAPES[[parser]](raw), error = function(e) list())
  .nbl_finish(.nbl_frame(rows), .NBL_ROSETTA_COLUMNS[[short]], parser)
}
