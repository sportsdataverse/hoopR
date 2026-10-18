# sportality_runtime.R -- transport, season mapping and answer checks of the Basketligaen wrappers.
#
# R mirror of sdv-py sportsdataverse/basketball/dbl/sportality_runtime.py (origin/main e3d232e).
# Basketligaen (Denmark) runs on the Sportality platform; the stats are `genius-basketball`, a
# relay of Genius Sports LiveStats. The API is keyless JSON:
#
# * Seasons are ssgts (season + series + game type). The wrappers take the END year plus a
#   `game_type` (`regular`, or `finals` for the playoffs); `.sportality_get()` maps the pair through
#   `/statistics-v2/layout-info` (fetched once per R session) to `ssgtUuid` for stats-info, to
#   `seasonSeriesGameType` for the match-day routes, and to the `seasonUuid` / `seriesUuid` /
#   `gameTypeUuid` that game-schedule needs. A season or game type layout-info does not list is
#   `hoopR_no_data`.
# * stats-info truncates silently: `count=1000` is always sent, and rows reaching the count or
#   differing from `totalCount` are `hoopR_asset_fetch`. An unknown module answers the games
#   table with HTTP 200, so a table without the module's columns is refused.
# * gameday/* starts in 2023/24: an EMPTY 200 body there is `hoopR_no_data`.
# * Refusals (the refs capture's gates): an error envelope or non-JSON 200 -> `hoopR_asset_fetch`;
#   `{}` / `[]` or a table with no rows -> `hoopR_no_data`; a body for another game, team,
#   athlete or ssgt, or one without the field that would show it -> `hoopR_asset_fetch`; an
#   unfinished game or a truncated play-by-play feed -> `hoopR_asset_fetch`.
# * A 500 is this API's answer for an unknown uuid; it is not retried (`retry_500 = FALSE`).
# * One text route: `/sports-v2/ssgt/{ssgt}/provider` answers a bare word.
# * Personal data (birth dates, e-mail, phone, address, contact) is removed from every body.

#' @noRd
.SPORTALITY_BASE <- "https://www.basketligaen.dk/api"
#' @noRd
.SPORTALITY_GAME_TYPES <- c("regular", "finals")
#' stats-info page size; without it the API serves 50 rows.
#' @noRd
.SPORTALITY_STATS_COUNT <- 1000L
#' layout-info lists 49 ssgts of 25 seasons; far fewer means a cut or foreign body.
#' @noRd
.SPORTALITY_MIN_SSGTS <- 40L
#' @noRd
.SPORTALITY_MIN_FILTER_SEASONS <- 20L
#' @noRd
.SPORTALITY_ERROR_KEYS <- c("error", "errors", "message", "code", "detail", "status", "statusCode")

#' Route (path below /api, ids as `[^/]+`) -> pluck path of the rows that must be present.
#' @noRd
.SPORTALITY_ROWS <- c(
  "/sports-v2/season-series-game-types-filter" = "season[]",
  "/statistics-v2/layout-info" = "[].seasonSeriesGameTypeTeams[]",
  "/sports-v2/game-schedule" = "gameInfo[]",
  "/sports-v2/game-info/[^/]+" = "gameInfo",
  "/sports-v2/teams/[^/]+" = "",
  "/sports-v2/athletes/by-team-uuid/[^/]+" = "[].players[]",
  "/sports-v2/athlete-details/[^/]+" = "athleteData",
  "/sports-v2/all-sites/[^/]+" = "[]",
  "/sports-v2/played-games/[^/]+" = "playedGames[]",
  "/sports-v2/upcoming-games/[^/]+" = "upcomingGames[]",
  "/sports-v2/last-game-day" = "games[]",
  "/sports-v2/next-game-day" = "games[]",
  "/gameday/play-by-play/[^/]+" = "[]",
  "/gameday/boxscore/[^/]+" = "stats.*[]",
  "/gameday/player-stats/[^/]+" = "stats.*[]",
  "/gameday/team-stats/[^/]+" = "home",
  "/gameday/game-info/[^/]+" = "teamPeriod.stats[]",
  "/gameday/game-overview/[^/]+" = "homeTeam",
  "/gameday/team-standings/[^/]+" = "leagueStandings[]",
  "/gameday/post-game-data/team-stats/[^/]+" = "stats[]",
  "/statistics-v2/stats-info/[^/]+" = "[].stats[]",
  "/statistics-v2/athlete/profile-page" = "",
  "/statistics-v2/athlete/playerProfile_gameLog" = "[].stats[]",
  "/statistics-v2/player-h2h-v2/[^/]+/[^/]+/[^/]+" = "players[]"
)

