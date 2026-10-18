# vtb_runtime.R -- transport, season mapping, personal-data scrub and refusals of the VTB United League families,
# at parity with sdv-py sportsdataverse/basketball/vtb/vtb_league_runtime.py and vtb_infobasket_runtime.py
# (origin/main e3d232ebc9).
#
# Two keyless public JSON backends of vtb-league.com, both through the shared R/intl_basketball_runtime.R getter
# (at least 1 s per host on every attempt, retries included; HTTP 500 retried, the package default policy, because
# neither host answers 500 for an unknown id):
#   api.vtb-league.com/v2  (vtb_league_*)      {meta, data} envelope; seasons are END years on the wire too.
#   org.infobasket.su      (vtb_infobasket_*)  everything keyed by a competition id; the END year is mapped to the
#                                              season-level CompID with /Comp/GetSeasonsForTag (cached per tag).
#
# Refusals (sdv-py vocabulary): hoopR_no_data for HTTP 404 and an empty valid answer; hoopR_bad_request for a bad
# argument (raised before any request, or after the season table when the END year is not in it); hoopR_asset_fetch
# for everything else: an Infobasket error envelope or bare string (HTTP 200), a game that is not final or a stub, a
# partial page, a body for another game / person / team / competition / league / season, and (Infobasket only) an
# HTTP 400 / 422, which sdv-py maps to AssetFetchError on that host.

#' The v2 schedule API host.
#' @noRd
.VTB_LEAGUE_BASE <- "https://api.vtb-league.com"

#' The Infobasket host.
#' @noRd
.VTB_IB_BASE <- "https://org.infobasket.su"

#' The competition tag every Infobasket wrapper defaults to.
#' @noRd
.VTB_DEFAULT_TAG <- "vtb"

#' Verified 2026-10-12 against /Comp/GetSeasonsForTag?tag=vtb (END year -> season CompID). The runtime reads the
#' live table; this copy is for tests and documentation (sdv-py SEASON_COMP_IDS).
#' @noRd
.VTB_SEASON_COMP_IDS <- c(
  `2010` = 5052L, `2011` = 6076L, `2012` = 7050L, `2013` = 8187L, `2014` = 9113L, `2015` = 10050L,
  `2016` = 11046L, `2017` = 14009L, `2018` = 17018L, `2019` = 30051L, `2020` = 32984L, `2021` = 34829L,
  `2022` = 37492L, `2023` = 39799L, `2024` = 42729L, `2025` = 46399L, `2026` = 50714L, `2027` = 55613L
)

# tag -> named integer vector (END year -> season CompID), cached for the process
.vtb_cache <- new.env(parent = emptyenv())

#' Forget the cached season tables (sdv-py `clear_cache()`).
#' @noRd
.vtb_clear_cache <- function() {
  rm(list = ls(.vtb_cache, all.names = TRUE), envir = .vtb_cache)
  invisible()
}

# ---------------------------------------------------------------------------
# Value helpers shared by the runtime and the parsers
# ---------------------------------------------------------------------------

#' A JSON object (named list) / array (unnamed list), as jsonlite::parse_json(simplifyVector = FALSE) gives them.
#' @noRd
.vtb_is_obj <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.vtb_is_arr <- function(x) is.list(x) && is.null(names(x))

#' `x` if it is an object, else an empty one (sdv-py `obj`).
#' @noRd
.vtb_obj <- function(x) if (.vtb_is_obj(x)) x else structure(list(), names = character())

#' The object members of an array, else an empty list (sdv-py `rows`).
#' @noRd
.vtb_rows <- function(x) if (.vtb_is_arr(x)) Filter(.vtb_is_obj, x) else list()

#' A scalar's JSON kind, so comparisons are type-strict like sdv-py `_same` (TRUE never equals 1).
#' @noRd
.vtb_kind <- function(x) {
  if (length(x) != 1L || is.list(x) || is.na(x)) return("none")
  if (is.logical(x)) return("bool")
  if (is.integer(x)) return("int")
  if (is.double(x)) return(if (x == trunc(x) && abs(x) >= 2^31) "int" else "float")
  if (is.character(x)) return("str")
  "none"
}

