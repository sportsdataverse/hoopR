# kbl_runtime.R -- transport, season mapping and scope checks of the KBL wrappers (api.kbl.or.kr).
#
# R mirror of sdv-py sportsdataverse/basketball/kbl/kbl_runtime.py (origin/main e3d232ebc9):
# * Every request goes through `.intl_get()` (>= 1 s per host on every attempt) with the two headers the API
#   insists on (`Channel`, `TeamCode`, any value; the site sends WEB and XX). The headers are always sent, so an
#   HTTP 400 is an unknown answer (`hoopR_asset_fetch`), never the caller's fault.
# * An unknown or malformed id is a deterministic HTTP 500 error envelope: 500 is NOT retried (429/502/503/504 are).
# * Seasons are END years. One sequential seasonCode numbers KBL seasons and D-League editions; `division` and
#   `game_code` pick the competition and the wrapper sends the API's glkey (`S47G01`) or seasonCode, never them.
#   `/league/playoff` is the old route below seasonCode 45 and `/league/playoff/new` from it, both with the
#   REGULAR-SEASON key.
# * Games: the box routes and the header serve final games only. `isEnded` is unreliable, so a game is final when
#   it is 1, or when it is dated before today (KST), both teams scored and its text-cast reached the game-end row
#   (`a` = "009") of the last period. The first call for a game fetches its header (and for such a game its
#   text-cast) once; the final game's context is cached for the session (`.kbl_clear_cache()`).
# * Scope: a body must be the one asked for (header gmkey; text-cast teams, periods and end row; box points that add
#   up to the header's; shot teams and a score chart that ends on the final score; standings, bracket and round-MVP
#   season codes; team-track rounds inside the season; schedule dates inside the window), else `hoopR_asset_fetch`.
# * Nothing here (an empty list, no bracket, no rounds, no schedule rows) is `hoopR_no_data`.
# The text-cast always asks for quarterList=Q1,Q2,Q3,Q4,EQ1..EQ4: without it only the last period comes back.

#' @noRd
.KBL_BASE <- "https://api.kbl.or.kr"
#' @noRd
.KBL_HEADERS <- c(Channel = "WEB", TeamCode = "XX", Accept = "application/json")
#' @noRd
.KBL_QUARTERS <- "Q1,Q2,Q3,Q4,EQ1,EQ2,EQ3,EQ4"
#' /league/playoff/new serves seasonCode >= 45, /league/playoff the earlier ones.
#' @noRd
.KBL_NEW_PLAYOFF_FROM <- 45L

# gmkey -> context of a FINAL game (sdv-py `_CACHE`)
.kbl_cache <- new.env(parent = emptyenv())

#' Forget the cached game contexts (sdv-py `kbl_runtime.clear_cache`).
#' @noRd
.kbl_clear_cache <- function() rm(list = ls(.kbl_cache, all.names = TRUE), envir = .kbl_cache)

#' Today's date in Korea, `YYYYMMDD` (a seam for the tests).
#' @noRd
.kbl_today_kst <- function() format(Sys.time(), "%Y%m%d", tz = "Asia/Seoul")

# --- JSON shape helpers (shared with R/kbl_parsers.R) ------------------------------------------------------------

#' @noRd
.kbl_is_dict <- function(x) is.list(x) && !is.null(names(x))
#' @noRd
.kbl_is_array <- function(x) is.list(x) && is.null(names(x))
#' @noRd
.kbl_obj <- function(x) if (.kbl_is_dict(x)) x else structure(list(), names = character())
#' @noRd
.kbl_rows <- function(x) if (.kbl_is_array(x)) Filter(.kbl_is_dict, x) else list()

#' A JSON scalar as a set key: the string itself, NA for null, else a typed tag (an int never equals a string).
#' @noRd
.kbl_key <- function(v) {
  if (is.null(v)) return(NA_character_)
  if (is.character(v) && length(v) == 1L) return(v)
  paste0("\001", typeof(v), ":", paste(format(v), collapse = ","))
}

