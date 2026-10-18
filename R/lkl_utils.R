# lkl_utils.R -- runtime and parsers of the LKL `lkl_*()` family (Lietuvos
# krepsinio lyga, Lithuania, on lkl.lt).
#
# R mirror of sdv-py sportsdataverse/basketball/lkl/ (lkl_runtime.py +
# lkl_parsers.py, e3d232e): same routes, same refusals, same column specs. One
# host, keyless: the livestream JSON API (/api/livestream/{route}/{gameId}) plus
# three server-rendered HTML routes (the game page /rungtynes/{gameId}, the
# results list /loadResults and the standings /loadStandings/{id}), read with
# regular expressions plus HTML unescaping, refusing layout drift instead of
# guessing. Requests go through .intl_response() (>= 1 s per host; 429 / 5xx,
# HTTP 500 included, retried up to three attempts).
#
# * Season = END year (2026 = 2025-26). The site keys a season by two opaque
#   ids (results id, standings id), read at run time from its own season
#   selects (/rezultatai #season-lkl, /turnyrine-lentele #season) by the label
#   "YYYY-YYYY m. sezonas"; a year the selects lack is hoopR_no_data.
# * Game routes serve FINISHED games only: the game page (cached per game per
#   session) must say "Pasibaige" and gives the team ids and the roster (slug ->
#   player id) every other route is checked against and stamped with.
# * Silent wrong answers are refused (type-strict compares, fail closed): a page
#   for another game, a box score of other teams or players, leaders /
#   play-by-play / shots by players of another game, a results list leaving its
#   season window or short / repeated / understated pages, standings drift.
# * hoopR_no_data: HTTP 404, a season the selects lack, a season without played
#   games, a finished game without play-by-play / shots (the site charts both
#   from 2024-25). hoopR_bad_request: a non-integer game id or season, HTTP 400 /
#   422. hoopR_asset_fetch: everything else above.
#
# Parsers: one column spec per wrapper (.LKL_SPECS, ported from sdv-py SPECS);
# a malformed body is a typed zero-row tibble. Lithuanian text in code is
# written with \u escapes.

# `x` named `nm` (non-ASCII names must be values, never call-argument names: those
# become symbols in the native encoding and break in a non-UTF-8 locale)
.lkl_named <- function(x, nm) {
  names(x) <- nm
  x
}

.LKL_SITE <- "https://lkl.lt"
.LKL_API <- "https://lkl.lt/api/livestream"
#: game-status of a finished game ("ended")
.LKL_FINISHED <- "Pasibaig\u0117"
#: "information is being prepared": the site's empty-table text
.LKL_PREPARING <- "Informacija ruo\u0161iama"
.LKL_PAGE_SIZE <- 10L
.LKL_MAX_PAGES <- 100L
.LKL_PERSONAL <- "(birth|^dob$|gimim|e_?mail|phone|^tel$|mobile|address|adresas)"
.LKL_ERROR_KEYS <- c("message", "error", "errors", "status", "exception", "trace", "code")
#: route -> kind
.LKL_API_ROUTES <- c(
  boxscore = "boxscore", summary = "summary", `game-score` = "game_score", `game-stats` = "game_stats",
  leaders = "leaders", `play-by-play` = "pbp", `shot-chart` = "shots"
)
#: wrapper -> route it reads
.LKL_ROUTE <- c(
  game_info = "rungtynes", game_players = "rungtynes", player_box = "boxscore", team_box = "boxscore",
  period_scores = "boxscore", summary = "summary", game_score = "game-score", game_stats = "game-stats",
  lead_chart = "game-stats", leaders = "leaders", pbp = "play-by-play", shots = "shot-chart",
  results = "loadResults", standings = "loadStandings"
)
#: UI config props of the game page (column / tab labels), not data
.LKL_DROP_PROPS <- c(":players-stats-columns", ":main-tabs", ":leaders-tabs")
.LKL_MONTHS <- .lkl_named(
  c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L),
  c(
    "sausio", "vasario", "kovo", "baland\u017eio", "gegu\u017e\u0117s", "bir\u017eelio", "liepos",
    "rugpj\u016b\u010dio", "rugs\u0117jo", "spalio", "lapkri\u010dio", "gruod\u017eio"
  )
)
.LKL_WEEKDAYS <- .lkl_named(
  c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  c(
    "pirmadienis", "antradienis", "tre\u010diadienis", "ketvirtadienis", "penktadienis", "\u0161e\u0161tadienis",
    "sekmadienis"
  )
)
.LKL_STANDINGS_HEADERS <- list(
  full = c("Poz.", "Komanda", "Rng.", "Per.", "Pr.", "Laim.%", "Serija", "T\u0161k. vid.", "Paskutin\u0117s 5"),
  home = c("Poz.", "Komanda", "Rng.", "Per.", "Pr.", "T\u0161k. vid.", "Paskutin\u0117s 5"),
  away = c("Poz.", "Komanda", "Rng.", "Per.", "Pr.", "T\u0161k. vid.", "Paskutin\u0117s 5"),
  final = c("Poz.", "Komanda")
)
#: the comparison rows' Lithuanian labels -> a stable English code
.LKL_STAT_CODES <- .lkl_named(
  c(
    "field_goals", "two_pointers", "three_pointers", "free_throws", "rebounds", "defensive_rebounds",
    "offensive_rebounds", "assists", "steals", "blocks", "turnovers", "fouls", "points", "points_off_turnovers",
    "fast_break_points", "second_chance_points", "bench_points"
  ),
  c(
    "Metimai i\u0161 \u017eaidimo", "Dvita\u0161kiai metimai", "Trita\u0161kiai metimai", "Baud\u0173 metimai",
    "Atkovoti kamuoliai", "Atkovoti kamuoliai gynyboje", "Atkovoti kamuoliai puolime",
    "Rezultatyv\u016bs perdavimai", "Perimti kamuoliai", "Blokai", "Klaidos", "Pra\u017eangos", "Ta\u0161kai",
    "Ta\u0161kai po klaid\u0173", "Ta\u0161kai greitose atakose", "Ta\u0161kai antru bandymu",
    "Atsargini\u0173 \u017eaid\u0117j\u0173 ta\u0161kai"
  )
)
.LKL_SIDES <- c("home", "away")

# game id -> the finished game's page record
.lkl_game_cache <- new.env(parent = emptyenv())

#' Empty the finished-game cache (the tests call it between scripted runs).
#' @noRd
.lkl_clear_cache <- function() {
  rm(list = ls(.lkl_game_cache), envir = .lkl_game_cache)
  invisible()
}

# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

# a page that is not the data asked for (sdv-py _NotParsed); `empty` marks the
# right page holding no games (raised as hoopR_no_data)
.lkl_not_parsed <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "hoopR_lkl_not_parsed", empty = isTRUE(empty))
}

.lkl_is_obj <- function(x) is.list(x) && !is.null(names(x))
.lkl_is_arr <- function(x) is.list(x) && is.null(names(x))
.lkl_objs <- function(x) if (.lkl_is_arr(x)) Filter(.lkl_is_obj, x) else list()
.lkl_scalar <- function(v) !is.null(v) && is.atomic(v) && length(v) == 1L && !is.na(v)

# Python truthiness of a JSON value
.lkl_truthy <- function(x) {
  if (is.null(x)) return(FALSE)
  if (is.list(x)) return(length(x) > 0L)
  if (length(x) != 1L || is.na(x)) return(length(x) > 0L)
  if (is.logical(x)) return(x)
  if (is.numeric(x)) return(x != 0)
  if (is.character(x)) return(nzchar(x))
  TRUE
}

# walk `...` keys through nested objects; NULL as soon as one is missing
.lkl_get <- function(d, ...) {
  for (k in c(...)) {
    if (!.lkl_is_obj(d)) return(NULL)
    d <- d[[k]]
  }
  d
}

# Python `==` on two JSON values (1 == 1.0, True == 1, None == None)
.lkl_eq <- function(a, b) {
  if (is.null(a) || is.null(b)) return(is.null(a) && is.null(b))
  if (!.lkl_scalar(a) || !.lkl_scalar(b)) return(FALSE)
  if (is.character(a) || is.character(b)) return(is.character(a) && is.character(b) && a == b)
  as.numeric(a) == as.numeric(b)
}

# type-strict equality (sdv-py _same: 1 != "1", TRUE != 1, 1L != 1.0)
.lkl_same <- function(a, b) {
  if (is.null(a) || is.null(b)) return(is.null(a) && is.null(b))
  .lkl_scalar(a) && .lkl_scalar(b) && identical(typeof(a), typeof(b)) && a == b
}

# `x in values` with Python semantics
.lkl_in <- function(x, values) any(vapply(values, function(v) .lkl_eq(x, v), logical(1)))

.lkl_repr <- function(x) {
  if (is.null(x)) return("None")
  if (is.character(x) && length(x) == 1L) return(paste0("'", x, "'"))
  if (is.logical(x) && length(x) == 1L && !is.na(x)) return(if (x) "True" else "False")
  if (is.atomic(x) && length(x) == 1L) return(as.character(x))
  "<object>"
}

.lkl_strip <- function(x) gsub("(*UCP)^\\s+|\\s+$", "", x, perl = TRUE)
.lkl_lower <- function(x) stringi::stri_trans_tolower(x)