#' Type-strict equality (sdv-py `_same`).
#' @noRd
.vtb_same <- function(got, want) {
  k <- .vtb_kind(got)
  k != "none" && k == .vtb_kind(want) && got == want
}

#' An integer (not a boolean) scalar, else NULL (sdv-py `int_or_none`).
#' @noRd
.vtb_int_or_null <- function(x) if (.vtb_kind(x) == "int") x else NULL

#' A whole number argument (an id or an END year): a number or a string of digits, never a boolean.
#' @noRd
.vtb_int_arg <- function(value, name, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.list(value) && !is.logical(value) && !is.na(value) &&
    grepl("^-?[0-9]+$", trimws(format(value, scientific = FALSE, trim = TRUE)))
  if (!ok) .abort_bad_request("{.arg {name}} must be an integer; got {.val {format(value)}}.", call = call)
  n <- as.numeric(trimws(format(value, scientific = FALSE, trim = TRUE)))
  if (abs(n) <= .Machine$integer.max) as.integer(n) else n
}

#' A path id: a non-negative whole number (sdv-py's route regex `\d+` refuses anything else).
#' @noRd
.vtb_path_id <- function(value, name, call = rlang::caller_env()) {
  id <- .vtb_int_arg(value, name, call = call)
  if (id < 0L) .abort_bad_request("{.arg {name}} must be a non-negative integer id; got {id}.", call = call)
  id
}

#' `lang` must be one of the spec's choices (the generated sdv-py wrappers check it before any request).
#' @noRd
.vtb_lang_arg <- function(lang, call = rlang::caller_env()) {
  if (!(is.character(lang) && length(lang) == 1L && lang %in% c("en", "ru"))) {
    .abort_bad_request("{.arg lang} must be one of {.val en} or {.val ru}; got {.val {format(lang)}}.", call = call)
  }
  lang
}

#' The year of a `DD.MM.YYYY` string, else NULL.
#' @noRd
.vtb_year <- function(x) {
  if (!(is.character(x) && length(x) == 1L && !is.na(x) && grepl("^[0-9]{2}\\.[0-9]{2}\\.[0-9]{4}$", x))) return(NULL)
  as.integer(substr(x, 7, 10))
}

# ---------------------------------------------------------------------------
# Personal data
# ---------------------------------------------------------------------------

.VTB_PERSONAL <- c("PersonBirth", "PersonBirthday", "PersonBirthYear", "Age")
.VTB_EVERYONE <- c("LicenceNumber", "PersonContacts", "PersonEmail", "PersonPhone", "Email", "Phone", "SysUser",
                   "SysMyUser")
.VTB_BETTING <- "bet"
.VTB_NON_PLAYER_KEY <- "coach|referee|official|commissioner|staff"

#' `body` without contact data, licence numbers and betting blocks, and without coaches' / officials' birth data
#' (sdv-py `_scrub`). Players' birth dates stay.
#'
#' @param body A parsed Infobasket body.
#' @param whole_body_is_coach `TRUE` for /Widget/CoachPage, whose whole body is a coach record.
#' @noRd
.vtb_scrub <- function(body, whole_body_is_coach = FALSE) {
  walk <- function(node, non_player) {
    if (!is.list(node)) return(node)
    if (is.null(names(node))) return(lapply(node, walk, non_player = non_player))
    if ("StartType" %in% names(node)) {
      st <- node[["StartType"]]
      is_player <- length(st) == 1L && !is.list(st) && !is.na(st) && (is.numeric(st) || is.logical(st)) && st == 1
      if (!is_player) non_player <- TRUE
    }
    keys <- names(node)
    keep <- !(keys %in% .VTB_EVERYONE | keys %in% .VTB_BETTING | (non_player & keys %in% .VTB_PERSONAL))
    out <- node[keep]
    for (i in seq_along(out)) {
      k <- names(out)[[i]]
      v <- walk(out[[i]], non_player || grepl(.VTB_NON_PLAYER_KEY, k, ignore.case = TRUE))
      if (!is.null(v)) out[[i]] <- v
    }
    out
  }
  walk(body, isTRUE(whole_body_is_coach))
}