#' Python `_int_of`: an integer, else 0.
#' @noRd
.kbl_int_of <- function(v) if (is.integer(v) && length(v) == 1L && !is.na(v)) v else 0L

#' Python's type-strict `_same()` for an integer or a string wanted value.
#' @noRd
.kbl_same <- function(got, want) identical(got, want)

#' A value for a message, like Python `repr()`.
#' @noRd
.kbl_repr <- function(v) {
  if (is.null(v)) return("None")
  if (is.character(v) && length(v) == 1L) return(paste0("'", v, "'"))
  if (is.atomic(v) && length(v) == 1L) return(format(v))
  paste0("<", if (.kbl_is_dict(v)) "object" else "list", ">")
}

#' String comparison by code point (Python `<=` on str).
#' @noRd
.kbl_le <- function(a, b) withr::with_collate("C", a <= b)

#' @noRd
.kbl_where <- function(path) paste0("api.kbl.or.kr", path)

# --- transport ----------------------------------------------------------------------------------------------------

#' GET a KBL path with the two required headers; refuse the error envelope.
#' @noRd
.kbl_fetch <- function(path, query = list(), call = rlang::caller_env()) {
  where <- .kbl_where(path)
  text <- tryCatch(
    .intl_get(paste0(.KBL_BASE, path), query = query, headers = .KBL_HEADERS, retry_500 = FALSE, call = call),
    hoopR_bad_request = function(e) {
      # the headers are always sent, so a 400 / 422 is an unknown answer, not the caller's fault
      msg <- conditionMessage(e)
      .abort_asset_fetch("{msg}", status = e$status, call = call)
    }
  )
  body <- .intl_json(text, where = where, call = call)
  if (.kbl_is_dict(body) && (identical(body$resultCode, "Fail") || all(c("errorCode", "resultCode") %in% names(body)))) {
    code <- .kbl_repr(body$errorCode)
    .abort_asset_fetch("{where} answered the KBL error envelope (errorCode={code})", call = call)
  }
  body
}

#' The body as a JSON array, else `hoopR_asset_fetch`.
#' @noRd
.kbl_list <- function(where, body, call) {
  if (!.kbl_is_array(body)) {
    kind <- if (.kbl_is_dict(body)) "dict" else if (is.null(body)) "NoneType" else typeof(body)
    .abort_asset_fetch("{where}: expected a JSON list, got {kind}", call = call)
  }
  body
}

# --- seasons ------------------------------------------------------------------------------------------------------

#' A public season as an integer END year; `hoopR_bad_request` otherwise (before any request).
#' @noRd
.kbl_season_arg <- function(value, call) {
  s <- if (is.atomic(value) && length(value) == 1L && !is.na(value) && !is.logical(value)) trimws(as.character(value))
  n <- if (!is.null(s) && grepl("^-*[0-9]+$", s)) suppressWarnings(as.integer(s)) else NA_integer_
  if (is.na(n)) {
    got <- .kbl_repr(value)
    .abort_bad_request("season must be an END year such as 2026 (2025-26); got {got}", call = call)
  }
  n
}

#' The KBL seasonCode of an END year and division (sdv-py `kbl_codes.season_code`).
#' @noRd
.kbl_season_code <- function(season, division, call) {
  grade <- c(kbl = 1L, d_league = 2L)
  if (!(is.character(division) && length(division) == 1L && division %in% names(grade))) {
    got <- .kbl_repr(division)
    .abort_bad_request("division must be one of {.val {names(grade)}}; got {got}", call = call)
  }
  t <- .kbl_season_table
  code <- t$code[t$end == season & t$grade == grade[[division]]]
  if (!length(code)) {
    .abort_bad_request(
      "the KBL has no {division} season {season}: seasons run 1997 to 2027 (the D-League from 2009)",
      call = call
    )
  }
  code[[1]]
}