# value of `key` in a named vector / list, else `default`. match() compares in UTF-8 in any
# locale; `x[[key]]` / `x[key]` translate non-ASCII names and miss in a C locale.
.lkl_name_get <- function(x, key, default = NA) {
  i <- if (is.character(key) && length(key) == 1L && !is.na(key)) match(key, names(x)) else NA_integer_
  if (is.na(i)) default else x[[i]]
}

# `x` with `key` set to `value` (replacing, so the last of a repeated key wins; a NULL is kept)
.lkl_name_set <- function(x, key, value) {
  i <- match(key, names(x))
  if (is.na(i)) {
    x <- c(x, if (is.list(x)) list(value) else value)
    names(x)[length(x)] <- key
  } else if (is.list(x)) {
    x[i] <- list(value)
  } else {
    x[i] <- value
  }
  x
}

# first match of `pattern` in `x`: c(full, group1, ...) or NULL
.lkl_match <- function(pattern, x) {
  m <- regmatches(x, regexec(pattern, x, perl = TRUE))[[1]]
  if (!length(m)) return(NULL)
  .lkl_utf8(m)
}

# mark regex output UTF-8 (in a non-UTF-8 locale regexec / gregexpr hand back unmarked bytes)
.lkl_utf8 <- function(x) {
  if (length(x) && all(validUTF8(x))) Encoding(x) <- "UTF-8"
  x
}

# every match of `pattern` in `x`: a character matrix of its groups, one row per match
.lkl_findall <- function(pattern, x) {
  m <- gregexpr(pattern, x, perl = TRUE)[[1]]
  st <- attr(m, "capture.start")
  if (m[1] == -1L) return(matrix(character(), 0L, max(1L, NCOL(st))))
  if (is.null(st)) return(matrix(regmatches(x, list(m))[[1]], ncol = 1L))
  ln <- attr(m, "capture.length")
  matrix(.lkl_utf8(substring(x, st, st + ln - 1L)), nrow = nrow(st))
}

#' Python `html.unescape()` (libxml2 decodes the entities; a literal "<" is kept).
#' @noRd
.lkl_unescape <- function(x) {
  if (!grepl("&", x, fixed = TRUE)) return(x)
  doc <- rvest::read_html(paste0("<html><body><p>", gsub("<", "&lt;", x, fixed = TRUE), "</p></body></html>"),
                          encoding = "UTF-8")
  rvest::html_text(rvest::html_element(doc, "p"))
}

#' Tags dropped, entities decoded, whitespace collapsed and stripped (sdv-py `_text`).
#' @noRd
.lkl_text <- function(fragment) {
  x <- .lkl_unescape(gsub("<[^>]+>", " ", fragment %||% "", perl = TRUE))
  .lkl_strip(gsub("(*UCP)\\s+", " ", x, perl = TRUE))
}

# Python `x or ""` for a value a regex reads: "" for a falsy value, the string,
# or an error (a parser error) for any other type
.lkl_str0 <- function(x) {
  if (!.lkl_truthy(x)) return("")
  if (is.character(x) && length(x) == 1L) return(x)
  stop("TypeError: expected a string")
}

#' `'2026  m. Spalio 3 d.'` (Lithuanian, month in the genitive) -> `'2026-10-03'`.
#' @noRd
.lkl_lt_date <- function(text) {
  m <- .lkl_match("(*UCP)(\\d{4})\\s+m\\.\\s+(\\S+)\\s+(\\d{1,2})\\s+d\\.", text %||% "")
  if (is.null(m)) return(NA_character_)
  month <- .lkl_name_get(.LKL_MONTHS, .lkl_lower(m[3]), NA_integer_)
  if (is.na(month)) return(NA_character_)
  iso <- sprintf("%04d-%02d-%02d", as.integer(m[2]), month, as.integer(m[4]))
  if (is.na(as.Date(iso, format = "%Y-%m-%d"))) NA_character_ else iso
}

# ---------------------------------------------------------------------------
# Casts (sdv-py lkl_parsers _i / _f / _s / _b / _mmss / _made_att / _date)
# ---------------------------------------------------------------------------

# an id / count from an integer or an integer string, never through a float
.lkl_i <- function(v) {
  if (!.lkl_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.character(v) && grepl("(*UCP)^\\s*[+-]?[0-9]+\\s*$", v, perl = TRUE)) {
    return(suppressWarnings(as.integer(.lkl_strip(v))))
  }
  NA_integer_
}

# a number from a number or a decimal string ("46.67", "71.4%"; "-" is NA)
.lkl_f <- function(v) {
  if (!.lkl_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("(*UCP)^\\s*[+-]?[0-9]+(?:\\.[0-9]+)?%?\\s*$", v, perl = TRUE)) {
    return(as.double(sub("%+$", "", .lkl_strip(v))))
  }
  NA_real_
}

# a stripped non-empty string (numbers stringified as Python does)
.lkl_s <- function(v) {
  if (!.lkl_scalar(v) || is.logical(v)) return(NA_character_)
  if (is.double(v)) {
    if (!is.finite(v)) return(NA_character_)
    return(if (v == trunc(v) && abs(v) < 1e16) sprintf("%.1f", v) else as.character(v))
  }
  t <- .lkl_strip(as.character(v))
  if (nzchar(t)) t else NA_character_
}

.lkl_b <- function(v) if (is.logical(v) && length(v) == 1L) v else NA

# "32:54" -> 1974 seconds (a team row sums its players: "225:00" -> 13500)
.lkl_mmss <- function(v) {
  if (!(is.character(v) && .lkl_scalar(v))) return(NA_integer_)
  m <- .lkl_match("(*UCP)^\\s*(\\d+):(\\d{2})\\s*$", v)
  if (is.null(m)) NA_integer_ else as.integer(m[2]) * 60L + as.integer(m[3])
}

# "4/9" -> c(4L, 9L)
.lkl_made_att <- function(v) {
  m <- if (is.character(v) && .lkl_scalar(v)) .lkl_match("(*UCP)^\\s*(\\d+)\\s*/\\s*(\\d+)\\s*$", v) else NULL
  if (is.null(m)) c(NA_integer_, NA_integer_) else as.integer(m[2:3])
}