# ---------------------------------------------------------------------------
# Infobasket
# ---------------------------------------------------------------------------

#' The wrapped Infobasket routes: where the season goes on the wire (`path`: the token is an END year to map; a query
#' key; or NA) and the body type (`list` or `dict`).
#' @noRd
.VTB_IB_ROUTES <- list(
  "/Comp/GetSeasonsForTag" = list(season = NA, kind = "list"),
  "/Comp/GetCalendar/" = list(season = "comps", kind = "list"),
  "/Comp/GetTeamStats/{season}" = list(season = "path", kind = "dict"),
  "/Comp/GetBestPlayers/{season}" = list(season = "path", kind = "list"),
  "/Comp/GetBestTeams/{season}" = list(season = "path", kind = "list"),
  "/Comp/GetTeamStatsForPreview/{game_id}" = list(season = "compId", kind = "list"),
  "/Widget/GetOnline/{game_id}" = list(season = NA, kind = "dict"),
  "/Widget/GamePage/{game_id}" = list(season = NA, kind = "dict"),
  "/Widget/CompIssue/{season}" = list(season = "path", kind = "dict"),
  "/Widget/CompTeamResults/{comp_id}" = list(season = NA, kind = "list"),
  "/Widget/CrossTable/{comp_id}" = list(season = NA, kind = "list"),
  "/Widget/PlayOff/{comp_id}" = list(season = NA, kind = "list"),
  "/Widget/GetBestPlayerParameters/" = list(season = NA, kind = "list"),
  "/Widget/GetBestTeamParameters/" = list(season = NA, kind = "list"),
  "/Widget/PlayerPage/{person_id}" = list(season = NA, kind = "dict"),
  "/Widget/PlayerSeasonStats/{person_id}" = list(season = NA, kind = "dict"),
  "/Widget/PlayerStats/{person_id}" = list(season = "compId", kind = "dict"),
  "/Widget/CoachPage/{person_id}" = list(season = NA, kind = "dict"),
  "/Widget/TeamPage/{team_id}" = list(season = NA, kind = "dict"),
  "/Widget/GetTeamSeasons/{team_id}" = list(season = NA, kind = "list"),
  "/Widget/GetTeamComps/{team_id}" = list(season = "season", kind = "list"),
  "/Widget/TeamRoster/{team_id}" = list(season = "compId", kind = "dict"),
  "/Widget/TeamGames/{team_id}" = list(season = "compId", kind = "list"),
  "/Widget/TeamStats/{team_id}" = list(season = "compId", kind = "dict")
)

#' Routes whose wire query takes `tag` (the others get it only as the key of the season table).
#' @noRd
.VTB_TAG_ROUTES <- c(
  "/Comp/GetSeasonsForTag", "/Widget/PlayerPage/{person_id}", "/Widget/PlayerSeasonStats/{person_id}",
  "/Widget/PlayerStats/{person_id}", "/Widget/TeamPage/{team_id}", "/Widget/GetTeamSeasons/{team_id}",
  "/Widget/GetTeamComps/{team_id}", "/Widget/TeamRoster/{team_id}", "/Widget/TeamGames/{team_id}",
  "/Widget/TeamStats/{team_id}"
)