#' First and last game date over every competition of an END year (sdv-py `kbl_codes.season_dates`).
#' @noRd
.kbl_season_dates <- function(season, call) {
  t <- .kbl_season_table[.kbl_season_table$end == season, ]
  if (!nrow(t)) .abort_bad_request("season must be an END year between 1997 and 2027; got {season}", call = call)
  c(min(t$first), max(t$last))
}

#' `(seasonCode, gameCode, glkey)` of a public season.
#' @noRd
.kbl_glkey <- function(season, division, game_code, call) {
  code <- .kbl_season_code(.kbl_season_arg(season, call), division %||% "kbl", call)
  gc <- if (is.null(game_code)) "01" else as.character(game_code)
  if (length(gc) != 1L || is.na(gc) || !grepl("^[0-9]{2}$", gc)) {
    got <- .kbl_repr(game_code)
    .abort_bad_request("game_code must be a two-digit code such as '01' (regular season); got {got}", call = call)
  }
  list(code = code, gc = gc, glkey = paste0("S", code, "G", gc))
}

#' The wrappers' division check (sdv-py raises it before the runtime).
#' @noRd
.kbl_check_division <- function(division, call) {
  if (!(is.character(division) && length(division) == 1L && division %in% c("kbl", "d_league"))) {
    got <- .kbl_repr(division)
    .abort_bad_request("division must be one of ('kbl', 'd_league'); got {got}", call = call)
  }
  invisible(division)
}

#' A season route: rewrite the END year to the API key, fetch, refuse other seasons.
#' @return `list(body =, req =)`; `req` is the request stamp the parsers read.
#' @noRd
.kbl_season_get <- function(name, season, division = "kbl", game_code = NULL, call = rlang::caller_env()) {
  if (name %in% c("playoff", "round_mvp")) game_code <- "01" # the playoff routes take the REGULAR-SEASON key
  k <- .kbl_glkey(season, division, game_code, call)
  code <- k$code
  gc <- k$gc
  glkey <- k$glkey
  req <- list(season = .kbl_season_arg(season, call), season_code = code, game_code = gc, glkey = glkey,
              division = division %||% "kbl")
  where <- paste0("api.kbl.or.kr/", name)
  if (name == "season_players") {
    body <- .kbl_list(where, .kbl_fetch(paste0("/leagues/", glkey, "/stats/players"), call = call), call)
  } else if (name == "rank") {
    body <- .kbl_list(where, .kbl_fetch(paste0("/league/rank/", glkey), call = call), call)
    for (r in .kbl_rows(body)) {
      if (!(.kbl_same(r$seasonCode, code) && .kbl_same(r$gameCode, gc))) {
        got_s <- .kbl_repr(r$seasonCode)
        got_g <- .kbl_repr(r$gameCode)
        .abort_asset_fetch("{where}: asked for {glkey}, got seasonCode={got_s} gameCode={got_g}", call = call)
      }
    }
  } else if (name == "team_tracks") {
    body <- .kbl_fetch(paste0("/league/rank/", glkey, "/team-tracks"), call = call)
    t <- .kbl_season_table[.kbl_season_table$code == code, ]
    lo <- t$first[[1]]
    hi <- t$last[[1]]
    rounds <- .kbl_rows(.kbl_obj(body)$rounds)
    if (!length(rounds)) .abort_no_data("{where}: no rounds for {glkey}", call = call)
    for (rd in rounds) {
      fd <- rd$fromDate
      if (!(is.character(fd) && length(fd) == 1L && .kbl_le(lo, fd) && .kbl_le(fd, hi))) {
        got <- .kbl_repr(fd)
        .abort_asset_fetch("{where}: round fromDate={got} is outside season {code} ({lo}..{hi})", call = call)
      }
    }
    return(list(body = body, req = req))
  } else if (name == "playoff") {
    new <- code >= .KBL_NEW_PLAYOFF_FROM
    body <- .kbl_fetch(paste0("/league/playoff/", if (new) "new/", glkey), call = call)
    seeds <- .kbl_rows(.kbl_obj(body)$defaultRank)
    if (!length(seeds)) .abort_no_data("{where}: no playoff bracket for {glkey}", call = call)
    bad <- lapply(Filter(function(s) !.kbl_same(s$seasonCode, code), seeds), function(s) s$seasonCode)
    result <- .kbl_obj(.kbl_obj(body)$result)
    for (key in names(result)) {
      games <- result[[key]]
      if (startsWith(key, "game") && .kbl_is_array(games)) {
        for (g in .kbl_rows(games)) {
          sc <- .kbl_obj(g$gmkey)$seasonCode
          if (!(is.numeric(sc) && length(sc) == 1L && !is.na(sc) && sc == code)) bad <- c(bad, list(sc))
        }
      }
    }
    if (length(bad)) {
      got <- paste(vapply(utils::head(bad, 3), .kbl_repr, character(1)), collapse = ", ")
      .abort_asset_fetch("{where}: asked for seasonCode {code}, the bracket has [{got}]", call = call)
    }
    req$format <- if (new) "new" else "old"
    return(list(body = body, req = req))
  } else { # round_mvp
    body <- .kbl_list(where, .kbl_fetch(paste0("/league/round-mvp/", code), call = call), call)
    for (r in .kbl_rows(body)) {
      if (!.kbl_same(r$seasonCode, code)) {
        got <- .kbl_repr(r$seasonCode)
        .abort_asset_fetch("{where}: asked for seasonCode {code}, got {got}", call = call)
      }
    }
  }
  if (!length(body)) .abort_no_data("{where}: the API answered no rows for {glkey}", call = call)
  list(body = body, req = req)
}

