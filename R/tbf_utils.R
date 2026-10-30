# tbf_utils.R -- runtime and parsers of the TBF `tbf_*()` family (Turkish
# Basketball Federation app API: BSL, TBL, KBSL).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/tbf/ (tbf_runtime.py +
# tbf_parsers.py): same routes, same refusals, same column specs. One host,
# miniappapi.tbf.org.tr/webapi-service/api, the official TBF app backend: no
# key, no cookie, plain GETs through .intl_get() (>= 1 s per host, 429 / 502 /
# 503 / 504 retried, a 500 NOT retried) with redirects OFF, so a 3xx (to the
# vendor origin *.nikayazilim.com or anywhere) is hoopR_asset_fetch.
#
# * Season = END year ("2026-2027" -> 2027); competition = bsl / tbl / kbsl. The
#   internal seasonId + activityId come from League/get-leagues-and-seasons-by-prefix
#   (cached per competition per session); a year the list lacks is hoopR_no_data.
# * Game routes serve FINISHED games only: Match/mac-header (cached per game)
#   must say matchStatusId 1, and gives the score, team-season ids and the
#   roster every other game route is checked against.
# * Silent wrong answers are refused (type-strict compares, fail closed):
#   echoed match ids, box totals vs the final score, players vs the header
#   roster, play-by-play ending on "Mac Sonu" at the final score, period sums,
#   league / season / team / date echoes, capped lists (20 seasons, 20 leaders)
#   that are not exactly their cap, partial pages, other-team rows.
# * hoopR_no_data: HTTP 404, NotFoundException envelope, a season the list
#   lacks, an empty list, a finished game without play-by-play / shots (TBF has
#   them from 2025-26). hoopR_bad_request: a bad argument, HTTP 400 / 422.
#   hoopR_asset_fetch: everything else above.
#
# Parsers: each table is a list of column specs (column, dotted source path
# with "|" alternatives, type, optional converter), ported from sportsdataverse-py
# tbf_parsers.TABLES. Paths starting with "_" read the request context the
# runtime stamps under "_request". A malformed body is a typed zero-row tibble.

.TBF_HOST <- "miniappapi.tbf.org.tr"
.TBF_BASE <- "/webapi-service/api"
.TBF_COMPETITIONS <- c("bsl", "tbl", "kbsl")
.TBF_CAP_ROWS <- 20L
.TBF_GAME_END <- "Ma\u00e7 Sonu"
#: wrapper category -> route stem of the nine /Player/get-<stem>-leaders routes
.TBF_LEADER_ROUTES <- c(
  points = "point", assists = "asist", blocks = "blok", rebounds = "ribound", steals = "top-calma",
  minutes = "duration", threes = "3Point", turnovers = "top-kaybi", efficiency = "mvp"
)
#: Turkey local time: every TBF timestamp is wall-clock Europe/Istanbul without a zone.
.TBF_TZ <- "Europe/Istanbul"

# competition -> season rows of the prefix list; match id -> finished-game context
.tbf_prefix_cache <- new.env(parent = emptyenv())
.tbf_game_cache <- new.env(parent = emptyenv())

#' Empty both TBF session caches (the tests call it between scripted runs).
#' @noRd
.tbf_clear_cache <- function() {
  rm(list = ls(.tbf_prefix_cache), envir = .tbf_prefix_cache)
  rm(list = ls(.tbf_game_cache), envir = .tbf_game_cache)
  invisible()
}

# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

.tbf_where <- function(path) paste0(.TBF_HOST, .TBF_BASE, path)

# a JSON object (named list, `{}` included)
.tbf_is_obj <- function(x) is.list(x) && !is.null(names(x))

# sportsdataverse-py `_rows`: the objects of a JSON array, else nothing
.tbf_rows <- function(x) if (is.list(x) && is.null(names(x))) Filter(.tbf_is_obj, x) else list()

.tbf_obj <- function(x) if (.tbf_is_obj(x)) x else structure(list(), names = character(0))

# Python truthiness of a JSON value
.tbf_truthy <- function(x) {
  if (is.null(x) || length(x) == 0L) return(FALSE)
  if (is.list(x)) return(TRUE)
  if (length(x) != 1L || is.na(x)) return(TRUE)
  if (is.logical(x)) return(x)
  if (is.numeric(x)) return(x != 0)
  nzchar(x)
}

# sportsdataverse-py `_same`: type-strict equality of a JSON value with an integer (an
# integral double counts as that integer; "1", TRUE and NULL never do)
.tbf_same <- function(a, b) {
  is.numeric(a) && length(a) == 1L && !is.na(a) && a == b
}

# JSON-encoded tuple: the key of a roster entry (isHome, jerseyNumber, playerName)
.tbf_key <- function(...) {
  as.character(jsonlite::toJSON(list(...), auto_unbox = TRUE, null = "null", digits = NA))
}

.tbf_int_arg <- function(value, what, call) {
  ok <- (is.numeric(value) && length(value) == 1L && is.finite(value) && value >= 0 && value == trunc(value)) ||
    (is.character(value) && length(value) == 1L && !is.na(value) && grepl("^[0-9]+$", trimws(value)))
  if (!ok) .abort_bad_request("{what} must be an integer; got {.val {format(value)}}.", call = call)
  as.integer(if (is.character(value)) trimws(value) else value)
}

.tbf_competition <- function(value, call) {
  comp <- if (is.character(value) && length(value) == 1L && !is.na(value)) tolower(value) else ""
  if (!comp %in% .TBF_COMPETITIONS) {
    .abort_bad_request("{.arg competition} must be one of {.val {(.TBF_COMPETITIONS)}}; got {.val {format(value)}}.",
                       call = call)
  }
  comp
}

# the wrappers' own check: exact, before any request (sportsdataverse-py's generated guard)
.tbf_check_competition <- function(competition, call, optional = FALSE) {
  if (optional && is.null(competition)) return(invisible())
  if (!(is.character(competition) && length(competition) == 1L && competition %in% .TBF_COMPETITIONS)) {
    .abort_bad_request("{.arg competition} must be one of {.val {(.TBF_COMPETITIONS)}}; got {.val {format(competition)}}.",
                       call = call)
  }
  invisible()
}

.tbf_need_rows <- function(path, rows, what, call) {
  if (!length(rows)) .abort_no_data("{(.tbf_where(path))}: no {what}.", call = call)
}

.tbf_envelope <- function(data) list(data = data, isSuccess = TRUE, problemDetails = NULL)