#' GET an Infobasket URL; an error envelope, a bare string or a scalar is `hoopR_asset_fetch` (sdv-py `_fetch`).
#' HTTP 400 / 422 are asset_fetch on this host too (sdv-py re-raises them as AssetFetchError).
#' @noRd
.vtb_ib_fetch <- function(url, query, call = rlang::caller_env()) {
  where <- .intl_where(url)
  text <- tryCatch(
    .intl_get(url, query = query, retry_500 = TRUE, call = call),
    hoopR_bad_request = function(e) {
      .abort_asset_fetch("{conditionMessage(e)}", status = e$status, call = call)
    }
  )
  body <- .intl_json(text, where = where, call = call)
  if (.vtb_is_obj(body) && all(c("MessageType", "Message") %in% names(body))) {
    msg <- substr(paste(format(body[["Message"]]), collapse = " "), 1, 80)
    .abort_asset_fetch("{where}: Infobasket error envelope: {.val {msg}}", call = call)
  }
  if (is.character(body)) {
    .abort_asset_fetch("{where}: answered the string {.val {substr(body, 1, 40)}}, not data", call = call)
  }
  if (!is.list(body)) .abort_asset_fetch("{where}: answered a scalar, not data", call = call)
  body
}

#' `{END year: season CompID}` of a competition tag, from /Comp/GetSeasonsForTag (cached for the process).
#' @noRd
.vtb_season_table <- function(tag = .VTB_DEFAULT_TAG, call = rlang::caller_env()) {
  if (is.null(.vtb_cache[[tag]])) {
    url <- paste0(.VTB_IB_BASE, "/Comp/GetSeasonsForTag")
    where <- .intl_where(url)
    rows <- .vtb_ib_fetch(url, list(tag = tag, format = "json"), call = call)
    if (!.vtb_is_arr(rows)) .abort_asset_fetch("{where}: no season list", call = call)
    if (!length(rows)) .abort_no_data("{where}: tag {.val {tag}} has no seasons", call = call)
    table <- integer()
    for (r in .vtb_rows(rows)) {
      if (!(.vtb_kind(r[["SeasonYear"]]) == "int" && .vtb_kind(r[["CompID"]]) == "int")) {
        .abort_asset_fetch("{where}: a season row without integer SeasonYear and CompID", call = call)
      }
      table[[as.character(r[["SeasonYear"]])]] <- as.integer(r[["CompID"]])
    }
    assign(tag, table, envir = .vtb_cache)
  }
  .vtb_cache[[tag]]
}

#' The season-level CompID of an END year; `hoopR_bad_request` when the tag has no such season.
#' @noRd
.vtb_season_comp_id <- function(season, tag = .VTB_DEFAULT_TAG, call = rlang::caller_env()) {
  end <- .vtb_int_arg(season, "season", call = call)
  table <- .vtb_season_table(tag, call = call)
  if (!as.character(end) %in% names(table)) {
    years <- sort(as.integer(names(table)))
    .abort_bad_request(
      "{.arg season} must be one of {years} for tag {.val {tag}} (an END year); got {end}.", call = call
    )
  }
  table[[as.character(end)]]
}

#' Every row satisfies `pred`, else `hoopR_asset_fetch` (sdv-py `_all`).
#' @noRd
.vtb_all <- function(where, rows, pred, what, call) {
  if (!.vtb_is_arr(rows)) rows <- .vtb_rows(rows)
  ok <- all(vapply(rows, function(r) .vtb_is_obj(r) && isTRUE(pred(r)), logical(1)))
  if (!ok) .abort_asset_fetch("{where}: the body holds a row of {what}", call = call)
  TRUE
}

#' Every row has an integer `key` (sdv-py `_all_int`).
#' @noRd
.vtb_all_int <- function(rows, key) {
  all(vapply(rows, function(r) .vtb_is_obj(r) && .vtb_kind(r[[key]]) == "int", logical(1)))
}

#' A player game-log row is the requested team's side (sdv-py `_side_is`).
#' @noRd
.vtb_side_is <- function(game_row, team) {
  game <- game_row[["Game"]]
  teams <- if (.vtb_is_obj(game)) .vtb_rows(game[["GameTeams"]]) else list()
  any(vapply(teams, function(t) {
    .vtb_same(t[["GameTeamNumber"]], game_row[["TeamNumber"]]) && .vtb_same(t[["TeamID"]], team)
  }, logical(1)))
}