# --- schedule -----------------------------------------------------------------------------------------------------

#' Request windows: the given dates, or a season's first..last game, split at New Year.
#' @noRd
.kbl_windows <- function(season, lo, hi, call) {
  given <- function(x) !is.null(x) && !identical(x, "")
  if (!is.null(season)) {
    if (given(lo) || given(hi)) .abort_bad_request("pass season, or from_date and to_date, not both", call = call)
    d <- .kbl_season_dates(.kbl_season_arg(season, call), call)
    lo <- d[[1]]
    hi <- d[[2]]
  }
  is_date <- function(x) is.character(x) && length(x) == 1L && !is.na(x) && grepl("^[0-9]{8}$", x)
  if (!(is_date(lo) && is_date(hi))) {
    .abort_bad_request("pass season (an END year) or both from_date and to_date as YYYYMMDD", call = call)
  }
  if (!.kbl_le(lo, hi)) .abort_bad_request("from_date {lo} is after to_date {hi}", call = call)
  out <- list()
  start <- lo
  while (substr(start, 1, 4) < substr(hi, 1, 4)) {
    out[[length(out) + 1L]] <- c(start, paste0(substr(start, 1, 4), "1231"))
    start <- paste0(as.integer(substr(start, 1, 4)) + 1L, "0101")
  }
  out[[length(out) + 1L]] <- c(start, hi)
  out
}

#' `/match/list` over the windows; every row must be dated inside its window and carry a consistent gmkey.
#' @noRd
.kbl_schedule_get <- function(season = NULL, from_date = NULL, to_date = NULL, call = rlang::caller_env()) {
  wins <- .kbl_windows(season, from_date, to_date, call)
  where <- "api.kbl.or.kr/match/list"
  rows <- list()
  for (w in wins) {
    part <- .kbl_list(where, .kbl_fetch("/match/list", list(fromDate = w[[1]], toDate = w[[2]]), call = call), call)
    for (r in .kbl_rows(part)) {
      date <- r$gameDate
      if (!(is.character(date) && length(date) == 1L && .kbl_le(w[[1]], date) && .kbl_le(date, w[[2]]))) {
        got <- .kbl_repr(date)
        lo <- w[[1]]
        hi <- w[[2]]
        .abort_asset_fetch("{where}: gameDate {got} is outside {lo}..{hi}", call = call)
      }
      p <- .kbl_game_key_parts(r$gmkey)
      num_eq <- function(a, b) is.numeric(a) && length(a) == 1L && !is.na(a) && a == b
      if (is.null(p) || !(num_eq(r$seasonCode, p$season_code) && identical(r$gameCode, p$game_code) &&
                          num_eq(r$gameNo, p$game_no))) {
        got <- .kbl_repr(r$gmkey)
        .abort_asset_fetch("{where}: gmkey {got} does not match its seasonCode/gameCode/gameNo", call = call)
      }
    }
    rows <- c(rows, part)
  }
  if (!length(rows)) .abort_no_data("{where}: no games in the window", call = call)
  list(body = rows, req = list(from_date = wins[[1]][[1]], to_date = wins[[length(wins)]][[2]]))
}