#' Route -> fields that must echo the request: `c(<pluck path> = <where the id is>)`; "path" = the
#' last path segment, "ssgt" = the ssgt this call resolved, "playerUuid" = that query parameter,
#' "path1" / "path2" = the last but one / last segment.
#' @noRd
.SPORTALITY_SCOPE <- list(
  "/sports-v2/game-schedule" = c(ssgtUuid = "ssgt", "gameInfo[].ssgtUuid" = "ssgt"),
  "/sports-v2/game-info/[^/]+" = c(gameInfo.gameUuid = "path"),
  "/sports-v2/teams/[^/]+" = c(uuid = "path"),
  "/sports-v2/athlete-details/[^/]+" = c(athleteData.uuid = "path"),
  "/sports-v2/last-game-day" = c("games[].ssgtUuid" = "ssgt"),
  "/sports-v2/next-game-day" = c("games[].ssgtUuid" = "ssgt"),
  "/gameday/play-by-play/[^/]+" = c("[].gameUuid" = "path"),
  "/gameday/team-stats/[^/]+" = c(home.gameUuid = "path", away.gameUuid = "path"),
  "/gameday/game-overview/[^/]+" = c(gameUuid = "path", homeTeam.gameUuid = "path", awayTeam.gameUuid = "path"),
  "/statistics-v2/athlete/profile-page" = c(uuid = "playerUuid"),
  "/statistics-v2/player-h2h-v2/[^/]+/[^/]+/[^/]+" = c(homeTeamUuid = "path1", awayTeamUuid = "path2")
)

#' Columns each stats-info module group must carry (an unknown module answers the games table).
#' @noRd
.SPORTALITY_STATS_NEED <- list(
  players = c("Rank", "Player", "Team"),
  teams = c("Rank", "Team"),
  standings = c("Rank", "GP", "W", "L"),
  games = c("DateTime", "homeTeam", "awayTeam")
)

#' Routes whose `season` (END year) + `gameType` are mapped to the provider's ssgt keys.
#' @noRd
.SPORTALITY_SEASON_ROUTES <- c(
  "/statistics-v2/stats-info/[^/]+", "/sports-v2/game-schedule", "/sports-v2/last-game-day",
  "/sports-v2/next-game-day"
)

# the layout-info directory, once per session
.sportality_cache <- new.env(parent = emptyenv())

#' JSON object (a named list, `{}` included) vs JSON array (an unnamed list).
#' @noRd
.sportality_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.sportality_is_array <- function(x) is.list(x) && is.null(names(x))
#' `x` when it is a JSON object, else `{}` (a malformed body reads as absent).
#' @noRd
.sportality_dict <- function(x) if (.sportality_is_dict(x)) x else stats::setNames(list(), character())
#' `x` when it is a JSON array, else `[]`.
#' @noRd
.sportality_list <- function(x) if (.sportality_is_array(x)) x else list()
#' A single non-NA string.
#' @noRd
.sportality_is_str <- function(x) is.character(x) && length(x) == 1L && !is.na(x)

#' `x` without personal data: birth dates, e-mail, phone, address and contact keys, at any depth.
#' @noRd
.sportality_scrub <- function(x) {
  if (!is.list(x)) return(x)
  if (.sportality_is_dict(x)) {
    keep <- !grepl("(birth|^dob$|e_?mail|phone|mobile|^tel$|address|^contact)", names(x), ignore.case = TRUE)
    x <- x[keep]
  }
  for (i in seq_along(x)) if (is.list(x[[i]])) x[i] <- list(.sportality_scrub(x[[i]]))
  x
}

#' The `.SPORTALITY_ROWS`-style key whose pattern matches `url`'s path below `/api`.
#' @noRd
.sportality_route <- function(url, keys) {
  path <- sub("/+$", "", sub("^[^/]*//[^/]*/api", "", sub("[?#].*$", "", url)))
  for (k in keys) if (grepl(paste0("^", k, "$"), path, perl = TRUE)) return(k)
  NULL
}

#' Values at a dotted path: `[]` walks an array, `*` an object's values, `""` = the body; nulls skipped.
#' @noRd
.sportality_pluck <- function(body, path) {
  parts <- strsplit(gsub("[]", ".[]", path, fixed = TRUE), ".", fixed = TRUE)[[1]]
  cur <- list(body)
  for (part in parts[nzchar(parts)]) {
    nxt <- list()
    for (c in cur) {
      if (part == "[]") {
        if (.sportality_is_array(c)) nxt <- c(nxt, c)
      } else if (part == "*") {
        if (.sportality_is_dict(c)) nxt <- c(nxt, unname(c))
      } else if (.sportality_is_dict(c) && !is.null(c[[part]])) {
        nxt[[length(nxt) + 1L]] <- c[[part]]
      }
    }
    cur <- nxt
  }
  cur
}

#' Python `_strict()`: equal values of the same type (`"5"` is not `5`); two absent values agree.
#' @noRd
.sportality_strict <- function(a, b) {
  if (is.null(a) || is.null(b)) return(is.null(a) && is.null(b))
  identical(typeof(a), typeof(b)) && identical(a, b)
}