# an ISO date string (kept as text; the frame converts the column)
.lkl_date <- function(v) {
  if (!(is.character(v) && .lkl_scalar(v))) return(NA_character_)
  if (grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", v) && !is.na(as.Date(v, format = "%Y-%m-%d"))) v else NA_character_
}

# keys of an object whose integer value is not NA, sorted numerically (stable)
.lkl_int_keys <- function(x) {
  if (!.lkl_is_obj(x)) return(character())
  k <- names(x)
  n <- vapply(k, .lkl_i, integer(1), USE.NAMES = FALSE)
  k <- k[!is.na(n)]
  k[order(n[!is.na(n)])]
}

# ---------------------------------------------------------------------------
# Personal data
# ---------------------------------------------------------------------------

#' `obj` with personal contact / birth-date values replaced by `"<redacted>"`
#' by key name, at any depth (sdv-py `_redact_personal`).
#' @noRd
.lkl_redact <- function(obj) {
  if (!is.list(obj) || !length(obj)) return(obj)
  nm <- names(obj)
  obj[] <- lapply(seq_along(obj), function(i) {
    if (!is.null(nm) && grepl(.LKL_PERSONAL, nm[[i]], ignore.case = TRUE, perl = TRUE)) "<redacted>" else .lkl_redact(obj[[i]])
  })
  obj
}

# ---------------------------------------------------------------------------
# HTML readers (sdv-py lkl_parsers _game_record / _options / _results_* / _standings_record)
# ---------------------------------------------------------------------------

#' The `<game-info-component>` props of the game page as one record (`:`-props are JSON).
#' @noRd
.lkl_game_record <- function(text, game_id) {
  m <- .lkl_match("(?s)<game-info-component\\b(.*?)>", text %||% "")
  if (is.null(m)) .lkl_not_parsed("no <game-info-component> (an unplayed game's preview page, or layout drift)")
  attrs <- .lkl_findall('(:?[a-z][a-z-]*)="([^"]*)"', m[2])
  props <- list()
  for (i in seq_len(nrow(attrs))) {
    name <- attrs[i, 1]
    raw <- .lkl_unescape(attrs[i, 2])
    if (name %in% .LKL_DROP_PROPS) next
    if (startsWith(name, ":")) {
      raw <- tryCatch(jsonlite::parse_json(raw, simplifyVector = FALSE),
                      error = function(e) .lkl_not_parsed(sprintf("prop %s is not JSON", name)))
    }
    props[gsub("-", "_", sub("^:+", "", name), fixed = TRUE)] <- list(raw)
  }
  gid <- props[["game_id"]]
  if (!.lkl_same(gid, as.character(game_id))) {
    .lkl_not_parsed(sprintf("out of scope: game-id %s, asked for %d", .lkl_repr(gid), game_id))
  }
  info <- if (.lkl_is_obj(props[["game_info"]])) props[["game_info"]] else list()
  tm <- .lkl_match("(*UCP),\\s*(\\d{1,2}:\\d{2})\\s*$", .lkl_str0(info[["time"]]))
  att <- .lkl_match("(*UCP)^\\s*(\\d+)", .lkl_str0(info[["attendance"]]))
  c(
    list(game_id = as.integer(gid)),
    props[names(props) != "game_id"],
    list(
      start_date = .lkl_lt_date(.lkl_str0(info[["time"]])),
      start_time = if (is.null(tm)) NA_character_ else tm[2],
      attendance_count = if (is.null(att)) NA_integer_ else as.integer(att[2])
    )
  )
}

#' `<option value=id>label</option>` of `select#select_id` as a list of `list(season_id, label)`.
#' @noRd
.lkl_options <- function(text, select_id) {
  m <- .lkl_match(paste0('(?s)<select\\b[^>]*\\bid="', select_id, '".*?</select>'), text %||% "")
  if (is.null(m)) .lkl_not_parsed(sprintf("no select#%s", select_id))
  opts <- .lkl_findall('(?s)<option value="([^"]*)"[^>]*>(.*?)</option>', m[1])
  keep <- grepl("^[0-9]+$", opts[, 1])
  lapply(which(keep), function(i) list(season_id = as.integer(opts[i, 1]), label = .lkl_text(opts[i, 2])))
}

#' `'2025-2026 m. sezonas'` -> `c('2025-08-01', '2026-07-31')`: the window every game of the season is in.
#' @noRd
.lkl_season_window <- function(label) {
  m <- .lkl_match("^([0-9]{4})-([0-9]{4}) m\\. sezonas\\z", .lkl_strip(if (is.character(label)) label else ""))
  if (is.null(m) || as.integer(m[3]) != as.integer(m[2]) + 1L) return(NULL)
  c(paste0(m[2], "-08-01"), paste0(m[3], "-07-31"))
}

.lkl_label_end_year <- function(label) {
  w <- .lkl_season_window(label)
  if (is.null(w)) NA_integer_ else as.integer(substr(w[2], 1L, 4L))
}

.lkl_team_block <- function(slug, inner) {
  code <- .lkl_match("(?s)<strong[^>]*>(.*?)</strong>", inner)
  alt <- .lkl_match('<img[^>]*alt="([^"]*)"', inner)
  list(slug = slug, code = if (is.null(code)) NA_character_ else .lkl_text(code[2]),
       name = if (is.null(alt)) NA_character_ else .lkl_unescape(alt[2]))
}

#' `list(games, last)` of one `/loadResults` fragment; `last` is NA without a paginator.
#' @noRd
.lkl_results_page <- function(text) {
  text <- text %||% ""
  m <- gregexpr('(?s)(<div class="font-semibold text-2xl[^"]*">.*?</div>)|<div class="result-item">', text, perl = TRUE)[[1]]
  games <- list()
  day <- NA_character_
  weekday <- NA_character_
  if (m[1] != -1L) {
    st <- as.integer(m)
    len <- attr(m, "match.length")
    cs <- attr(m, "capture.start")[, 1]
    cl <- attr(m, "capture.length")[, 1]
    n <- length(st)
    for (j in seq_len(n)) {
      if (cs[j] > 0L) {
        h <- .lkl_text(substring(text, cs[j], cs[j] + cl[j] - 1L))
        day <- .lkl_lt_date(h)
        wd <- .lkl_match("\\(([^)]+)\\)", h)
        weekday <- if (is.null(wd)) NA_character_ else .lkl_name_get(.LKL_WEEKDAYS, .lkl_lower(wd[2]), NA_character_)
        if (is.na(day)) .lkl_not_parsed(sprintf("date header drift: '%s'", h))
        next
      }
      if (is.na(day)) .lkl_not_parsed("result item before any date header")
      chunk <- substring(text, st[j] + len[j], if (j < n) st[j + 1L] - 1L else nchar(text))
      teams <- .lkl_findall('(?s)<a href="https://lkl\\.lt/komandos/([^"]+)"[^>]*>(.*?)</a>', chunk)
      score <- .lkl_match('(?s)<a href="https://lkl\\.lt/rungtynes/(\\d+)">(.*?)</a>', chunk)
      loc <- .lkl_match('(*UCP)(?s)<div class="location[^"]*">\\s*<div[^>]*>(.*?)</div>\\s*<div>(.*?)</div>', chunk)
      if (nrow(teams) != 2L || is.null(score) || is.null(loc)) .lkl_not_parsed("result item drift (teams / score link / location)")
      pts <- .lkl_match("(*UCP)^(\\d+)\\s*-\\s*(\\d+)\\z", .lkl_text(score[3]))
      if (is.null(pts)) .lkl_not_parsed(sprintf("score drift: '%s'", .lkl_text(score[3])))
      dash <- regexpr("-", score[3], fixed = TRUE)
      left <- if (dash > 0L) substr(score[3], 1L, dash - 1L) else score[3]
      right <- if (dash > 0L) substring(score[3], dash + 1L) else ""
      winner <- if (grepl("<strong", left, fixed = TRUE)) "home" else if (grepl("<strong", right, fixed = TRUE)) "away" else NA_character_
      venue <- .lkl_strip(strsplit(paste0(.lkl_text(loc[3]), ","), ",", fixed = TRUE)[[1]])
      home <- .lkl_team_block(teams[1, 1], teams[1, 2])
      away <- .lkl_team_block(teams[2, 1], teams[2, 2])
      time <- .lkl_text(loc[2])
      games[[length(games) + 1L]] <- list(
        game_id = as.integer(score[2]), date = day, weekday = weekday,
        time = if (nzchar(time)) time else NA_character_,
        arena = if (nzchar(venue[1])) venue[1] else NA_character_,
        city = if (length(venue) > 1L && nzchar(venue[2])) venue[2] else NA_character_,
        home_slug = home$slug, home_code = home$code, home_name = home$name, home_score = as.integer(pts[2]),
        away_slug = away$slug, away_code = away$code, away_name = away$name, away_score = as.integer(pts[3]),
        winner_highlighted = winner
      )
    }
  }
  pages <- as.integer(.lkl_findall("loadResults\\?page=(\\d+)", text)[, 1])
  list(games = games, last = if (length(pages)) max(pages) else NA_integer_)
}

#' Merge every page of one season's results; refuse a short, duplicated, unconfirmed or out-of-season list.
#' @noRd
.lkl_results_record <- function(season_id, index_html, pages, after = NULL) {
  opts <- .lkl_options(index_html, "season-lkl")
  label <- NULL
  for (o in opts) if (identical(o$season_id, season_id)) { label <- o$label; break }
  window <- .lkl_season_window(label)
  if (is.null(window)) {
    .lkl_not_parsed(sprintf("season %d not in the /rezultatai season select (or label drift: %s)", season_id, .lkl_repr(label)))
  }
  games <- list()
  last <- NA_integer_
  for (n in seq_along(pages)) {
    pg <- .lkl_results_page(pages[[n]])
    rows <- pg$games
    page_last <- pg$last
    if (n == 1L) {
      if (!length(rows) && grepl(.LKL_PREPARING, .lkl_text(pages[[n]]), fixed = TRUE)) {
        .lkl_not_parsed(sprintf("season %d (%s) has no played games yet", season_id, label), empty = TRUE)
      }
      if (is.na(page_last) && length(rows) >= .LKL_PAGE_SIZE) {
        .lkl_not_parsed(sprintf("page 1 holds %d games but has no paginator (pagination drift)", length(rows)))
      }
      last <- if (is.na(page_last) || page_last == 0L) 1L else page_last
    }
    pl <- if (is.na(page_last) || page_last == 0L) 1L else page_last
    if (pl != last) .lkl_not_parsed(sprintf("page %d says %s pages, page 1 said %d", n, page_last, last))
    if (!length(rows) || (n < last && length(rows) != .LKL_PAGE_SIZE)) {
      .lkl_not_parsed(sprintf("page %d has %d games (expected %d on all but the last page)", n, length(rows), .LKL_PAGE_SIZE))
    }
    games <- c(games, rows)
  }
  if (is.na(last) || length(pages) != last) .lkl_not_parsed(sprintf("walked %d pages, the list has %s", length(pages), last))
  if (length(.lkl_results_page(pages[[length(pages)]])$games) == .LKL_PAGE_SIZE) {
    if (is.null(after)) .lkl_not_parsed(sprintf("the last page (%d) is full and page %d was not checked", last, last + 1L))
    extra <- .lkl_results_page(after)$games
    if (length(extra)) {
      .lkl_not_parsed(sprintf("page %d, after the paginator's last page, holds %d games", last + 1L, length(extra)))
    }
  }
  ids <- vapply(games, function(g) g$game_id, integer(1))
  if (anyDuplicated(ids)) .lkl_not_parsed("duplicate games across pages (the list moved while walking it)")
  dates <- as.Date(vapply(games, function(g) g$date, ""))
  out <- which(dates < as.Date(window[1]) | dates > as.Date(window[2]))
  if (length(out)) {
    g <- games[[out[1]]]
    .lkl_not_parsed(sprintf("out of scope: game %d on %s outside %s ('%s', '%s')", g$game_id, g$date, label, window[1], window[2]))
  }
  list(season_id = season_id, season_label = label, season_end_year = as.integer(substr(window[2], 1L, 4L)),
       pages = last, game_count = length(games), games = games)
}

#' The 'Paskutines 5' squares in rendered order: bg-green = W(in), bg-red = L(oss); anything else refuses.
#' @noRd
.lkl_last5 <- function(cell) {
  colors <- .lkl_findall("(*UCP)\\bblock\\s+bg-(\\w+)", cell)[, 1]
  if (!all(colors %in% c("green", "red"))) .lkl_not_parsed(sprintf("last-5 colour drift: %s", paste(colors, collapse = ", ")))
  unname(c(green = "W", red = "L")[colors])
}

#' The four standings tables of `/loadStandings/{season_id}` as one record.
#' @noRd
.lkl_standings_record <- function(text, season_id, index_html) {
  label <- NULL
  for (o in .lkl_options(index_html, "season")) if (identical(o$season_id, season_id)) { label <- o$label; break }
  if (is.null(label)) .lkl_not_parsed(sprintf("standings season %d not in the /turnyrine-lentele season select", season_id))
  text <- gsub("(?s)<svg\\b.*?</svg>", "", text %||% "", perl = TRUE)
  tabs <- .lkl_findall('(?s)<div class="tab-c-ins[^"]*" data-id="([a-z]+)">(.*?)(?=<div class="tab-c-ins|\\z)', text)
  if (!identical(tabs[, 1], names(.LKL_STANDINGS_HEADERS))) {
    .lkl_not_parsed(sprintf("standings tabs drift: %s", paste(tabs[, 1], collapse = ", ")))
  }
  rec <- list(season_id = season_id, season_label = label, season_end_year = .lkl_label_end_year(label))
  for (t in seq_len(nrow(tabs))) {
    tab <- tabs[t, 1]
    body <- tabs[t, 2]
    head <- vapply(.lkl_findall("(?s)<th\\b[^>]*>(.*?)</th>", body)[, 1], .lkl_text, "", USE.NAMES = FALSE)
    if (!identical(head, .LKL_STANDINGS_HEADERS[[tab]])) .lkl_not_parsed(sprintf("%s header drift: %s", tab, paste(head, collapse = ", ")))
    rows <- list()
    for (tr in .lkl_findall("(?s)<tr>(.*?)</tr>", body)[-1L, 1]) {
      if (identical(.lkl_text(tr), .LKL_PREPARING)) next
      cells <- .lkl_findall("(?s)<td\\b[^>]*>(.*?)</td>", tr)[, 1]
      if (length(cells) != length(head)) .lkl_not_parsed(sprintf("%s row width %d != %d", tab, length(cells), length(head)))
      team <- .lkl_findall('(?s)<a href="https://lkl\\.lt/komandos/([^"]+)"[^>]*>(.*?)</a>', cells[2])
      if (!nrow(team)) .lkl_not_parsed(sprintf("%s row without a team link", tab))
      name <- .lkl_text(team[nrow(team), 2])
      row <- list(position = .lkl_i(.lkl_text(cells[1])), team_slug = team[1, 1],
                  team_name = if (nzchar(name)) name else NA_character_)
      if (tab != "final") {
        row <- c(row, list(played = .lkl_i(.lkl_text(cells[3])), won = .lkl_i(.lkl_text(cells[4])),
                           lost = .lkl_i(.lkl_text(cells[5]))))
        rest <- cells[-(1:5)]
        if (tab == "full") {
          row <- c(row, list(win_pct = .lkl_f(.lkl_text(rest[1])), streak = .lkl_i(.lkl_text(rest[2]))))
          rest <- rest[-(1:2)]
        }
        avg <- .lkl_findall('(*UCP)<span class="num base bordered[^"]*">\\s*([^<]*?)\\s*</span>', rest[1])[, 1]
        row <- c(row, list(
          points_for_avg = if (length(avg) == 2L) .lkl_f(avg[1]) else NA_real_,
          points_against_avg = if (length(avg) == 2L) .lkl_f(avg[2]) else NA_real_,
          last5 = .lkl_last5(rest[2])
        ))
      }
      rows[[length(rows) + 1L]] <- row
    }
    rec[tab] <- list(rows)
  }
  if (!any(vapply(names(.LKL_STANDINGS_HEADERS), function(t) length(rec[[t]]) > 0L, logical(1)))) {
    .lkl_not_parsed(sprintf("standings of %s: every table is empty", label), empty = TRUE)
  }
  rec
}

#' Build a page record (`game`, `results` or `standings`); an odd page is a refusal, never a crash.
#' @noRd
.lkl_page_record <- function(kind, ...) {
  build <- switch(kind, game = .lkl_game_record, results = .lkl_results_record, standings = .lkl_standings_record)
  # one handler: a second, outer one would catch the not-parsed condition re-raised by the first
  tryCatch(build(...), error = function(e) {
    if (inherits(e, "hoopR_lkl_not_parsed")) stop(e)
    .lkl_not_parsed(sprintf("parser error: %s", class(e)[1]))
  })
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

# the text of an lkl.lt route: HTTP 200, an HTML / JSON content type, a non-empty body
.lkl_body <- function(url, query = list(), kind = c("html", "json"), call = rlang::caller_env()) {
  kind <- match.arg(kind)
  resp <- .intl_response(url, query = query, retry_500 = TRUE, timeout = 60, call = call)
  where <- .intl_where(url)
  .intl_check_status(resp, where = where, call = call)
  status <- httr2::resp_status(resp)
  if (status != 200L) .abort_asset_fetch("{where} answered HTTP {status}, not 200", status = status, call = call)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl(kind, ctype, fixed = TRUE)) {
    got <- if (nzchar(ctype)) ctype else "no content type"
    what <- toupper(kind)
    .abort_asset_fetch("{where} answered {got}, not {what}", call = call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(.lkl_strip(text))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body", call = call)
  text
}

.lkl_json <- function(url, call) {
  text <- .lkl_body(url, kind = "json", call = call)
  where <- .intl_where(url)
  tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE),
           error = function(e) .abort_asset_fetch("{where} answered a body that is not JSON", call = call))
}

# a non-negative integer argument (an integral number or a digit string), else hoopR_bad_request
.lkl_int_arg <- function(value, what, call) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) && (
    (is.character(value) && grepl("^[0-9]+$", trimws(value))) ||
      (is.numeric(value) && is.finite(value) && value >= 0 && value == trunc(value) && value <= .Machine$integer.max)
  )
  if (!isTRUE(ok)) {
    got <- if (is.null(value)) "NULL" else paste(deparse(value), collapse = " ")
    .abort_bad_request("{what} must be an integer; got {got}", call = call)
  }
  as.integer(if (is.character(value)) trimws(value) else value)
}