# --- the routes without parameters ----------------------------------------------------------------------------------

#' @noRd
.kbl_simple_get <- function(path, call = rlang::caller_env()) {
  body <- .kbl_fetch(path, call = call)
  if (is.null(body) || (is.list(body) && !length(body))) {
    where <- .kbl_where(path)
    .abort_no_data("{where}: the API answered no rows", call = call)
  }
  list(body = body, req = list())
}

# --- games --------------------------------------------------------------------------------------------------------

#' `(seasonCode, gameCode, gameNo)` of a `S{seasonCode}G{gameCode}N{gameNo}` key, else NULL.
#' @noRd
.kbl_game_key_parts <- function(gmkey) {
  if (!(is.character(gmkey) && length(gmkey) == 1L && !is.na(gmkey))) return(NULL)
  m <- regmatches(gmkey, regexec("^S([0-9]+)G([0-9]{2})N([0-9]+)$", gmkey))[[1]]
  if (!length(m)) return(NULL)
  list(season_code = as.integer(m[[2]]), game_code = m[[3]], game_no = as.integer(m[[4]]))
}

#' What the per-game checks need from a `/match/{gmkey}` body.
#' @noRd
.kbl_context <- function(gmkey, body, call) {
  where <- .kbl_where(paste0("/match/", gmkey))
  game <- .kbl_obj(.kbl_obj(body)$game)
  records <- .kbl_obj(.kbl_obj(body)$teamrecords)
  if (!.kbl_same(game$gmkey, gmkey)) {
    got <- .kbl_repr(game$gmkey)
    .abort_asset_fetch("{where}: asked for '{gmkey}', the header has game.gmkey={got}", call = call)
  }
  if (!length(game) || !length(records)) .abort_asset_fetch("{where}: the header has no game or teamrecords", call = call)
  totals <- c(home = 0L, away = 0L)
  ots <- 0L
  for (side in c("home", "away")) {
    rec <- .kbl_obj(records[[side]])
    eq <- if (.kbl_is_array(rec$scoreeq)) rec$scoreeq else list()
    totals[[side]] <- sum(vapply(1:4, function(i) .kbl_int_of(rec[[paste0("scoreq", i)]]), integer(1))) +
      sum(vapply(eq, .kbl_int_of, integer(1)))
    ots <- max(ots, length(eq))
  }
  list(gmkey = gmkey, home = .kbl_key(game$tcodeH), away = .kbl_key(game$tcodeA), date = game$gameDate,
       is_ended = game$isEnded, totals = totals, ots = ots)
}