#' Raise `hoopR_no_data` for a row-less body, `hoopR_asset_fetch` for a partial, non-final or out-of-scope one
#' (sdv-py `_check`).
#' @noRd
.vtb_ib_check <- function(template, kind, ids, params, comp, season, body, call) {
  where <- paste0("org.infobasket.su", template)
  if (kind == "list") {
    if (!.vtb_is_arr(body)) .abort_asset_fetch("{where}: expected a list", call = call)
    if (!length(body)) .abort_no_data("{where}: the host answered no rows", call = call)
  } else if (!.vtb_is_obj(body)) {
    .abort_asset_fetch("{where}: expected an object", call = call)
  }
  t <- template
  if (t == "/Comp/GetCalendar/") {
    .vtb_all(where, body, function(r) {
      if (is.null(season)) return(TRUE)
      y <- .vtb_year(r[["GameDate"]])
      !is.null(y) && y %in% c(season - 1L, season)
    }, "another season", call)
  } else if (t == "/Comp/GetTeamStatsForPreview/{game_id}") {
    if (length(body) != 2L || !.vtb_all_int(body, "TeamID")) {
      .abort_asset_fetch("{where}: expected the two teams of game {ids$game_id}", call = call)
    }
  } else if (t == "/Comp/GetTeamStats/{season}") {
    stats <- body[["Stats"]]
    count <- body[["Count"]]
    full <- .vtb_is_arr(stats) && .vtb_same(body[["Pages"]], 1L) &&
      length(count) == 1L && is.numeric(count) && !is.na(count) && length(stats) == count
    if (!full) {
      pages <- format(body[["Pages"]] %||% "NULL")
      count_txt <- format(count %||% "NULL")
      .abort_asset_fetch("{where}: partial page (Pages {pages}, Count {count_txt})", call = call)
    }
    if (!length(stats)) .abort_no_data("{where}: the season has no team totals", call = call)
  } else if (t == "/Widget/GetOnline/{game_id}") {
    online <- body[["Online"]]
    if (!(.vtb_is_obj(online) && .vtb_same(online[["GameID"]], ids$game_id))) {
      .abort_asset_fetch("{where}: asked for game {ids$game_id}, the body is another game or a stub", call = call)
    }
    if (!(.vtb_same(body[["GameStatus"]], 1L) && .vtb_same(body[["IsOnline"]], FALSE))) {
      .abort_asset_fetch("{where}: game {ids$game_id} is not final", call = call)
    }
    teams <- .vtb_rows(body[["GameTeams"]])
    if (length(teams) != 2L || !.vtb_all_int(teams, "TeamID")) {
      .abort_asset_fetch("{where}: game {ids$game_id} has no two-team box score (a stub body)", call = call)
    }
  } else if (t == "/Widget/GamePage/{game_id}") {
    if (!.vtb_same(body[["GameID"]], ids$game_id)) {
      .abort_asset_fetch("{where}: asked for game {ids$game_id}, got another game", call = call)
    }
    if (!.vtb_same(body[["GameStatus"]], 1L)) {
      .abort_asset_fetch("{where}: game {ids$game_id} is not final", call = call)
    }
  } else if (t == "/Widget/CompIssue/{season}") {
    ok <- .vtb_same(body[["ParentCompID"]], comp) &&
      .vtb_all(where, .vtb_rows(body[["Comps"]]), function(r) .vtb_same(r[["CompIDparent"]], comp),
               "a stage of another competition", call)
    if (!ok) .abort_asset_fetch("{where}: the stage tree is not the one of competition {comp}", call = call)
  } else if (t == "/Widget/CompTeamResults/{comp_id}") {
    .vtb_all(where, body, function(r) .vtb_same(r[["CompID"]], ids$comp_id), "another stage", call)
  } else if (t == "/Widget/CrossTable/{comp_id}") {
    .vtb_all(where, body, function(r) .vtb_kind(r[["GameID"]]) == "int", "a non-game row", call)
  } else if (t == "/Widget/PlayOff/{comp_id}") {
    .vtb_all(where, body, function(r) .vtb_is_arr(r[["Scores"]]), "a non-series row", call)
  } else if (grepl("{person_id}", t, fixed = TRUE)) {
    if (!.vtb_same(body[["PersonID"]], ids$person_id)) {
      .abort_asset_fetch("{where}: asked for person {ids$person_id}, got another person", call = call)
    }
    if (t == "/Widget/PlayerStats/{person_id}" && !is.null(params$team)) {
      team <- .vtb_int_arg(params$team, "team", call = call)
      .vtb_all(where, .vtb_rows(body[["GameStats"]]), function(r) .vtb_side_is(r, team), "another team", call)
    }
  } else if (t %in% c("/Widget/TeamPage/{team_id}", "/Widget/TeamRoster/{team_id}", "/Widget/TeamStats/{team_id}")) {
    if (!.vtb_same(body[["TeamID"]], ids$team_id)) {
      .abort_asset_fetch("{where}: asked for team {ids$team_id}, got another team", call = call)
    }
  } else if (t == "/Widget/GetTeamComps/{team_id}") {
    .vtb_all(where, body, function(r) .vtb_same(r[["CompID"]], comp) || .vtb_same(r[["ParentCompID"]], comp),
             "another season", call)
  } else if (t == "/Widget/TeamGames/{team_id}") {
    team <- ids$team_id
    .vtb_all(where, body, function(r) .vtb_same(r[["TeamAid"]], team) || .vtb_same(r[["TeamBid"]], team),
             "another team", call)
  }
  invisible()
}