# ---------------------------------------------------------------------------
# Game page and JSON routes (sdv-py lkl_runtime _game / _api / _scope_error)
# ---------------------------------------------------------------------------

.lkl_team <- function(rec, side) {
  t <- .lkl_get(rec, "teams_info", side)
  if (.lkl_is_obj(t)) t else list()
}

.lkl_roster <- function(rec, side) .lkl_objs(.lkl_get(rec, "players", side))

#' The game page record of a FINISHED game (cached); anything else raises.
#' @noRd
.lkl_game <- function(game_id, call) {
  key <- as.character(game_id)
  if (!is.null(.lkl_game_cache[[key]])) return(.lkl_game_cache[[key]])
  url <- sprintf("%s/rungtynes/%d", .LKL_SITE, game_id)
  where <- .intl_where(url)
  text <- .lkl_body(url, kind = "html", call = call)
  rec <- tryCatch(.lkl_page_record("game", text, game_id), hoopR_lkl_not_parsed = function(e) {
    msg <- conditionMessage(e)
    .abort_asset_fetch("{where}: no finished game to read: {msg}", call = call)
  })
  if (!.lkl_same(rec[["game_status"]], .LKL_FINISHED)) {
    status <- .lkl_repr(rec[["game_status"]])
    .abort_asset_fetch(paste0("{where}: game {game_id} is not finished (game-status {status}); ",
                              "LKL game wrappers serve finished games only"), call = call)
  }
  for (side in .LKL_SIDES) {
    players <- if (.lkl_is_obj(rec[["players"]])) rec[["players"]][[side]] else NULL
    if (!is.integer(.lkl_team(rec, side)[["id"]]) || !.lkl_is_arr(players) || !length(players)) {
      .abort_asset_fetch("{where}: game page without a {side} team id or players", call = call)
    }
  }
  rec <- .lkl_redact(rec)
  assign(key, rec, envir = .lkl_game_cache)
  rec
}

#' What the parsers need from the game page: team ids and the slug -> player id map.
#' @noRd
.lkl_request <- function(rec) {
  players <- structure(list(), names = character(0))
  for (side in .LKL_SIDES) {
    for (p in .lkl_roster(rec, side)) {
      slug <- p[["slug"]]
      if (is.character(slug) && length(slug) == 1L && nzchar(slug)) players <- .lkl_name_set(players, slug, p[["id"]])
    }
  }
  list(game_id = rec[["game_id"]], home_team_id = .lkl_team(rec, "home")[["id"]],
       away_team_id = .lkl_team(rec, "away")[["id"]], players = players)
}

.lkl_quarters <- function(body) {
  q <- if ("quarters" %in% names(body)) body[["quarters"]] else body
  if (.lkl_is_obj(q) && length(q) == 2L && setequal(names(q), c("regular", "overtime"))) q else NULL
}

.lkl_lines <- function(q) {
  reg <- q[["regular"]]
  ot <- q[["overtime"]]
  vals <- if (.lkl_is_obj(reg)) unname(reg) else if (.lkl_is_arr(reg)) reg else list()
  rows <- list()
  for (v in vals) rows <- c(rows, if (.lkl_is_arr(v)) v else list(v))
  if (.lkl_is_arr(ot)) rows <- c(rows, ot)
  Filter(.lkl_is_obj, rows)
}