#' Python `str()` of a scalar id, for messages and set membership.
#' @noRd
.sportality_str <- function(x) {
  if (is.null(x)) return("None")
  if (is.list(x) || length(x) != 1L) return(paste(format(x), collapse = ","))
  if (is.logical(x)) return(if (isTRUE(x)) "True" else "False")
  as.character(x)
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

#' GET a JSON route politely (a 500 is not retried); an empty gameday body is `hoopR_no_data`.
#' @noRd
.sportality_fetch <- function(url, query = list(), call = rlang::caller_env()) {
  where <- .intl_where(url)
  text <- .intl_get(url, query = Filter(Negate(is.null), query), retry_500 = FALSE, call = call)
  if (grepl("/gameday/", url, fixed = TRUE) && !nzchar(trimws(text))) {
    .abort_no_data(
      "{where} answered an empty body: an unknown game, or a game before 2023/24 (gameday data starts there).",
      call = call
    )
  }
  .sportality_scrub(.intl_json(text, where, call = call))
}

# ---------------------------------------------------------------------------
# Season -> ssgt
# ---------------------------------------------------------------------------

#' `list(entries = <"END|game type" -> ids + teams>, active = <active ssgt>)` from one layout-info
#' call, cached for the session.
#' @noRd
.sportality_directory <- function(call = rlang::caller_env()) {
  if (!is.null(.sportality_cache$directory)) return(.sportality_cache$directory)
  url <- paste0(.SPORTALITY_BASE, "/statistics-v2/layout-info")
  raw <- .sportality_fetch(url, call = call)
  body <- if (.sportality_is_array(raw) && length(raw) && .sportality_is_dict(raw[[1]])) raw[[1]] else list()
  out <- list()
  for (s in .sportality_list(body$seasonSeriesGameTypeTeams)) {
    if (!.sportality_is_dict(s)) next
    season <- .sportality_dict(s$season)
    code <- if (is.null(season$code)) "" else .sportality_str(season$code)
    gtype <- .sportality_dict(s$gameType)$code
    if (grepl("^[0-9]+$", code) && !is.null(gtype) && !identical(gtype, "") && !is.null(s$ssgtUuid)) {
      teams <- Filter(.sportality_is_dict, .sportality_list(s$teams))
      ids <- function(k) unique(vapply(Filter(function(t) !is.null(t[[k]]) && !identical(t[[k]], ""), teams),
                                       function(t) .sportality_str(t[[k]]), character(1)))
      uuid <- function(x) if (is.null(x)) "" else .sportality_str(x)
      out[[paste0(as.integer(code) + 1L, "|", .sportality_str(gtype))]] <- list(
        ssgt = .sportality_str(s$ssgtUuid),
        season = uuid(season$uuid),
        series = uuid(.sportality_dict(s$series)$uuid),
        game_type = uuid(.sportality_dict(s$gameType)$uuid),
        start_year = as.integer(code),
        teams = ids("uuid"),
        instances = ids("instanceId")
      )
    }
  }
  if (length(out) < .SPORTALITY_MIN_SSGTS) {
    where <- .intl_where(url)
    n <- length(out)
    .abort_asset_fetch("{where}: {n} ssgts in the body, expected the {(.SPORTALITY_MIN_SSGTS)}+ of 25 seasons.",
                       call = call)
  }
  active <- .sportality_dict(body$ssgtDefaultValue)$ssgtUuid
  .sportality_cache$directory <- list(entries = out, active = if (is.null(active)) "" else .sportality_str(active))
  .sportality_cache$directory
}

#' The directory entry of an ssgt uuid, or `NULL`.
#' @noRd
.sportality_by_ssgt <- function(ssgt, call = rlang::caller_env()) {
  if (is.null(ssgt)) return(NULL)
  for (e in .sportality_directory(call)$entries) if (identical(e$ssgt, ssgt)) return(e)
  NULL
}

#' A season END year as an integer; anything else is `hoopR_bad_request`.
#' @noRd
.sportality_season <- function(season, call = rlang::caller_env()) {
  n <- suppressWarnings(if (is.character(season)) as.numeric(trimws(season)) else season)
  if (length(season) != 1L || is.logical(season) || !is.numeric(n) || is.na(n) || n != trunc(n)) {
    shown <- .sportality_str(season)
    .abort_bad_request("season must be an END year such as 2026; got {.val {shown}}.", call = call)
  }
  as.integer(n)
}

#' The uuids of (END-year `season`, `game_type`); `hoopR_no_data` when layout-info has none.
#' @noRd
.sportality_resolve <- function(season, game_type, call = rlang::caller_env()) {
  gtype <- if (is.null(game_type) || identical(game_type, "")) "regular" else as.character(game_type)
  season <- .sportality_season(season, call)
  dir <- .sportality_directory(call)$entries
  key <- paste0(season, "|", gtype)
  if (is.null(dir[[key]])) {
    split <- strsplit(names(dir), "|", fixed = TRUE)
    seasons <- range(as.integer(vapply(split, `[[`, "", 1L)))
    types <- paste(sort(unique(vapply(split, `[[`, "", 2L))), collapse = ", ")
    .abort_no_data(
      paste0("Basketligaen lists no {gtype} ssgt for season {season} (END year); layout-info covers ",
             "{seasons[1]}-{seasons[2]} with game types {types}."),
      call = call
    )
  }
  dir[[key]]
}

#' Rewrite the wrappers' `season` / `gameType` into the provider's keys: `list(query =, ssgt =)`.
#' @noRd
.sportality_map_query <- function(route, query, call = rlang::caller_env()) {
  q <- query
  if (is.null(route) || !route %in% .SPORTALITY_SEASON_ROUTES) return(list(query = q, ssgt = NULL))
  season <- q$season
  gtype <- q$gameType
  q$season <- NULL
  q$gameType <- NULL
  if (route == "/statistics-v2/stats-info/[^/]+") {
    if (!is.null(season)) q["ssgtUuid"] <- list(.sportality_resolve(season, gtype, call)$ssgt)
    q["count"] <- list(.SPORTALITY_STATS_COUNT)
    return(list(query = q, ssgt = q$ssgtUuid))
  }
  if (route == "/sports-v2/game-schedule") {
    if (is.null(season)) return(list(query = q, ssgt = NULL))
    ids <- .sportality_resolve(season, gtype, call)
    q[c("seasonUuid", "seriesUuid", "gameTypeUuid")] <- list(ids$season, ids$series, ids$game_type)
    return(list(query = q, ssgt = ids$ssgt))
  }
  if (!is.null(season)) { # last-game-day / next-game-day
    q["seasonSeriesGameType"] <- list(.sportality_resolve(season, gtype, call)$ssgt)
  } else if (is.null(q$seasonSeriesGameType) || identical(q$seasonSeriesGameType, "")) {
    q["seasonSeriesGameType"] <- list(.sportality_directory(call)$active) # the active ssgt
  }
  list(query = q, ssgt = q$seasonSeriesGameType)
}

# ---------------------------------------------------------------------------
# Answer checks
# ---------------------------------------------------------------------------

#' @noRd
.sportality_refuse <- function(where, why, call) .abort_asset_fetch("{where}: {why}", call = call)

#' One team-totals row per side, every player row in its own side's `players` map, nobody on both sides.
#' @noRd
.sportality_check_box <- function(where, raw, call) {
  seen <- list()
  raw <- .sportality_dict(raw)
  sides <- c(homeTeamValue = "home", awayTeamValue = "away")
  for (key in names(sides)) {
    side <- sides[[key]]
    rows <- Filter(.sportality_is_dict, .sportality_list(.sportality_dict(raw$stats)[[key]]))
    label <- function(r) .sportality_dict(r$info)$label
    totals <- Filter(function(r) identical(label(r), "sports.stats.team_totals"), rows)
    if (length(totals) != 1L) {
      .sportality_refuse(where, paste0(key, " has ", length(totals), " team_totals rows, expected 1"), call)
    }
    got <- .sportality_dict(totals[[1]]$info)$side
    if (!identical(got, side)) {
      .sportality_refuse(where, paste0("the ", key, " totals row is for side '", .sportality_str(got), "'"), call)
    }
    roster <- .sportality_dict(.sportality_dict(raw$players)[[key]])
    if (!length(roster)) .sportality_refuse(where, paste0("no players map for ", key), call)
    ids <- names(roster)
    players <- Filter(function(r) {
      pid <- .sportality_dict(r$info)$playerId
      !is.null(pid) && !identical(pid, "")
    }, rows)
    if (!length(players)) .sportality_refuse(where, paste0(key, " has no player rows"), call)
    for (r in players) {
      pid <- .sportality_str(.sportality_dict(r$info)$playerId)
      if (!pid %in% ids) {
        .sportality_refuse(where, paste0("a ", key, " row of player ", pid, " is not in the ", key,
                                         " players map: a different game's body"), call)
      }
    }
    seen[[side]] <- ids
  }
  if (length(intersect(seen$home, seen$away))) .sportality_refuse(where, "a player is on both sides of the box score", call)
}

#' A whole, finished feed of one game: ids agree, no player on both teams, the game-end line is newest.
#' @noRd
.sportality_check_pbp <- function(where, raw, call) {
  if (!.sportality_is_array(raw)) .sportality_refuse(where, "play-by-play is not a list of events", call)
  events <- Filter(.sportality_is_dict, raw)
  n_ids <- length(unique(vapply(events, function(e) .sportality_str(e$gameSourceId), character(1))))
  if (n_ids != 1L) {
    .sportality_refuse(where, paste0("the events name ", n_ids, " Genius match ids: not one game's feed"), call)
  }
  side_of <- character()
  for (e in raw) {
    et <- .sportality_dict(e$eventTeam)
    if (!length(et)) next
    place <- et$place
    block <- .sportality_dict(e[[if (identical(place, "home")) "homeTeam" else "awayTeam"]])
    if (!.sportality_strict(et$teamId, block$teamId)) {
      .sportality_refuse(where, paste0("eventTeam '", .sportality_str(place), "' has teamId '", .sportality_str(et$teamId),
                                       "', the ", .sportality_str(place), " block '", .sportality_str(block$teamId), "'"), call)
    }
    pid <- .sportality_dict(e$player)$playerId
    if (!is.null(pid)) {
      p <- .sportality_str(pid)
      if (is.na(side_of[p])) side_of[p] <- .sportality_str(place)
      if (!identical(side_of[[p]], place)) {
        .sportality_refuse(where, paste0("player ", p, " plays for both teams: not one game's feed"), call)
      }
    }
  }
  numbered <- Filter(function(e) is.integer(e$eventId) && length(e$eventId) == 1L, events)
  if (!length(numbered)) .sportality_refuse(where, "no numbered events", call)
  last <- numbered[[which.max(vapply(numbered, function(e) e$eventId, integer(1)))]]
  ends <- Filter(function(e) identical(e$type, "game") && identical(e$subType, "end"), events)
  if (length(ends) != 1L || !identical(ends[[1]], last) || !identical(last$gameState, "GameEnded")) {
    score <- function(k) .sportality_str(.sportality_dict(last[[k]])$score)
    .sportality_refuse(where, paste0(
      "unfinished game or truncated feed: the newest event is ", .sportality_str(last$type), "/",
      .sportality_str(last$subType), " at ", score("homeTeam"), "-", score("awayTeam"), " in state '",
      .sportality_str(last$gameState), "', not the game-end line"
    ), call)
  }
}

#' A finished game whose two team blocks name the same Genius match.
#' @noRd
.sportality_check_overview <- function(where, raw, call) {
  raw <- .sportality_dict(raw)
  if (!identical(raw$state, "GameEnded")) {
    .sportality_refuse(where, paste0("unfinished game: state '", .sportality_str(raw$state), "', expected 'GameEnded'"), call)
  }
  ids <- lapply(c("homeTeam", "awayTeam"), function(k) .sportality_dict(raw[[k]])$gameSourceId)
  if (any(vapply(ids, is.null, logical(1))) || !identical(ids[[1]], ids[[2]])) {
    .sportality_refuse(where, paste0("the team blocks name Genius match ids ",
                                     paste(vapply(ids, .sportality_str, ""), collapse = ", ")), call)
  }
}

#' @noRd
.sportality_check_team_stats <- function(where, raw, call) {
  raw <- .sportality_dict(raw)
  blocks <- lapply(c("home", "away"), function(k) .sportality_dict(raw[[k]]))
  places <- vapply(blocks, function(b) .sportality_str(b$place), character(1))
  if (!setequal(places, c("home", "away"))) {
    .sportality_refuse(where, paste0("the team blocks are placed ", paste(sort(unique(places)), collapse = ", "),
                                     ", expected home and away"), call)
  }
  sides <- stats::setNames(blocks, places)
  if (!.sportality_strict(sides$home$gameSourceId, sides$away$gameSourceId)) {
    .sportality_refuse(where, "the home and away blocks name different Genius match ids", call)
  }
}

#' Rows in the season window and a team list equal to layout-info's for the ssgt.
#' @noRd
.sportality_check_schedule <- function(where, raw, ssgt, call) {
  entry <- .sportality_by_ssgt(ssgt, call)
  if (is.null(entry)) return(invisible())
  lo <- paste0(entry$start_year, "-07-01")
  hi <- paste0(entry$start_year + 1L, "-07-31")
  raw <- .sportality_dict(raw)
  for (g in .sportality_list(raw$gameInfo)) {
    g <- .sportality_dict(g)
    day <- substr(.sportality_str(g$rawStartDateTime), 1L, 10L)
    if (!(lo <= day && day <= hi)) {
      .sportality_refuse(where, paste0("game '", .sportality_str(g$uuid), "' is on ", day,
                                       ", outside the season window ", lo, "..", hi), call)
    }
  }
  teams <- unique(vapply(Filter(.sportality_is_dict, .sportality_list(raw$teamList)),
                         function(t) .sportality_str(t$uuid), character(1)))
  if (!setequal(teams, entry$teams)) {
    .sportality_refuse(where, paste0("the team list (", length(teams), ") is not layout-info's (",
                                     length(entry$teams), ") for this ssgt"), call)
  }
}

#' @noRd
.sportality_check_stats_info <- function(where, url, raw, ssgt, call) {
  if (!(.sportality_is_array(raw) && length(raw) == 1L && .sportality_is_dict(raw[[1]]))) {
    .sportality_refuse(where, "stats-info did not answer a one-item list", call)
  }
  rec <- raw[[1]]
  rows <- .sportality_list(rec$stats)
  if (length(rows) >= .SPORTALITY_STATS_COUNT) {
    .sportality_refuse(where, paste0("answered ", length(rows), " rows = count=", .SPORTALITY_STATS_COUNT,
                                     ": the table may be cut"), call)
  }
  total <- rec$totalCount
  if (is.integer(total) && length(total) == 1L && length(rows) != total) {
    .sportality_refuse(where, paste0("answered ", length(rows), " of totalCount=", total, " rows: the table was cut"), call)
  }
  module <- sub("^.*/", "", sub("/+$", "", sub("[?#].*$", "", url)))
  group <- sub("_.*$", "", module)
  cols <- unlist(lapply(Filter(.sportality_is_dict, .sportality_list(rec$dataColumns)), function(c) c$name))
  need <- .SPORTALITY_STATS_NEED[[group]]
  if (!is.null(need) && !all(need %in% cols)) {
    .sportality_refuse(where, paste0("module '", module, "': the columns lack ",
                                     paste(sort(setdiff(need, cols)), collapse = ", "),
                                     " (an unknown module answers the games table)"), call)
  }
  entry <- .sportality_by_ssgt(ssgt, call)
  if (!is.null(entry) && group != "games") {
    teams <- unique(vapply(Filter(.sportality_is_dict, unname(.sportality_dict(rec$teams))),
                           function(t) .sportality_str(t$uuid), character(1)))
    if (!length(teams) || !all(teams %in% entry$teams)) {
      .sportality_refuse(where, paste0("the teams ", paste(utils::head(sort(setdiff(teams, entry$teams)), 3L), collapse = ", "),
                                       " are not teams of the ssgt asked for"), call)
    }
  }
}

#' @noRd
.sportality_check_team_games <- function(where, raw, key, team, call) {
  for (g in .sportality_list(.sportality_dict(raw)[[key]])) {
    g <- .sportality_dict(g)
    sides <- list(.sportality_dict(g$homeTeamInfo)$uuid, .sportality_dict(g$awayTeamInfo)$uuid)
    if (!any(vapply(sides, identical, logical(1), team))) {
      .sportality_refuse(where, paste0("game '", .sportality_str(g$uuid), "' does not involve team '", team,
                                       "': not the data asked for"), call)
    }
  }
}

#' @noRd
.sportality_check_career <- function(where, raw, athlete, call) {
  first <- if (.sportality_is_array(raw) && length(raw)) raw[[1]] else NULL
  players <- .sportality_dict(.sportality_dict(first)$players)
  got <- unique(lapply(unname(players), function(p) .sportality_dict(p)$uuid))
  if (!is.null(athlete) && nzchar(athlete) && !identical(got, list(athlete))) {
    .sportality_refuse(where, "the player map is not (only) the requested athlete: not the data asked for", call)
  }
}

#' @noRd
.sportality_check_sites <- function(where, raw, ssgt, call) {
  entry <- .sportality_by_ssgt(ssgt, call)
  if (is.null(entry)) return(invisible())
  got <- unique(vapply(Filter(.sportality_is_dict, .sportality_list(raw)),
                       function(r) .sportality_str(r$instanceId), character(1)))
  if (!setequal(got, entry$instances)) {
    .sportality_refuse(where, paste0("the clubs ", paste(sort(got), collapse = ", "), " are not layout-info's ",
                                     paste(sort(entry$instances), collapse = ", "), " for this ssgt"), call)
  }
}

#' Refuse an unusable answer (sdv-py `_check`).
#' @noRd
.sportality_check <- function(url, route, raw, query, ssgt, call) {
  where <- .intl_where(url)
  if (.sportality_is_dict(raw) && length(raw) && all(names(raw) %in% .SPORTALITY_ERROR_KEYS)) {
    keys <- paste(sort(names(raw)), collapse = ", ")
    .abort_asset_fetch("{where} answered an error envelope ({keys}).", call = call)
  }
  if (is.null(raw) || (is.list(raw) && !length(raw)) || identical(raw, "")) {
    .abort_no_data("{where} answered an empty body.", call = call)
  }
  if (is.null(route)) return(invisible())
  path <- .SPORTALITY_ROWS[[route]]
  rows <- .sportality_pluck(raw, path)
  has_row <- vapply(rows, function(r) .sportality_is_dict(r) && any(!vapply(r, is.null, logical(1))), logical(1))
  if (!any(has_row)) .abort_no_data("{where} answered no rows at '{path}'.", call = call)
  segments <- strsplit(sub("/+$", "", sub("[?#].*$", "", url)), "/", fixed = TRUE)[[1]]
  n <- length(segments)
  if (route == "/statistics-v2/layout-info" && length(rows) < .SPORTALITY_MIN_SSGTS) {
    .sportality_refuse(where, paste0(length(rows), " ssgts, expected the ", .SPORTALITY_MIN_SSGTS, "+ of 25 seasons"), call)
  }
  if (route == "/sports-v2/season-series-game-types-filter" && length(rows) < .SPORTALITY_MIN_FILTER_SEASONS) {
    .sportality_refuse(where, paste0(length(rows), " seasons, expected the ", .SPORTALITY_MIN_FILTER_SEASONS,
                                     "+ of the site"), call)
  }
  expected <- list(path = segments[[n]], ssgt = ssgt, playerUuid = query$playerUuid,
                   path1 = segments[[n - 1L]], path2 = segments[[n]])
  scope <- .SPORTALITY_SCOPE[[route]]
  for (field in names(scope)) {
    want <- expected[[scope[[field]]]]
    if (is.null(want) || identical(want, "")) next
    values <- .sportality_pluck(raw, field)
    parent <- sub("\\.[^.]*$", "", field)
    if (!length(values) || (grepl("[]", field, fixed = TRUE) && length(values) != length(.sportality_pluck(raw, parent)))) {
      .sportality_refuse(where, paste0("the body lacks '", field, "', so '", want, "' cannot be verified"), call)
    }
    wrong <- Filter(function(v) !identical(v, want), values)
    if (length(wrong)) {
      .sportality_refuse(where, paste0("answered ", field, "='", .sportality_str(wrong[[1]]), "' for '", want,
                                       "': not the data asked for"), call)
    }
  }
  path_id <- segments[[n]]
  switch(route,
    "/gameday/boxscore/[^/]+" = ,
    "/gameday/player-stats/[^/]+" = .sportality_check_box(where, raw, call),
    "/gameday/play-by-play/[^/]+" = .sportality_check_pbp(where, raw, call),
    "/gameday/game-overview/[^/]+" = .sportality_check_overview(where, raw, call),
    "/gameday/team-stats/[^/]+" = .sportality_check_team_stats(where, raw, call),
    "/sports-v2/game-schedule" = .sportality_check_schedule(where, raw, ssgt, call),
    "/statistics-v2/stats-info/[^/]+" = .sportality_check_stats_info(where, url, raw, ssgt, call),
    "/sports-v2/played-games/[^/]+" = .sportality_check_team_games(where, raw, "playedGames", path_id, call),
    "/sports-v2/upcoming-games/[^/]+" = .sportality_check_team_games(where, raw, "upcomingGames", path_id, call),
    "/statistics-v2/athlete/playerProfile_gameLog" = .sportality_check_career(where, raw, query$playerUuid, call),
    "/sports-v2/all-sites/[^/]+" = .sportality_check_sites(where, raw, path_id, call),
    NULL
  )
  invisible()
}

#' GET a Basketligaen route: map the season, fetch politely, then refuse an unusable answer.
#'
#' @param url Fully built request URL.
#' @param query Named list of query parameters; `season` (END year) and `gameType` are mapped,
#'   `NULL` values are dropped.
#' @param call The frame named in a raised condition (the exported wrapper).
#' @return The parsed JSON body (personal data removed); the bare word of the provider text route.
#' @noRd
.sportality_get <- function(url, query = list(), call = rlang::caller_env()) {
  query <- Filter(Negate(is.null), query)
  if (grepl("/sports-v2/ssgt/[^/]+/provider", url, perl = TRUE)) {
    text <- trimws(.intl_get(url, retry_500 = FALSE, call = call))
    if (!grepl("^[a-z_-]{1,40}$", text, perl = TRUE)) {
      where <- .intl_where(url)
      shown <- substr(text, 1L, 40L)
      .abort_asset_fetch("{where} answered {.val {shown}}, not a provider name.", call = call)
    }
    return(text)
  }
  route <- .sportality_route(url, names(.SPORTALITY_ROWS))
  mapped <- .sportality_map_query(route, query, call)
  raw <- .sportality_fetch(url, mapped$query, call)
  .sportality_check(url, route, raw, mapped$query, mapped$ssgt, call)
  raw
}

# ---------------------------------------------------------------------------
# Argument checks (before any request)
# ---------------------------------------------------------------------------

#' The stats-info modules (sdv-py `sportality_stats_info` choices).
#' @noRd
.SPORTALITY_MODULES <- c(
  "games_games", "players_defensive", "players_fieldGoal", "players_foul", "players_offensive", "players_point",
  "players_rebound", "players_summary", "standings_standings", "teams_attendance", "teams_defensive",
  "teams_fieldGoal", "teams_foul", "teams_offensive", "teams_point", "teams_possession", "teams_rebound",
  "teams_summary"
)

#' `x` must be one of `choices` (sdv-py raises ValueError).
#' @noRd
.sportality_check_choice <- function(x, choices, arg, call = rlang::caller_env()) {
  if (!.sportality_is_str(x) || !x %in% choices) {
    shown <- .sportality_str(x)
    .abort_bad_request("{.arg {arg}} must be one of {.val {choices}}; got {.val {shown}}.", call = call)
  }
  invisible(x)
}

#' `x` must be one id: one non-empty string (or `NULL` when `optional`).
#' @noRd
.sportality_check_id <- function(x, arg, optional = FALSE, call = rlang::caller_env()) {
  if (optional && is.null(x)) return(invisible(x))
  if (!.sportality_is_str(x) || !nzchar(x)) {
    .abort_bad_request("{.arg {arg}} must be one non-empty string (a Basketligaen uuid).", call = call)
  }
  invisible(x)
}

# ---------------------------------------------------------------------------
# Exported helpers (sdv-py sportality_runtime)
# ---------------------------------------------------------------------------

#' @title
#' **Get the Basketligaen ssgt uuid of a season**
#' @description
#' The ssgt (season + series + game type) uuid of a season END year and game type, from
#' `/statistics-v2/layout-info` (fetched once per R session). Use it for the routes that take an ssgt
#' uuid directly: [sportality_standings()], [sportality_sites()], [sportality_ssgt_provider()],
#' [sportality_post_game_team_stats()] and [sportality_player_h2h()].
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/layout-info`
#' @param season (required) Season END year (2026 = 2025/26). Basketligaen 2002/03 on.
#' @param game_type (default `"regular"`) Game type: `regular` (the league season) or `finals` (the
#'   playoffs, Slutspil).
#' @return A character string: the ssgt uuid (e.g. `"qzw34da6jg"` for the 2025/26 regular season).
#'   A season or game type layout-info does not list raises `hoopR_no_data`; a season that is not a
#'   year raises `hoopR_bad_request`.
#' @eval .intl_details(.sportality_schedule_details, c(
#'   'sportality_ssgt_uuid(season = 2026)',
#'   'sportality_ssgt_uuid(season = 2026, game_type = "finals")'
#' ))
#' @export
#' @family Basketligaen Functions
sportality_ssgt_uuid <- function(season, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_season(season)
  .sportality_resolve(season, game_type, call = rlang::current_env())$ssgt
}

#' @title
#' **Get the Basketligaen player id crosswalk**
#' @description
#' Genius person id -> athlete uuid for every player of a Basketligaen season, from one stats-info
#' call (`players_summary`). The site has two player id systems: the **Genius person id** that
#' play-by-play, box scores and stats tables key on (and that joins the genius family), and the
#' platform **athlete uuid** that rosters and athlete routes key on. The `players_summary` table's
#' `players` map is keyed by Genius id and carries each player's uuid.
#'
#' Endpoint: `GET https://www.basketligaen.dk/api/statistics-v2/stats-info/players_summary`
#' @param season (required) Season END year (2026 = 2025/26), mapped to its ssgt through layout-info.
#' @param game_type (default `"regular"`) Game type: `regular` (the league season) or `finals` (the
#'   playoffs, Slutspil).
#' @return
#' A `hoopR_data` tibble, one row per player. sdv-py documents no fixed schema for this frame: the
#'   columns after the first two are the fields the `players` map carries (the 2025/26 map is shown);
#'   birth dates are dropped.
#'
#' | col_name | type | description |
#' |:---|:---|:---|
#' | player_id | integer | Genius person id (the map key); joins play-by-play, box scores, stats tables and the genius family. |
#' | athlete_uuid | character | Platform athlete uuid (NA where the site has none, common before about 2005); joins rosters and the athlete routes. |
#' | first_name | character | Given (first) name(s) of the player. |
#' | last_name | character | Family name (surname) of the player. |
#' | shoots | character | Shooting hand (empty or NA for every player seen). |
#' | ep_url | character | Profile URL on an external site (empty for every player seen). |
#' | full_name | character | Full display name of the player. |
#' | nationality | character | ISO 3166-1 alpha-2 country code. |
#' | gender | character | Gender as recorded by the site (`male`, or empty). |
#' | weight | integer | Weight in kilograms. |
#' | height | integer | Height in centimetres. |
#' @eval .intl_details(.sportality_schedule_details, "sportality_player_crosswalk(season = 2026)")
#' @export
#' @family Basketligaen Functions
sportality_player_crosswalk <- function(season, game_type = "regular") {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  .sportality_season(season)
  .sportality_check_choice(game_type, .SPORTALITY_GAME_TYPES, "game_type")
  raw <- .sportality_get(
    paste0(.SPORTALITY_BASE, "/statistics-v2/stats-info/players_summary"),
    list(season = season, gameType = game_type),
    call = rlang::current_env()
  )
  .sportality_out(.sportality_parse_player_crosswalk(raw), "Basketligaen Player Crosswalk from basketligaen.dk")
}