#' GET one wrapped Infobasket route; return its scrubbed body with the request stamped under `_request`
#' (sdv-py `vtb_infobasket_runtime._get`).
#'
#' @param template The route template, e.g. `"/Widget/GetOnline/{game_id}"`.
#' @param ids Named list of the path token (`game_id`, `person_id`, `team_id`, `comp_id`, or `season`: an END year).
#' @param query Named list of query parameters as the wrapper builds them; `NULL` entries are dropped. `season` (an
#'   END year) is mapped to the route's competition parameter; `tag` names the season table and goes on the wire only
#'   on the profile routes.
#' @param call The wrapper's frame.
#' @return The body as a named list (a list body as `list(items = ...)`), plus `_request`.
#' @noRd
.vtb_ib_get <- function(template, ids = list(), query = list(), call = rlang::caller_env()) {
  route <- .VTB_IB_ROUTES[[template]]
  ids <- lapply(ids, function(v) v)
  for (nm in setdiff(names(ids), "season")) ids[[nm]] <- .vtb_path_id(ids[[nm]], nm, call = call)
  p <- Filter(Negate(is.null), query)
  tag <- as.character(p$tag %||% .VTB_DEFAULT_TAG)
  season <- NULL
  comp <- NULL
  path <- template
  if (identical(route$season, "path")) {
    season <- .vtb_int_arg(ids$season, "season", call = call)
    ids$season <- season
    comp <- .vtb_season_comp_id(season, tag, call = call)
    path <- sub("{season}", comp, path, fixed = TRUE)
  } else if (!is.na(route$season) && !is.null(p$season)) {
    season <- .vtb_int_arg(p$season, "season", call = call)
    p$season <- NULL
    comp <- .vtb_season_comp_id(season, tag, call = call)
    p[[route$season]] <- comp
  }
  for (nm in names(ids)) path <- sub(paste0("{", nm, "}"), ids[[nm]], path, fixed = TRUE)
  wire <- if (template %in% .VTB_TAG_ROUTES) p else p[names(p) != "tag"]
  body <- .vtb_ib_fetch(paste0(.VTB_IB_BASE, path), wire, call = call)
  body <- .vtb_scrub(body, whole_body_is_coach = template == "/Widget/CoachPage/{person_id}")
  .vtb_ib_check(template, route$kind, ids, p, comp, season, body, call)
  stamp <- c(ids, list(route = template))
  if (!is.null(season)) {
    stamp$season <- season
    stamp$season_comp_id <- comp
  }
  if (!is.null(p$tag)) stamp$tag <- tag
  if (startsWith(template, "/Widget/PlayerStats") && !is.null(p$team)) {
    stamp$team_id <- .vtb_int_arg(p$team, "team", call = call)
  }
  if (.vtb_is_arr(body)) return(list(items = body, `_request` = stamp))
  body[["_request"]] <- stamp
  body
}