#' Why `body` is not this finished game's, or `NULL`. Fails closed.
#' @noRd
.lkl_scope_error <- function(kind, body, rec) {
  gid <- rec[["game_id"]]
  roster <- list(home = .lkl_roster(rec, "home"), away = .lkl_roster(rec, "away"))
  slugs <- lapply(roster, function(r) lapply(r, function(p) p[["slug"]]))
  pids <- lapply(roster, function(r) lapply(r, function(p) p[["id"]]))
  if (kind %in% c("boxscore", "summary")) {
    gs <- body[["gameStatistics"]]
    want <- c(as.character(.lkl_team(rec, "home")[["id"]]), as.character(.lkl_team(rec, "away")[["id"]]))
    if (!.lkl_is_obj(gs) || !setequal(names(gs), want)) {
      got <- if (.lkl_is_obj(gs)) paste0("['", paste(sort(names(gs)), collapse = "', '"), "']") else .lkl_repr(gs)
      return(sprintf("out of scope: gameStatistics teams %s, game has ['%s']", got, paste(sort(unique(want)), collapse = "', '")))
    }
    for (tid in names(gs)) {
      row <- gs[[tid]]
      if (!.lkl_is_obj(row) || !.lkl_same(row[["game_id"]], gid) || !.lkl_same(row[["team_id"]], as.integer(tid))) {
        return(sprintf("out of scope: gameStatistics[%s] is not game %d's row", tid, gid))
      }
      if (!is.integer(row[["points"]]) || length(row[["points"]]) != 1L) return(sprintf("game not final: team %s has no points", tid))
    }
    if (kind == "boxscore") {
      box <- body[["boxscore"]]
      for (side in .LKL_SIDES) {
        players <- .lkl_get(box, side, "players")
        pts <- .lkl_get(box, side, "team", "points", "value")
        if (!.lkl_is_arr(players) || !length(players)) return(sprintf("boxscore without %s players", side))
        if (!.lkl_same(pts, gs[[as.character(.lkl_team(rec, side)[["id"]])]][["points"]])) {
          return(sprintf("out of scope: boxscore %s points %s != gameStatistics", side, .lkl_repr(pts)))
        }
        for (p in players) {
          if (!.lkl_is_obj(p) || !.lkl_in(p[["slug"]], slugs[[side]])) {
            return(sprintf("out of scope: a %s box row is not a %s player of game %d", side, side, gid))
          }
        }
      }
    }
    return(NULL)
  }
  if (kind == "game_score") {
    ok <- is.integer(body[["home"]]) && length(body[["home"]]) == 1L && is.integer(body[["away"]]) && length(body[["away"]]) == 1L
    return(if (ok) NULL else "game not final: score line without two integer scores")
  }
  if (kind == "game_stats") {
    comp <- body[["comparison"]]
    if (!.lkl_is_obj(comp) || !.lkl_is_arr(comp[["all"]]) || !.lkl_is_obj(body[["leads"]])) {
      return("game-stats without comparison.all / leads (layout drift)")
    }
    return(NULL)
  }
  if (kind == "leaders") {
    cats <- body[["leaders"]]
    if (!.lkl_is_obj(cats) || !length(cats)) return("leaders without categories")
    for (cat in cats) {
      for (side in .LKL_SIDES) {
        lead <- if (.lkl_is_obj(cat)) cat[[side]] else NULL
        rows <- if (.lkl_is_obj(lead)) {
          others <- lead[["others"]]
          c(list(lead), if (!.lkl_truthy(others)) list() else if (.lkl_is_arr(others)) others else list(NULL))
        } else {
          list(NULL)
        }
        for (r in rows) {
          if (!.lkl_is_obj(r) || !.lkl_in(r[["slug"]], slugs[[side]])) {
            return(sprintf("out of scope: a %s leader is not a %s player of game %d", side, side, gid))
          }
        }
      }
    }
    return(NULL)
  }
  q <- .lkl_quarters(body)
  if (is.null(q)) return("no quarters.regular / quarters.overtime (layout drift)")
  rows <- .lkl_lines(q)
  for (r in rows) {
    side <- if (isTRUE(r[["is_home"]])) "home" else if (isFALSE(r[["is_home"]])) "away" else NA_character_
    if (is.na(side)) return("row without a boolean is_home")
    if (kind == "shots") {
      if (!.lkl_in(r[["player_id"]], pids[[side]])) {
        return(sprintf("out of scope: a shot by player %s, not a %s player of game %d", .lkl_repr(r[["player_id"]]), side, gid))
      }
    } else {
      slug <- if (.lkl_is_obj(r[["player"]])) r[["player"]][["slug"]] else NULL
      if (!is.null(slug) && !.lkl_in(slug, slugs[[side]])) {
        return(sprintf("out of scope: a play by %s, not a %s player of game %d", .lkl_repr(slug), side, gid))
      }
    }
  }
  if (kind == "pbp" && length(rows)) {
    ends <- vapply(rows, function(r) .lkl_eq(r[["type"]], "game") && .lkl_eq(r[["subtype"]], "end"), logical(1))
    if (!any(ends)) return("play-by-play without a game-end line (unfinished?)")
  }
  NULL
}

#' One livestream route of a finished game: checked, redacted, stamped with `_request`.
#' @noRd
.lkl_api <- function(route, game_id, call) {
  kind <- .LKL_API_ROUTES[[route]]
  rec <- .lkl_game(game_id, call) # hoopR_no_data / hoopR_asset_fetch before the route is asked for
  url <- sprintf("%s/%s/%d", .LKL_API, route, game_id)
  where <- .intl_where(url)
  body <- .lkl_json(url, call)
  if (!.lkl_is_obj(body) || !length(body)) .abort_asset_fetch("{where}: the body is empty or not an object", call = call)
  if (all(names(body) %in% .LKL_ERROR_KEYS)) .abort_asset_fetch("{where}: the body is an error envelope", call = call)
  if (kind %in% c("pbp", "shots")) {
    q <- .lkl_quarters(body)
    if (!is.null(q) && !length(.lkl_lines(q))) {
      what <- if (kind == "pbp") "play-by-play" else "shots"
      .abort_no_data("{where}: no {what} for game {game_id} (the site charts both from 2024-25)", call = call)
    }
  }
  why <- .lkl_scope_error(kind, body, rec)
  if (!is.null(why)) .abort_asset_fetch("{where}: {why}", call = call)
  body <- .lkl_redact(body)
  body[["_request"]] <- .lkl_request(rec)
  body
}

.lkl_game_page <- function(game_id, call) {
  rec <- .lkl_game(game_id, call)
  rec[["_request"]] <- list(game_id = game_id)
  rec
}

# ---------------------------------------------------------------------------
# Season pages (sdv-py lkl_runtime _season_id / _results / _standings)
# ---------------------------------------------------------------------------

#' The id whose label ends in `season` in `select#select_id` of the index page.
#' @noRd
.lkl_season_id <- function(index_html, select_id, season, what, call) {
  opts <- tryCatch(.lkl_options(index_html, select_id), hoopR_lkl_not_parsed = function(e) {
    msg <- conditionMessage(e)
    .abort_asset_fetch("{what}: {msg}", call = call)
  })
  ends <- vapply(opts, function(o) .lkl_label_end_year(o$label), integer(1))
  ids <- vapply(opts, function(o) o$season_id, integer(1))[!is.na(ends) & ends == season]
  if (!length(ids)) .abort_no_data("{what}: the season select lists no season ending in {season}", call = call)
  if (length(ids) > 1L) {
    n <- length(ids)
    .abort_asset_fetch("{what}: {n} seasons end in {season} (ambiguous)", call = call)
  }
  ids
}

.lkl_results <- function(season, call) {
  index_url <- paste0(.LKL_SITE, "/rezultatai")
  index <- .lkl_body(index_url, kind = "html", call = call)
  sid <- .lkl_season_id(index, "season-lkl", season, .intl_where(index_url), call)
  url <- paste0(.LKL_SITE, "/loadResults")
  where <- .intl_where(url)
  q <- list(team = "-", opponent = "-", month = "-", season = sid)
  pages <- character()
  last <- 1L
  while (length(pages) < min(last, .LKL_MAX_PAGES)) {
    pages <- c(pages, .lkl_body(url, c(q, list(page = length(pages) + 1L)), kind = "html", call = call))
    if (length(pages) == 1L) {
      last <- tryCatch(.lkl_results_page(pages[1])$last, hoopR_lkl_not_parsed = function(e) {
        msg <- conditionMessage(e)
        .abort_asset_fetch("{where}: not the page asked for: {msg}", call = call)
      })
      if (is.na(last) || last == 0L) last <- 1L
    }
  }
  rec <- tryCatch({
    after <- NULL
    if (length(pages) && length(.lkl_results_page(pages[length(pages)])$games) == .LKL_PAGE_SIZE) {
      after <- .lkl_body(url, c(q, list(page = length(pages) + 1L)), kind = "html", call = call)
    }
    .lkl_page_record("results", sid, index, as.list(pages), after)
  }, hoopR_lkl_not_parsed = function(e) {
    msg <- conditionMessage(e)
    if (isTRUE(e$empty)) .abort_no_data("{where}: {msg}", call = call)
    .abort_asset_fetch("{where}: not the list asked for: {msg}", call = call)
  })
  rec[["_request"]] <- list(season = season, season_id = sid)
  .lkl_redact(rec)
}