.tbf_stamp <- function(body, ...) {
  body[["_request"]] <- list(...)
  body
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' GET `BASE + path`: the checked TBF envelope `{data, isSuccess, problemDetails}`.
#' @noRd
.tbf_fetch <- function(path, params = list(), call) {
  where <- .tbf_where(path)
  text <- .intl_get(paste0("https://", .TBF_HOST, .TBF_BASE, path), query = params, retry_500 = FALSE,
                    follow_redirects = FALSE, timeout = 60, call = call)
  body <- .intl_json(text, where = where, call = call)
  if (!.tbf_is_obj(body) || !all(c("data", "isSuccess") %in% names(body))) {
    .abort_asset_fetch("{where} answered a body that is not the TBF envelope.", call = call)
  }
  problem <- body[["problemDetails"]]
  if (!isTRUE(body[["isSuccess"]]) || !is.null(problem)) {
    if (.tbf_is_obj(problem) && identical(problem[["type"]], "NotFoundException")) {
      .abort_no_data("{where}: not found.", call = call)
    }
    .abort_asset_fetch("{where} answered an error envelope (isSuccess {format(body[['isSuccess']])}).", call = call)
  }
  body
}

# a paged list must be whole: hasNextPage false and count == the rows
.tbf_paged_complete <- function(path, body, rows, call) {
  if (!identical(body[["hasNextPage"]], FALSE) || !.tbf_same(body[["count"]], length(rows))) {
    n <- length(rows)
    .abort_asset_fetch("{(.tbf_where(path))}: partial page ({n} rows, count {format(body[['count']])}, next page {format(body[['hasNextPage']])}).",
                       call = call)
  }
}

# ---------------------------------------------------------------------------
# Season / competition
# ---------------------------------------------------------------------------

.tbf_prefix_rows <- function(comp, call) {
  if (is.null(.tbf_prefix_cache[[comp]])) {
    path <- "/League/get-leagues-and-seasons-by-prefix"
    rows <- .tbf_rows(.tbf_fetch(path, list(prefix = comp), call)[["data"]])
    .tbf_need_rows(path, rows, paste("seasons for", comp), call)
    ok <- vapply(rows, function(r) {
      u <- r[["url"]]
      is.character(u) && length(u) == 1L && !is.na(u) && startsWith(u, paste0(comp, "-"))
    }, logical(1))
    if (!all(ok)) {
      bad <- format(rows[[which(!ok)[1]]][["url"]])
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: url {bad} is not a {comp}- league.", call = call)
    }
    .tbf_prefix_cache[[comp]] <- rows
  }
  .tbf_prefix_cache[[comp]]
}

# list(sid, aid, comp, year) of an END year; hoopR_no_data when the list lacks it
.tbf_league <- function(season, competition, call) {
  year <- .tbf_int_arg(season, "season", call)
  comp <- .tbf_competition(if (is.null(competition)) "bsl" else competition, call)
  hits <- Filter(function(r) identical(.tbf_end_year(r[["sezon"]]), year), .tbf_prefix_rows(comp, call))
  if (!length(hits)) .abort_no_data("{(.TBF_HOST)}: no {comp} season ending {year} in TBF's league list.", call = call)
  if (length(hits) > 1L) {
    n <- length(hits)
    .abort_asset_fetch("{(.TBF_HOST)}: {n} {comp} seasons end {year}; the season key is ambiguous.", call = call)
  }
  sid <- .tbf_i(hits[[1]][["sezon_ID"]])
  aid <- .tbf_i(hits[[1]][["faaliyet_ID"]])
  if (is.na(sid) || is.na(aid)) {
    .abort_asset_fetch("{(.TBF_HOST)}: {comp} {year} row without season / activity id.", call = call)
  }
  list(sid = sid, aid = aid, comp = comp, year = year)
}

# ---------------------------------------------------------------------------
# Route handlers (sportsdataverse-py tbf_runtime._ROUTES)
# ---------------------------------------------------------------------------

.tbf_seasons <- function(p, call) {
  path <- "/Season/get-seasons"
  body <- .tbf_fetch(path, list(), call)
  rows <- .tbf_rows(body[["data"]])
  .tbf_paged_complete(path, body, rows, call)
  if (length(rows) != .TBF_CAP_ROWS) {
    n <- length(rows)
    .abort_asset_fetch("{(.tbf_where(path))}: capped list drifted: {n} rows, expected exactly {(.TBF_CAP_ROWS)}.",
                       call = call)
  }
  body
}

.tbf_leagues <- function(p, call) {
  sid <- .tbf_league(p[["season"]], "bsl", call)$sid # the bsl list holds every TBF season since 1966-67
  path <- "/League/get-leagues-for-filter"
  body <- .tbf_fetch(path, list(seasonId = sid), call)
  rows <- .tbf_rows(body[["data"]])
  .tbf_need_rows(path, rows, "leagues", call)
  for (r in rows) {
    if (!.tbf_same(r[["seasonId"]], sid)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: seasonId {format(r[['seasonId']])}, asked for {sid}.",
                         call = call)
    }
  }
  body
}

.tbf_league_seasons <- function(p, call) {
  comp <- .tbf_competition(p[["competition"]], call)
  .tbf_stamp(.tbf_envelope(.tbf_prefix_rows(comp, call)), competition = comp)
}

.tbf_weeks_list <- function(sid, aid, call) {
  path <- "/League/get-league-weeks"
  rows <- .tbf_rows(.tbf_fetch(path, list(seasonId = sid, leagueId = aid), call)[["data"]])
  .tbf_need_rows(path, rows, "weeks", call)
  rows
}

.tbf_weeks <- function(p, call) {
  L <- .tbf_league(p[["season"]], p[["competition"]], call)
  .tbf_stamp(.tbf_envelope(.tbf_weeks_list(L$sid, L$aid, call)), season = L$year, competition = L$comp,
             activity_id = L$aid)
}

.tbf_standings <- function(p, call) {
  L <- .tbf_league(p[["season"]], p[["competition"]], call)
  week <- if (is.null(p[["week"]])) NULL else .tbf_int_arg(p[["week"]], "week", call)
  path <- "/League/get-standings-table"
  body <- .tbf_fetch(path, list(seasonId = L$sid, leagueId = L$aid, hafta = week), call)
  rows <- unlist(lapply(.tbf_rows(body[["data"]]), function(g) .tbf_rows(g[["standings"]])), recursive = FALSE)
  .tbf_need_rows(path, rows, "standings rows", call)
  for (s in rows) {
    if (!.tbf_same(s[["faaliyetAltAlanId"]], L$aid)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: faaliyetAltAlanId {format(s[['faaliyetAltAlanId']])}, asked for {L$aid}.",
                         call = call)
    }
    if (!is.null(week) && !.tbf_same(s[["hafta"]], week)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: hafta {format(s[['hafta']])}, asked for {week}.",
                         call = call)
    }
  }
  .tbf_stamp(body, season = L$year, competition = L$comp)
}

.tbf_matches_page <- function(sid, aid, week, call) {
  path <- "/Match/get-all-matches-for-filter"
  body <- .tbf_fetch(path, list(ActivityId = aid, WeekFilter = week, Page = 1L, PageSize = -1L), call)
  rows <- .tbf_rows(body[["data"]])
  .tbf_paged_complete(path, body, rows, call)
  for (r in rows) {
    if (!.tbf_same(r[["activityId"]], aid) || !.tbf_same(r[["seasonId"]], sid)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: activity/season {format(r[['activityId']])}/{format(r[['seasonId']])}, asked for {aid}/{sid}.",
                         call = call)
    }
  }
  if (length(unique(lapply(rows, function(r) r[["week"]]))) > 1L) {
    .abort_asset_fetch("{(.tbf_where(path))}: week {week}: rows from several weeks.", call = call)
  }
  rows
}

.tbf_schedule <- function(p, call) {
  L <- .tbf_league(p[["season"]], p[["competition"]], call)
  weeks <- if (!is.null(p[["week"]])) {
    as.character(.tbf_int_arg(p[["week"]], "week", call))
  } else {
    vapply(.tbf_weeks_list(L$sid, L$aid, call), function(w) {
      v <- w[["sezon_Hafta"]]
      if (is.null(v)) "None" else as.character(v)
    }, character(1))
  }
  rows <- unlist(lapply(weeks, function(w) .tbf_matches_page(L$sid, L$aid, w, call)), recursive = FALSE)
  .tbf_need_rows("/Match/get-all-matches-for-filter", rows, "games", call)
  .tbf_stamp(.tbf_envelope(rows), season = L$year, competition = L$comp)
}

.tbf_daily <- function(p, call) {
  day <- p[["match_date"]]
  iso <- if (inherits(day, "Date") && length(day) == 1L) format(day) else if (is.character(day) && length(day) == 1L) day else ""
  parsed <- if (grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", iso)) as.Date(iso, format = "%Y-%m-%d") else NA
  if (is.na(parsed)) .abort_bad_request("{.arg match_date} must be {.val YYYY-MM-DD}; got {.val {format(day)}}.", call = call)
  day <- format(parsed)
  aid <- if (!is.null(p[["season"]]) || !is.null(p[["competition"]])) .tbf_league(p[["season"]], p[["competition"]], call)$aid
  path <- "/Match/get-daily-matches"
  body <- .tbf_fetch(path, list(MatchDate = day, GroupByActivity = "true", ActivityId = aid), call)
  groups <- .tbf_rows(body[["data"]])
  games <- unlist(lapply(groups, function(g) .tbf_rows(g[["matches"]])), recursive = FALSE)
  .tbf_need_rows(path, games, "games that day", call)
  for (g in groups) {
    if (!.tbf_same(g[["totalCount"]], length(.tbf_rows(g[["matches"]])))) {
      .abort_asset_fetch("{(.tbf_where(path))}: truncated group {format(g[['groupName']])}: totalCount {format(g[['totalCount']])}.",
                         call = call)
    }
  }
  for (m in games) {
    if (!identical(m[["matchDateOnly"]], day)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: matchDateOnly {format(m[['matchDateOnly']])}, asked for {day}.",
                         call = call)
    }
    if (!is.null(aid) && !.tbf_same(m[["activityId"]], aid)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: activityId {format(m[['activityId']])}, asked for {aid}.",
                         call = call)
    }
  }
  body
}

.tbf_players <- function(p, call) {
  L <- .tbf_league(p[["season"]], p[["competition"]], call)
  path <- "/Player/get-player-list"
  body <- .tbf_fetch(path, list(seasonId = L$sid, leagueId = L$aid, page = 1L, pageSize = -1L, sortPlayersEnum = "AZ"),
                     call)
  rows <- .tbf_rows(body[["data"]])
  .tbf_paged_complete(path, body, rows, call)
  .tbf_need_rows(path, rows, "players", call)
  for (r in rows) {
    if (!.tbf_same(r[["seasonId"]], L$sid) || !identical(r[["prefix"]], L$comp)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: seasonId/prefix {format(r[['seasonId']])}/{format(r[['prefix']])}, asked for {L$sid}/{L$comp}.",
                         call = call)
    }
  }
  .tbf_stamp(body, season = L$year, competition = L$comp)
}