# ---------------------------------------------------------------------------
# v2 schedule API
# ---------------------------------------------------------------------------

#' The v2 envelope is a complete, untruncated success, else `hoopR_asset_fetch` (sdv-py `_check_envelope`).
#' @noRd
.vtb_league_envelope <- function(where, body, call) {
  if (!.vtb_is_obj(body) || !.vtb_is_obj(body[["meta"]]) || !"data" %in% names(body)) {
    .abort_asset_fetch("{where}: no meta/data envelope", call = call)
  }
  meta <- body[["meta"]]
  data <- body[["data"]]
  if (!.vtb_same(meta[["status"]], "success") || !.vtb_same(meta[["code"]], 200L)) {
    st <- substr(format(meta[["status"]] %||% "NULL"), 1, 40)
    .abort_asset_fetch("{where}: meta status {.val {st}}", call = call)
  }
  if (!.vtb_is_arr(data) || .vtb_kind(meta[["count"]]) != "int" || length(data) != meta[["count"]]) {
    .abort_asset_fetch("{where}: data is not a list of meta.count rows", call = call)
  }
  limit <- meta[["limit"]]
  if (.vtb_kind(limit) != "int" || meta[["count"]] >= limit) {
    .abort_asset_fetch(
      "{where}: possibly truncated page (count {meta[['count']]} reaches limit {format(limit %||% 'NULL')}); ask for a larger limit",
      call = call
    )
  }
  meta
}

#' GET one wrapped v2 route; return its envelope with the request stamped under `_request`
#' (sdv-py `vtb_league_runtime._get`).
#'
#' @param league_slug League slug, or `NULL` for /v2/leagues.
#' @param season END year, or `NULL`.
#' @noRd
.vtb_league_get <- function(league_slug = NULL, season = NULL, query = list(), call = rlang::caller_env()) {
  ids <- list()
  if (is.null(league_slug)) {
    route <- "/v2/leagues"
    path <- route
  } else {
    if (!(is.character(league_slug) && length(league_slug) == 1L && !is.na(league_slug) &&
          grepl("^[A-Za-z0-9_-]+$", league_slug))) {
      .abort_bad_request("{.arg league_slug} must be a league slug such as {.val vtb}; got {.val {format(league_slug)}}.",
                         call = call)
    }
    ids$league_slug <- league_slug
    route <- "/v2/leagues/{league_slug}/seasons"
    path <- paste0("/v2/leagues/", league_slug, "/seasons")
    if (!is.null(season)) {
      ids$season <- .vtb_path_id(season, "season", call = call)
      route <- "/v2/leagues/{league_slug}/seasons/{season}/matches"
      path <- paste0(path, "/", ids$season, "/matches")
    }
  }
  url <- paste0(.VTB_LEAGUE_BASE, path)
  where <- .intl_where(url)
  body <- .intl_json(.intl_get(url, query = query, retry_500 = TRUE, call = call), where = where, call = call)
  meta <- .vtb_league_envelope(where, body, call)
  data <- body[["data"]]
  if (!length(data)) .abort_no_data("{where}: the API answered no rows", call = call)
  if (route != "/v2/leagues") {
    for (row in .vtb_rows(data)) {
      if (!.vtb_same(row[["league"]], ids$league_slug)) {
        .abort_asset_fetch("{where}: asked for league {.val {ids$league_slug}}, got a row of another league",
                           call = call)
      }
      if (!is.null(ids$season) && !.vtb_same(row[["season"]], ids$season)) {
        .abort_asset_fetch("{where}: asked for season {ids$season}, got a row of another season", call = call)
      }
    }
  }
  list(meta = meta, data = data, `_request` = c(ids, list(route = route)))
}