.lkl_standings <- function(season, call) {
  index_url <- paste0(.LKL_SITE, "/turnyrine-lentele")
  index <- .lkl_body(index_url, kind = "html", call = call)
  sid <- .lkl_season_id(index, "season", season, .intl_where(index_url), call)
  url <- sprintf("%s/loadStandings/%d", .LKL_SITE, sid)
  where <- .intl_where(url)
  text <- .lkl_body(url, kind = "html", call = call)
  rec <- tryCatch(.lkl_page_record("standings", text, sid, index), hoopR_lkl_not_parsed = function(e) {
    msg <- conditionMessage(e)
    if (isTRUE(e$empty)) .abort_no_data("{where}: {msg}", call = call)
    .abort_asset_fetch("{where}: not the page asked for: {msg}", call = call)
  })
  rec[["_request"]] <- list(season = season, season_id = sid)
  .lkl_redact(rec)
}

#' The raw body or page record one wrapper reads (sdv-py `lkl_runtime._get`).
#' @noRd
.lkl_raw <- function(short, value, call) {
  route <- .LKL_ROUTE[[short]]
  if (short %in% c("results", "standings")) {
    if (short == "results" && is.null(value)) {
      .abort_bad_request("lkl_results needs season (the END year, 2026 = 2025-26)", call = call)
    }
    season <- .lkl_int_arg(value, "season", call) # validated before any request
    return(if (short == "results") .lkl_results(season, call) else .lkl_standings(season, call))
  }
  gid <- .lkl_int_arg(value, "game id", call)
  if (route == "rungtynes") .lkl_game_page(gid, call) else .lkl_api(route, gid, call)
}

#' Fetch + parse one wrapper's route: the exported functions' single body.
#' @noRd
.lkl_wrap <- function(short, value, type, call = rlang::caller_env()) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .lkl_raw(short, value, call)
  make_hoopR_data(.lkl_parse(short, raw), type, Sys.time())
}

# ---------------------------------------------------------------------------
# Parsers (sdv-py lkl_parsers parse_lkl_*): each returns exactly its spec
# ---------------------------------------------------------------------------

.lkl_side_spec <- function(cols) {
  out <- character()
  for (side in .LKL_SIDES) out <- c(out, .lkl_named(cols, paste0(side, "_", names(cols))))
  out
}

.LKL_SPECS <- list(
  game_info = c(
    game_id = "integer", game_status = "character", start_date = "Date", start_time = "character",
    arena = "character", attendance = "character", attendance_count = "integer", referees = "character",
    has_actions = "logical", is_streaming = "logical",
    .lkl_side_spec(c(team_id = "integer", team = "character", short_name = "character", slug = "character",
                     winner = "logical", coach = "character", assistant_coach = "character"))
  ),
  game_players = c(
    game_id = "integer", team_side = "character", team_id = "integer", player_id = "integer",
    player = "character", jersey = "character", slug = "character"
  ),
  player_box = c(
    game_id = "integer", team_side = "character", team_id = "integer", player_slug = "character",
    player_id = "integer", player = "character", jersey = "character", is_starter = "logical",
    is_captain = "logical", is_active = "logical", seconds_played = "integer", points = "integer",
    fg_made = "integer", fg_attempted = "integer", fg_pct = "double", fg2_made = "integer",
    fg2_attempted = "integer", fg2_pct = "double", fg3_made = "integer", fg3_attempted = "integer",
    fg3_pct = "double", ft_made = "integer", ft_attempted = "integer", ft_pct = "double",
    total_rebounds = "integer", offensive_rebounds = "integer", defensive_rebounds = "integer",
    assists = "integer", steals = "integer", turnovers = "integer", blocks = "integer",
    blocks_received = "integer", fouls = "integer", fouls_on = "integer", plus_minus = "integer",
    efficiency = "integer"
  ),
  team_box = c(
    game_id = "integer", team_id = "integer", team_side = "character",
    .lkl_named(rep("integer", 31L), c(
      "points", "seconds_played", "field_goals_made_total", "field_goals_attempted_total",
      "field_goals_made_2pt", "field_goals_attempted_2pt", "field_goals_made_3pt", "field_goals_attempted_3pt",
      "free_throws_made", "free_throws_attempted", "offensive_rebounds", "defensive_rebounds",
      "total_rebounds", "assists", "steals", "blocks", "blocks_received", "turnovers", "fouls", "fouls_on",
      "efficiency", "points_off_turnovers", "fast_break_points", "second_chance_points", "points_in_paint",
      "bench_points", "biggest_lead", "biggest_scoring_run", "lead_changes", "tie_results", "time_leading"
    )),
    .lkl_named(rep("double", 4L), c(
      "field_goals_percentage", "field_goals_2pt_percentage", "field_goals_3pt_percentage",
      "free_throws_percentage"
    ))
  ),
  period_scores = c(
    game_id = "integer", team_id = "integer", team_side = "character", period = "integer",
    period_type = "character", points = "integer"
  ),
  summary = c(
    game_id = "integer", group = "character", stat = "character", label = "character",
    .lkl_side_spec(c(value = "character", percentage = "double", graph_length = "double", winning = "logical"))
  ),
  lead_chart = c(
    game_id = "integer", period = "integer", diff = "integer", clock = "character", score_home = "integer",
    score_away = "integer", column_height = "double"
  ),
  game_score = c(game_id = "integer", home_score = "integer", away_score = "integer", clock = "character"),
  leaders = c(
    game_id = "integer", category = "character", category_label = "character", team_side = "character",
    team_id = "integer", rank = "integer", player = "character", player_slug = "character",
    player_id = "integer", value = "integer"
  ),
  pbp = c(
    game_id = "integer", event_num = "integer", period = "integer", period_type = "character",
    clock = "character", clock_seconds = "integer", team_side = "character", team_id = "integer",
    player = "character", player_slug = "character", player_id = "integer", type = "character",
    subtype = "character", description = "character", success = "logical", is_points_info = "logical",
    score_home = "integer", score_away = "integer"
  ),
  shots = c(
    game_id = "integer", shot_id = "integer", period = "integer", period_type = "character",
    team_side = "character", team_id = "integer", player_id = "integer", player_slug = "character",
    type = "character", made = "logical", x = "double", y = "double", side = "character", area = "character"
  ),
  results = c(
    season_id = "integer", season_end_year = "integer", game_id = "integer", date = "Date",
    weekday = "character", time = "character", arena = "character", city = "character",
    .lkl_side_spec(c(slug = "character", code = "character", name = "character", score = "integer")),
    winner_highlighted = "character"
  ),
  standings = c(
    season_id = "integer", season_end_year = "integer", table = "character", position = "integer",
    team_slug = "character", team_name = "character", played = "integer", won = "integer", lost = "integer",
    win_pct = "double", streak = "integer", points_for_avg = "double", points_against_avg = "double",
    last5 = "character"
  )
)
.LKL_SPECS$game_stats <- .LKL_SPECS$summary

.lkl_proto <- list(integer = NA_integer_, double = NA_real_, character = NA_character_, logical = NA,
                   Date = NA_character_)