.tbf_profile <- function(p, call) {
  player_id <- .tbf_int_arg(p[["player_id"]], "player_id", call)
  body <- .tbf_fetch(paste0("/Player/get-player-detail-profile-and-career-info/", player_id), list(), call)
  data <- .tbf_obj(body[["data"]])
  if (!.tbf_truthy(data[["playerProfile"]]) || !length(.tbf_rows(data[["careerInfo"]]))) {
    .abort_no_data("{(.tbf_where('/Player/get-player-detail-profile-and-career-info'))}: no profile for {player_id}.",
                   call = call)
  }
  .tbf_stamp(body, player_id = player_id)
}

.tbf_leaders <- function(category) {
  force(category)
  function(p, call) {
    L <- .tbf_league(p[["season"]], p[["competition"]], call)
    path <- paste0("/Player/get-", .TBF_LEADER_ROUTES[[category]], "-leaders")
    body <- .tbf_fetch(path, list(seasonId = L$sid, leagueId = L$aid), call)
    data <- .tbf_obj(body[["data"]])
    total <- .tbf_rows(data[["sum"]])
    avg <- .tbf_rows(data[["avg"]])
    if (!length(total) && !length(avg)) .abort_no_data("{(.tbf_where(path))}: no leaders.", call = call)
    if (length(total) != .TBF_CAP_ROWS || length(avg) != .TBF_CAP_ROWS) {
      nt <- length(total)
      na <- length(avg)
      .abort_asset_fetch("{(.tbf_where(path))}: capped list drifted: {nt} sum / {na} avg rows, expected exactly {(.TBF_CAP_ROWS)} each.",
                         call = call)
    }
    .tbf_stamp(body, season = L$year, competition = L$comp, category = category)
  }
}

.tbf_teams <- function(p, call) {
  L <- .tbf_league(p[["season"]], p[["competition"]], call)
  path <- "/Team/get-teams-by-leauge"
  body <- .tbf_fetch(path, list(leaugeId = L$aid), call)
  rows <- .tbf_rows(body[["data"]])
  .tbf_need_rows(path, rows, "teams", call)
  for (r in rows) {
    if (!.tbf_same(r[["seasonId"]], L$sid)) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: seasonId {format(r[['seasonId']])}, the league's season is {L$sid}.",
                         call = call)
    }
  }
  .tbf_stamp(body, season = L$year, competition = L$comp)
}

# a team-season route; `key` names the row list inside `data` ("": `data` is the list)
.tbf_team <- function(route, key) {
  force(route)
  force(key)
  function(p, call) {
    path <- paste0("/Team/", route)
    L <- .tbf_league(p[["season"]], p[["competition"]], call)
    tp <- .tbf_int_arg(p[["team_process_id"]], "team_process_id", call)
    body <- .tbf_fetch(path, list(LeagueId = L$aid, SeasonId = L$sid, TeamProcessId = tp), call)
    data <- body[["data"]]
    rows <- .tbf_rows(if (nzchar(key) && .tbf_is_obj(data)) data[[key]] else data)
    .tbf_need_rows(path, rows, "rows for this team-season", call)
    if (key == "maclar") { # the one team route that names the teams: the asked team must play in every game
      for (m in rows) {
        if (!(.tbf_same(m[["takimAId"]], tp) || .tbf_same(m[["takimBId"]], tp))) {
          .abort_asset_fetch("{(.tbf_where(path))}: out of scope: game {format(m[['matchId']])} is not team {tp}'s.",
                             call = call)
        }
      }
    }
    .tbf_stamp(body, season = L$year, competition = L$comp, team_process_id = tp)
  }
}

# ---------------------------------------------------------------------------
# Games
# ---------------------------------------------------------------------------

.tbf_persons <- function(rows, named_only = FALSE) {
  keep <- Filter(function(r) !named_only || .tbf_truthy(r[["playerName"]]), rows)
  vapply(keep, function(r) .tbf_key(r[["isHome"]], r[["jerseyNumber"]], r[["playerName"]]), character(1))
}

.tbf_off_roster <- function(path, persons, roster, call) {
  bad <- setdiff(persons, roster)
  if (length(bad)) {
    who <- bad[[1]]
    .abort_asset_fetch("{(.tbf_where(path))}: out of scope: player {who} is not on this game's header roster.",
                       call = call)
  }
}

# the header context of a FINISHED game (cached); anything else raises
.tbf_game <- function(match_id, call) {
  key <- as.character(match_id)
  if (!is.null(.tbf_game_cache[[key]])) return(.tbf_game_cache[[key]])
  path <- "/Match/mac-header"
  body <- .tbf_fetch(path, list(matchId = match_id), call)
  h <- .tbf_obj(body[["data"]])
  if (!length(h)) .abort_no_data("{(.tbf_where(path))}: no game {match_id}.", call = call)
  if (!.tbf_same(h[["matchStatusId"]], 1L)) {
    .abort_asset_fetch("{(.tbf_where(path))}: game {match_id} is not finished (matchStatusId {format(h[['matchStatusId']])}); TBF game wrappers serve finished games only.",
                       call = call)
  }
  ids <- vapply(c("homeTeamProcessId", "awayTeamProcessId", "homeTeamScore", "awayTeamScore"),
                function(k) .tbf_i(h[[k]]), integer(1))
  roster <- unique(.tbf_persons(.tbf_rows(h[["players"]])))
  if (anyNA(ids) || !length(roster)) {
    .abort_asset_fetch("{(.tbf_where(path))}: game {match_id}: header without team ids, score or roster.", call = call)
  }
  game <- list(
    body = body,
    roster = roster,
    score = unname(ids[3:4]),
    request = list(match_id = match_id, home_team_process_id = ids[[1]], away_team_process_id = ids[[2]],
                   activity_id = .tbf_i(h[["faaliyetId"]]), season_id = .tbf_i(h[["seasonId"]]))
  )
  .tbf_game_cache[[key]] <- game
  game
}

.tbf_check_summary <- function(path, d, g, call) {
  home <- .tbf_rows(d[["homeTeamScore"]])
  away <- .tbf_rows(d[["awayTeamScore"]])
  .tbf_need_rows(path, home, "period scores", call)
  pts <- function(rows) sum(vapply(rows, function(p) {
    v <- .tbf_i(p[["score"]])
    if (is.na(v)) 0L else v
  }, integer(1)))
  sums <- c(pts(home), pts(away))
  if (!identical(as.integer(sums), as.integer(g$score))) {
    got <- paste(sums, collapse = "-")
    want <- paste(g$score, collapse = "-")
    .abort_asset_fetch("{(.tbf_where(path))}: out of scope: period scores sum to {got}, the final score is {want}.",
                       call = call)
  }
  # (isHome, playerName) pairs of the roster
  names_ok <- vapply(g$roster, function(k) {
    t <- jsonlite::parse_json(k)
    .tbf_key(t[[1]], t[[3]])
  }, character(1))
  for (r in .tbf_rows(d[["matchHighlightLeaders"]])) {
    for (side in list(list(TRUE, "homePlayer"), list(FALSE, "awayPlayer"))) {
      v <- r[[side[[2]]]]
      if (.tbf_truthy(v) && !.tbf_key(side[[1]], v) %in% names_ok) {
        .abort_asset_fetch("{(.tbf_where(path))}: out of scope: {side[[2]]} {format(v)} is not on this game's header roster.",
                           call = call)
      }
    }
  }
}

.tbf_check_flow <- function(path, d, g, call) {
  ev <- .tbf_rows(d[["events"]])
  .tbf_need_rows(path, ev, "play-by-play events (TBF has them from 2025-26)", call)
  last <- ev[[length(ev)]]
  final <- paste(g$score, collapse = "-")
  if (!identical(last[["action"]], .TBF_GAME_END)) {
    .abort_asset_fetch("{(.tbf_where(path))}: game not final: last event {format(last[['action']])}, not {(.TBF_GAME_END)}.",
                       call = call)
  }
  if (!identical(last[["score"]], final)) {
    .abort_asset_fetch("{(.tbf_where(path))}: out of scope: final event score {format(last[['score']])}, the game's is {final}.",
                       call = call)
  }
  .tbf_off_roster(path, .tbf_persons(ev, named_only = TRUE), g$roster, call)
}