#' The text-cast must be this game's whole feed and end with a game-end row; returns its rows.
#' @noRd
.kbl_check_text_cast <- function(where, ctx, body, call) {
  rows <- .kbl_list(where, body, call)
  if (!length(rows)) .abort_asset_fetch("{where}: the text-cast is empty (a truncated page or an unknown game)", call = call)
  teams <- c(ctx$home, ctx$away)
  want <- c(paste0("Q", 1:4), if (ctx$ots) paste0("X", seq_len(ctx$ots)))
  last <- if (ctx$ots) paste0("X", ctx$ots) else "Q4"
  seen <- character()
  acted <- character()
  ended <- FALSE
  for (row in rows) {
    if (!.kbl_is_dict(row)) .abort_asset_fetch("{where}: a text-cast row is not an object", call = call)
    t <- .kbl_key(row$t)
    if (!t %in% c(teams, "", " ")) { # team-less events: '' (later seasons) or ' ' (1997-98)
      got <- .kbl_repr(row$t)
      .abort_asset_fetch("{where}: text-cast team {got} is not in {.val {teams}}", call = call)
    }
    seen <- union(seen, .kbl_key(row$q))
    acted <- union(acted, t)
    ended <- ended || (identical(row$a, "009") && identical(row$q, last))
  }
  if (!setequal(seen, want)) {
    got <- sort(seen)
    .abort_asset_fetch("{where}: text-cast periods {.val {got}} are not the game's {.val {sort(want)}} (truncated or another game)",
                       call = call)
  }
  if (!all(teams %in% acted)) {
    missing <- setdiff(teams, acted)
    .abort_asset_fetch("{where}: the text-cast has no row for team(s) {.val {missing}}", call = call)
  }
  if (!ended) {
    .abort_asset_fetch("{where}: the text-cast has no game-end row (a=009) in {last}: the game may not be over",
                       call = call)
  }
  rows
}

#' `list(ctx, header, text)` of a FINAL game; a cached game has no header or text.
#' @noRd
.kbl_game <- function(gmkey, call) {
  if (exists(gmkey, envir = .kbl_cache, inherits = FALSE)) return(list(ctx = .kbl_cache[[gmkey]]))
  where <- .kbl_where(paste0("/match/", gmkey))
  header <- .kbl_fetch(paste0("/match/", gmkey), call = call)
  ctx <- .kbl_context(gmkey, header, call)
  text <- NULL
  if (!.kbl_same(ctx$is_ended, 1L)) {
    date <- ctx$date
    today <- .kbl_today_kst()
    if (!(is.character(date) && length(date) == 1L && withr::with_collate("C", date < today) && min(ctx$totals) > 0)) {
      ie <- .kbl_repr(ctx$is_ended)
      gd <- .kbl_repr(date)
      pts <- paste0("home=", ctx$totals[["home"]], ", away=", ctx$totals[["away"]])
      .abort_asset_fetch("{where}: the game is not final (isEnded={ie}, gameDate={gd}, points: {pts})", call = call)
    }
    text <- .kbl_fetch(paste0("/match/", gmkey, "/text-cast"), list(quarterList = .KBL_QUARTERS), call = call)
    .kbl_check_text_cast(where, ctx, text, call) # raises unless it reached the end of the last period
  }
  assign(gmkey, ctx, envir = .kbl_cache)
  list(ctx = ctx, header = header, text = text)
}

#' @noRd
.kbl_check_player_stat <- function(where, ctx, rows, call) {
  teams <- c(ctx$home, ctx$away)
  pts <- c(0L, 0L)
  for (row in rows) {
    tcode <- .kbl_key(.kbl_obj(.kbl_obj(row)$player)$tcode)
    i <- match(tcode, teams)
    if (is.na(i)) {
      got <- .kbl_repr(.kbl_obj(.kbl_obj(row)$player)$tcode)
      .abort_asset_fetch("{where}: player team {got} is not in {.val {teams}}", call = call)
    }
    pts[[i]] <- pts[[i]] + .kbl_int_of(.kbl_obj(.kbl_obj(row)$records)$score)
  }
  if (!identical(unname(pts), unname(ctx$totals))) {
    got <- paste0("home=", pts[[1]], ", away=", pts[[2]])
    want <- paste0("home=", ctx$totals[["home"]], ", away=", ctx$totals[["away"]])
    .abort_asset_fetch("{where}: player points ({got}) are not the header's ({want})", call = call)
  }
}