#' `rows` (lists of typed scalars) as a tibble with exactly the spec's columns and types.
#' @noRd
.lkl_frame <- function(short, rows) {
  spec <- .LKL_SPECS[[short]]
  cols <- lapply(names(spec), function(col) {
    proto <- .lkl_proto[[spec[[col]]]]
    v <- vapply(rows, function(r) {
      x <- r[[col]]
      if (is.null(x) || is.na(x)) proto else x
    }, proto, USE.NAMES = FALSE)
    if (spec[[col]] == "Date") v <- as.Date(v, format = "%Y-%m-%d")
    v
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

.lkl_req <- function(raw) {
  r <- if (.lkl_is_obj(raw)) raw[["_request"]] else NULL
  if (.lkl_is_obj(r)) r else list()
}

.lkl_team_ids <- function(req) list(home = .lkl_i(req[["home_team_id"]]), away = .lkl_i(req[["away_team_id"]]))

# slug -> player id (named integer vector; the last of a repeated slug wins)
.lkl_slug_ids <- function(req) {
  players <- req[["players"]]
  out <- integer()
  if (!.lkl_is_obj(players)) return(out)
  for (i in seq_along(players)) {
    k <- names(players)[i]
    v <- .lkl_i(players[[i]])
    if (nzchar(k) && !is.na(v)) out <- .lkl_name_set(out, k, v)
  }
  out
}

.lkl_lookup <- function(map, key) if (is.null(key)) NA else .lkl_name_get(map, key)

.lkl_side_rows <- function(rec) {
  info <- if (.lkl_is_obj(rec)) rec[["teams_info"]] else NULL
  if (!.lkl_is_obj(info)) return(list())
  out <- list()
  for (side in .LKL_SIDES) if (.lkl_is_obj(info[[side]])) out[[side]] <- info[[side]]
  out
}

.lkl_parse_game_info <- function(raw) {
  if (!.lkl_is_obj(raw) || !.lkl_is_obj(raw[["teams_info"]])) return(.lkl_frame("game_info", list()))
  row <- list(
    game_id = .lkl_i(raw[["game_id"]]), game_status = .lkl_s(raw[["game_status"]]),
    start_date = .lkl_date(raw[["start_date"]]), start_time = .lkl_s(raw[["start_time"]]),
    arena = .lkl_s(.lkl_get(raw, "game_info", "arena")), attendance = .lkl_s(.lkl_get(raw, "game_info", "attendance")),
    attendance_count = .lkl_i(raw[["attendance_count"]]), referees = .lkl_s(raw[["referees"]]),
    has_actions = .lkl_b(raw[["has_actions"]]), is_streaming = .lkl_b(raw[["is_streaming"]])
  )
  sides <- .lkl_side_rows(raw)
  for (side in names(sides)) {
    t <- sides[[side]]
    row[paste0(side, c("_team_id", "_team", "_short_name", "_slug", "_winner", "_coach", "_assistant_coach"))] <- list(
      .lkl_i(t[["id"]]), .lkl_s(t[["name"]]), .lkl_s(t[["short_name"]]), .lkl_s(t[["slug"]]), .lkl_b(t[["winner"]]),
      .lkl_s(t[["coach"]]), .lkl_s(t[["assistant_coach"]])
    )
  }
  .lkl_frame("game_info", list(row))
}

.lkl_parse_game_players <- function(raw) {
  if (!.lkl_is_obj(raw) || !.lkl_is_obj(raw[["players"]])) return(.lkl_frame("game_players", list()))
  gid <- .lkl_i(raw[["game_id"]])
  sides <- .lkl_side_rows(raw)
  rows <- list()
  for (side in .LKL_SIDES) {
    tid <- if (is.null(sides[[side]])) NA_integer_ else .lkl_i(sides[[side]][["id"]])
    for (p in .lkl_objs(raw[["players"]][[side]])) {
      rows[[length(rows) + 1L]] <- list(
        game_id = gid, team_side = side, team_id = tid, player_id = .lkl_i(p[["id"]]),
        player = .lkl_s(p[["name"]]), jersey = .lkl_s(p[["jersey"]]), slug = .lkl_s(p[["slug"]])
      )
    }
  }
  .lkl_frame("game_players", rows)
}

.LKL_CELL_INTS <- c("points", "total_rebounds", "offensive_rebounds", "defensive_rebounds", "assists", "steals",
                    "turnovers", "blocks", "blocks_received", "fouls", "fouls_on", "plus_minus", "efficiency")

.lkl_parse_player_box <- function(raw) {
  box <- if (.lkl_is_obj(raw)) raw[["boxscore"]] else NULL
  if (!.lkl_is_obj(box)) return(.lkl_frame("player_box", list()))
  req <- .lkl_req(raw)
  teams <- .lkl_team_ids(req)
  ids <- .lkl_slug_ids(req)
  rows <- list()
  for (side in .LKL_SIDES) {
    for (p in .lkl_objs(.lkl_get(box, side, "players"))) {
      cell <- function(k) .lkl_get(p, k, "value")
      slug <- p[["slug"]]
      row <- list(
        game_id = .lkl_i(req[["game_id"]]), team_side = side, team_id = teams[[side]], player_slug = .lkl_s(slug),
        player_id = if (is.character(slug) && length(slug) == 1L) .lkl_lookup(ids, slug) else NA_integer_,
        player = .lkl_s(cell("name")), jersey = .lkl_s(cell("jersey")), is_starter = .lkl_b(p[["is_starter"]]),
        is_captain = .lkl_b(p[["is_captain"]]), is_active = .lkl_b(p[["is_active"]]),
        seconds_played = .lkl_mmss(cell("time"))
      )
      for (c in .LKL_CELL_INTS) row[[c]] <- .lkl_i(cell(c))
      for (key in c("fg", "fg2", "fg3", "ft")) {
        ma <- .lkl_made_att(cell(key))
        row[[paste0(key, "_made")]] <- ma[1]
        row[[paste0(key, "_attempted")]] <- ma[2]
        row[[paste0(key, "_pct")]] <- .lkl_f(.lkl_get(p, key, "percentage"))
      }
      rows[[length(rows) + 1L]] <- row
    }
  }
  .lkl_frame("player_box", rows)
}

# list(side, row) of gameStatistics (keyed by team id), home first when the sides are known
.lkl_stats_rows <- function(raw) {
  gs <- if (.lkl_is_obj(raw)) raw[["gameStatistics"]] else NULL
  if (!.lkl_is_obj(gs)) return(list())
  teams <- .lkl_team_ids(.lkl_req(raw))
  out <- list()
  for (row in gs) {
    if (!.lkl_is_obj(row)) next
    tid <- .lkl_i(row[["team_id"]])
    side <- NA_character_
    for (s in .LKL_SIDES) if (!is.na(teams[[s]]) && !is.na(tid) && teams[[s]] == tid) { side <- s; break }
    out[[length(out) + 1L]] <- list(side = side, row = row)
  }
  rank <- vapply(out, function(o) if (is.na(o$side)) 2L else match(o$side, .LKL_SIDES) - 1L, integer(1))
  out[order(rank)]
}

.lkl_parse_team_box <- function(raw) {
  spec <- .LKL_SPECS$team_box
  rows <- lapply(.lkl_stats_rows(raw), function(o) {
    r <- o$row
    row <- list(game_id = .lkl_i(r[["game_id"]]), team_id = .lkl_i(r[["team_id"]]), team_side = o$side)
    for (c in names(spec)[spec == "integer"][-(1:2)]) row[[c]] <- .lkl_i(r[[c]])
    for (c in names(spec)[spec == "double"]) row[[c]] <- .lkl_f(r[[c]])
    row
  })
  .lkl_frame("team_box", rows)
}

.lkl_parse_period_scores <- function(raw) {
  rows <- list()
  for (o in .lkl_stats_rows(raw)) {
    r <- o$row
    qs <- r[["quarter_scores"]]
    if (!.lkl_is_obj(qs)) next
    for (k in .lkl_int_keys(qs)) {
      p <- .lkl_i(k)
      rows[[length(rows) + 1L]] <- list(
        game_id = .lkl_i(r[["game_id"]]), team_id = .lkl_i(r[["team_id"]]), team_side = o$side, period = p,
        period_type = if (p <= 4L) "regular" else "overtime", points = .lkl_i(qs[[k]])
      )
    }
  }
  .lkl_frame("period_scores", rows)
}

.lkl_comparison_rows <- function(rows, gid, group_of = character(), group = NA_character_) {
  lapply(.lkl_objs(rows), function(r) {
    label <- .lkl_s(r[["label"]])
    key <- if (is.na(label)) "" else label
    row <- list(
      game_id = gid,
      group = if (!is.na(group)) group else .lkl_name_get(group_of, key, NA_character_),
      stat = .lkl_name_get(.LKL_STAT_CODES, key, NA_character_),
      label = label
    )
    for (side in .LKL_SIDES) {
      c <- r[[side]]
      if (!.lkl_is_obj(c)) c <- list()
      row[paste0(side, c("_value", "_percentage", "_graph_length", "_winning"))] <- list(
        .lkl_s(c[["value"]]), .lkl_f(c[["percentage"]]), .lkl_f(c[["graph_length"]]), .lkl_b(c[["winning"]])
      )
    }
    row
  })
}

.lkl_parse_summary <- function(raw) {
  if (!.lkl_is_obj(raw)) return(.lkl_frame("summary", list()))
  .lkl_frame("summary", .lkl_comparison_rows(raw[["comparison"]], .lkl_i(.lkl_req(raw)[["game_id"]])))
}

.lkl_parse_game_stats <- function(raw) {
  comp <- if (.lkl_is_obj(raw)) raw[["comparison"]] else NULL
  if (!.lkl_is_obj(comp)) return(.lkl_frame("game_stats", list()))
  group_of <- character()
  for (g in c("shooting", "main")) {
    for (r in .lkl_objs(comp[[g]])) {
      lab <- r[["label"]]
      if (is.character(lab) && length(lab) == 1L && !(lab %in% names(group_of))) group_of <- .lkl_name_set(group_of, lab, g)
    }
  }
  .lkl_frame("game_stats", .lkl_comparison_rows(comp[["all"]], .lkl_i(.lkl_req(raw)[["game_id"]]), group_of))
}

.lkl_parse_lead_chart <- function(raw) {
  leads <- if (.lkl_is_obj(raw)) raw[["leads"]] else NULL
  if (!.lkl_is_obj(leads)) return(.lkl_frame("lead_chart", list()))
  gid <- .lkl_i(.lkl_req(raw)[["game_id"]])
  rows <- list()
  for (k in .lkl_int_keys(leads)) {
    for (pt in .lkl_objs(leads[[k]])) {
      rows[[length(rows) + 1L]] <- list(
        game_id = gid, period = .lkl_i(k), diff = .lkl_i(pt[["diff"]]), clock = .lkl_s(pt[["clock"]]),
        score_home = .lkl_i(pt[["score_1"]]), score_away = .lkl_i(pt[["score_2"]]),
        column_height = .lkl_f(pt[["column_height"]])
      )
    }
  }
  .lkl_frame("lead_chart", rows)
}

.lkl_parse_game_score <- function(raw) {
  if (!.lkl_is_obj(raw) || !any(c("home", "away") %in% names(raw))) return(.lkl_frame("game_score", list()))
  .lkl_frame("game_score", list(list(
    game_id = .lkl_i(.lkl_req(raw)[["game_id"]]), home_score = .lkl_i(raw[["home"]]),
    away_score = .lkl_i(raw[["away"]]), clock = .lkl_s(raw[["clock"]])
  )))
}

.lkl_parse_leaders <- function(raw) {
  cats <- if (.lkl_is_obj(raw)) raw[["leaders"]] else NULL
  if (!.lkl_is_obj(cats)) return(.lkl_frame("leaders", list()))
  req <- .lkl_req(raw)
  teams <- .lkl_team_ids(req)
  ids <- .lkl_slug_ids(req)
  rows <- list()
  for (cat in names(cats)) {
    body <- cats[[cat]]
    if (!.lkl_is_obj(body)) next
    for (side in .LKL_SIDES) {
      lead <- body[[side]]
      if (!.lkl_is_obj(lead)) next
      ranked <- c(list(lead), .lkl_objs(lead[["others"]]))
      for (n in seq_along(ranked)) {
        p <- ranked[[n]]
        slug <- .lkl_s(p[["slug"]])
        rows[[length(rows) + 1L]] <- list(
          game_id = .lkl_i(req[["game_id"]]), category = cat, category_label = .lkl_s(body[["label"]]),
          team_side = side, team_id = teams[[side]], rank = n, player = .lkl_s(p[["name"]]), player_slug = slug,
          player_id = .lkl_lookup(ids, slug), value = .lkl_i(p[["value"]])
        )
      }
    }
  }
  .lkl_frame("leaders", rows)
}

#' `list(period, period_type, line)` oldest first from the newest-first `quarters` body.
#'
#' Overtime lines are one merged newest-first list with no period field: the
#' oldest overtime is period 5 and each `period` / `end` line (read oldest
#' first) closes one; the `game` / `end` line keeps the period of the line before.
#' @noRd
.lkl_chronological <- function(quarters) {
  if (!.lkl_is_obj(quarters)) return(list())
  out <- list()
  reg <- quarters[["regular"]]
  for (k in .lkl_int_keys(reg)) {
    lines <- .lkl_objs(reg[[k]])
    for (ln in rev(lines)) out[[length(out) + 1L]] <- list(period = .lkl_i(k), type = "regular", line = ln)
  }
  ot <- .lkl_objs(quarters[["overtime"]])
  done <- 0L
  period <- 5L
  for (ln in rev(ot)) {
    if (!.lkl_eq(ln[["type"]], "game")) period <- 5L + done
    out[[length(out) + 1L]] <- list(period = period, type = "overtime", line = ln)
    if (.lkl_eq(ln[["type"]], "period") && .lkl_eq(ln[["subtype"]], "end")) done <- done + 1L
  }
  out
}

.lkl_side_of <- function(is_home) if (isTRUE(is_home)) "home" else if (isFALSE(is_home)) "away" else NA_character_

.lkl_parse_pbp <- function(raw) {
  req <- .lkl_req(raw)
  teams <- .lkl_team_ids(req)
  ids <- .lkl_slug_ids(req)
  plays <- .lkl_chronological(if (.lkl_is_obj(raw)) raw[["quarters"]] else NULL)
  rows <- lapply(seq_along(plays), function(n) {
    ln <- plays[[n]]$line
    side <- .lkl_side_of(ln[["is_home"]])
    player <- if (.lkl_is_obj(ln[["player"]])) ln[["player"]] else list()
    slug <- .lkl_s(player[["slug"]])
    list(
      game_id = .lkl_i(req[["game_id"]]), event_num = n, period = plays[[n]]$period, period_type = plays[[n]]$type,
      clock = .lkl_s(ln[["clock"]]), clock_seconds = .lkl_mmss(ln[["clock"]]), team_side = side,
      team_id = if (is.na(side)) NA_integer_ else teams[[side]], player = .lkl_s(player[["name"]]),
      player_slug = slug, player_id = .lkl_lookup(ids, slug), type = .lkl_s(ln[["type"]]),
      subtype = .lkl_s(ln[["subtype"]]), description = .lkl_s(ln[["description"]]), success = .lkl_b(ln[["success"]]),
      is_points_info = .lkl_b(ln[["is_points_info"]]), score_home = .lkl_i(.lkl_get(ln, "score", "home")),
      score_away = .lkl_i(.lkl_get(ln, "score", "away"))
    )
  })
  .lkl_frame("pbp", rows)
}

.lkl_parse_shots <- function(raw) {
  q <- if (.lkl_is_obj(raw)) raw[["quarters"]] else NULL
  if (!.lkl_is_obj(q)) return(.lkl_frame("shots", list()))
  req <- .lkl_req(raw)
  teams <- .lkl_team_ids(req)
  ids <- .lkl_slug_ids(req)
  slugs <- character()
  for (i in seq_along(ids)) slugs <- .lkl_name_set(slugs, as.character(ids[[i]]), names(ids)[i]) # id -> slug, the last wins
  reg <- q[["regular"]]
  lines <- list()
  for (k in .lkl_int_keys(reg)) lines <- c(lines, .lkl_objs(reg[[k]]))
  lines <- c(lines, .lkl_objs(q[["overtime"]]))
  rows <- lapply(lines, function(ln) {
    side <- .lkl_side_of(ln[["is_home"]])
    pid <- .lkl_i(ln[["player_id"]])
    ptype <- .lkl_s(ln[["period_type"]])
    list(
      game_id = .lkl_i(req[["game_id"]]), shot_id = .lkl_i(ln[["id"]]), period = .lkl_i(ln[["period"]]),
      period_type = if (is.na(ptype)) NA_character_ else .lkl_lower(ptype), team_side = side,
      team_id = if (is.na(side)) NA_integer_ else teams[[side]], player_id = pid,
      player_slug = if (is.na(pid)) NA_character_ else .lkl_lookup(slugs, as.character(pid)),
      type = .lkl_s(ln[["type"]]), made = .lkl_b(ln[["success"]]), x = .lkl_f(ln[["x"]]), y = .lkl_f(ln[["y"]]),
      side = .lkl_s(ln[["side"]]), area = .lkl_s(ln[["area"]])
    )
  })
  .lkl_frame("shots", rows)
}

.lkl_parse_results <- function(raw) {
  games <- if (.lkl_is_obj(raw)) raw[["games"]] else NULL
  if (!.lkl_is_arr(games)) return(.lkl_frame("results", list()))
  rows <- lapply(.lkl_objs(games), function(g) {
    row <- list(season_id = .lkl_i(raw[["season_id"]]), season_end_year = .lkl_i(raw[["season_end_year"]]),
                game_id = .lkl_i(g[["game_id"]]), date = .lkl_date(g[["date"]]))
    for (c in c("weekday", "time", "arena", "city")) row[[c]] <- .lkl_s(g[[c]])
    for (side in .LKL_SIDES) {
      for (c in c("slug", "code", "name")) row[[paste0(side, "_", c)]] <- .lkl_s(g[[paste0(side, "_", c)]])
      row[[paste0(side, "_score")]] <- .lkl_i(g[[paste0(side, "_score")]])
    }
    row$winner_highlighted <- .lkl_s(g[["winner_highlighted"]])
    row
  })
  .lkl_frame("results", rows)
}

.lkl_parse_standings <- function(raw) {
  if (!.lkl_is_obj(raw)) return(.lkl_frame("standings", list()))
  rows <- list()
  for (table in c("full", "home", "away", "final")) {
    for (r in .lkl_objs(raw[[table]])) {
      l5 <- r[["last5"]]
      l5 <- if (is.list(l5)) {
        paste(unlist(Filter(function(x) is.character(x) && length(x) == 1L, l5)), collapse = "")
      } else if (is.character(l5)) {
        paste(l5, collapse = "")
      } else {
        NA_character_
      }
      rows[[length(rows) + 1L]] <- list(
        season_id = .lkl_i(raw[["season_id"]]), season_end_year = .lkl_i(raw[["season_end_year"]]), table = table,
        position = .lkl_i(r[["position"]]), team_slug = .lkl_s(r[["team_slug"]]), team_name = .lkl_s(r[["team_name"]]),
        played = .lkl_i(r[["played"]]), won = .lkl_i(r[["won"]]), lost = .lkl_i(r[["lost"]]),
        win_pct = .lkl_f(r[["win_pct"]]), streak = .lkl_i(r[["streak"]]),
        points_for_avg = .lkl_f(r[["points_for_avg"]]), points_against_avg = .lkl_f(r[["points_against_avg"]]),
        last5 = l5
      )
    }
  }
  .lkl_frame("standings", rows)
}

#' Parse one wrapper's raw body / record into its documented tibble.
#' @noRd
.lkl_parse <- function(short, raw) {
  f <- switch(short,
    game_info = .lkl_parse_game_info, game_players = .lkl_parse_game_players,
    player_box = .lkl_parse_player_box, team_box = .lkl_parse_team_box,
    period_scores = .lkl_parse_period_scores, summary = .lkl_parse_summary,
    game_score = .lkl_parse_game_score, game_stats = .lkl_parse_game_stats,
    lead_chart = .lkl_parse_lead_chart, leaders = .lkl_parse_leaders, pbp = .lkl_parse_pbp,
    shots = .lkl_parse_shots, results = .lkl_parse_results, standings = .lkl_parse_standings
  )
  f(raw)
}