.tbf_check_stats <- function(path, mid, d, g, call) {
  if (!is.null(d[["matchId"]]) && !identical(d[["matchId"]], as.character(mid))) {
    .abort_asset_fetch("{(.tbf_where(path))}: out of scope: matchId {format(d[['matchId']])}, asked for {mid}.",
                       call = call)
  }
  blocks <- c("homeTopFive", "homeBenchPlayers", "awayTopFive", "awayBenchPlayers")
  persons <- unlist(lapply(blocks, function(b) {
    vapply(.tbf_rows(d[[b]]), function(p) .tbf_key(startsWith(b, "home"), p[["jerseyNumber"]], p[["playerName"]]),
           character(1))
  }))
  .tbf_need_rows(path, persons, "player rows", call)
  .tbf_off_roster(path, persons, g$roster, call)
  totals <- lapply(c("home", "away"), function(s) .tbf_obj(d[[paste0(s, "TeamTotal")]])[["points"]])
  if (!(.tbf_same(totals[[1]], g$score[[1]]) && .tbf_same(totals[[2]], g$score[[2]]))) {
    got <- paste(vapply(totals, format, character(1)), collapse = "-")
    want <- paste(g$score, collapse = "-")
    .abort_asset_fetch("{(.tbf_where(path))}: out of scope: team totals {got}, the game's final score is {want}.",
                       call = call)
  }
}

.tbf_game_route <- function(route, kind) {
  force(route)
  force(kind)
  function(p, call) {
    path <- paste0("/Match/", route)
    mid <- .tbf_int_arg(p[["match_id"]], "match_id", call)
    g <- .tbf_game(mid, call)
    stamp <- function(body) do.call(.tbf_stamp, c(list(body), g$request))
    if (kind == "header") return(stamp(g$body))
    body <- .tbf_fetch(path, list(matchId = mid), call)
    d <- .tbf_obj(body[["data"]])
    if (kind == "stats") {
      .tbf_check_stats(path, mid, d, g, call)
      return(stamp(body))
    }
    # play-by-play, shots, summary and leaders echo the id as a string
    if (!identical(d[["matchId"]], as.character(mid))) {
      .abort_asset_fetch("{(.tbf_where(path))}: out of scope: matchId {format(d[['matchId']])}, asked for {mid}.",
                         call = call)
    }
    if (kind == "flow") {
      .tbf_check_flow(path, d, g, call)
    } else if (kind == "shots") {
      shots <- .tbf_rows(d[["shotInfos"]])
      .tbf_need_rows(path, shots, "shots (TBF has them from 2025-26)", call)
      .tbf_off_roster(path, .tbf_persons(shots), g$roster, call)
    } else if (kind == "summary") {
      .tbf_check_summary(path, d, g, call)
    } else {
      cats <- .tbf_rows(d[["categories"]])
      .tbf_need_rows(path, cats, "leader categories", call)
      .tbf_off_roster(path, .tbf_persons(unlist(lapply(cats, function(c) .tbf_rows(c[["leaders"]])),
                                               recursive = FALSE)), g$roster, call)
    }
    stamp(body)
  }
}

#' Wrapper short name -> route handler.
#' @noRd
.tbf_handler <- function(short) {
  if (startsWith(short, "leaders_")) return(.tbf_leaders(sub("^leaders_", "", short)))
  switch(short,
    seasons = .tbf_seasons,
    leagues = .tbf_leagues,
    league_seasons = .tbf_league_seasons,
    weeks = .tbf_weeks,
    standings = .tbf_standings,
    schedule = .tbf_schedule,
    daily_matches = .tbf_daily,
    game_header = ,
    game_players = .tbf_game_route("mac-header", "header"),
    player_box = ,
    team_box = .tbf_game_route("mac-istatistik", "stats"),
    pbp = .tbf_game_route("game-flow", "flow"),
    shots = .tbf_game_route("shot-chart", "shots"),
    period_scores = ,
    highlights = .tbf_game_route("mac-ozet", "summary"),
    game_leaders = .tbf_game_route("mac-leader", "leaders"),
    players = .tbf_players,
    player_career = .tbf_profile,
    teams = .tbf_teams,
    team_player_stats = .tbf_team("get-team-detail-statistic", "playersTotal"),
    team_games = .tbf_team("get-team-detail-matches-by-season-and-league", "maclar"),
    team_roster = .tbf_team("get-team-active-player-list-by-season-and-league", ""),
    team_staff = .tbf_team("get-team-detail-team-staff-by-season-and-league", "")
  )
}

#' Fetch + parse one wrapper's route: the exported functions' single body.
#' @noRd
.tbf_wrap <- function(short, params = list(), type = short, call = rlang::caller_env()) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .tbf_handler(short)(params, call)
  df <- .tbf_parse(if (startsWith(short, "leaders_")) "leaders" else short, raw)
  make_hoopR_data(df, type, Sys.time())
}

# ---------------------------------------------------------------------------
# Casts (sportsdataverse-py tbf_parsers._i / _f / _s / _b / _date / _dt / _clock / ...)
# Each takes one JSON value and returns a length-1 value of the column type;
# Date / POSIXct columns are carried as ISO text and converted per column.
# ---------------------------------------------------------------------------

.tbf_scalar <- function(v) !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)

# an id / count from an integer, an integral double or a digit string (never via a float string)
.tbf_i <- function(v) {
  v <- .intl_ascii_digits(v) # full-width digits, as sportsdataverse-py's \d / int() read them
  if (!.tbf_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.double(v)) return(if (is.finite(v) && v == trunc(v)) as.integer(v) else NA_integer_)
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+\\s*$", v, perl = TRUE)) return(as.integer(trimws(v)))
  NA_integer_
}

# a number from a number or a decimal string ("47.62", "71.4%", "3,5")
.tbf_f <- function(v) {
  v <- .intl_ascii_digits(v) # full-width digits, as sportsdataverse-py's \d / int() read them
  if (!.tbf_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+(?:[.,][0-9]+)?%?\\s*$", v, perl = TRUE)) {
    return(as.double(sub(",", ".", sub("%$", "", trimws(v)), fixed = TRUE)))
  }
  NA_real_
}

# a stripped non-empty string (an integral double without ".0")
.tbf_s <- function(v) {
  if (!.tbf_scalar(v) || is.logical(v)) return(NA_character_)
  if (is.double(v)) {
    if (!is.finite(v)) return(NA_character_)
    return(if (v == trunc(v)) sprintf("%.0f", v) else as.character(v))
  }
  t <- trimws(as.character(v), whitespace = "[\\h\\v]")
  if (nzchar(t)) t else NA_character_
}

.tbf_b <- function(v) if (is.logical(v) && length(v) == 1L) v else NA

.tbf_date <- function(v) {
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_character_)
  d <- substr(v, 1L, 10L)
  if (grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", d) && !is.na(as.Date(d, format = "%Y-%m-%d"))) d else NA_character_
}

# an ISO 8601 timestamp without zone -> "YYYY-MM-DD HH:MM:SS(.f)" text
.tbf_dt <- function(v) {
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_character_)
  m <- regmatches(v, regexec("^([0-9]{4}-[0-9]{2}-[0-9]{2})(?:[T ]([0-9]{2}:[0-9]{2})(:[0-9]{2}(?:\\.[0-9]+)?)?)?$",
                             v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_character_)
  out <- paste0(m[2], " ", if (nzchar(m[3])) m[3] else "00:00", if (nzchar(m[4])) m[4] else ":00")
  if (is.na(as.POSIXct(out, tz = .TBF_TZ, format = "%Y-%m-%d %H:%M:%OS"))) NA_character_ else out
}

# "25:19" -> 1519 s; "01:25:20" -> 5120 s
.tbf_clock <- function(v) {
  v <- .intl_ascii_digits(v) # full-width digits, as sportsdataverse-py's \d / int() read them
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*(?:([0-9]+):)?([0-9]+):([0-9]{2})\\s*$", v, perl = TRUE))[[1]]
  if (!length(m)) return(NA_integer_)
  h <- if (nzchar(m[2])) as.integer(m[2]) else 0L
  h * 3600L + as.integer(m[3]) * 60L + as.integer(m[4])
}

# season label "2026-2027" -> its END year 2027
.tbf_end_year <- function(v) {
  v <- .intl_ascii_digits(v) # full-width digits, as sportsdataverse-py's \d / int() read them
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_integer_)
  m <- regmatches(v, regexec("([0-9]{4})\\s*-\\s*([0-9]{4})\\s*$", v, perl = TRUE))[[1]]
  if (length(m)) as.integer(m[3]) else NA_integer_
}

.tbf_side <- function(v) if (isTRUE(v)) "home" else if (isFALSE(v)) "away" else NA_character_

# the home (1) or away (2) half of a running score "34-30"
.tbf_score <- function(v, idx) {
  v <- .intl_ascii_digits(v) # full-width digits, as sportsdataverse-py's \d / int() read them
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*([0-9]+)\\s*-\\s*([0-9]+)\\s*$", v, perl = TRUE))[[1]]
  if (length(m)) as.integer(m[idx + 1L]) else NA_integer_
}