#' @noRd
.kbl_check_team_record <- function(where, ctx, rows, call) {
  keys <- character()
  vals <- integer()
  for (row in rows) {
    if (!.kbl_is_dict(row)) .abort_asset_fetch("{where}: a team-record row is not an object", call = call)
    keys <- c(keys, .kbl_key(row$tcode))
    vals <- c(vals, .kbl_int_of(.kbl_obj(row$records)$score))
  }
  keep <- !duplicated(keys, fromLast = TRUE) # a dict: the last row of a team wins
  keys <- keys[keep]
  vals <- vals[keep]
  wk <- c(ctx$home, ctx$away)
  wv <- unname(ctx$totals)
  wkeep <- !duplicated(wk, fromLast = TRUE)
  wk <- wk[wkeep]
  wv <- wv[wkeep]
  m <- match(wk, keys)
  if (length(keys) != length(wk) || anyNA(m) || !all(vals[m] == wv)) {
    got <- paste(keys, vals, sep = "=", collapse = ", ")
    want <- paste(wk, wv, sep = "=", collapse = ", ")
    .abort_asset_fetch("{where}: team scores ({got}) are not the header's ({want})", call = call)
  }
}

#' @noRd
.kbl_check_match_chart <- function(where, ctx, body, call) {
  if (!.kbl_is_dict(body)) .abort_asset_fetch("{where}: the match chart is not an object", call = call)
  teams <- c(ctx$home, ctx$away)
  for (row in .kbl_rows(body$shootLog)) {
    if (!.kbl_key(row$tcode) %in% teams) {
      got <- .kbl_repr(row$tcode)
      .abort_asset_fetch("{where}: shot team {got} is not in {.val {teams}}", call = call)
    }
  }
  chart <- .kbl_obj(body$scoreChart)
  for (side in c("home", "away")) {
    periods <- .kbl_obj(chart[[side]])
    full <- Filter(function(p) .kbl_is_array(p) && length(p) > 0L, periods)
    last <- if (length(full)) full[[length(full)]] else NULL
    total <- ctx$totals[[side]]
    if (is.null(last) || !.kbl_same(last[[length(last)]], total)) {
      got <- if (is.null(last)) "None" else .kbl_repr(last[[length(last)]])
      .abort_asset_fetch("{where}: scoreChart {side} ends {got}, the header total is {total}", call = call)
    }
  }
}

#' A game route of a FINAL game, checked against its header.
#' @return `list(body =, req = list(gmkey =))`.
#' @noRd
.kbl_game_get <- function(name, gmkey, call = rlang::caller_env()) {
  if (!(is.character(gmkey) && length(gmkey) == 1L && !is.na(gmkey) && grepl("^S[0-9]+G[0-9]{2}N[0-9]+$", gmkey))) {
    got <- .kbl_repr(gmkey)
    .abort_bad_request("gmkey must look like S47G01N49 (S<seasonCode>G<gameCode>N<gameNo>); got {got}", call = call)
  }
  route <- if (name == "header") "" else paste0("/", gsub("_", "-", name, fixed = TRUE))
  path <- paste0("/match/", gmkey, route)
  where <- .kbl_where(path)
  g <- .kbl_game(gmkey, call)
  ctx <- g$ctx
  if (name == "header") {
    body <- g$header
    if (is.null(body)) {
      body <- .kbl_fetch(path, call = call)
      .kbl_context(gmkey, body, call)
    }
  } else if (name == "text_cast") {
    text <- g$text %||% .kbl_fetch(path, list(quarterList = .KBL_QUARTERS), call = call)
    body <- .kbl_check_text_cast(where, ctx, text, call)
  } else {
    body <- .kbl_fetch(path, call = call)
    if (name %in% c("player_stat", "team_record")) {
      body <- .kbl_list(where, body, call)
      if (!length(body)) .abort_no_data("{where}: the final game has no box score", call = call)
      if (name == "player_stat") .kbl_check_player_stat(where, ctx, body, call) else .kbl_check_team_record(where, ctx, body, call)
    } else {
      .kbl_check_match_chart(where, ctx, body, call)
    }
  }
  list(body = body, req = list(gmkey = gmkey))
}