.tbf_action_en <- function(v) {
  if (!(is.character(v) && .tbf_scalar(v))) return(NA_character_)
  hit <- match(v, names(.TBF_ACTIONS))
  if (is.na(hit)) NA_character_ else unname(.TBF_ACTIONS[[hit]])
}

.tbf_cast <- function(type) {
  switch(type,
    integer = .tbf_i, double = .tbf_f, character = .tbf_s, logical = .tbf_b, Date = .tbf_date, POSIXct = .tbf_dt
  )
}

.tbf_fn <- function(fn) {
  switch(fn,
    clock = .tbf_clock, end_year = .tbf_end_year, side = .tbf_side, action_en = .tbf_action_en,
    score_home = function(v) .tbf_score(v, 1L), score_away = function(v) .tbf_score(v, 2L)
  )
}

# ---------------------------------------------------------------------------
# Frames
# ---------------------------------------------------------------------------

# first non-null value among the "|"-separated dotted alternatives of `path`
.tbf_get <- function(row, path) {
  for (alt in strsplit(path, "|", fixed = TRUE)[[1]]) {
    cur <- row
    for (k in strsplit(alt, ".", fixed = TRUE)[[1]]) cur <- if (.tbf_is_obj(cur)) cur[[k]] else NULL
    if (!is.null(cur)) return(cur)
  }
  NULL
}

.tbf_proto <- list(integer = NA_integer_, double = NA_real_, character = NA_character_, logical = NA,
                   Date = NA_character_, POSIXct = NA_character_)

# rows projected through .TBF_TABLES[[short]]: exactly the table's columns and types
.tbf_frame <- function(short, rows) {
  cols <- lapply(.TBF_TABLES[[short]], function(spec) {
    col_type <- spec[[3]]
    proto <- .tbf_proto[[col_type]]
    f <- if (length(spec) > 3L) .tbf_fn(spec[[4]]) else .tbf_cast(col_type)
    has_fn <- length(spec) > 3L
    v <- vapply(rows, function(r) {
      x <- .tbf_get(r, spec[[2]])
      if (has_fn && is.null(x)) proto else f(x)
    }, proto, USE.NAMES = FALSE)
    if (col_type == "Date") v <- as.Date(v, format = "%Y-%m-%d")
    if (col_type == "POSIXct") v <- as.POSIXct(v, tz = .TBF_TZ, format = "%Y-%m-%d %H:%M:%OS")
    v
  })
  names(cols) <- vapply(.TBF_TABLES[[short]], `[[`, "", 1L)
  dplyr::as_tibble(cols)
}

.tbf_req <- function(raw) {
  r <- if (.tbf_is_obj(raw)) raw[["_request"]] else NULL
  if (!(.tbf_is_obj(r) && length(r))) return(list())
  names(r) <- paste0("_", names(r))
  r
}

.tbf_data <- function(raw) if (.tbf_is_obj(raw)) raw[["data"]] else NULL

# {**row, **ctx, **extra}
.tbf_with <- function(ctx, row, ...) {
  for (add in list(ctx, list(...))) for (k in names(add)) row[k] <- list(add[[k]])
  row
}

.tbf_rows_list <- function(raw) {
  ctx <- .tbf_req(raw)
  lapply(.tbf_rows(.tbf_data(raw)), function(r) .tbf_with(ctx, r))
}

.tbf_rows_of <- function(key) {
  force(key)
  function(raw) {
    ctx <- .tbf_req(raw)
    lapply(.tbf_rows(.tbf_obj(.tbf_data(raw))[[key]]), function(r) .tbf_with(ctx, r))
  }
}

.tbf_flat <- function(x) unlist(x, recursive = FALSE)

.tbf_row_builders <- list(
  list = .tbf_rows_list,
  daily_matches = function(raw) {
    ctx <- .tbf_req(raw)
    .tbf_flat(lapply(.tbf_rows(.tbf_data(raw)), function(g) {
      lapply(.tbf_rows(g[["matches"]]), function(m) .tbf_with(ctx, m, `_group` = g[["groupName"]]))
    }))
  },
  standings = function(raw) {
    ctx <- .tbf_req(raw)
    .tbf_flat(lapply(.tbf_rows(.tbf_data(raw)), function(g) lapply(.tbf_rows(g[["standings"]]), function(s) .tbf_with(ctx, s))))
  },
  game_header = function(raw) {
    d <- .tbf_data(raw)
    if (.tbf_is_obj(d) && length(d)) list(.tbf_with(.tbf_req(raw), d)) else list()
  },
  game_players = .tbf_rows_of("players"),
  player_box = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    .tbf_flat(lapply(c("home", "away"), function(side) {
      tp <- ctx[[paste0("_", side, "_team_process_id")]]
      .tbf_flat(lapply(list(list(paste0(side, "TopFive"), TRUE), list(paste0(side, "BenchPlayers"), FALSE)), function(b) {
        lapply(.tbf_rows(d[[b[[1]]]]), function(p) {
          .tbf_with(ctx, p, `_side` = side, `_team_process_id` = tp, `_starter` = b[[2]])
        })
      }))
    }))
  },
  team_box = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    out <- list()
    for (side in c("home", "away")) {
      total <- d[[paste0(side, "TeamTotal")]]
      if (.tbf_is_obj(total) && length(total)) {
        out[[length(out) + 1L]] <- .tbf_with(ctx, total, `_side` = side,
                                             `_team_process_id` = ctx[[paste0("_", side, "_team_process_id")]],
                                             `_stats` = .tbf_obj(d[[paste0(side, "TeamStats")]]))
      }
    }
    out
  },
  pbp = .tbf_rows_of("events"),
  shots = .tbf_rows_of("shotInfos"),
  period_scores = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    .tbf_flat(lapply(c("home", "away"), function(side) {
      lapply(.tbf_rows(d[[paste0(side, "TeamScore")]]), function(p) .tbf_with(ctx, p, `_side` = side))
    }))
  },
  highlights = .tbf_rows_of("matchHighlightStatistics"),
  game_leaders = function(raw) {
    ctx <- .tbf_req(raw)
    .tbf_flat(lapply(.tbf_rows(.tbf_obj(.tbf_data(raw))[["categories"]]), function(cat) {
      leaders <- .tbf_rows(cat[["leaders"]])
      lapply(seq_along(leaders), function(n) {
        .tbf_with(ctx, leaders[[n]], `_category` = .tbf_s(cat[["leaderCategory"]]),
                  `_category_label` = .tbf_s(cat[["leaderCategoryDescription"]]), `_rank` = n)
      })
    }))
  },
  leaders = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    .tbf_flat(lapply(list(c("sum", "total"), c("avg", "average")), function(kk) {
      rows <- .tbf_rows(d[[kk[[1]]]])
      lapply(seq_along(rows), function(n) .tbf_with(ctx, rows[[n]], `_kind` = kk[[2]], `_rank` = n))
    }))
  },
  player_career = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    prof <- .tbf_obj(d[["playerProfile"]])
    lapply(.tbf_rows(d[["careerInfo"]]), function(r) {
      .tbf_with(ctx, r, `_name` = prof[["fullName"]], `_country` = prof[["country"]], `_height` = prof[["height"]])
    })
  },
  team_player_stats = function(raw) {
    ctx <- .tbf_req(raw)
    d <- .tbf_obj(.tbf_data(raw))
    avg <- list()
    for (r in .tbf_rows(d[["playersAverage"]])) {
      k <- .tbf_i(r[["code"]])
      if (!is.na(k)) avg[[as.character(k)]] <- r
    }
    lapply(.tbf_rows(d[["playersTotal"]]), function(r) {
      k <- .tbf_i(r[["code"]])
      .tbf_with(ctx, r, avg = if (is.na(k) || is.null(avg[[as.character(k)]])) .tbf_obj(NULL) else avg[[as.character(k)]])
    })
  },
  team_games = .tbf_rows_of("maclar")
)

#' The `short` tibble of an enveloped body; a typed zero-row tibble for anything unrecognised.
#' @noRd
.tbf_parse <- function(short, raw) {
  builder <- .tbf_row_builders[[short]] %||% .tbf_row_builders[["list"]]
  rows <- tryCatch(builder(raw), error = function(e) list())
  .tbf_frame(short, rows)
}

# ---------------------------------------------------------------------------
# Column specs: GENERATED from sportsdataverse-py tbf_parsers.TABLES / ACTIONS (sportsdataverse-py e3d232e).
# (column, source path, type[, converter]); Turkish text as \u escapes.
# ---------------------------------------------------------------------------

#' Turkish play-by-play action -> English gloss (sportsdataverse-py tbf_parsers.ACTIONS).
#' @noRd
.TBF_ACTIONS <- local({
  # (action, gloss) pairs, named with setNames(): a non-ASCII name written in source is translated
  # to the native encoding and lost in a C locale. Look up with match(), never x[[key]].
  kv <- c(
    "2 Say\u0131 Aniden Durarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT pull-up jump shot made",
    "2 Say\u0131 Aniden Durarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT pull-up jump shot missed",
    "2 Say\u0131 At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT shot made",
    "2 Say\u0131 D\u00f6nerek S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT turnaround jump shot made",
    "2 Say\u0131 D\u00f6nerek S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT turnaround jump shot missed",
    "2 Say\u0131 Geriye Ad\u0131m Atarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT step-back jump shot made",
    "2 Say\u0131 Geriye Ad\u0131m Atarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT step-back jump shot missed",
    "2 Say\u0131 Geriye Do\u011fru S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT fade-away jump shot made",
    "2 Say\u0131 Geriye Do\u011fru S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT fade-away jump shot missed",
    "2 Say\u0131 Havada Kayarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT floater made",
    "2 Say\u0131 Havada Kayarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT floater missed",
    "2 Say\u0131 Sma\u00e7 Ba\u015far\u0131l\u0131", "2PT dunk made",
    "2 Say\u0131 S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT jump shot made",
    "2 Say\u0131 S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT jump shot missed",
    "2 Say\u0131 Ters Turnike Ba\u015far\u0131l\u0131", "2PT reverse layup made",
    "2 Say\u0131 Ters Turnike Ba\u015far\u0131s\u0131z", "2PT reverse layup missed",
    "2 Say\u0131 Tip-In Ba\u015far\u0131l\u0131", "2PT tip-in made",
    "2 Say\u0131 Tip-In Ba\u015far\u0131s\u0131z", "2PT tip-in missed",
    "2 Say\u0131 Top S\u00fcrerek Turnike Ba\u015far\u0131l\u0131", "2PT driving layup made",
    "2 Say\u0131 Top S\u00fcrerek Turnike Ba\u015far\u0131s\u0131z", "2PT driving layup missed",
    "2 Say\u0131 Turnike Ba\u015far\u0131l\u0131", "2PT layup made",
    "2 Say\u0131 Turnike Ba\u015far\u0131s\u0131z", "2PT layup missed",
    "2 Say\u0131 \u00c7engel At\u0131\u015f Ba\u015far\u0131l\u0131", "2PT hook shot made",
    "2 Say\u0131 \u00c7engel At\u0131\u015f Ba\u015far\u0131s\u0131z", "2PT hook shot missed",
    "3 Say\u0131 Aniden Durarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "3PT pull-up jump shot made",
    "3 Say\u0131 Aniden Durarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "3PT pull-up jump shot missed",
    "3 Say\u0131 Geriye Ad\u0131m Atarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "3PT step-back jump shot made",
    "3 Say\u0131 Geriye Ad\u0131m Atarak S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "3PT step-back jump shot missed",
    "3 Say\u0131 S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131l\u0131", "3PT jump shot made",
    "3 Say\u0131 S\u0131\u00e7rayarak At\u0131\u015f Ba\u015far\u0131s\u0131z", "3PT jump shot missed",
    "Asist", "assist",
    "Blok", "block",
    "De\u011fi\u015fiklik Giren", "substitution - player in",
    "De\u011fi\u015fiklik \u00c7\u0131kan", "substitution - player out",
    "Faul", "foul",
    "Faul Yap\u0131lan", "foul drawn",
    "Hava At\u0131\u015f\u0131 - Kaybetti", "jump ball - lost",
    "Hava At\u0131\u015f\u0131 - Kazand\u0131", "jump ball - won",
    "Head Coach Challenge", "head coach's challenge",
    "H\u00fccum Faul", "offensive foul",
    "H\u00fccum Ribaundu", "offensive rebound",
    "Jump Ball - Tutulmu\u015f Top", "jump ball - held ball",
    "Ki\u015fisel Faul", "personal foul",
    "Ko\u00e7 Teknik Faul", "technical foul (coach)",
    "Ma\u00e7 Ba\u015flad\u0131", "game started",
    "Ma\u00e7 Sonu", "game end",
    "Mola", "timeout",
    "Ribaund", "rebound",
    "Savunma Ribaundu", "defensive rebound",
    "Serbest At\u0131\u015f 1/1 Ba\u015far\u0131l\u0131", "free throw 1 of 1 made",
    "Serbest At\u0131\u015f 1/1 Ba\u015far\u0131s\u0131z", "free throw 1 of 1 missed",
    "Serbest At\u0131\u015f 1/2 Ba\u015far\u0131l\u0131", "free throw 1 of 2 made",
    "Serbest At\u0131\u015f 1/2 Ba\u015far\u0131s\u0131z", "free throw 1 of 2 missed",
    "Serbest At\u0131\u015f 1/3 Ba\u015far\u0131l\u0131", "free throw 1 of 3 made",
    "Serbest At\u0131\u015f 1/3 Ba\u015far\u0131s\u0131z", "free throw 1 of 3 missed",
    "Serbest At\u0131\u015f 2/2 Ba\u015far\u0131l\u0131", "free throw 2 of 2 made",
    "Serbest At\u0131\u015f 2/2 Ba\u015far\u0131s\u0131z", "free throw 2 of 2 missed",
    "Serbest At\u0131\u015f 2/3 Ba\u015far\u0131l\u0131", "free throw 2 of 3 made",
    "Serbest At\u0131\u015f 3/3 Ba\u015far\u0131l\u0131", "free throw 3 of 3 made",
    "Serbest At\u0131\u015f 3/3 Ba\u015far\u0131s\u0131z", "free throw 3 of 3 missed",
    "S\u0131k\u0131\u015fm\u0131\u015f Top", "held ball",
    "Tak\u0131m H\u00fccum Ribaundu", "team offensive rebound",
    "Tak\u0131m Savunma Ribaundu", "team defensive rebound",
    "Teknik Faul", "technical foul (player)",
    "Top Kayb\u0131 - 24 Saniye", "turnover - 24-second (shot-clock) violation",
    "Top Kayb\u0131 - 3 Saniye", "turnover - 3-second violation",
    "Top Kayb\u0131 - 5 Saniye", "turnover - 5-second violation",
    "Top Kayb\u0131 - 8 Saniye", "turnover - 8-second violation",
    "Top Kayb\u0131 - Hatal\u0131 Y\u00fcr\u00fcme", "turnover - travelling",
    "Top Kayb\u0131 - H\u00fccum Faul", "turnover - offensive foul",
    "Top Kayb\u0131 - K\u00f6t\u00fc Pas", "turnover - bad pass",
    "Top Kayb\u0131 - Oyun Sahas\u0131 D\u0131\u015f\u0131", "turnover - out of bounds",
    "Top Kayb\u0131 - Top Hakimiyeti", "turnover - ball handling",
    "Top Kayb\u0131 - Yar\u0131 Saha \u0130hlali", "turnover - backcourt violation",
    "Top \u00c7alma", "steal",
    "\u00c7eyrek Ba\u015flad\u0131", "period started",
    "\u00c7eyrek Sonu", "period end"
  )
  stats::setNames(kv[c(FALSE, TRUE)], kv[c(TRUE, FALSE)])
})

#' @noRd
.TBF_TABLES <- list(
  seasons = list(
    list("season_id", "seasonId", "integer"),
    list("season_label", "code", "character"),
    list("season", "code", "integer", "end_year"),
    list("start_date", "startDate", "Date"),
    list("end_date", "endDate", "Date"),
    list("international", "international", "logical")
  ),
  leagues = list(
    list("activity_id", "activityId", "integer"),
    list("name", "name", "character"),
    list("display_name", "displayName", "character"),
    list("competition", "prefixUrl", "character"),
    list("gender", "gender", "character"),
    list("season_id", "seasonId", "integer"),
    list("season_label", "season", "character"),
    list("season", "season", "integer", "end_year"),
    list("sort", "sort", "integer")
  ),
  league_seasons = list(
    list("activity_id", "faaliyet_ID", "integer"),
    list("activity_name", "faaliyet", "character"),
    list("url", "url", "character"),
    list("season_id", "sezon_ID", "integer"),
    list("season_label", "sezon", "character"),
    list("season", "sezon", "integer", "end_year"),
    list("competition", "_competition", "character")
  ),
  weeks = list(
    list("activity_id", "_activity_id", "integer"),
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("week", "sezon_Hafta", "character"),
    list("phase", "devre_ID", "integer"),
    list("phase_name", "devre_Deger", "character"),
    list("label", "display_Text", "character"),
    list("is_current", "isCurrentWeek", "logical")
  ),
  standings = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("group", "grup", "character"),
    list("activity_id", "faaliyetAltAlanId", "integer"),
    list("team_process_id", "takimIslemId", "integer"),
    list("team_name", "takimAdi", "character"),
    list("week", "hafta", "integer"),
    list("rank", "sira", "integer"),
    list("played", "o", "integer"),
    list("won", "g", "integer"),
    list("lost", "m", "integer"),
    list("points_for", "a", "integer"),
    list("points_against", "y", "integer"),
    list("points", "puan", "integer"),
    list("head_to_head_points", "icP", "integer"),
    list("head_to_head_diff", "icA", "integer"),
    list("total_diff", "toA", "integer"),
    list("excluded", "ihrac", "integer")
  ),
  schedule = list(
    list("match_id", "matchId", "integer"),
    list("match_code", "matchCode", "character"),
    list("genius_id", "genuisId", "integer"),
    list("activity_id", "activityId", "integer"),
    list("activity_name", "activityName", "character"),
    list("competition", "activityCode", "character"),
    list("season_id", "seasonId", "integer"),
    list("season_label", "season", "character"),
    list("season", "season", "integer", "end_year"),
    list("tipoff", "matchDate", "POSIXct"),
    list("match_date", "matchDateOnly", "Date"),
    list("week", "week", "character"),
    list("phase", "halfValue", "integer"),
    list("status_id", "matchStatusId", "integer"),
    list("home_team_process_id", "homeTeam.id", "integer"),
    list("home_team", "homeTeam.name", "character"),
    list("home_score", "homeTeam.score", "integer"),
    list("away_team_process_id", "awayTeam.id", "integer"),
    list("away_team", "awayTeam.name", "character"),
    list("away_score", "awayTeam.score", "integer"),
    list("venue", "salonAdi|venueName", "character"),
    list("province", "il", "character"),
    list("gender", "cinsiyet", "character"),
    list("broadcast_channel", "broadcastChannel", "character"),
    list("has_overtime", "hasUzatma", "logical")
  ),
  daily_matches = list(
    list("group_name", "_group", "character"),
    list("match_id", "matchId", "integer"),
    list("match_code", "matchCode", "character"),
    list("genius_id", "genuisId", "integer"),
    list("activity_id", "activityId", "integer"),
    list("activity_name", "activityName", "character"),
    list("competition", "activityCode", "character"),
    list("season_id", "seasonId", "integer"),
    list("season_label", "season", "character"),
    list("season", "season", "integer", "end_year"),
    list("tipoff", "matchDate", "POSIXct"),
    list("match_date", "matchDateOnly", "Date"),
    list("week", "week", "character"),
    list("phase", "halfValue", "integer"),
    list("status_id", "matchStatusId", "integer"),
    list("home_team_process_id", "homeTeam.id", "integer"),
    list("home_team", "homeTeam.name", "character"),
    list("home_score", "homeTeam.score", "integer"),
    list("away_team_process_id", "awayTeam.id", "integer"),
    list("away_team", "awayTeam.name", "character"),
    list("away_score", "awayTeam.score", "integer"),
    list("venue", "salonAdi|venueName", "character"),
    list("province", "il", "character"),
    list("gender", "cinsiyet", "character"),
    list("broadcast_channel", "broadcastChannel", "character"),
    list("has_overtime", "hasUzatma", "logical"),
    list("status", "matchStatus", "character")
  ),
  game_header = list(
    list("match_id", "_match_id", "integer"),
    list("match_code", "matchCode", "character"),
    list("genius_id", "genuisId", "integer"),
    list("activity_id", "faaliyetId", "integer"),
    list("activity_name", "faaliyetAdi", "character"),
    list("season_id", "seasonId", "integer"),
    list("season_label", "seasonName", "character"),
    list("season", "seasonName", "integer", "end_year"),
    list("tipoff", "matchDateTime", "POSIXct"),
    list("status_id", "matchStatusId", "integer"),
    list("status", "matchStatus", "character"),
    list("venue", "location", "character"),
    list("attendance", "matchSpectatorCount", "integer"),
    list("has_overtime", "hasUzatma", "logical"),
    list("broadcast_channel", "matchBroadcastChannel", "character"),
    list("home_team_process_id", "homeTeamProcessId", "integer"),
    list("home_team", "homeTeam.teamName", "character"),
    list("home_coach", "homeTeam.coachName", "character"),
    list("home_score", "homeTeamScore", "integer"),
    list("away_team_process_id", "awayTeamProcessId", "integer"),
    list("away_team", "awayTeam.teamName", "character"),
    list("away_coach", "awayTeam.coachName", "character"),
    list("away_score", "awayTeamScore", "integer"),
    list("referee", "mainReferee", "character"),
    list("first_assistant_referee", "firstAssistantReferee", "character"),
    list("second_assistant_referee", "secondAssistantReferee", "character"),
    list("commissioner", "temsilciAdi", "character")
  ),
  game_players = list(
    list("match_id", "_match_id", "integer"),
    list("side", "isHome", "character", "side"),
    list("team", "teamName", "character"),
    list("player_name", "playerName", "character"),
    list("jersey_number", "jerseyNumber", "character"),
    list("is_starter", "isStarter", "logical"),
    list("is_active", "isActive", "logical")
  ),
  player_box = list(
    list("match_id", "_match_id", "integer"),
    list("side", "_side", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("player_id", "playerId", "integer"),
    list("player_name", "playerName", "character"),
    list("jersey_number", "jerseyNumber", "character"),
    list("is_starter", "_starter", "logical"),
    list("seconds_played", "minutesPlayed", "integer", "clock"),
    list("points", "points", "integer"),
    list("fg_made", "successfulShots", "integer"),
    list("fg_attempted", "shotAttempts", "integer"),
    list("fg_pct", "shotPercentage", "integer"),
    list("fg2_made", "twoPointShots", "integer"),
    list("fg2_attempted", "twoPointShotAttempts", "integer"),
    list("fg2_pct", "twoPointPercentage", "integer"),
    list("fg3_made", "threePointShots", "integer"),
    list("fg3_attempted", "threePointShotAttempts", "integer"),
    list("fg3_pct", "threePointPercentage", "integer"),
    list("ft_made", "freeThrows", "integer"),
    list("ft_attempted", "freeThrowAttempts", "integer"),
    list("ft_pct", "freeThrowPercentage", "integer"),
    list("off_rebounds", "offensiveRebounds", "integer"),
    list("def_rebounds", "defensiveRebounds", "integer"),
    list("rebounds", "totalRebounds", "integer"),
    list("assists", "assists", "integer"),
    list("steals", "steals", "integer"),
    list("blocks", "blocks", "integer"),
    list("turnovers", "turnovers", "integer"),
    list("fouls", "fouls", "integer"),
    list("fouls_drawn", "rivalFoul", "integer"),
    list("blocks_received", "blocksReceived", "integer"),
    list("plus_minus", "plusMinus", "integer"),
    list("efficiency", "efficiency", "integer")
  ),
  team_box = list(
    list("match_id", "_match_id", "integer"),
    list("side", "_side", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("seconds_played", "minutesPlayed", "integer", "clock"),
    list("points", "points", "integer"),
    list("fg_made", "successfulShots", "integer"),
    list("fg_attempted", "shotAttempts", "integer"),
    list("fg_pct", "shotPercentage", "integer"),
    list("fg2_made", "twoPointShots", "integer"),
    list("fg2_attempted", "twoPointShotAttempts", "integer"),
    list("fg2_pct", "twoPointPercentage", "integer"),
    list("fg3_made", "threePointShots", "integer"),
    list("fg3_attempted", "threePointShotAttempts", "integer"),
    list("fg3_pct", "threePointPercentage", "integer"),
    list("ft_made", "freeThrows", "integer"),
    list("ft_attempted", "freeThrowAttempts", "integer"),
    list("ft_pct", "freeThrowPercentage", "integer"),
    list("off_rebounds", "offensiveRebounds", "integer"),
    list("def_rebounds", "defensiveRebounds", "integer"),
    list("rebounds", "totalRebounds", "integer"),
    list("assists", "assists", "integer"),
    list("steals", "steals", "integer"),
    list("blocks", "blocks", "integer"),
    list("turnovers", "turnovers", "integer"),
    list("fouls", "fouls", "integer"),
    list("fouls_drawn", "rivalFoul", "integer"),
    list("blocks_received", "blocksReceived", "integer"),
    list("efficiency", "efficiency", "integer"),
    list("team_off_rebounds", "_stats.offensiveRebounds", "integer"),
    list("team_def_rebounds", "_stats.defensiveRebounds", "integer"),
    list("team_rebounds", "_stats.totalRebounds", "integer"),
    list("team_turnovers", "_stats.turnovers", "integer"),
    list("team_fouls", "_stats.fouls", "integer")
  ),
  pbp = list(
    list("match_id", "_match_id", "integer"),
    list("action_number", "actionNumber", "integer"),
    list("period", "quarterNumber", "integer"),
    list("period_type", "periodType", "integer"),
    list("clock", "time", "character"),
    list("seconds_remaining", "time", "integer", "clock"),
    list("home_score", "score", "integer", "score_home"),
    list("away_score", "score", "integer", "score_away"),
    list("side", "isHome", "character", "side"),
    list("player_name", "playerName", "character"),
    list("jersey_number", "jerseyNumber", "character"),
    list("action", "action", "character"),
    list("action_en", "action", "character", "action_en")
  ),
  shots = list(
    list("match_id", "_match_id", "integer"),
    list("period", "period", "integer"),
    list("period_type", "periodType", "integer"),
    list("side", "isHome", "character", "side"),
    list("shot_player_id", "playerId", "integer"),
    list("player_name", "playerName", "character"),
    list("jersey_number", "jerseyNumber", "character"),
    list("x", "x", "integer"),
    list("y", "y", "integer"),
    list("made", "isSucceed", "logical")
  ),
  period_scores = list(
    list("match_id", "_match_id", "integer"),
    list("side", "_side", "character"),
    list("period", "quarter", "integer"),
    list("period_type", "periodType", "integer"),
    list("points", "score", "integer")
  ),
  highlights = list(
    list("match_id", "_match_id", "integer"),
    list("title", "title", "character"),
    list("category", "leaderCategory", "character"),
    list("home_value", "homeValue", "character"),
    list("away_value", "awayValue", "character"),
    list("home_number", "homeValue", "double"),
    list("away_number", "awayValue", "double")
  ),
  game_leaders = list(
    list("match_id", "_match_id", "integer"),
    list("category", "_category", "character"),
    list("category_label", "_category_label", "character"),
    list("rank", "_rank", "integer"),
    list("side", "isHome", "character", "side"),
    list("player_id", "playerId", "integer"),
    list("player_name", "playerName", "character"),
    list("jersey_number", "jerseyNumber", "character"),
    list("value", "value", "double")
  ),
  players = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("person_id", "kisiID", "integer"),
    list("player_name", "adiSoyadi", "character"),
    list("nationality", "tabiyet", "character"),
    list("nationality_code", "tabiyetK\u0131sa", "character"),
    list("club_id", "takimID", "integer"),
    list("team_name", "takimAdi", "character"),
    list("jersey_number", "formaNo", "character"),
    list("prefix", "prefix", "character"),
    list("season_id", "seasonId", "integer")
  ),
  player_career = list(
    list("person_id", "_player_id", "integer"),
    list("player_name", "_name", "character"),
    list("nationality", "_country", "character"),
    list("height_cm", "_height", "integer"),
    list("season_label", "seasonCode", "character"),
    list("season", "seasonCode", "integer", "end_year"),
    list("team_name", "teamName", "character"),
    list("activity_name", "activityName", "character"),
    list("activity_type_id", "faaliyetTuruId", "integer"),
    list("activity_id", "faaliyetAltAlaniId", "integer"),
    list("games", "matchCount", "integer"),
    list("seconds_played", "formattedTotalSeconds", "integer", "clock"),
    list("points", "totalPoints", "integer"),
    list("assists", "assists", "integer"),
    list("fg_made", "fieldGoalsMade", "integer"),
    list("fg_attempted", "fieldGoalsAttempted", "integer"),
    list("fg3_made", "threePointsMade", "integer"),
    list("fg3_attempted", "threePointsAttempted", "integer"),
    list("ft_made", "freeThowsMade", "integer"),
    list("ft_attempted", "freeThowsAttempted", "integer"),
    list("off_rebounds", "offensiveRebounds", "integer"),
    list("def_rebounds", "defensiveRebounds", "integer"),
    list("rebounds", "rebounds", "integer"),
    list("steals", "steals", "integer"),
    list("turnovers", "tournovers", "integer"),
    list("blocks", "blocks", "integer"),
    list("fouls", "fauls", "integer"),
    list("efficiency", "playerEfficiency", "integer"),
    list("fouls_drawn", "yapilanFaul", "integer"),
    list("blocks_received", "yenilenBlok", "integer")
  ),
  leaders = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("category", "_category", "character"),
    list("kind", "_kind", "character"),
    list("rank", "_rank", "integer"),
    list("person_id", "oyuncuKodu", "integer"),
    list("player_name", "oyuncuAdi", "character"),
    list("team_process_id", "takimKodu", "integer"),
    list("team_name", "takimAdi", "character"),
    list("games", "macSayisi", "integer"),
    list("value", "grup", "double")
  ),
  teams = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("team_process_id", "teamProcessId", "integer"),
    list("club_id", "teamId", "integer"),
    list("team_name", "teamName", "character"),
    list("city", "teamCityName", "character"),
    list("code", "teamCode", "character"),
    list("season_id", "seasonId", "integer"),
    list("season_label", "season", "character")
  ),
  team_player_stats = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("person_id", "code", "integer"),
    list("jersey_number", "oyuncuNo", "character"),
    list("first_name", "firstName", "character"),
    list("last_name", "lastName", "character"),
    list("games", "macSayisi", "integer"),
    list("seconds_played", "sureToplam", "integer", "clock"),
    list("points", "sayiToplam", "integer"),
    list("fg_made", "agBasarili", "integer"),
    list("fg_attempted", "agDeneme", "integer"),
    list("fg2_made", "puan20Toplam", "integer"),
    list("fg2_attempted", "puan21Toplam", "integer"),
    list("fg3_made", "puan30Toplam", "integer"),
    list("fg3_attempted", "puan31Toplam", "integer"),
    list("ft_made", "sA0Toplam", "integer"),
    list("ft_attempted", "sA1Toplam", "integer"),
    list("def_rebounds", "drToplam", "integer"),
    list("off_rebounds", "hrToplam", "integer"),
    list("rebounds", "trToplam", "integer"),
    list("assists", "asistToplam", "integer"),
    list("blocks", "blokToplam", "integer"),
    list("steals", "topCalmaToplam", "integer"),
    list("turnovers", "topKaybiToplam", "integer"),
    list("fouls", "faulToplam", "integer"),
    list("plus_minus", "oyunaKatki", "double"),
    list("efficiency", "vpToplam", "integer"),
    list("fg_pct", "agYuzdesi", "double"),
    list("fg2_pct", "ikilikYuzdesi", "double"),
    list("fg3_pct", "uclukYuzdesi", "double"),
    list("ft_pct", "serbestAtisYuzdesi", "double"),
    list("seconds_per_game", "avg.sureOrtalama", "integer", "clock"),
    list("points_per_game", "avg.sayiOrtalama", "double"),
    list("rebounds_per_game", "avg.trOrtalama", "double"),
    list("assists_per_game", "avg.asistOrtalama", "double"),
    list("steals_per_game", "avg.topCalmaOrtalama", "double"),
    list("blocks_per_game", "avg.blokOrtalama", "double"),
    list("turnovers_per_game", "avg.topKaybiOrtalama", "double"),
    list("efficiency_per_game", "avg.vpOrtalama", "double")
  ),
  team_games = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("match_id", "matchId", "integer"),
    list("match_code", "matchCode", "character"),
    list("tipoff", "tarih", "POSIXct"),
    list("week", "formattedWeek", "character"),
    list("city", "sehir", "character"),
    list("venue", "salon", "character"),
    list("home_team_process_id", "takimAId", "integer"),
    list("home_team", "takimA", "character"),
    list("home_score", "skorA", "integer"),
    list("away_team_process_id", "takimBId", "integer"),
    list("away_team", "takimB", "character"),
    list("away_score", "skorB", "integer"),
    list("team_is_home", "isHome", "logical"),
    list("team_won", "isWin", "logical"),
    list("is_played", "isPlayed", "logical"),
    list("status", "durum", "character"),
    list("status_id", "durumId", "integer"),
    list("has_overtime", "hasUzatma", "logical")
  ),
  team_roster = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("person_id", "personId", "integer"),
    list("first_name", "firstName", "character"),
    list("last_name", "lastName", "character"),
    list("nationality", "country", "character"),
    list("height_cm", "height", "integer"),
    list("jersey_number", "jerseyNo", "character"),
    list("games", "macSayisi", "integer"),
    list("seconds_played", "sure", "integer", "clock"),
    list("points_per_game", "sayi", "double"),
    list("efficiency_per_game", "verimlilikPuani", "double")
  ),
  team_staff = list(
    list("season", "_season", "integer"),
    list("competition", "_competition", "character"),
    list("team_process_id", "_team_process_id", "integer"),
    list("person_id", "code", "integer"),
    list("first_name", "firstName", "character"),
    list("last_name", "lastName", "character"),
    list("role", "job", "character"),
    list("role_code", "subRolesCode", "integer")
  )
)
