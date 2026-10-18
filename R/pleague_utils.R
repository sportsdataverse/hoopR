# pleague_utils.R -- runtime and parsers of the P. LEAGUE+ family (`pleague_*()`):
# the league site pleagueofficial.com and the third-party analytics vendor
# api.preciser.io behind its game page.
#
# R mirror of sdv-py sportsdataverse/basketball/plg/ (pleague_runtime.py,
# pleague_parsers.py, pleague_preciser_runtime.py, pleague_preciser_parsers.py,
# origin/main e3d232e): same routes, same refusals, same column specs.
#
# * Season = END year; the site names a season by its slug, season 2025 ->
#   "2024-25" (`.pleague_season_slug()`). The first season is 2020-21.
# * A game is keyed by `gid`, ONE global integer sequence. The box and
#   play-by-play routes echo no id: the game page is fetched first (cached per
#   gid, finished games do not change) and the body is checked against it
#   (scores, quarters, player points; the play-by-play's periods and final).
#   Only finished games are served.
# * Site transport: GET with a browser User-Agent, redirects NOT followed (the
#   site answers an unknown gid or a season before 2020-21 with a 302 to the home
#   page: hoopR_no_data). 429 / 502 / 503 / 504 are retried; 500 is NOT (the site
#   answers 500 for an unknown id): retry_500 = FALSE. Vendor transport: plain
#   GET, redirects followed but the final host must be api.preciser.io; 500 not
#   retried either (an unknown uuid answers 500).
# * Every wrong answer fails closed (hoopR_asset_fetch): a page of another game,
#   season, stage or player; an unfinished game; a box or play-by-play that does
#   not match its game page; a play-by-play phrase outside the observed
#   vocabulary; layout drift; a vendor access key surviving in a body.
#
# HTML is walked with rvest::read_html() and xml2 node queries (libxml2), keeping
# the sdv-py _Node semantics: a node's text skips <script> / <style>, a <br> is a
# space, whitespace (NBSP included) collapses to one space. Traditional Chinese
# literals are written as \u escapes (the package sources stay ASCII).

.PLEAGUE_HOST <- "https://pleagueofficial.com"
.PLEAGUE_VENDOR <- "https://api.preciser.io"
.PLEAGUE_FIRST_SEASON <- 2021L
.PLEAGUE_UA <- paste("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)",
                     "Chrome/129.0.0.0 Safari/537.36")
.PLEAGUE_REDIRECTS <- c(301L, 302L, 303L, 307L, 308L)
.PLEAGUE_FINAL <- "\u5df2\u5b8c\u8cfd"
.PLEAGUE_STAGES <- c(`pre-season` = "\u71b1\u8eab\u8cfd", `regular-season` = "\u4f8b\u884c\u8cfd", playoffs = "\u5b63\u5f8c\u8cfd",
                     finals = "\u7e3d\u51a0\u8ecd\u8cfd")
.PLEAGUE_STAT_STAGES <- c(`2` = "regular-season", `3` = "playoffs", `4` = "finals")
.PLEAGUE_UUID <- "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
#: Points a box may leave off its player rows (gid 213 is 2 short).
.PLEAGUE_MAX_UNCREDITED <- 3L
#: Rotation stint totals vs the box's mm:ss (live: median 1 s, max 24 s).
.PLEAGUE_ROTATION_TOLERANCE <- 30
.PLEAGUE_WS <- "[\\h\\v]+"

# per-gid game page records and box bodies (sdv-py pleague_runtime._GAMES / _BOXES)
.pleague_cache <- new.env(parent = emptyenv())

#' Forget the cached game pages and box bodies (sdv-py `pleague_runtime.clear_cache`).
#' @noRd
.pleague_clear_cache <- function() {
  rm(list = ls(.pleague_cache, all.names = TRUE), envir = .pleague_cache)
  invisible()
}

# ---------------------------------------------------------------------------
# Small helpers (Python value semantics)
# ---------------------------------------------------------------------------

.pleague_is_obj <- function(x) is.list(x) && !is.null(names(x))
.pleague_is_arr <- function(x) is.list(x) && is.null(names(x))
.pleague_obj <- function(x) if (.pleague_is_obj(x)) x else list()
.pleague_objs <- function(x) if (.pleague_is_arr(x)) Filter(.pleague_is_obj, x) else list()
.pleague_str1 <- function(x) is.character(x) && length(x) == 1L && !is.na(x)
.pleague_one <- function(x) !is.null(x) && !is.list(x) && length(x) == 1L && !is.na(x)

# Python truthiness of a decoded JSON value / record field
.pleague_truthy <- function(x) {
  if (is.null(x) || (length(x) == 1L && !is.list(x) && is.na(x))) return(FALSE)
  if (is.list(x)) return(length(x) > 0L)
  if (length(x) != 1L) return(length(x) > 0L)
  if (is.logical(x)) return(x)
  if (is.numeric(x)) return(x != 0)
  if (is.character(x)) return(nzchar(x))
  TRUE
}

# Python == between two decoded scalars: numbers by value, strings by text, else unequal
.pleague_eq <- function(a, b) {
  if (!.pleague_one(a) || !.pleague_one(b)) return(is.null(a) && is.null(b))
  if (is.numeric(a) && is.numeric(b)) return(a == b)
  if (is.character(a) && is.character(b)) return(a == b)
  if (is.logical(a) && is.logical(b)) return(a == b)
  FALSE
}

.pleague_or <- function(x, y) if (is.null(x) || (length(x) == 1L && is.na(x))) y else x

# Python re.sub(r"\s+", " ", s).strip() / str.strip()
.pleague_squish <- function(x) trimws(gsub(.PLEAGUE_WS, " ", x, perl = TRUE), whitespace = "[\\h\\v]")
.pleague_strip <- function(x) trimws(x, whitespace = "[\\h\\v]")

# re.search (`pattern` as given) / re.fullmatch: the match then its groups ("" when unset), or NULL
.pleague_match <- function(pattern, x) {
  if (!.pleague_str1(x)) return(NULL)
  m <- regmatches(x, regexec(pattern, x, perl = TRUE))[[1]]
  if (length(m)) m else NULL
}
.pleague_full <- function(pattern, x, ucp = FALSE) {
  .pleague_match(paste0(if (ucp) "(*UCP)", "^(?:", pattern, ")\\z"), x)
}

# every match's first group (re.findall with one group)
.pleague_groups <- function(pattern, x) {
  m <- regmatches(x, gregexec(pattern, x, perl = TRUE))[[1]]
  if (!length(m)) character() else unname(m[2, ])
}

# a refusal inside a page walk: sdv-py pleague_parsers._NotParsed (`empty` = no data)
.pleague_refuse <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "hoopR_pleague_not_parsed", empty = empty)
}
.pleague_need <- function(node, what) {
  if (is.null(node)) .pleague_refuse(paste0("layout drift: ", what, " not found"))
  node
}
.pleague_check <- function(what, got, want) {
  if (!identical(got, want)) {
    .pleague_refuse(sprintf("out of scope: %s %s, asked for %s", what, .pleague_repr(got), .pleague_repr(want)))
  }
}
.pleague_repr <- function(x) {
  if (is.null(x)) return("None")
  if (is.character(x)) x <- sprintf("'%s'", x)
  if (length(x) == 1L) as.character(x) else paste0("[", paste(x, collapse = ", "), "]")
}

.pleague_int_text <- function(s) {
  s <- gsub(",", "", .pleague_strip(if (.pleague_str1(s)) s else ""), fixed = TRUE)
  if (grepl("^[+-]?[0-9]+$", s, perl = TRUE)) suppressWarnings(as.integer(s)) else NA_integer_
}
.pleague_num_text <- function(s) {
  s <- sub("%+$", "", gsub(",", "", .pleague_strip(if (.pleague_str1(s)) s else ""), fixed = TRUE))
  if (grepl("^[+-]?[0-9]+(\\.[0-9]+)?$", s, perl = TRUE)) as.double(s) else NA_real_
}
.pleague_flt_text <- function(s) {
  s <- .pleague_strip(if (.pleague_str1(s)) s else "")
  if (grepl("^-?[0-9]+(\\.[0-9]+)?$", s, perl = TRUE)) as.double(s) else NA_real_
}

# sdv-py pleague_parsers._i / _f / _s / _seconds / _score
.pleague_i <- function(v) {
  if (!.pleague_one(v) || is.logical(v)) return(NA_integer_)
  if (is.numeric(v)) return(if (v == trunc(v) && abs(v) <= .Machine$integer.max) as.integer(v) else NA_integer_)
  if (is.character(v) && grepl("^[\\h\\v]*[+-]?[0-9]+[\\h\\v]*$", v, perl = TRUE)) {
    return(suppressWarnings(as.integer(.pleague_strip(v))))
  }
  NA_integer_
}
.pleague_f <- function(v) {
  if (!.pleague_one(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("^[\\h\\v]*[+-]?[0-9]+(\\.[0-9]+)?[\\h\\v]*$", v, perl = TRUE)) {
    return(as.double(.pleague_strip(v)))
  }
  NA_real_
}
.pleague_s <- function(v) {
  if (!.pleague_str1(v)) return(NA_character_)
  v <- .pleague_strip(v)
  if (nzchar(v)) v else NA_character_
}
.pleague_seconds <- function(v) {
  m <- .pleague_full("[\\h\\v]*([0-9]+):([0-9]{2})[\\h\\v]*", v)
  if (is.null(m)) NA_integer_ else as.integer(m[2]) * 60L + as.integer(m[3])
}
.pleague_score <- function(v) {
  if (is.integer(v) && .pleague_one(v)) return(v)
  if (.pleague_str1(v) && grepl("^[0-9]+$", v, perl = TRUE)) return(suppressWarnings(as.integer(v)))
  NA_integer_
}
.pleague_lgl <- function(v) if (is.logical(v) && .pleague_one(v)) v else NA
.pleague_date <- function(v) {
  if (.pleague_str1(v) && grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", v) &&
      !is.na(as.Date(v, format = "%Y-%m-%d", optional = TRUE))) v else NA_character_
}
.pleague_na_if_blank <- function(x) if (.pleague_str1(x) && nzchar(x)) x else NA_character_

# sdv-py _int_arg: a non-negative integer, or a string of digits
.pleague_int_arg <- function(value, what, call) {
  ok <- (is.numeric(value) && .pleague_one(value) && value >= 0 && value == trunc(value)) ||
    (.pleague_str1(value) && grepl("^[\\h\\v]*[0-9]+[\\h\\v]*$", value, perl = TRUE))
  if (!ok) {
    got <- .pleague_repr(if (is.null(value) || is.list(value)) NULL else value[1])
    .abort_bad_request("{what} must be a non-negative integer; got {got}", call = call)
  }
  as.integer(.pleague_strip(as.character(value)))
}

#' The site's slug of a season END year (2025 -> "2024-25"): sdv-py's stray `season_slug` export.
#'
#' @param season The season END year.
#' @return `sprintf("%d-%02d", season - 1, season %% 100)`.
#' @noRd
.pleague_season_slug <- function(season, call = rlang::caller_env()) {
  n <- .pleague_int_arg(season, "season", call)
  if (n < .PLEAGUE_FIRST_SEASON) {
    got <- .pleague_repr(season)
    .abort_no_data("the site's first season is 2020-21 (season=2021); got season={got}",
                   call = call)
  }
  sprintf("%d-%02d", n - 1L, n %% 100L)
}

# "2024-25" -> 2025 (sdv-py season_end_year)
.pleague_season_end_year <- function(season) as.integer(substr(season, 1, 4)) + 1L

# ---------------------------------------------------------------------------
# DOM (rvest / libxml2), with the sdv-py _Node semantics
# ---------------------------------------------------------------------------

# blank text nodes are kept (no NOBLANKS): sdv-py's parser keeps them and they separate words
.pleague_dom <- function(html) {
  rvest::read_html(charToRaw(enc2utf8(html)), encoding = "UTF-8", options = c("RECOVER", "NOERROR", "NONET"))
}

# tag + every class in `cls` (a set, as _Node.findall) + exact attributes
.pleague_xpath <- function(tag = NULL, cls = NULL, id = NULL) {
  preds <- character()
  if (!is.null(cls)) {
    preds <- sprintf("contains(concat(' ', normalize-space(@class), ' '), ' %s ')", strsplit(cls, " ", fixed = TRUE)[[1]])
  }
  if (!is.null(id)) preds <- c(preds, sprintf("@id='%s'", id))
  paste0(".//", if (is.null(tag)) "*" else tag, if (length(preds)) paste0("[", paste(preds, collapse = " and "), "]"))
}

# xml2 queries with an empty namespace map (the default walks the whole document per call)
.pleague_xfind <- function(node, xpath) xml2::xml_find_all(node, xpath, ns = character())

.pleague_find <- function(node, tag = NULL, cls = NULL, id = NULL) {
  if (is.null(node)) return(NULL)
  hit <- xml2::xml_find_first(node, .pleague_xpath(tag, cls, id), ns = character())
  if (inherits(hit, "xml_missing")) NULL else hit
}
.pleague_findall <- function(node, tag = NULL, cls = NULL, id = NULL) {
  if (is.null(node)) return(list())
  as.list(.pleague_xfind(node, .pleague_xpath(tag, cls, id)))
}
.pleague_kids <- function(node, tag) as.list(.pleague_xfind(node, paste0("./", tag)))
.pleague_children <- function(node) as.list(.pleague_xfind(node, "./node()[not(self::comment())]"))
.pleague_parent <- function(node) {
  p <- xml2::xml_parent(node)
  if (inherits(p, "xml_missing")) NULL else p
}
.pleague_attr <- function(node, name) xml2::xml_attr(node, name)
.pleague_classes <- function(node) {
  cls <- .pleague_attr(node, "class")
  if (is.na(cls)) character() else unique(strsplit(.pleague_strip(cls), "[\\h\\v]+", perl = TRUE)[[1]])
}

# sdv-py _Node.text(): text descendants outside <script> / <style>, <br> = " ", whitespace collapsed
.pleague_text <- function(node) {
  if (is.null(node)) return("")
  parts <- .pleague_xfind(node, ".//text()[not(ancestor::script) and not(ancestor::style)] | .//br")
  txt <- xml2::xml_text(parts)
  txt[xml2::xml_type(parts) != "text"] <- " "
  .pleague_squish(paste(txt, collapse = ""))
}

# ---------------------------------------------------------------------------
# Page records (sdv-py pleague_parsers.record_for and the refs capture shapes)
# ---------------------------------------------------------------------------

.PLEAGUE_PHASES <- c("before-today", "is-today", "is-future")

.pleague_schedule_record <- function(html, stage, season) {
  root <- .pleague_dom(gsub("<br>", " ", gsub("<br />", " ", html, fixed = TRUE), fixed = TRUE))
  title <- .pleague_text(.pleague_need(.pleague_find(root, "title"), "title"))
  m <- .pleague_match("^([0-9]{4}-[0-9]{2})-(\u71b1\u8eab\u8cfd|\u4f8b\u884c\u8cfd|\u5b63\u5f8c\u8cfd|\u7e3d\u51a0\u8ecd\u8cfd)\u8cfd\u7a0b", title)
  if (is.null(m)) .pleague_refuse(sprintf("layout drift: schedule title '%s'", title))
  .pleague_check("season", m[2], season)
  .pleague_check("stage", m[3], .PLEAGUE_STAGES[[stage]])
  rows <- .pleague_findall(root, "div", "match_row justify-content-center")
  if (!length(rows)) .pleague_refuse("zero games on the schedule page (a stage this season does not have)", empty = TRUE)
  games <- list()
  months <- character()
  for (row in rows) {
    cls <- .pleague_classes(row)
    month <- substring(grep("^d-[0-9]{4}-[0-9]{2}$", cls, value = TRUE, perl = TRUE), 3)[1]
    phase <- .PLEAGUE_PHASES[.PLEAGUE_PHASES %in% cls][1]
    ids <- as.integer(substring(grep("^team-[0-9]+$", cls, value = TRUE, perl = TRUE), 6))
    home_ids <- as.integer(substring(grep("^team-home-[0-9]+$", cls, value = TRUE, perl = TRUE), 11))
    if (is.na(month) || is.na(phase) || length(ids) != 2L || length(home_ids) != 1L || !home_ids %in% ids) {
      .pleague_refuse(sprintf("layout drift: match row classes [%s]", paste(sort(cls), collapse = ", ")))
    }
    months <- union(months, month)
    home_id <- home_ids
    away_id <- ids[ids != home_id][1]
    if (is.na(away_id)) .pleague_refuse("layout drift: match row team classes")
    dt <- .pleague_need(.pleague_find(row, "div", "match_row_datetime"), "datetime")
    parts <- vapply(as.list(.pleague_xfind(dt, ".//*[self::h5 or self::h6]")), .pleague_text, "")
    parts <- parts[nzchar(parts)]
    star <- !is.null(.pleague_find(dt, "i", "czi-star-filled"))
    if (length(parts) != 3L) .pleague_refuse(sprintf("layout drift: datetime block [%s]", paste(parts, collapse = ", ")))
    mm <- .pleague_full("([0-9][0-9])/([0-9][0-9])", parts[1])
    wm <- .pleague_full("\\((.)\\)", parts[2])
    if (is.null(mm) || is.null(wm) || is.null(.pleague_full("[0-9][0-9]:[0-9][0-9]", parts[3]))) {
      .pleague_refuse(sprintf("layout drift: datetime '%s' '%s' '%s'", parts[1], parts[2], parts[3]))
    }
    if (as.integer(substr(month, 6, 7)) != as.integer(mm[2])) {
      .pleague_refuse(sprintf("layout drift: month class %s vs date %s", month, parts[1]))
    }
    cols <- .pleague_findall(row, "div", "col-lg-3")
    if (length(cols) != 2L) .pleague_refuse("layout drift: team columns")
    teams <- list()
    labels <- c("\u5ba2\u968a", "\u4e3b\u968a")
    for (k in 1:2) {
      col <- cols[[k]]
      if (!grepl(labels[k], .pleague_text(col), fixed = TRUE)) {
        .pleague_refuse(sprintf("layout drift: team column lacks %s", labels[k]))
      }
      teams[[k]] <- list(
        zh = .pleague_text(.pleague_need(.pleague_find(col, "span", "PC_only fs14"), "team name")),
        en = .pleague_text(.pleague_need(.pleague_find(col, "span", "fs12 PC_only"), "team English name")),
        logo = .pleague_attr(.pleague_need(.pleague_find(col, "img"), "team logo"), "src")
      )
    }
    info <- .pleague_need(.pleague_find(row, "div", "col-lg-4"), "score column")
    scores <- vapply(.pleague_findall(info, "h6", "PC_only ff8bit"), .pleague_text, "")
    if (length(scores) != 2L || anyNA(vapply(scores, .pleague_int_text, 1L))) {
      .pleague_refuse(sprintf("layout drift: scores [%s]", paste(scores, collapse = ", ")))
    }
    label <- .pleague_text(.pleague_need(.pleague_find(info, "h5", "fs14"), "game label"))
    venue <- .pleague_text(.pleague_need(.pleague_find(info, "h5", "fs12 mb-0"), "venue"))
    seats <- .pleague_match("([0-9,]+)[\\h\\v]*/[\\h\\v]*([0-9,]+)", .pleague_text(info))
    anchors <- .pleague_findall(row, "a")
    hrefs <- vapply(anchors, function(a) .pleague_attr(a, "href"), "")
    link <- hrefs[!is.na(hrefs) & grepl("^/game/[0-9]+$", hrefs, perl = TRUE)]
    clicks <- vapply(anchors, function(a) .pleague_attr(a, "onclick"), "")
    track <- .pleague_match("trackGame\\('([0-9]+)'", paste(ifelse(is.na(clicks), "null", clicks), collapse = ", "))
    if (length(link) != 1L || is.null(track) || as.integer(substring(link, 7)) != as.integer(track[2])) {
      .pleague_refuse(sprintf("layout drift: game link [%s] vs trackGame", paste(link, collapse = ", ")))
    }
    games[[length(games) + 1L]] <- list(
      gid = as.integer(substring(link, 7)),
      date = sprintf("%d-%s-%s", as.integer(substr(month, 1, 4)), mm[2], mm[3]),
      weekday_zh = wm[2], time = parts[3], starred = star, game_label = label, venue_zh = venue,
      attendance = if (is.null(seats)) NA_integer_ else .pleague_int_text(seats[2]),
      capacity = if (is.null(seats)) NA_integer_ else .pleague_int_text(seats[3]),
      phase = gsub("-", "_", phase, fixed = TRUE),
      away_team_id = away_id, away_name_zh = teams[[1]]$zh, away_name_en = teams[[1]]$en,
      away_logo = teams[[1]]$logo, away_score = .pleague_int_text(scores[1]),
      home_team_id = home_id, home_name_zh = teams[[2]]$zh, home_name_en = teams[[2]]$en,
      home_logo = teams[[2]]$logo, home_score = .pleague_int_text(scores[2])
    )
  }
  gids <- vapply(games, `[[`, 1L, "gid")
  if (anyDuplicated(gids)) .pleague_refuse("duplicate game ids on the schedule page")
  vals <- vapply(.pleague_findall(root, "button", "month-btn"), function(b) .pleague_attr(b, "data-val"), "")
  shown <- unique(vals[!is.na(vals) & vals != "all"])
  if (!setequal(shown, months)) {
    .pleague_refuse(sprintf("month buttons [%s] vs months with games [%s]", paste(sort(shown), collapse = ", "),
                            paste(sort(months), collapse = ", ")))
  }
  list(season = season, season_sdv = .pleague_season_end_year(season), stage = stage,
       stage_zh = .PLEAGUE_STAGES[[stage]], game_count = length(games), games = games[order(gids)])
}

.PLEAGUE_QUARTER_ID <- "(q[1-4]|ot[1-9])_(away|home)"

.pleague_game_record <- function(html, gid) {
  m <- .pleague_match("window\\.gid\\s*=\\s*\"([0-9]+)\"", html)
  if (is.null(m)) .pleague_refuse("layout drift: window.gid not found")
  .pleague_check("gid", as.integer(m[2]), gid)
  u <- .pleague_groups("getPlayByPlay\\('([^']*)'\\)", html)
  if (length(u) != 1L) .pleague_refuse(sprintf("layout drift: getPlayByPlay calls %d", length(u)))
  if (any(.pleague_groups("(?:fetchChartData|fetchData)\\('([^']*)'\\)", html) != u)) {
    .pleague_refuse("layout drift: the page's uuids disagree")
  }
  if (nzchar(u) && is.null(.pleague_full("[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}", u))) {
    .pleague_refuse(sprintf("uuid not a uuid: '%s'", u))
  }
  root <- .pleague_dom(html)
  head <- .pleague_need(.pleague_find(root, "div", "card-header game_header"), "game header")
  dm <- .pleague_match("([0-9]{4}-[0-9]{2}-[0-9]{2}) ([0-9][0-9]:[0-9][0-9])", .pleague_text(head))
  first_text <- function(nodes, keep) {
    for (n in nodes) if (keep(n)) return(.pleague_text(n))
    NULL
  }
  venue <- first_text(.pleague_findall(head, "a"), function(a) {
    grepl("google.com/maps", .pleague_or(.pleague_attr(a, "href"), ""), fixed = TRUE)
  })
  label <- first_text(.pleague_findall(head, "span"), function(s) "fs16" %in% .pleague_classes(s))
  if (is.null(dm) || !.pleague_truthy(venue) || !.pleague_truthy(label)) {
    .pleague_refuse("layout drift: game header date / venue / label")
  }
  badge <- .pleague_text(.pleague_need(.pleague_find(root, "span", "badge badge-secondary"), "status badge"))
  sides <- list()
  fs10 <- .pleague_findall(root, "span", "fs10")
  for (side in c("away", "home")) {
    zh <- c(away = "\u5ba2\u968a", home = "\u4e3b\u968a")[[side]]
    tag <- NULL
    for (s in fs10) if (identical(.pleague_text(s), zh)) {
      tag <- s
      break
    }
    col <- .pleague_parent(.pleague_need(tag, paste(zh, "label")))
    score <- .pleague_text(.pleague_need(.pleague_find(col, "h6", paste0("score_", side)), paste(side, "score")))
    name <- .pleague_text(.pleague_need(.pleague_find(col, "h6", "fs14 mt-2 pb-0"), paste(side, "name")))
    en <- .pleague_text(.pleague_need(.pleague_find(col, "small"), paste(side, "English name")))
    logo <- .pleague_attr(.pleague_need(.pleague_find(.pleague_parent(col), "img"), paste(side, "logo")), "src")
    if (is.na(.pleague_int_text(score))) .pleague_refuse(sprintf("layout drift: %s score '%s'", side, score))
    sides[[side]] <- list(name = name, en = .pleague_na_if_blank(en), logo = logo, score = .pleague_int_text(score))
  }
  quarters <- list()
  for (td in .pleague_xfind(root, ".//td[@id]")) {
    i <- .pleague_attr(td, "id")
    if (!is.null(.pleague_full(.PLEAGUE_QUARTER_ID, i))) {
      v <- .pleague_int_text(.pleague_text(td))
      if (is.na(v)) .pleague_refuse(sprintf("layout drift: %s '%s'", i, .pleague_text(td)))
      quarters[[i]] <- v
    }
  }
  if (!all(paste0("q", rep(1:4, each = 2), "_", c("away", "home")) %in% names(quarters))) {
    .pleague_refuse("layout drift: quarter score cells")
  }
  officials <- list()
  box <- .pleague_find(root, "div", "container text-center fs12 text-light my-3")
  if (!is.null(box)) {
    role <- NA_character_
    for (c in .pleague_children(box)) {
      if (xml2::xml_type(c) == "element" && xml2::xml_name(c) == "b") {
        role <- .pleague_text(c)
      } else if (xml2::xml_type(c) == "text") {
        nm <- .pleague_strip(xml2::xml_text(c))
        if (nzchar(nm) && .pleague_truthy(role)) {
          officials[[length(officials) + 1L]] <- list(role_zh = role, name_zh = nm)
          role <- NA_character_
        }
      }
    }
  }
  list(gid = gid, uuid = .pleague_na_if_blank(u), status_zh = badge, date = dm[2], time = dm[3],
       venue_zh = venue, game_label_zh = label,
       away_name_zh = sides$away$name, away_name_en = sides$away$en, away_logo = sides$away$logo,
       away_score = sides$away$score,
       home_name_zh = sides$home$name, home_name_en = sides$home$en, home_logo = sides$home$logo,
       home_score = sides$home$score, quarters = quarters, officials = officials)
}

# ---------------------------------------------------------------------------
# Play-by-play fragment and its phrase vocabulary
# ---------------------------------------------------------------------------

# (phrase stem, code stem, English)
.PLEAGUE_SHOT_STYLES <- list(
  c("\u4e0a\u7c43", "layup", "layup"), c("\u7a81\u7834\u4e0a\u7c43", "driving_layup", "driving layup"),
  c("\u8df3\u6295", "jump_shot", "jump shot"), c("\u62cb\u6295", "floater", "floater"),
  c("\u88dc\u7c43", "putback", "putback / tip-in"), c("\u704c\u7c43", "dunk", "dunk"),
  c("\u8f49\u8eab\u8df3\u6295", "turnaround_jumper", "turnaround jumper"), c("\u6025\u505c\u8df3\u6295", "pull_up_jumper", "pull-up jumper"),
  c("\u5f8c\u4ef0\u8df3\u6295", "fadeaway_jumper", "fadeaway jumper"), c("\u52fe\u5c04", "hook_shot", "hook shot"),
  c("\u5f8c\u64a4\u6b65\u6295\u7c43", "step_back_shot", "step-back shot"), c("alleyOop", "alley_oop", "alley-oop")
)
.PLEAGUE_FIXED <- list(
  c("\u4e09\u5206\u7403\u5f97\u5206", "fg3_made", "3-point shot, style not recorded, made"),
  c("\u4e09\u5206\u7403\u4e0d\u9032", "fg3_missed", "3-point shot, style not recorded, missed"),
  c("\u5f97\u5206", "fg_made", "field goal made, shot type and distance not recorded"),
  c("\u4e0d\u9032", "fg_missed", "field goal missed, shot type and distance not recorded"),
  c("\u6436\u5230\u9032\u653b\u7c43\u677f", "reb_off", "offensive rebound (a team rebound has no player)"),
  c("\u6436\u5230\u9632\u5b88\u7c43\u677f", "reb_def", "defensive rebound (a team rebound has no player)"),
  c("\u52a9\u653b", "ast", "assist"), c("\u6284\u622a", "stl", "steal"), c("\u963b\u653b", "blk", "block"),
  c("\u50b3\u7403\u5931\u8aa4", "tov_bad_pass", "turnover: bad pass"),
  c("\u63a7\u7403\u5931\u8aa4", "tov_ball_handling", "turnover: ball-handling"),
  c("\u9032\u653b\u5931\u8aa4", "tov_offensive", "turnover: offensive (kind not recorded)"),
  c("\u5e36\u7403\u8d70\u6b65", "tov_travel", "turnover: travelling"),
  c("\u7403\u51fa\u754c", "tov_out_of_bounds", "turnover: ball out of bounds"),
  c("3Sec \u5931\u8aa4", "tov_3sec", "turnover: 3-second violation"),
  c("5Sec \u5931\u8aa4", "tov_5sec", "turnover: 5-second violation"),
  c("8Sec \u5931\u8aa4", "tov_8sec", "turnover: 8-second violation"),
  c("shotClock \u5931\u8aa4", "tov_shot_clock", "turnover: shot-clock violation"),
  c("backCourt \u5931\u8aa4", "tov_backcourt", "turnover: backcourt violation"),
  c("doubleDribble \u5931\u8aa4", "tov_double_dribble", "turnover: double dribble"),
  c("carrying \u5931\u8aa4", "tov_carrying", "turnover: carrying the ball"),
  c("offensiveGoalTending \u5931\u8aa4", "tov_offensive_goaltending", "turnover: offensive goaltending"),
  c("\u5176\u4ed6\u5931\u8aa4", "tov_other", "turnover: other"),
  c("\u500b\u4eba\u72af\u898f", "foul_personal", "personal foul committed"),
  c("\u9032\u653b\u72af\u898f", "foul_offensive", "offensive foul committed"),
  c("\u9020\u6210\u5c0d\u624b\u72af\u898f", "foul_drawn", "foul drawn (the opponent's foul on this player)"),
  c("\u6280\u8853\u72af\u898f", "foul_technical", "technical foul"),
  c("\u9055\u53cd\u904b\u52d5\u9053\u5fb7\u72af\u898f", "foul_unsportsmanlike", "unsportsmanlike foul"),
  c("\u72af\u898fdisqualifying", "foul_disqualifying", "disqualifying foul"),
  c("\u72af\u898fcoachTechnical", "foul_coach_technical", "technical foul on the coach"),
  c("\u72af\u898fbenchTechnical", "foul_bench_technical", "technical foul on the bench"),
  c("\u72af\u898f", "foul", "foul, kind not recorded (team row)"),
  c("\u66ab\u505c", "timeout", "timeout (a team row)"),
  c("videoReview, coachChallenge,", "review_coach_challenge",
    "video review: coach's challenge (2025-26 onward; the printed text ends with a bare comma)"),
  c("videoReview, instantReplaySystem,", "review_instant_replay",
    "video review: instant-replay system, started by the officials (2025-26 onward)"),
  c("videoReview, instantReplaySystem, 1", "review_instant_replay_1",
    paste("video review: instant-replay system, variant printed with a trailing '1' (meaning unexplained; the row",
          "also prints the running score and the points tag '+videoReview')")),
  c("\u66ff\u63db\u4e0a\u5834", "sub_in", "substitution: enters the game"),
  c("\u4e0b\u5834\u4f11\u606f", "sub_out", "substitution: leaves the game"),
  c("\u8df3\u7403 \u8d0f", "jump_ball_won", "jump ball won"), c("\u8df3\u7403 \u8f38", "jump_ball_lost", "jump ball lost")
)

#: phrase -> events over the 404 finished 2022-23..2025-26 games; "" = a row with no action text.
.PLEAGUE_OBSERVED <- stats::setNames(
  c(
    29537, 25532, 25505, 17046, 17035, 17020, 15745, 12379, 7817, 7361, 6325, 5798, 5187, 4428, 4281, 3961, 3606,
    3547, 3403, 3181, 3052, 2854, 2736, 2319, 2138, 1920, 1657, 1564, 1539, 1326, 1316, 1158, 1121, 1024, 1007, 1004,
    922, 773, 718, 708, 672, 669, 610, 583, 559, 489, 480, 441, 410, 404, 261, 210, 249, 245, 243, 205, 169, 168,
    162, 158, 149, 128, 96, 92, 82, 81, 75, 67, 67, 53, 51, 48, 47, 46, 40, 35, 26, 23, 18, 10, 6, 4, 2
  ),
  # names via setNames(): a non-ASCII name written in source is lost in a C locale
  c(
    "\u6436\u5230\u9632\u5b88\u7c43\u677f", "\u4e0b\u5834\u4f11\u606f", "\u66ff\u63db\u4e0a\u5834",
    "\u4e09\u5206\u7403\u4e0d\u9032", "\u9020\u6210\u5c0d\u624b\u72af\u898f", "\u52a9\u653b",
    "\u500b\u4eba\u72af\u898f", "\u6436\u5230\u9032\u653b\u7c43\u677f", "\u4e09\u5206\u7403\u5f97\u5206",
    "\u6284\u622a", "\u50b3\u7403\u5931\u8aa4", "\u7b2c\u4e8c\u7f70 \u7f70\u9032",
    "\u5f97\u5230\u5169\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u7f70\u9032", "\u4e0a\u7c43\u5f97\u5206",
    "\u7a81\u7834\u4e0a\u7c43\u5f97\u5206", "\u7a81\u7834\u4e0a\u7c43\u4e0d\u9032", "\u8df3\u6295\u4e0d\u9032",
    "\u63a7\u7403\u5931\u8aa4", "\u4e0a\u7c43\u4e0d\u9032", "\u963b\u653b", "\u62cb\u6295\u4e0d\u9032",
    "\u66ab\u505c", "\u5f97\u5230\u5169\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u4e0d\u9032",
    "\u7b2c\u4e8c\u7f70 \u4e0d\u9032", "\u88dc\u7c43\u5f97\u5206", "\u62cb\u6295\u5f97\u5206",
    "\u8df3\u6295\u5f97\u5206", "\u6025\u505c\u8df3\u6295\u4e0d\u9032", "\u88dc\u7c43\u4e0d\u9032",
    "\u5f97\u5230\u4e00\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u7f70\u9032", "\u704c\u7c43\u5f97\u5206",
    "\u8f49\u8eab\u8df3\u6295\u4e0d\u9032", "\u5f8c\u4ef0\u8df3\u6295\u4e0d\u9032", "\u9032\u653b\u72af\u898f",
    "\u9032\u653b\u5931\u8aa4", "\u6025\u505c\u8df3\u6295\u5f97\u5206",
    "\u4e09\u5206\u5916\u7dda\u6025\u505c\u8df3\u6295\u4e0d\u9032", "\u52fe\u5c04\u4e0d\u9032",
    "\u5e36\u7403\u8d70\u6b65", "\u8df3\u7403 \u8d0f", "\u8f49\u8eab\u8df3\u6295\u5f97\u5206",
    "\u5f97\u5230\u4e00\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u4e0d\u9032", "\u52fe\u5c04\u5f97\u5206",
    "\u5f8c\u4ef0\u8df3\u6295\u5f97\u5206", "\u4e09\u5206\u5916\u7dda\u5f8c\u64a4\u6b65\u6295\u7c43\u4e0d\u9032",
    "shotClock \u5931\u8aa4", "\u4e09\u5206\u5916\u7dda\u6025\u505c\u8df3\u6295\u5f97\u5206", "\u7403\u51fa\u754c",
    "\u5f8c\u64a4\u6b65\u6295\u7c43\u4e0d\u9032", "\u8df3\u7403 \u8f38",
    "\u9055\u53cd\u904b\u52d5\u9053\u5fb7\u72af\u898f", "\u6280\u8853\u72af\u898f", "3Sec \u5931\u8aa4",
    "\u4e09\u5206\u5916\u7dda\u5f8c\u64a4\u6b65\u6295\u7c43\u5f97\u5206",
    "\u5f8c\u64a4\u6b65\u6295\u7c43\u5f97\u5206", "alleyOop\u5f97\u5206", " ", "\u4e0d\u9032",
    "\u704c\u7c43\u4e0d\u9032", "\u5f97\u5206", "\u7b2c\u4e09\u7f70 \u7f70\u9032",
    "\u5f97\u5230\u4e09\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u7f70\u9032", "backCourt \u5931\u8aa4",
    "\u4e09\u5206\u5916\u7dda\u5f8c\u4ef0\u8df3\u6295\u4e0d\u9032", "videoReview, coachChallenge,",
    "alleyOop\u4e0d\u9032", "\u72af\u898fcoachTechnical", "videoReview, instantReplaySystem,",
    "\u5f97\u5230\u4e09\u6b21\u7f70\u7403 \u7b2c\u4e00\u7f70 \u4e0d\u9032", "doubleDribble \u5931\u8aa4",
    "\u5176\u4ed6\u5931\u8aa4", "\u4e09\u5206\u5916\u7dda\u5f8c\u4ef0\u8df3\u6295\u5f97\u5206",
    "carrying \u5931\u8aa4", "\u7b2c\u4e09\u7f70 \u4e0d\u9032", "5Sec \u5931\u8aa4", "\u72af\u898fbenchTechnical",
    "8Sec \u5931\u8aa4", "\u4e09\u5206\u5916\u7dda\u8f49\u8eab\u8df3\u6295\u4e0d\u9032", "\u72af\u898f",
    "\u4e09\u5206\u5916\u7dda\u8f49\u8eab\u8df3\u6295\u5f97\u5206", "videoReview, instantReplaySystem, 1",
    "offensiveGoalTending \u5931\u8aa4", "\u72af\u898fdisqualifying"
  )
)
# the blank-phrase row is keyed " " above (an R name cannot be ""): rename it
names(.PLEAGUE_OBSERVED)[names(.PLEAGUE_OBSERVED) == " "] <- ""

# sdv-py pleague_parsers._actions(): the generated shapes, kept only where observed
.pleague_actions <- function() {
  code <- character()
  en <- character()
  add <- function(z, c, e) {
    code[[z]] <<- c
    en[[z]] <<- e
  }
  threes <- Filter(function(s) s[2] %in% c("step_back_shot", "pull_up_jumper", "turnaround_jumper", "fadeaway_jumper"),
                   .PLEAGUE_SHOT_STYLES)
  threes <- lapply(threes, function(s) c(paste0("\u4e09\u5206\u5916\u7dda", s[1]), s[2], s[3]))
  outcomes <- list(c("\u5f97\u5206", "made", "made"), c("\u4e0d\u9032", "missed", "missed"))
  for (grp in list(list(.PLEAGUE_SHOT_STYLES, "fg2", "2-point "), list(threes, "fg3", "3-point "))) {
    for (s in grp[[1]]) for (o in outcomes) {
      add(paste0(s[1], o[1]), sprintf("%s_%s_%s", grp[[2]], s[2], o[2]), sprintf("%s%s, %s", grp[[3]], s[3], o[3]))
    }
  }
  for (f in .PLEAGUE_FIXED) add(f[1], f[2], f[3])
  counts <- c("", "\u5f97\u5230\u4e00\u6b21\u7f70\u7403 ", "\u5f97\u5230\u5169\u6b21\u7f70\u7403 ", "\u5f97\u5230\u4e09\u6b21\u7f70\u7403 ")
  n_of <- c("", "1", "2", "3")
  nths <- c("\u7b2c\u4e00\u7f70", "\u7b2c\u4e8c\u7f70", "\u7b2c\u4e09\u7f70")
  outs <- list(c("\u7f70\u9032", "ft_made", "made"), c("\u4e0d\u9032", "ft_missed", "missed"))
  for (i in seq_along(counts)) for (k in seq_along(nths)) for (o in outs) {
    add(sprintf("%s%s %s", counts[i], nths[k], o[1]), o[2],
        paste0("free throw ", k, if (nzchar(n_of[i])) paste0(" of ", n_of[i], " awarded") else "", ", ", o[3]))
  }
  keep <- names(code) %in% names(.PLEAGUE_OBSERVED)
  list(code = code[keep], en = en[keep])
}
.PLEAGUE_ACTIONS <- .pleague_actions()
.PLEAGUE_UNLABELLED <- c("unlabelled", paste(
  "row has a player but no action text; in the corpus a shot with x/y followed by a rebound, i.e. a missed shot",
  "(inferred)"
))
# code -> meaning, the LAST phrase per code winning. Only the fallback for a row without its phrase: action_en is
# read per row from the phrase (`.pleague_action_en()`). Documented divergence: sdv-py e3d232e maps the code through
# this dict, so every ft_made / ft_missed row reads "free throw 1 of 3 awarded, ..." (an sdv-py bug, not copied).
.PLEAGUE_ACTION_EN <- local({
  code <- c(unname(.PLEAGUE_ACTIONS$code), .PLEAGUE_UNLABELLED[1])
  en <- c(unname(.PLEAGUE_ACTIONS$en), .PLEAGUE_UNLABELLED[2])
  keep <- !duplicated(code, fromLast = TRUE)
  stats::setNames(en[keep], code[keep])
})

# English meaning of one play: from its phrase when the phrase is in the vocabulary, else from its code
.pleague_action_en <- function(code, phrase) {
  if (is.na(code)) return(NA_character_)
  i <- if (is.character(phrase) && length(phrase) == 1L) match(phrase, names(.PLEAGUE_ACTIONS$en)) else NA_integer_
  if (!is.na(i)) unname(.PLEAGUE_ACTIONS$en[[i]]) else unname(.PLEAGUE_ACTION_EN[code])
}

#' The observed play-by-play phrase vocabulary (sdv-py's stray `action_table` export).
#'
#' @return A tibble `action_zh`, `action`, `meaning`, `events`, ordered by code; the row with an empty
#'   `action_zh` is the unlabelled action.
#' @noRd
.pleague_action_table <- function() {
  z <- c(names(.PLEAGUE_ACTIONS$code), "")
  out <- dplyr::tibble(action_zh = z, action = c(unname(.PLEAGUE_ACTIONS$code), .PLEAGUE_UNLABELLED[1]),
                       meaning = c(unname(.PLEAGUE_ACTIONS$en), .PLEAGUE_UNLABELLED[2]),
                       events = as.integer(.PLEAGUE_OBSERVED[match(z, names(.PLEAGUE_OBSERVED))]))
  # Python sorts by (code, phrase) on code points
  out[order(out$action, out$action_zh, method = "radix"), ]
}

.PLEAGUE_FT_PHRASE <- "(?:\u5f97\u5230(.)\u6b21\u7f70\u7403 )?\u7b2c(.)\u7f70 (\u7f70\u9032|\u4e0d\u9032)"
# non-ASCII names via setNames() (a name written in source is lost in a C locale); read with match()
.PLEAGUE_FT_AWARDED <- stats::setNames(1:3, c("\u4e00", "\u5169", "\u4e09"))
.PLEAGUE_FT_ORDINAL <- stats::setNames(1:3, c("\u4e00", "\u4e8c", "\u4e09"))
.PLEAGUE_PERIOD <- "(Q[1-4]|OT[1-9])-tr"
.PLEAGUE_SCORE <- "([0-9]+) - ([0-9]+)"

# "#35 name phrase" -> list(jersey, player, phrase); the phrase is the longest known suffix
.pleague_split_text <- function(text, has_xy) {
  t <- .pleague_strip(text)
  known <- names(.PLEAGUE_ACTIONS$code)
  hits <- known[endsWith(t, known)]
  if (!length(hits)) {
    if (has_xy && !is.null(.pleague_full("#\\S+ \\S+|\\S+", t, ucp = TRUE))) {
      if (startsWith(t, "#")) {
        rest <- substring(t, 2)
        sp <- regexpr(" ", rest, fixed = TRUE)
        if (sp < 0) return(list(jersey = rest, player = "", phrase = ""))
        return(list(jersey = substr(rest, 1, sp - 1L), player = substring(rest, sp + 1L), phrase = ""))
      }
      return(list(jersey = NA_character_, player = t, phrase = ""))
    }
    .pleague_refuse(sprintf("unknown play-by-play phrase: '%s'", text))
  }
  best <- hits[which.max(nchar(hits))]
  who <- .pleague_strip(substr(t, 1, nchar(t) - nchar(best)))
  jersey <- NA_character_
  player <- NA_character_
  if (nzchar(who)) {
    mm <- .pleague_full("#(\\S+)\\s+(.+)", who, ucp = TRUE)
    if (is.null(mm)) player <- who else {
      jersey <- mm[2]
      player <- mm[3]
    }
  }
  list(jersey = jersey, player = player, phrase = best)
}

# data-tryspot: base64 JSON -> list(video = <clip refs, never a url> | NULL, starred)
.pleague_video <- function(raw) {
  if (is.na(raw) || !nzchar(raw)) return(list(video = NULL, starred = FALSE))
  ok <- grepl("^[A-Za-z0-9+/]*={0,2}$", raw, perl = TRUE) && nchar(raw) %% 4L == 0L
  d <- if (ok) tryCatch({
    txt <- rawToChar(jsonlite::base64_dec(raw))
    Encoding(txt) <- "UTF-8"
    jsonlite::parse_json(txt, simplifyVector = FALSE)
  }, error = function(e) NULL)
  if (is.null(d)) .pleague_refuse("layout drift: data-tryspot is not base64 JSON")
  if (!.pleague_is_obj(d)) .pleague_refuse("layout drift: data-tryspot is not an object")
  list(video = list(video_uuid = d$uuid, synergy_play_id = d$synergy_play_id, stat_category = d$stat_category,
                    tryspot_player_id = d$player_id, created_at = d$created_at),
       starred = .pleague_truthy(d$starred))
}

#' The play-by-play body `{error, data: "<table ...>"}` -> its record (sdv-py `pbp_record`).
#' @noRd
.pleague_pbp_record <- function(body) {
  html <- if (.pleague_is_obj(body)) body$data else NULL
  if (!.pleague_str1(html) || !nzchar(.pleague_strip(html))) .pleague_refuse("play-by-play data is not an HTML string")
  root <- .pleague_dom(html)
  table <- .pleague_need(.pleague_find(root, "table", "pbplay"), "pbplay table")
  events <- list()
  periods <- character()
  final <- NULL
  for (tr in .pleague_findall(table, "tr")) {
    cls <- .pleague_classes(tr)
    pcls <- grep(paste0("^", .PLEAGUE_PERIOD, "$"), cls, value = TRUE, perl = TRUE)
    per <- substr(pcls, 1, nchar(pcls) - 3L)
    if ("quater-tr" %in% cls) {
      label <- .pleague_text(.pleague_need(.pleague_find(tr, "span", "quater"), "period label"))
      if ("all-tr" %in% cls) {
        sc <- .pleague_full(.PLEAGUE_SCORE, .pleague_text(.pleague_need(.pleague_find(tr, "span", "match_score"), "final score")))
        if (label != "Final" || is.null(sc)) .pleague_refuse(sprintf("layout drift: closing row '%s'", label))
        final <- as.integer(sc[2:3])
      } else {
        if (!identical(unique(per), label)) {
          .pleague_refuse(sprintf("layout drift: period row '%s' [%s]", label, paste(sort(cls), collapse = ", ")))
        }
        periods <- c(periods, label)
      }
      next
    }
    if (length(per) != 1L || !per %in% periods) {
      .pleague_refuse(sprintf("layout drift: event row in period [%s] (headers [%s])", paste(per, collapse = ", "),
                              paste(periods, collapse = ", ")))
    }
    tds <- .pleague_kids(tr, "td")
    if (length(tds) != 3L) .pleague_refuse("layout drift: event row cells")
    side_td <- Filter(function(td) any(c("bar_away", "bar_home") %in% .pleague_classes(td)), tds)
    if (length(side_td) != 1L) .pleague_refuse("layout drift: event row has no single side cell")
    td <- side_td[[1]]
    side <- if ("bar_away" %in% .pleague_classes(td)) "away" else "home"
    clock <- .pleague_text(.pleague_need(.pleague_find(tr, "span", "countdown"), "countdown"))
    if (is.null(.pleague_full("[0-9][0-9]:[0-9][0-9]", clock))) .pleague_refuse(sprintf("layout drift: clock '%s'", clock))
    sc <- .pleague_full(.PLEAGUE_SCORE, .pleague_text(.pleague_need(.pleague_find(tr, "span", "match_score"), "match score")))
    txt <- .pleague_need(.pleague_find(td, "b", "pbp_detail_text"), "event text")
    act <- .pleague_text(.pleague_need(.pleague_find(td, "b", "pbp_detail_action"), "event points"))
    text_zh <- .pleague_text(txt)
    who <- .pleague_split_text(text_zh, nzchar(.pleague_or(.pleague_attr(txt, "data-x"), "")))
    vid <- .pleague_video(.pleague_attr(td, "data-tryspot"))
    phrase <- who$phrase
    ftm <- .pleague_full(.PLEAGUE_FT_PHRASE, phrase)
    events[[length(events) + 1L]] <- list(
      seq = length(events) + 1L, period = per, clock = clock, side = side, jersey = who$jersey,
      player_zh = who$player, action = if (nzchar(phrase)) .PLEAGUE_ACTIONS$code[[phrase]] else .PLEAGUE_UNLABELLED[1],
      action_zh = phrase, text_zh = text_zh,
      ft_number = if (is.null(ftm)) NA_integer_ else .PLEAGUE_FT_ORDINAL[[match(ftm[3], names(.PLEAGUE_FT_ORDINAL))]],
      ft_awarded = if (is.null(ftm) || !nzchar(ftm[2])) NA_integer_ else unname(.PLEAGUE_FT_AWARDED[match(ftm[2], names(.PLEAGUE_FT_AWARDED))]),
      points = if (startsWith(act, "+") && act != "+") .pleague_int_text(sub("^\\++", "", act)) else NA_integer_,
      score_away = if (is.null(sc)) NA_integer_ else as.integer(sc[2]),
      score_home = if (is.null(sc)) NA_integer_ else as.integer(sc[3]),
      x = .pleague_flt_text(.pleague_attr(txt, "data-x")), y = .pleague_flt_text(.pleague_attr(txt, "data-y")),
      nice_play = vid$starred || any(startsWith(cls, "nice_play")), video = vid$video
    )
  }
  if (!length(events) || is.null(final) || !length(periods)) {
    .pleague_refuse("play-by-play has no events, no period rows or no closing row (truncated or empty)")
  }
  list(period_count = length(periods), periods = periods, final_score_away = final[1], final_score_home = final[2],
       event_count = length(events), events = events)
}

# ---------------------------------------------------------------------------
# Standings, player season table, player page
# ---------------------------------------------------------------------------

.PLEAGUE_STANDINGS_HEADER <- c("\u6392\u884c", "\u7403\u968a", "\u5df2\u8cfd GP", "\u52dd W", "\u6557 L", "\u52dd\u7387 PCT", "\u52dd\u5dee", "\u5e73\u5747\u5f97\u5206",
                               "\u5e73\u5747\u5931\u5206", "\u5e73\u5747\u5206\u5dee", "\u4e3b\u5834", "\u5ba2\u5834", "\u9023\u52dd\u9023\u6557", "\u8fd110\u5834\u6bd4\u8cfd")

.pleague_th_texts <- function(table) {
  vapply(.pleague_findall(.pleague_need(.pleague_find(table, "thead"), "thead"), "th"), .pleague_text, "")
}

.pleague_standings_record <- function(html, season) {
  root <- .pleague_dom(html)
  m <- .pleague_match("^([0-9]{4}-[0-9]{2}) \u6230\u7e3e", .pleague_text(.pleague_need(.pleague_find(root, "title"), "title")))
  if (is.null(m)) .pleague_refuse("layout drift: standings title")
  .pleague_check("season", m[2], season)
  table <- .pleague_need(.pleague_find(root, "table", "team_ranking"), "standings table")
  head <- .pleague_th_texts(table)
  if (!identical(head, .PLEAGUE_STANDINGS_HEADER)) {
    .pleague_refuse(sprintf("layout drift: standings header [%s]", paste(head, collapse = ", ")))
  }
  rows <- list()
  for (tr in .pleague_findall(.pleague_need(.pleague_find(table, "tbody"), "tbody"), "tr")) {
    team <- .pleague_kids(tr, "th")
    cells <- vapply(.pleague_kids(tr, "td"), .pleague_text, "")
    a <- .pleague_need(.pleague_find(tr, "a"), "team link")
    tid <- .pleague_full("/team/([0-9]+)", .pleague_or(.pleague_attr(a, "href"), ""))
    if (is.null(tid) || length(team) != 2L || length(cells) != 12L || is.na(.pleague_int_text(.pleague_text(team[[1]])))) {
      .pleague_refuse("layout drift: standings row")
    }
    img <- .pleague_find(a, "img")
    rows[[length(rows) + 1L]] <- list(
      rank = .pleague_int_text(.pleague_text(team[[1]])), team_id = as.integer(tid[2]), team_zh = .pleague_text(a),
      team_logo = if (is.null(img)) NA_character_ else .pleague_attr(img, "src"),
      games_played = .pleague_int_text(cells[1]), wins = .pleague_int_text(cells[2]),
      losses = .pleague_int_text(cells[3]), win_pct = .pleague_num_text(cells[4]),
      games_behind = .pleague_num_text(cells[5]), points_for_avg = .pleague_num_text(cells[6]),
      points_against_avg = .pleague_num_text(cells[7]), point_diff_avg = .pleague_num_text(cells[8]),
      home_record = cells[9], away_record = cells[10], streak = cells[11], last_n_record = cells[12]
    )
  }
  if (!length(rows)) .pleague_refuse("zero standings rows", empty = TRUE)
  last_n <- .pleague_match("\u8fd1([0-9]+)\u5834\u6bd4\u8cfd", head[length(head)])
  list(season = season, season_sdv = .pleague_season_end_year(season),
       last_n = if (is.null(last_n)) NA_integer_ else as.integer(last_n[2]), team_count = length(rows), teams = rows)
}

.PLEAGUE_STAT_HEADER <- c("\u7403\u54e1", "\u80cc\u865f", "\u7403\u968a", "\u51fa\u8cfd", "\u4e0a\u5834\u6642\u9593", "\u5169\u5206\u547d\u4e2d", "\u5169\u5206\u51fa\u624b", "\u5169\u5206\u547d\u4e2d\u7387",
                          "\u4e09\u5206\u547d\u4e2d", "\u4e09\u5206\u51fa\u624b", "\u4e09\u5206\u547d\u4e2d\u7387", "\u7f70\u7403\u547d\u4e2d", "\u7f70\u7403\u51fa\u624b", "\u7f70\u7403\u547d\u4e2d\u7387", "\u5f97\u5206",
                          "\u653b\u677f", "\u9632\u677f", "\u7c43\u677f", "\u52a9\u653b", "\u6284\u622a", "\u963b\u653b", "\u5931\u8aa4", "\u72af\u898f")
.PLEAGUE_STAT_KEYS <- c("jersey", "team_zh", "games", "minutes", "fg2_made", "fg2_att", "fg2_pct", "fg3_made",
                        "fg3_att", "fg3_pct", "ft_made", "ft_att", "ft_pct", "points", "reb_off", "reb_def", "reb",
                        "ast", "stl", "blk", "tov", "pf")

.pleague_stat_player_record <- function(html, season, stage_sn) {
  root <- .pleague_dom(html)
  m <- .pleague_match("^([0-9]{4}-[0-9]{2}) \u7403\u54e1\u6578\u64da", .pleague_text(.pleague_need(.pleague_find(root, "title"), "title")))
  if (is.null(m)) .pleague_refuse("layout drift: stat-player title")
  .pleague_check("season", m[2], season)
  sel <- list()
  for (s in .pleague_findall(root, "select")) {
    opts <- Filter(function(o) xml2::xml_has_attr(o, "selected"), .pleague_findall(s, "option"))
    sel[[.pleague_or(.pleague_attr(s, "id"), "\001")]] <- vapply(opts, function(o) .pleague_attr(o, "value"), "")
  }
  .pleague_check("season select", sel[["season_name"]], season)
  .pleague_check("stage select", sel[["stage_sn"]], as.character(stage_sn))
  table <- .pleague_need(.pleague_find(root, "table", id = "main-table"), "main-table")
  head <- gsub(.PLEAGUE_WS, "", .pleague_th_texts(table), perl = TRUE)
  if (!identical(head, .PLEAGUE_STAT_HEADER)) {
    .pleague_refuse(sprintf("layout drift: stat-player header [%s]", paste(head, collapse = ", ")))
  }
  players <- list()
  for (tr in .pleague_findall(.pleague_need(.pleague_find(table, "tbody"), "tbody"), "tr")) {
    th <- .pleague_need(.pleague_find(tr, "th"), "player cell")
    a <- .pleague_need(.pleague_find(th, "a"), "player link")
    pid <- .pleague_full("/player/([A-Za-z0-9]+)", .pleague_or(.pleague_attr(a, "href"), ""))
    tds <- .pleague_kids(tr, "td")
    if (is.null(pid) || length(tds) != length(.PLEAGUE_STAT_KEYS)) .pleague_refuse("layout drift: stat-player row")
    rec <- list(name_zh = .pleague_text(a), player_page_id = pid[2])
    for (k in seq_along(.PLEAGUE_STAT_KEYS)) {
      key <- .PLEAGUE_STAT_KEYS[k]
      td <- tds[[k]]
      avg <- .pleague_attr(td, "data-avg")
      tot <- .pleague_attr(td, "data-total")
      if (key %in% c("jersey", "team_zh")) {
        rec[[key]] <- .pleague_text(td)
      } else if (key %in% c("games", "fg2_pct", "fg3_pct", "ft_pct")) {
        rec[[key]] <- if (key == "games") .pleague_int_text(avg) else .pleague_num_text(avg)
        if (!identical(avg, tot)) .pleague_refuse(sprintf("layout drift: %s avg '%s' != total '%s'", key, avg, tot))
      } else {
        rec[[paste0(key, "_avg")]] <- if (key == "minutes") avg else .pleague_num_text(avg)
        rec[[paste0(key, "_total")]] <- if (key == "minutes") tot else if (grepl("^[0-9]+$", .pleague_or(tot, ""))) {
          .pleague_int_text(tot)
        } else {
          .pleague_num_text(tot)
        }
      }
    }
    players[[length(players) + 1L]] <- rec
  }
  if (!length(players)) .pleague_refuse("zero player rows", empty = TRUE)
  if (anyDuplicated(vapply(players, `[[`, "", "player_page_id"))) .pleague_refuse("duplicate player rows")
  list(season = season, season_sdv = .pleague_season_end_year(season), stage_sn = stage_sn,
       stage = .PLEAGUE_STAT_STAGES[[as.character(stage_sn)]], player_count = length(players), players = players)
}

.PLEAGUE_SEASON_LINK <- "/player/([A-Za-z0-9]+)/([0-9]{4}-[0-9]{2})"
.PLEAGUE_PLAYER_COLS <- c("games", "minutes", "points", "reb", "ast", "stl", "blk", "fg2", "fg2_pct", "fg3",
                          "fg3_pct", "ft", "ft_pct", "tov", "pf")
.PLEAGUE_PLAYER_HEAD <- c("\u8cfd\u5b63", "\u51fa\u8cfd", "\u4e0a\u5834\u6642\u9593", "\u5f97\u5206", "\u7c43\u677f", "\u52a9\u653b", "\u6284\u622a", "\u963b\u653b", "\u4e8c\u5206", "\u4e8c\u5206%",
                          "\u4e09\u5206", "\u4e09\u5206%", "\u7f70\u7403", "\u7f70\u7403%", "\u5931\u8aa4", "\u72af\u898f")
.PLEAGUE_BIO <- stats::setNames(
  c("nickname", "tenure", "height", "weight", "birthday", "birthplace", "status_zh"),
  c("\u7dbd\u865f", "\u5e74\u8cc7", "\u8eab\u9ad8", "\u9ad4\u91cd", "\u751f\u65e5", "\u51fa\u751f\u5730", "\u8eab\u4efd")
)

.pleague_season_rows <- function(table, pid) {
  head <- .pleague_th_texts(table)
  if (!identical(head, .PLEAGUE_PLAYER_HEAD)) {
    .pleague_refuse(sprintf("layout drift: player table header [%s]", paste(head, collapse = ", ")))
  }
  out <- list()
  for (tr in .pleague_findall(.pleague_need(.pleague_find(table, "tbody"), "tbody"), "tr")) {
    tds <- .pleague_kids(tr, "td")
    if (length(tds) != length(.PLEAGUE_PLAYER_HEAD)) .pleague_refuse("layout drift: player season row")
    a <- .pleague_find(tds[[1]], "a")
    if (!is.null(a)) {
      lm <- .pleague_full(.PLEAGUE_SEASON_LINK, .pleague_or(.pleague_attr(a, "href"), ""))
      if (is.null(lm)) .pleague_refuse("layout drift: season link")
      .pleague_check("player page id", lm[2], pid)
    }
    c <- stats::setNames(as.list(vapply(tds, .pleague_text, "")), c("season", .PLEAGUE_PLAYER_COLS))
    row <- list(season = c$season, games = .pleague_int_text(c$games), minutes = c$minutes)
    for (k in c("points", "reb", "ast", "stl", "blk", "tov", "pf")) row[[k]] <- .pleague_num_text(c[[k]])
    for (k in c("fg2", "fg3", "ft")) {
      pm <- .pleague_full("([0-9.]+) - ([0-9.]+)", c[[k]])
      made <- if (is.null(pm)) NA_real_ else suppressWarnings(as.double(pm[2]))
      att <- if (is.null(pm)) NA_real_ else suppressWarnings(as.double(pm[3]))
      if (is.na(made) || is.na(att)) .pleague_refuse(sprintf("layout drift: player %s cell '%s'", k, c[[k]]))
      row[[paste0(k, "_made")]] <- made
      row[[paste0(k, "_att")]] <- att
      row[[paste0(k, "_pct")]] <- .pleague_num_text(c[[paste0(k, "_pct")]])
    }
    out[[length(out) + 1L]] <- row
  }
  out
}

.pleague_player_record <- function(html, pid) {
  root <- .pleague_dom(html)
  sec <- .pleague_need(.pleague_find(root, "section", id = "section_player"), "player section")
  track <- .pleague_match("trackPlayer\\('([0-9]+)'", html)
  name <- .pleague_need(.pleague_find(sec, "h1", "player_name_ch"), "player name")
  en <- .pleague_text(.pleague_need(.pleague_find(sec, "h3", "player_name_en"), "player English name"))
  head <- .pleague_text(.pleague_need(.pleague_find(sec, "h5", "text-light mt-2 mb-5"), "team line"))
  tm <- .pleague_full("(.+?) (.+?) \\| # (\\S+) \\| (\\S+)", head)
  if (is.null(track) || is.null(tm)) .pleague_refuse(sprintf("layout drift: player header '%s'", head))
  bio <- list()
  for (sp in .pleague_findall(.pleague_need(.pleague_find(sec, "p", "text-light opacity-9"), "bio"), "span")) {
    t <- .pleague_text(sp)
    at <- regexpr("\uff1a", t, fixed = TRUE)
    k <- if (at > 0) substr(t, 1, at - 1L) else t
    v <- if (at > 0) substring(t, at + 1L) else ""
    if (k %in% names(.PLEAGUE_BIO)) bio[[.PLEAGUE_BIO[[match(k, names(.PLEAGUE_BIO))]]]] <- .pleague_na_if_blank(.pleague_strip(v))
  }
  if (!setequal(names(bio), .PLEAGUE_BIO)) {
    .pleague_refuse(sprintf("layout drift: bio fields [%s]", paste(sort(names(bio)), collapse = ", ")))
  }
  exp <- .pleague_find(sec, "div", id = "player_experience")
  edu <- vapply(.pleague_findall(exp, "span", "d-block"), .pleague_text, "")
  sections <- list(plg = list(), easl = list())
  cur <- NULL
  for (n in as.list(.pleague_xfind(root, ".//tbody[@id='match-tbody' or @id='easl-match-tbody'] | .//table[.//thead]"))) {
    if (xml2::xml_name(n) == "tbody") {
      cur <- if (startsWith(.pleague_attr(n, "id"), "easl")) "easl" else "plg"
    } else if (identical(.pleague_th_texts(n), .PLEAGUE_PLAYER_HEAD)) {
      if (is.null(cur)) .pleague_refuse("layout drift: a season table before any game-log block")
      sections[[cur]][[length(sections[[cur]]) + 1L]] <- n
    }
  }
  links <- unique(.pleague_groups(.PLEAGUE_SEASON_LINK, html))
  if (!identical(links, pid)) {
    .pleague_refuse(sprintf("out of scope: season links name [%s], asked for '%s'", paste(sort(links), collapse = ", "), pid))
  }
  if (length(sections$plg) != 2L || !length(sections$easl) %in% c(0L, 2L)) {
    .pleague_refuse(sprintf("layout drift: season tables %d + %d", length(sections$plg), length(sections$easl)))
  }
  easl <- length(sections$easl) > 0L
  list(player_page_id = pid, member_id = as.integer(track[2]), name_zh = .pleague_text(name), name_en = en,
       team_zh = tm[2], team_en = tm[3], jersey = tm[4], position = tm[5],
       nickname = bio$nickname, tenure = bio$tenure,
       height_cm = .pleague_num_text(gsub("cm", "", .pleague_or(bio$height, ""), fixed = TRUE)),
       weight_kg = .pleague_num_text(gsub("kg", "", .pleague_or(bio$weight, ""), fixed = TRUE)),
       birthday = bio$birthday, birthplace_zh = bio$birthplace, status_zh = bio$status_zh,
       education = as.list(edu[nzchar(edu)]),
       season_totals = .pleague_season_rows(sections$plg[[1]], pid),
       season_averages = .pleague_season_rows(sections$plg[[2]], pid),
       easl_season_totals = if (easl) .pleague_season_rows(sections$easl[[1]], pid) else list(),
       easl_season_averages = if (easl) .pleague_season_rows(sections$easl[[2]], pid) else list())
}

#' Parse one HTML page into its record and check it against the request (sdv-py `record_for`).
#'
#' @param kind `"schedule"`, `"game"`, `"standings"`, `"stat_player"` or `"player"`.
#' @param want The request's scope: `stage` + `season` (slug), `gid`, `season`, `season` + `stage_sn`, `pid`.
#' @return The record; a refusal raises `hoopR_pleague_not_parsed` (`empty` = no data).
#' @noRd
.pleague_record_for <- function(kind, html, want) {
  tryCatch(
    switch(kind,
      schedule = .pleague_schedule_record(html, want$stage, want$season),
      game = .pleague_game_record(html, want$gid),
      standings = .pleague_standings_record(html, want$season),
      stat_player = .pleague_stat_player_record(html, want$season, want$stage_sn),
      player = .pleague_player_record(html, want$pid),
      .pleague_refuse(sprintf("unknown page kind '%s'", kind))
    ),
    # one handler: a second one would be the OUTER of the two and catch the rethrow
    error = function(e) {
      if (inherits(e, "hoopR_pleague_not_parsed")) stop(e)
      .pleague_refuse(paste0("parser error: ", conditionMessage(e)))
    }
  )
}

# ---------------------------------------------------------------------------
# Scope checks
# ---------------------------------------------------------------------------

.PLEAGUE_BOX_KEYS <- c("q1_home", "q1_away", "q2_home", "q2_away", "q3_home", "q3_away", "q4_home", "q4_away",
                       "ot1_home", "ot1_away", "ot2_home", "ot2_away", "score_home", "score_away", "home", "away",
                       "home_total", "away_total")

.pleague_game_error <- function(game, gid) {
  if (!identical(game$gid, gid)) return(sprintf("game page gid %s, asked for %s", .pleague_repr(game$gid), gid))
  if (!identical(game$status_zh, .PLEAGUE_FINAL)) {
    return(sprintf("game %d is not final (status '%s'): only finished games are served", gid, game$status_zh))
  }
  NULL
}

.pleague_show <- function(v) {
  if (is.null(v)) return("None")
  if (is.character(v)) sprintf("'%s'", v) else as.character(v)
}

#' Why `body` is not the final box of the game whose page record is `game` (sdv-py `box_error`); NULL when it is.
#' @noRd
.pleague_box_error <- function(body, game) {
  err <- if (.pleague_is_obj(body)) body$error else body
  if (!.pleague_is_obj(body) || !(is.null(err) || identical(err, ""))) {
    return(paste("box error field", if (is.list(err)) "<object>" else .pleague_show(err)))
  }
  d <- body$data
  if (!.pleague_is_obj(d)) return("box data is not an object")
  missing <- setdiff(.PLEAGUE_BOX_KEYS, names(d))
  if (length(missing)) return(sprintf("box body lacks [%s]", paste(sort(missing), collapse = ", ")))
  if (!.pleague_truthy(d$home) || !.pleague_truthy(d$away)) return("box has no player rows (unknown or unplayed game id)")
  for (side in c("home", "away")) {
    final <- .pleague_score(d[[paste0("score_", side)]])
    want <- game[[paste0(side, "_score")]]
    if (is.na(final) || final != want) {
      return(sprintf("box %s score %s != game page %d", side, .pleague_show(d[[paste0("score_", side)]]), want))
    }
    for (q in 1:4) {
      k <- sprintf("q%d_%s", q, side)
      if (!identical(.pleague_score(d[[k]]), game$quarters[[k]])) {
        return(sprintf("box %s %s != game page %d", k, .pleague_show(d[[k]]), game$quarters[[k]]))
      }
    }
    for (ot in c("ot1", "ot2")) {
      k <- paste0(ot, "_", side)
      page <- game$quarters[[k]]
      got <- d[[k]]
      gs <- .pleague_score(got)
      zero_ok <- is.null(got) || identical(got, "-") || identical(got, "0") || (is.numeric(got) && .pleague_one(got) && got == 0)
      if ((if (is.na(gs)) 0L else gs) != (page %||% 0L) || (is.null(page) && !zero_ok)) {
        return(sprintf("box %s %s != game page %s", k, .pleague_show(got), .pleague_show(page)))
      }
    }
    pts <- sum(vapply(.pleague_objs(d[[side]]), function(p) {
      s <- .pleague_score(p$points)
      if (is.na(s)) 0L else s
    }, 1L))
    tot <- .pleague_score(.pleague_obj(d[[paste0(side, "_total")]])$points)
    if (is.na(tot) || tot != final || pts < final - .PLEAGUE_MAX_UNCREDITED || pts > final) {
      return(sprintf("box %s player points %d / total row %s != final %d", side, pts, .pleague_show(tot), final))
    }
  }
  NULL
}

# the period labels the game page implies: Q1-Q4 plus one OT per overtime cell with points
.pleague_expected_periods <- function(game) {
  q <- game$quarters
  ot <- names(q)[startsWith(names(q), "ot") & vapply(q, .pleague_truthy, TRUE)]
  c("Q1", "Q2", "Q3", "Q4", sort(unique(toupper(substr(ot, 1, 3)))))
}

.pleague_pbp_error <- function(rec, game) {
  if (rec$final_score_away != game$away_score || rec$final_score_home != game$home_score) {
    return(sprintf("play-by-play final %d-%d != game page %d-%d", rec$final_score_away, rec$final_score_home,
                   game$away_score, game$home_score))
  }
  want <- .pleague_expected_periods(game)
  if (!identical(rec$periods, want)) {
    return(sprintf("play-by-play periods [%s] != game page [%s]", paste(rec$periods, collapse = ", "),
                   paste(want, collapse = ", ")))
  }
  scored <- Filter(function(e) !is.na(e$score_away), rec$events)
  last <- if (length(scored)) scored[[length(scored)]] else NULL
  if (is.null(last) || last$score_away != game$away_score || last$score_home != game$home_score) {
    return("the last scoring event does not reach the final score")
  }
  NULL
}

# the vendor's clip access key (?key=<hex>) is never kept
.PLEAGUE_SECRET <- "[?&]key=[0-9a-fA-F]{16,}"
.pleague_scrub <- function(obj) {
  if (is.character(obj)) return(gsub("([?&]key=)[0-9a-fA-F]{16,}", "\\1<redacted>", obj, perl = TRUE))
  if (is.list(obj)) {
    out <- lapply(obj, .pleague_scrub)
    attributes(out) <- attributes(obj)
    return(out)
  }
  obj
}
.pleague_has_secret <- function(obj) {
  grepl(.PLEAGUE_SECRET, jsonlite::toJSON(obj, auto_unbox = TRUE, null = "null", na = "null"), perl = TRUE)
}

.pleague_made <- function(cell) {
  m <- .pleague_full("([0-9]+)-([0-9]+)", cell)
  if (is.null(m)) 0L else as.integer(m[2])
}
#' Made 2- and 3-pointers on a box's player rows (sdv-py's stray `box_field_goals` export).
#' @noRd
.pleague_box_field_goals <- function(box) {
  rows <- c(.pleague_objs(box$home), .pleague_objs(box$away))
  c(sum(vapply(rows, function(p) .pleague_made(p$two_m_two), 1L)),
    sum(vapply(rows, function(p) .pleague_made(p$trey_m_trey), 1L)))
}
#' Box player name -> seconds played (sdv-py's stray `box_seconds` export).
#' @noRd
.pleague_box_seconds <- function(box) {
  out <- list()
  for (p in c(.pleague_objs(box$home), .pleague_objs(box$away))) {
    s <- .pleague_seconds(p$mins)
    if (!is.na(s)) out[[.pleague_key(p$name_alt)]] <- s
  }
  out
}
# a decoded scalar as a lookup key (Python dict / set membership); NULL is its own key
.pleague_key <- function(v) if (.pleague_one(v)) paste0(class(v)[1], ":", v) else "\001None"

.pleague_vendor_error <- function(kind, body, uuid, ctx) {
  if (!.pleague_is_arr(body) || length(body) != 1L || !.pleague_is_obj(body[[1]])) {
    return(paste0(kind, ": expected a one-element list"))
  }
  b <- body[[1]]
  if (kind %in% c("summary", "injury")) {
    if (!identical(b$game_id, uuid)) return(sprintf("%s: game_id %s, asked for '%s'", kind, .pleague_show(b$game_id), uuid))
    ids <- list(.pleague_obj(b$home_team)$id, .pleague_obj(b$away_team)$id)
    if (!all(vapply(ids, .pleague_truthy, TRUE))) return(paste0(kind, ": a team id is missing"))
    if (kind == "summary") {
      ps <- b$pbp
      if (!.pleague_truthy(ps)) return("summary: the play log is empty")
      game <- ctx$game
      last <- .pleague_obj(ps[[length(ps)]])
      if (!is.null(game) && !(.pleague_eq(last$away_score, game$away_score) && .pleague_eq(last$home_score, game$home_score))) {
        return("summary: the play log does not end on the game page's final score")
      }
      ctx$team_ids <- ids # only after every summary check passed
    } else if (!is.null(ctx$team_ids) && !identical(ids, ctx$team_ids)) {
      return("injury: team ids differ from the summary's")
    }
  } else if (kind == "shots") {
    if (!identical(b$game_status, "post")) return(sprintf("shots: game_status %s, not post", .pleague_show(b$game_status)))
    if (!is.null(ctx$team_ids) && !identical(list(b$home_id, b$away_id), ctx$team_ids)) {
      return("shots: home_id / away_id differ from the summary's teams")
    }
    known <- vapply(.pleague_objs(b$players), function(p) .pleague_key(p$id), "")
    shots <- .pleague_objs(b$shot)
    if (!all(vapply(shots, function(s) .pleague_key(s$player), "") %in% known)) {
      return("shots: a shot names a player the body does not list")
    }
    if (!is.null(ctx$box)) {
      made <- c(`2pt` = 0L, `3pt` = 0L)
      for (s in shots) {
        if (isTRUE(s$success) && .pleague_str1(s$type) && s$type %in% names(made)) made[[s$type]] <- made[[s$type]] + 1L
      }
      want <- .pleague_box_field_goals(ctx$box)
      if (!identical(unname(made), want)) {
        return(sprintf("shots: made 2pt/3pt %d/%d != the box's (%d, %d)", made[[1]], made[[2]], want[1], want[2]))
      }
    }
  } else if (kind == "rotation" && !is.null(ctx$box)) {
    for (sk in list(c("home", "homeTeam"), c("away", "awayTeam"))) {
      roster <- vapply(.pleague_objs(ctx$box[[sk[1]]]), function(p) .pleague_key(p$name_alt), "")
      players <- .pleague_objs(b[[sk[2]]])
      names <- unique(vapply(players, function(p) .pleague_key(p$name), ""))
      if (!length(names) || !all(names %in% roster)) {
        off <- vapply(Filter(function(p) !.pleague_key(p$name) %in% roster && .pleague_truthy(p$name), players),
                      function(p) as.character(p$name), "")
        return(sprintf("rotation: %s names [%s] are not on the %s box roster", sk[2],
                       paste(utils::head(sort(unique(off)), 3), collapse = ", "), sk[1]))
      }
    }
    secs <- .pleague_box_seconds(ctx$box)
    for (key in c("homeTeam", "awayTeam")) {
      for (p in .pleague_objs(b[[key]])) {
        on <- sum(vapply(.pleague_objs(p$periods), function(st) {
          e <- if (.pleague_truthy(st$endSeconds)) st$endSeconds else 0
          s <- if (.pleague_truthy(st$startSeconds)) st$startSeconds else 0
          as.double(e - s)
        }, 1))
        box_s <- secs[[.pleague_key(p$name)]]
        if (abs(on - (box_s %||% -999)) > .PLEAGUE_ROTATION_TOLERANCE) {
          return(sprintf("rotation: %s on court %ss != the box's %ss", .pleague_show(p$name), on, .pleague_show(box_s)))
        }
      }
    }
  }
  NULL
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

.pleague_status <- function(resp, where, call) {
  status <- httr2::resp_status(resp)
  if (status %in% .PLEAGUE_REDIRECTS) {
    loc <- httr2::resp_header(resp, "location", default = "")
    path <- sub("[?#].*$", "", sub("^[A-Za-z][A-Za-z0-9+.-]*://[^/]*", "", loc))
    if (!nzchar(path)) path <- "/"
    .abort_no_data("{where}: the site redirected to {path} (it has no such page)", status = status, call = call)
  }
  if (status == 404L) .abort_no_data("{where} answered HTTP 404", status = status, call = call)
  if (status %in% c(400L, 422L)) .abort_bad_request("{where} rejected the request: HTTP {status}", status = status, call = call)
  if (status != 200L) {
    .abort_asset_fetch("{where} answered HTTP {status}, not 200", status = status,
                       transient = status %in% c(408L, 429L) || status >= 500L, call = call)
  }
  invisible(status)
}

# GET one site URL (browser User-Agent, redirects not followed, 500 not retried) -> the HTTP 200 response
.pleague_site_get <- function(url, query = list(), call) {
  where <- .intl_where(url)
  resp <- .intl_response(url, query = query, headers = list(`User-Agent` = .PLEAGUE_UA), retry_500 = FALSE,
                         timeout = 60, follow_redirects = FALSE, call = call)
  .pleague_status(resp, where, call)
  text <- .intl_body_text(resp)
  if (!nzchar(.pleague_strip(text))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body", call = call)
  list(resp = resp, text = text)
}

.pleague_page <- function(url, kind, want, call) {
  got <- .pleague_site_get(url, call = call)
  where <- .intl_where(url)
  if (!grepl("html", tolower(httr2::resp_header(got$resp, "content-type", default = "")), fixed = TRUE)) {
    .abort_asset_fetch("{where} answered a body that is not HTML", call = call)
  }
  tryCatch(.pleague_record_for(kind, got$text, want), hoopR_pleague_not_parsed = function(e) {
    msg <- conditionMessage(e)
    if (isTRUE(e$empty)) .abort_no_data("{where}: {msg}", call = call)
    .abort_asset_fetch("{where}: not the page asked for: {msg}", call = call)
  })
}

.pleague_site_json <- function(url, query, call) {
  text <- .pleague_site_get(url, query = query, call = call)$text
  tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) {
    where <- .intl_where(url)
    .abort_asset_fetch("{where} answered a body that is not JSON", call = call)
  })
}

#' The verified game page record of a FINISHED game, cached per gid (sdv-py `game_record`).
#' @noRd
.pleague_game_data <- function(gid, call) {
  key <- paste0("game:", gid)
  if (is.null(.pleague_cache[[key]])) {
    url <- paste0(.PLEAGUE_HOST, "/game/", gid)
    rec <- .pleague_page(url, "game", list(gid = gid), call)
    why <- .pleague_game_error(rec, gid)
    if (!is.null(why)) {
      where <- .intl_where(url)
      .abort_asset_fetch("{where}: {why}", call = call)
    }
    .pleague_cache[[key]] <- rec
  }
  .pleague_cache[[key]]
}

#' The box body of a finished game, checked against its game page, cached per gid (sdv-py's stray `box_data`).
#' @noRd
.pleague_box_data <- function(gid, call) {
  key <- paste0("box:", gid)
  if (is.null(.pleague_cache[[key]])) {
    game <- .pleague_game_data(gid, call)
    url <- paste0(.PLEAGUE_HOST, "/api/boxscore.preciser.php")
    body <- .pleague_site_json(url, list(id = gid, away_tab = "total", home_tab = "total"), call)
    why <- .pleague_box_error(body, game)
    if (!is.null(why)) {
      where <- .intl_where(url)
      .abort_asset_fetch("{where}: not the box of game {gid}: {why}", call = call)
    }
    .pleague_cache[[key]] <- body
  }
  .pleague_cache[[key]]
}

.pleague_pbp_data <- function(gid, call) {
  game <- .pleague_game_data(gid, call)
  uuid <- game$uuid
  if (!.pleague_truthy(uuid)) {
    .abort_no_data(paste("game {gid} has no play-by-play: the page embeds an empty uuid (2020-21 and 2021-22",
                         "have a box only)"), call = call)
  }
  url <- paste0(.PLEAGUE_HOST, "/api/playbyplay.php")
  where <- .intl_where(url)
  body <- .pleague_site_json(url, list(uuid = uuid), call)
  err <- if (.pleague_is_obj(body)) body$error else body
  if (!.pleague_is_obj(body) || !(is.null(err) || identical(err, ""))) {
    shown <- if (is.list(err)) "<object>" else .pleague_show(err)
    .abort_asset_fetch("{where}: error field {shown}", call = call)
  }
  rec <- tryCatch(.pleague_pbp_record(body),
    hoopR_pleague_not_parsed = function(e) e,
    error = function(e) structure(class = c("hoopR_pleague_not_parsed", "error", "condition"),
                                  list(message = paste0("parser error: ", conditionMessage(e)), call = NULL))
  )
  if (inherits(rec, "hoopR_pleague_not_parsed")) {
    msg <- conditionMessage(rec)
    .abort_asset_fetch("{where}: not a play-by-play I can read: {msg}", call = call)
  }
  why <- .pleague_pbp_error(rec, game)
  if (!is.null(why)) .abort_asset_fetch("{where}: not the play-by-play of game {gid}: {why}", call = call)
  if (.pleague_has_secret(rec)) .abort_asset_fetch("{where}: a vendor access key survived in the record", call = call)
  rec[["_request"]] <- list(kind = "pbp", gid = gid, uuid = uuid)
  rec
}

#' Fetch one P. LEAGUE+ site route and refuse every wrong answer (sdv-py `pleague_runtime._get`).
#'
#' @param short Wrapper short name.
#' @param p Named list of the wrapper arguments.
#' @return The record (the box body as the site sends it) with `_request` stamped.
#' @noRd
.pleague_fetch <- function(short, p, call) {
  if (short %in% c("game", "periods", "officials")) {
    gid <- .pleague_int_arg(p$gid, "gid", call)
    rec <- .pleague_game_data(gid, call)
    rec[["_request"]] <- list(kind = "game", gid = gid)
    return(rec)
  }
  if (short %in% c("box_players", "box_teams")) {
    gid <- .pleague_int_arg(p$gid, "gid", call)
    body <- .pleague_box_data(gid, call)
    body[["_request"]] <- list(kind = "box", gid = gid)
    return(body)
  }
  if (short == "pbp") return(.pleague_pbp_data(.pleague_int_arg(p$gid, "gid", call), call))
  if (short %in% c("player", "player_seasons")) {
    pid <- p$player_page_id
    if (!(is.atomic(pid) && length(pid) == 1L && !is.na(pid) &&
          grepl("^[A-Za-z0-9]{4,16}$", as.character(pid), perl = TRUE))) {
      got <- .pleague_repr(if (is.atomic(pid) && length(pid) == 1L) pid else NULL)
      .abort_bad_request("player_page_id must be the 8-character page id of /player/{{id}}; got {got}", call = call)
    }
    pid <- as.character(pid)
    rec <- .pleague_page(paste0(.PLEAGUE_HOST, "/player/", pid), "player", list(pid = pid), call)
    rec[["_request"]] <- list(kind = "player", player_page_id = pid)
    return(rec)
  }
  if (short == "schedule") {
    stage <- p$stage
    if (!.pleague_str1(stage) || !stage %in% names(.PLEAGUE_STAGES)) {
      got <- .pleague_repr(if (is.atomic(stage) && length(stage) == 1L) stage else NULL)
      .abort_bad_request(paste("stage must be one of ('pre-season', 'regular-season', 'playoffs', 'finals');",
                               "got {got}"), call = call)
    }
  }
  slug <- .pleague_season_slug(p$season, call)
  season <- .pleague_int_arg(p$season, "season", call)
  if (short == "schedule") {
    stage <- p$stage
    rec <- .pleague_page(sprintf("%s/schedule-%s/%s", .PLEAGUE_HOST, stage, slug), "schedule",
                         list(stage = stage, season = slug), call)
    rec[["_request"]] <- list(kind = "schedule", season = season, season_slug = slug, stage = stage)
    return(rec)
  }
  if (short == "standings") {
    rec <- .pleague_page(sprintf("%s/standings/%s", .PLEAGUE_HOST, slug), "standings", list(season = slug), call)
    rec[["_request"]] <- list(kind = "standings", season = season, season_slug = slug)
    return(rec)
  }
  sn <- .pleague_int_arg(p$stage_sn, "stage_sn", call)
  if (!sn %in% 2:4) {
    .abort_bad_request("stage_sn must be one of [2, 3, 4] (2 regular season, 3 playoffs, 4 finals)", call = call)
  }
  rec <- .pleague_page(sprintf("%s/stat-player/%s/%d", .PLEAGUE_HOST, slug, sn), "stat_player",
                       list(season = slug, stage_sn = sn), call)
  rec[["_request"]] <- list(kind = "stat_player", season = season, season_slug = slug, stage_sn = sn)
  rec
}

.PLEAGUE_VENDOR_ROUTES <- c(shots = "/v1/chart-data/id/", summary = "/post/game/summary/o/plg/gameId/",
                            rotation = "/game/rotation/chart/o/plg/gameId/", injury = "/game/injury/list/o/plg/gameId/")

# one checked vendor body: the one game object (sdv-py pleague_preciser_runtime._vendor)
.pleague_vendor <- function(kind, uuid, ctx, call) {
  url <- paste0(.PLEAGUE_VENDOR, .PLEAGUE_VENDOR_ROUTES[[kind]], uuid)
  where <- .intl_where(url)
  resp <- .intl_response(url, retry_500 = FALSE, timeout = 60, call = call)
  status <- httr2::resp_status(resp)
  if (status == 404L) .abort_no_data("{where} answered HTTP 404", status = status, call = call)
  if (status %in% c(400L, 422L)) .abort_bad_request("{where} rejected the request: HTTP {status}", status = status, call = call)
  if (status != 200L) {
    .abort_asset_fetch("{where} answered HTTP {status}, not 200 (an unknown uuid also answers 500)", status = status,
                       transient = status %in% c(408L, 429L) || status >= 500L, call = call)
  }
  final <- httr2::url_parse(resp$url %||% url)$hostname %||% ""
  if (!identical(final, httr2::url_parse(.PLEAGUE_VENDOR)$hostname)) {
    off <- if (nzchar(final)) final else "an unknown host"
    .abort_asset_fetch("{where}: redirected off the Preciser host to {off}", call = call)
  }
  if (!grepl("json", tolower(httr2::resp_header(resp, "content-type", default = "")), fixed = TRUE)) {
    .abort_asset_fetch("{where} answered a body that is not JSON", call = call)
  }
  body <- tryCatch(jsonlite::parse_json(.intl_body_text(resp), simplifyVector = FALSE), error = function(e) {
    .abort_asset_fetch("{where} answered a body that is not JSON", call = call)
  })
  if (.pleague_is_arr(body) && !length(body)) {
    .abort_no_data("{where}: the vendor answered [] (an unknown uuid, or a game with no data)", call = call)
  }
  body <- .pleague_scrub(body)
  if (.pleague_has_secret(body)) .abort_asset_fetch("{where}: a vendor access key survived in the body", call = call)
  if (kind == "rotation" && .pleague_is_arr(body) && .pleague_is_obj(body[[1]]) &&
      !.pleague_truthy(body[[1]]$homeTeam) && !.pleague_truthy(body[[1]]$awayTeam)) {
    .abort_no_data("{where}: empty rotation lists (an unknown or unplayed uuid)", call = call)
  }
  why <- .pleague_vendor_error(kind, body, uuid, ctx)
  if (!is.null(why)) .abort_asset_fetch("{where}: not the {kind} of game {uuid}: {why}", call = call)
  body[[1]]
}

#' Fetch one Preciser route (sdv-py `pleague_preciser_runtime._get`): `list(data = <game object>, _request)`.
#' @noRd
.pleague_vendor_fetch <- function(kind, uuid, gid, call) {
  if (!.pleague_str1(uuid) || !grepl(.PLEAGUE_UUID, uuid, perl = TRUE)) {
    got <- .pleague_repr(if (is.atomic(uuid) && length(uuid) == 1L) uuid else NULL)
    .abort_bad_request("uuid must be a Preciser game uuid (see the uuid column of pleague_game); got {got}", call = call)
  }
  ctx <- new.env(parent = emptyenv())
  if (!is.null(gid)) {
    gid <- .pleague_int_arg(gid, "gid", call)
    game <- .pleague_game_data(gid, call)
    if (!identical(game$uuid, uuid)) {
      have <- .pleague_show(if (is.na(game$uuid)) NULL else game$uuid)
      .abort_asset_fetch("game {gid} on the site has uuid {have}, not '{uuid}'", call = call)
    }
    ctx$game <- game
    ctx$box <- .pleague_box_data(gid, call)$data
    if (kind %in% c("shots", "injury")) .pleague_vendor("summary", uuid, ctx, call)
  }
  data <- .pleague_vendor(kind, uuid, ctx, call)
  list(data = data, `_request` = list(kind = kind, uuid = uuid, verified = !is.null(gid), gid = gid))
}

# ---------------------------------------------------------------------------
# Frames (sdv-py parse_pleague_* / parse_pleague_preciser_*)
# ---------------------------------------------------------------------------

.PLEAGUE_STAT_COUNTS <- c("fg2_made", "fg2_att", "fg3_made", "fg3_att", "ft_made", "ft_att", "points", "reb_off",
                          "reb_def", "reb", "ast", "stl", "blk", "tov", "pf")
.PLEAGUE_SPECS <- list(
  schedule = c(season = "integer", season_slug = "character", stage = "character", gid = "integer", date = "Date",
               weekday_zh = "character", time = "character", starred = "logical", game_label = "character",
               venue_zh = "character", attendance = "integer", capacity = "integer", phase = "character",
               away_team_id = "integer", away_name_zh = "character", away_name_en = "character",
               away_logo = "character", away_score = "integer", home_team_id = "integer",
               home_name_zh = "character", home_name_en = "character", home_logo = "character",
               home_score = "integer"),
  game = c(gid = "integer", uuid = "character", status_zh = "character", finished = "logical", date = "Date",
           time = "character", venue_zh = "character", game_label_zh = "character", away_name_zh = "character",
           away_name_en = "character", away_logo = "character", away_score = "integer", home_name_zh = "character",
           home_name_en = "character", home_logo = "character", home_score = "integer", overtimes = "integer"),
  periods = c(gid = "integer", period = "character", period_no = "integer", home_points = "integer",
              away_points = "integer"),
  officials = c(gid = "integer", official_no = "integer", role = "character", role_zh = "character",
                name_zh = "character"),
  box_players = c(gid = "integer", side = "character", player_id = "integer", person_id = "character",
                  random_id = "character", name_zh = "character", jersey = "character", starter = "logical",
                  played = "logical", minutes = "character", seconds = "integer", points = "integer",
                  reb_off = "integer", reb_def = "integer", reb = "integer", ast = "integer", stl = "integer",
                  blk = "integer", tov = "integer", pf = "integer", plus_minus = "integer", eff = "integer",
                  fg2_made = "integer", fg2_att = "integer", fg2_pct = "double", fg3_made = "integer",
                  fg3_att = "integer", fg3_pct = "double", ft_made = "integer", ft_att = "integer",
                  ft_pct = "double", efg_pct = "double", ts_pct = "double", usage_pct = "double",
                  position = "character", ortg = "double", drtg = "double", netrtg = "double", pace = "double",
                  ast_ratio = "double", to_ratio = "double", off_possessions = "integer",
                  opp_off_possessions = "integer", opp_pts_second_chance = "integer",
                  opp_pts_fast_break = "integer", opp_pts_off_turnover = "integer", opp_pts_paint = "integer"),
  box_teams = c(gid = "integer", side = "character", minutes = "character", seconds = "integer", points = "integer",
                fg2_made = "integer", fg2_att = "integer", fg2_pct = "double", fg3_made = "integer",
                fg3_att = "integer", fg3_pct = "double", ft_made = "integer", ft_att = "integer", ft_pct = "double",
                reb = "integer", reb_off = "integer", reb_def = "integer", ast = "integer", stl = "integer",
                blk = "integer", tov = "integer", pf = "integer", plus_minus = "integer"),
  pbp = c(gid = "integer", seq = "integer", period = "character", period_no = "integer", clock = "character",
          seconds_left = "integer", side = "character", jersey = "character", player_zh = "character",
          action = "character", action_zh = "character", action_en = "character", text_zh = "character",
          ft_number = "integer", ft_awarded = "integer", points = "integer", score_away = "integer",
          score_home = "integer", x = "double", y = "double", nice_play = "logical", video_uuid = "character",
          synergy_play_id = "character", video_stat_category = "character", tryspot_player_id = "integer",
          video_created_at = "character"),
  standings = c(season = "integer", season_slug = "character", rank = "integer", team_id = "integer",
                team_zh = "character", team_uuid = "character", team_logo = "character", games_played = "integer",
                wins = "integer", losses = "integer", win_pct = "double", games_behind = "double",
                points_for_avg = "double", points_against_avg = "double", point_diff_avg = "double",
                home_record = "character", away_record = "character", streak = "character", last_n = "integer",
                last_n_record = "character"),
  stat_player = c(season = "integer", season_slug = "character", stage_sn = "integer", stage = "character",
                  player_page_id = "character", name_zh = "character", jersey = "character", team_zh = "character",
                  games = "integer", minutes_avg = "character", minutes_total = "character",
                  unlist(lapply(.PLEAGUE_STAT_COUNTS, function(k) stats::setNames(c("double", "integer"),
                                                                                  paste0(k, c("_avg", "_total"))))),
                  fg2_pct = "double", fg3_pct = "double", ft_pct = "double"),
  player = c(player_page_id = "character", player_id = "integer", name_zh = "character", name_en = "character",
             team_zh = "character", team_en = "character", jersey = "character", position = "character",
             nickname = "character", tenure = "character", height_cm = "double", weight_kg = "double",
             birthplace_zh = "character", status_zh = "character", education = "character"),
  player_seasons = c(player_page_id = "character", competition = "character", table = "character",
                     season = "integer", season_slug = "character", games = "integer", minutes = "character",
                     points = "double", reb = "double", ast = "double", stl = "double", blk = "double",
                     tov = "double", pf = "double", fg2_made = "double", fg2_att = "double", fg2_pct = "double",
                     fg3_made = "double", fg3_att = "double", fg3_pct = "double", ft_made = "double",
                     ft_att = "double", ft_pct = "double"),
  preciser_shots = c(game_uuid = "character", shot_no = "integer", period = "integer", period_label = "character",
                     clock = "character", seconds_left = "integer", side = "character", team_uuid = "character",
                     person_id = "character", player_name = "character", type = "character",
                     subtype = "character", area = "character", success = "logical", x = "double", y = "double",
                     message_zh = "character", has_video = "logical", home_team_uuid = "character",
                     away_team_uuid = "character"),
  preciser_summary_teams = c(game_uuid = "character", side = "character", team_uuid = "character",
                             team_name_zh = "character", color = "character", logo_url = "character",
                             points = "integer", rebounds = "integer", assists = "integer", steals = "integer",
                             blocks = "integer", turnovers = "integer", fg_made = "integer", fg2_pct = "double",
                             fg3_pct = "double", ft_pct = "double", fast_break_points = "double",
                             paint_points = "double", second_chance_points = "double", biggest_lead = "integer",
                             biggest_scoring_run = "integer", time_leading_seconds = "integer",
                             lead_changes = "integer", top_player_name = "character",
                             top_player_jersey = "character", top_player_points = "integer",
                             top_player_rebounds = "integer", top_player_assists = "integer"),
  preciser_score_log = c(game_uuid = "character", seq = "integer", period = "character", period_no = "integer",
                         clock = "character", seconds_left = "integer", home_score = "integer",
                         away_score = "integer"),
  preciser_win_probability = c(game_uuid = "character", minute = "integer", home_win_pct = "double"),
  preciser_rotation = c(game_uuid = "character", side = "character", name_zh = "character", jersey = "integer",
                        started = "logical", stint_no = "integer", start_period = "character",
                        start_clock = "character", start_seconds = "integer", end_period = "character",
                        end_clock = "character", end_seconds = "integer"),
  preciser_injury = c(game_uuid = "character", side = "character", team_uuid = "character",
                      team_name_zh = "character", team_name_en = "character", color = "character",
                      logo_url = "character", injury_report = "character"),
  team_crosswalk = c(team_id = "integer", team_uuid = "character")
)
.PLEAGUE_SPECS$preciser_lead_flow <- c(.PLEAGUE_SPECS$preciser_score_log, score_difference = "integer")

.PLEAGUE_PROTO <- list(integer = NA_integer_, double = NA_real_, character = NA_character_, logical = NA,
                       Date = NA_character_)

# rows (lists of typed scalars, NA / NULL for null) as a tibble with exactly the spec's columns
.pleague_frame <- function(short, rows) {
  spec <- .PLEAGUE_SPECS[[short]]
  cols <- lapply(names(spec), function(col) {
    type <- spec[[col]]
    proto <- .PLEAGUE_PROTO[[type]]
    v <- unlist(lapply(rows, function(r) {
      x <- r[[col]]
      if (is.null(x) || is.list(x) || length(x) != 1L || is.na(x)) proto else unname(x)
    }), use.names = FALSE)
    switch(type,
      integer = as.integer(v), double = as.double(v), character = as.character(v), logical = as.logical(v),
      Date = as.Date(as.character(v), format = "%Y-%m-%d")
    )
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

.pleague_rec <- function(raw) .pleague_obj(raw)
.pleague_gid <- function(raw) {
  r <- .pleague_rec(raw)
  got <- .pleague_i(r$gid)
  if (is.na(got)) got <- .pleague_i(.pleague_obj(r[["_request"]])$gid)
  got
}
.pleague_period_no <- function(label) {
  m <- .pleague_full("(Q|OT)([1-9])", label)
  if (is.null(m)) NA_integer_ else if (m[2] == "Q") as.integer(m[3]) else 4L + as.integer(m[3])
}

.pleague_parse_schedule <- function(raw) {
  r <- .pleague_rec(raw)
  rows <- lapply(.pleague_objs(r$games), function(g) {
    row <- list(season = .pleague_i(r$season_sdv), season_slug = .pleague_s(r$season), stage = .pleague_s(r$stage),
                gid = .pleague_i(g$gid), date = .pleague_date(g$date), weekday_zh = .pleague_s(g$weekday_zh),
                time = .pleague_s(g$time), starred = .pleague_lgl(g$starred), game_label = .pleague_s(g$game_label),
                venue_zh = .pleague_s(g$venue_zh), attendance = .pleague_i(g$attendance),
                capacity = .pleague_i(g$capacity), phase = .pleague_s(g$phase))
    for (side in c("away", "home")) for (k in c("team_id", "name_zh", "name_en", "logo", "score")) {
      key <- paste0(side, "_", k)
      row[[key]] <- if (k %in% c("team_id", "score")) .pleague_i(g[[key]]) else .pleague_s(g[[key]])
    }
    row
  })
  .pleague_frame("schedule", rows)
}

.pleague_parse_game <- function(raw) {
  r <- .pleague_rec(raw)
  gid <- .pleague_gid(r)
  rows <- list()
  if (!is.na(gid) && .pleague_one(r$status_zh)) {
    q <- .pleague_obj(r$quarters)
    ot <- names(q)[startsWith(names(q), "ot") & endsWith(names(q), "_home") & vapply(q, .pleague_truthy, TRUE)]
    rows[[1]] <- list(gid = gid, uuid = .pleague_s(r$uuid), status_zh = .pleague_s(r$status_zh),
                      finished = identical(r$status_zh, .PLEAGUE_FINAL), date = .pleague_date(r$date),
                      time = .pleague_s(r$time), venue_zh = .pleague_s(r$venue_zh),
                      game_label_zh = .pleague_s(r$game_label_zh), away_name_zh = .pleague_s(r$away_name_zh),
                      away_name_en = .pleague_s(r$away_name_en), away_logo = .pleague_s(r$away_logo),
                      away_score = .pleague_i(r$away_score), home_name_zh = .pleague_s(r$home_name_zh),
                      home_name_en = .pleague_s(r$home_name_en), home_logo = .pleague_s(r$home_logo),
                      home_score = .pleague_i(r$home_score), overtimes = length(ot))
  }
  .pleague_frame("game", rows)
}

.pleague_parse_periods <- function(raw) {
  r <- .pleague_rec(raw)
  gid <- .pleague_gid(r)
  q <- .pleague_obj(r$quarters)
  rows <- list()
  if (!is.na(gid)) {
    for (key in c("q1", "q2", "q3", "q4", "ot1", "ot2", "ot3", "ot4", "ot5")) {
      h <- .pleague_i(q[[paste0(key, "_home")]])
      a <- .pleague_i(q[[paste0(key, "_away")]])
      if (is.na(h) || is.na(a) || (startsWith(key, "ot") && h == 0L && a == 0L)) next
      n <- as.integer(substring(key, nchar(key)))
      rows[[length(rows) + 1L]] <- list(gid = gid, period = toupper(key),
                                        period_no = if (startsWith(key, "q")) n else 4L + n,
                                        home_points = h, away_points = a)
    }
  }
  .pleague_frame("periods", rows)
}

.PLEAGUE_ROLES <- stats::setNames(c("referee", "first_umpire", "second_umpire"),
                                  c("\u4e3b\u88c1\u5224", "\u7b2c\u4e00\u6aa2\u67e5\u54e1", "\u7b2c\u4e8c\u6aa2\u67e5\u54e1"))

.pleague_parse_officials <- function(raw) {
  r <- .pleague_rec(raw)
  gid <- .pleague_gid(r)
  rows <- list()
  if (!is.na(gid)) {
    off <- .pleague_objs(r$officials)
    rows <- lapply(seq_along(off), function(n) {
      role <- .pleague_s(off[[n]]$role_zh)
      list(gid = gid, official_no = n, role = if (is.na(role)) NA_character_ else unname(.PLEAGUE_ROLES[match(role, names(.PLEAGUE_ROLES))]),
           role_zh = role, name_zh = .pleague_s(off[[n]]$name_zh))
    })
  }
  .pleague_frame("officials", rows)
}

.pleague_pair <- function(v) {
  m <- .pleague_full("\\s*([0-9]+)\\s*-\\s*([0-9]+)\\s*", v)
  if (is.null(m)) c(NA_integer_, NA_integer_) else as.integer(m[2:3])
}
.pleague_box_body <- function(raw) .pleague_obj(.pleague_rec(raw)$data)

.pleague_parse_box_players <- function(raw) {
  gid <- .pleague_gid(raw)
  d <- .pleague_box_body(raw)
  rows <- list()
  for (side in c("home", "away")) for (p in .pleague_objs(d[[side]])) {
    played <- .pleague_str1(p$mins) && !.pleague_strip(p$mins) %in% c("", "DNP")
    fg2 <- .pleague_pair(p$two_m_two)
    fg3 <- .pleague_pair(p$trey_m_trey)
    ft <- .pleague_pair(p$ft_m_ft)
    secs <- .pleague_i(p$seconds)
    name <- .pleague_s(p$name_alt)
    rows[[length(rows) + 1L]] <- list(
      gid = gid, side = side, player_id = .pleague_i(p$player_id), person_id = .pleague_s(p$personId),
      random_id = .pleague_s(p$random_id), name_zh = if (is.na(name)) .pleague_s(p$name) else name,
      jersey = .pleague_s(p$jersey), starter = if (played) .pleague_str1(p$starter) && p$starter == "\u3007" else NA, played = played,
      minutes = if (played) .pleague_strip(p$mins) else NA_character_,
      seconds = if (!is.na(secs)) secs else if (played) .pleague_seconds(p$mins) else NA_integer_,
      points = .pleague_i(p$points), reb_off = .pleague_i(p$reb_o), reb_def = .pleague_i(p$reb_d),
      reb = .pleague_i(p$reb), ast = .pleague_i(p$ast), stl = .pleague_i(p$stl), blk = .pleague_i(p$blk),
      tov = .pleague_i(p$turnover), pf = .pleague_i(p$pfoul), plus_minus = .pleague_i(p$positive),
      eff = .pleague_i(p$eff), fg2_made = fg2[1], fg2_att = fg2[2], fg2_pct = .pleague_f(p$twop),
      fg3_made = fg3[1], fg3_att = fg3[2], fg3_pct = .pleague_f(p$treyp), ft_made = ft[1], ft_att = ft[2],
      ft_pct = .pleague_f(p$ftp), efg_pct = .pleague_f(p$efgp), ts_pct = .pleague_f(p$tsp),
      usage_pct = .pleague_f(p$ugp), position = .pleague_s(p$position), ortg = .pleague_f(p$ORTG),
      drtg = .pleague_f(p$DRTG), netrtg = .pleague_f(p$NETRTG), pace = .pleague_f(p$pace),
      ast_ratio = .pleague_f(p$AST_RATIO), to_ratio = .pleague_f(p$TO_RATIO),
      off_possessions = .pleague_i(p$offensive_possession),
      opp_off_possessions = .pleague_i(p$opp_offensive_possession),
      opp_pts_second_chance = .pleague_i(p$opp_points_from_2nd_chance),
      opp_pts_fast_break = .pleague_i(p$opp_points_from_fastbreak),
      opp_pts_off_turnover = .pleague_i(p$opp_points_from_turnover),
      opp_pts_paint = .pleague_i(p$opp_points_in_the_paint)
    )
  }
  .pleague_frame("box_players", rows)
}

.pleague_parse_box_teams <- function(raw) {
  gid <- .pleague_gid(raw)
  d <- .pleague_box_body(raw)
  rows <- list()
  for (side in c("home", "away")) {
    t <- d[[paste0(side, "_total")]]
    if (!.pleague_is_obj(t)) next
    secs <- .pleague_i(t$seconds)
    rows[[length(rows) + 1L]] <- list(
      gid = gid, side = side, minutes = .pleague_s(t$mins),
      seconds = if (!is.na(secs)) secs else .pleague_seconds(t$mins), points = .pleague_i(t$points),
      fg2_made = .pleague_i(t$two_m), fg2_att = .pleague_i(t$two), fg2_pct = .pleague_f(t$twop),
      fg3_made = .pleague_i(t$trey_m), fg3_att = .pleague_i(t$trey), fg3_pct = .pleague_f(t$treyp),
      ft_made = .pleague_i(t$ft_m), ft_att = .pleague_i(t$ft), ft_pct = .pleague_f(t$ftp), reb = .pleague_i(t$reb),
      reb_off = .pleague_i(t$reb_o), reb_def = .pleague_i(t$reb_d), ast = .pleague_i(t$ast), stl = .pleague_i(t$stl),
      blk = .pleague_i(t$blk), tov = .pleague_i(t$turnover), pf = .pleague_i(t$pfoul),
      plus_minus = .pleague_i(t$positive)
    )
  }
  .pleague_frame("box_teams", rows)
}

.pleague_parse_pbp <- function(raw) {
  r <- .pleague_rec(raw)
  gid <- .pleague_gid(r)
  rows <- lapply(.pleague_objs(r$events), function(e) {
    v <- .pleague_obj(e$video)
    code <- .pleague_s(e$action)
    list(gid = gid, seq = .pleague_i(e$seq), period = .pleague_s(e$period), period_no = .pleague_period_no(e$period),
         clock = .pleague_s(e$clock), seconds_left = .pleague_seconds(e$clock), side = .pleague_s(e$side),
         jersey = .pleague_s(e$jersey), player_zh = .pleague_s(e$player_zh), action = code,
         action_zh = if (.pleague_str1(e$action_zh)) e$action_zh else NA_character_,
         action_en = .pleague_action_en(code, e$action_zh),
         text_zh = .pleague_s(e$text_zh), ft_number = .pleague_i(e$ft_number), ft_awarded = .pleague_i(e$ft_awarded),
         points = .pleague_i(e$points), score_away = .pleague_i(e$score_away), score_home = .pleague_i(e$score_home),
         x = .pleague_f(e$x), y = .pleague_f(e$y), nice_play = .pleague_lgl(e$nice_play),
         video_uuid = .pleague_s(v$video_uuid), synergy_play_id = .pleague_s(v$synergy_play_id),
         video_stat_category = .pleague_s(v$stat_category), tryspot_player_id = .pleague_i(v$tryspot_player_id),
         video_created_at = .pleague_s(v$created_at))
  })
  .pleague_frame("pbp", rows)
}

.pleague_parse_standings <- function(raw) {
  r <- .pleague_rec(raw)
  rows <- lapply(.pleague_objs(r$teams), function(t) {
    logo <- .pleague_s(t$team_logo)
    uu <- .pleague_match("/plg/teams/([0-9a-f-]{36})\\.png", .pleague_or(logo, ""))
    list(season = .pleague_i(r$season_sdv), season_slug = .pleague_s(r$season), rank = .pleague_i(t$rank),
         team_id = .pleague_i(t$team_id), team_zh = .pleague_s(t$team_zh),
         team_uuid = if (is.null(uu)) NA_character_ else uu[2], team_logo = logo,
         games_played = .pleague_i(t$games_played), wins = .pleague_i(t$wins), losses = .pleague_i(t$losses),
         win_pct = .pleague_f(t$win_pct), games_behind = .pleague_f(t$games_behind),
         points_for_avg = .pleague_f(t$points_for_avg), points_against_avg = .pleague_f(t$points_against_avg),
         point_diff_avg = .pleague_f(t$point_diff_avg), home_record = .pleague_s(t$home_record),
         away_record = .pleague_s(t$away_record), streak = .pleague_s(t$streak), last_n = .pleague_i(r$last_n),
         last_n_record = .pleague_s(t$last_n_record))
  })
  .pleague_frame("standings", rows)
}

.pleague_cast <- function(v, type) {
  switch(type, character = .pleague_s(v), integer = .pleague_i(v), .pleague_f(v))
}

.pleague_parse_stat_player <- function(raw) {
  r <- .pleague_rec(raw)
  spec <- .PLEAGUE_SPECS$stat_player
  rows <- lapply(.pleague_objs(r$players), function(p) {
    row <- list(season = .pleague_i(r$season_sdv), season_slug = .pleague_s(r$season),
                stage_sn = .pleague_i(r$stage_sn), stage = .pleague_s(r$stage))
    for (c in setdiff(names(spec), names(row))) row[[c]] <- .pleague_cast(p[[c]], spec[[c]])
    row
  })
  .pleague_frame("stat_player", rows)
}

.pleague_parse_player <- function(raw) {
  r <- .pleague_rec(raw)
  rows <- list()
  if (!is.na(.pleague_s(r$player_page_id))) {
    edu <- Filter(function(e) .pleague_str1(e) && nzchar(.pleague_strip(e)), if (is.list(r$education)) r$education else list())
    rows[[1]] <- list(
      player_page_id = .pleague_s(r$player_page_id), player_id = .pleague_i(r$member_id),
      name_zh = .pleague_s(r$name_zh), name_en = .pleague_s(r$name_en), team_zh = .pleague_s(r$team_zh),
      team_en = .pleague_s(r$team_en), jersey = .pleague_s(r$jersey), position = .pleague_s(r$position),
      nickname = .pleague_s(r$nickname), tenure = .pleague_s(r$tenure), height_cm = .pleague_f(r$height_cm),
      weight_kg = .pleague_f(r$weight_kg), birthplace_zh = .pleague_s(r$birthplace_zh),
      status_zh = .pleague_s(r$status_zh),
      education = if (length(edu)) paste(vapply(edu, .pleague_strip, ""), collapse = "; ") else NA_character_
    )
  }
  .pleague_frame("player", rows)
}

.pleague_parse_player_seasons <- function(raw) {
  r <- .pleague_rec(raw)
  pid <- .pleague_s(r$player_page_id)
  spec <- .PLEAGUE_SPECS$player_seasons
  rows <- list()
  for (t in list(c("plg", "totals", "season_totals"), c("plg", "averages", "season_averages"),
                 c("easl", "totals", "easl_season_totals"), c("easl", "averages", "easl_season_averages"))) {
    for (s in .pleague_objs(r[[t[3]]])) {
      slug <- .pleague_s(s$season)
      m <- .pleague_full("([0-9]{4})-([0-9]{2})", .pleague_or(slug, ""))
      row <- list(player_page_id = pid, competition = t[1], table = t[2],
                  season = if (is.null(m)) NA_integer_ else as.integer(m[2]) + 1L, season_slug = slug)
      for (c in setdiff(names(spec), names(row))) row[[c]] <- .pleague_cast(s[[c]], spec[[c]])
      rows[[length(rows) + 1L]] <- row
    }
  }
  .pleague_frame("player_seasons", rows)
}

# --- the Preciser vendor ------------------------------------------------------

.pleague_vdata <- function(raw) {
  if (!.pleague_is_obj(raw)) return(list(d = list(), uuid = NA_character_))
  uuid <- .pleague_obj(raw[["_request"]])$uuid
  list(d = .pleague_obj(raw$data), uuid = if (.pleague_str1(uuid) && nzchar(uuid)) uuid else NA_character_)
}
.pleague_period_label <- function(v) {
  if (is.numeric(v) && .pleague_one(v) && !is.logical(v) && v == trunc(v)) {
    return(if (v >= 1 && v <= 4) paste0("Q", v) else if (v > 4) paste0("OT", v - 4) else NA_character_)
  }
  if (.pleague_str1(v)) .pleague_na_if_blank(toupper(.pleague_strip(v))) else NA_character_
}
.pleague_uuid_or <- function(uuid, d) if (is.na(uuid)) .pleague_s(d$game_id) else uuid

.pleague_parse_preciser_shots <- function(raw) {
  x <- .pleague_vdata(raw)
  d <- x$d
  home <- .pleague_s(d$home_id)
  away <- .pleague_s(d$away_id)
  players <- list()
  for (p in .pleague_objs(d$players)) {
    k <- .pleague_key(p$id)
    players[[k]] <- p # a Python dict: the last row per id wins
  }
  shots <- .pleague_objs(d$shot)
  rows <- lapply(seq_along(shots), function(n) {
    s <- shots[[n]]
    p <- .pleague_obj(players[[.pleague_key(s$player)]])
    team <- .pleague_s(p$team_id)
    side <- if (!is.na(team) && identical(team, home)) "home" else if (!is.na(team) && identical(team, away)) "away" else NA_character_
    list(game_uuid = x$uuid, shot_no = n, period = .pleague_i(s$period), period_label = .pleague_period_label(s$period),
         clock = .pleague_s(s$clock), seconds_left = .pleague_seconds(s$clock), side = side, team_uuid = team,
         person_id = .pleague_s(s$player), player_name = .pleague_s(p$name), type = .pleague_s(s$type),
         subtype = .pleague_s(s$subtype), area = .pleague_s(s$area), success = .pleague_lgl(s$success),
         x = .pleague_f(s$x), y = .pleague_f(s$y), message_zh = .pleague_s(s$message),
         has_video = .pleague_truthy(s$video_url), home_team_uuid = home, away_team_uuid = away)
  })
  .pleague_frame("preciser_shots", rows)
}

.PLEAGUE_COMPARE <- c(points = "points", rebounds = "rebounds", assists = "assists", steals = "steals",
                      blocks = "blocks", turnovers = "turnovers",
                      field_goal_percentage = "fg_made", # the key says percentage; the value is a count of makes
                      two_points_percentage = "fg2_pct", three_points_percentage = "fg3_pct",
                      free_throw_percentage = "ft_pct")

.pleague_parse_preciser_summary_teams <- function(raw) {
  x <- .pleague_vdata(raw)
  d <- x$d
  spec <- .PLEAGUE_SPECS$preciser_summary_teams
  rows <- list()
  if (.pleague_is_obj(d$home_team) || .pleague_is_obj(d$away_team)) {
    lead <- .pleague_obj(d$leadStats)
    for (side in c("home", "away")) {
      team <- .pleague_obj(d[[paste0(side, "_team")]])
      top <- .pleague_obj(.pleague_obj(d$top_performers)[[paste0(side, "_player")]])
      sv <- paste0(side, "_value")
      row <- list(game_uuid = .pleague_uuid_or(x$uuid, d), side = side, team_uuid = .pleague_s(team$id),
                  team_name_zh = .pleague_s(team$name), color = .pleague_s(team$color),
                  logo_url = .pleague_s(team$logo_url),
                  fast_break_points = .pleague_f(.pleague_obj(d$fast_break_points)[[sv]]),
                  paint_points = .pleague_f(.pleague_obj(d$paint_points)[[sv]]),
                  second_chance_points = .pleague_f(.pleague_obj(d$second_chance_points)[[sv]]),
                  biggest_lead = .pleague_i(.pleague_obj(lead$biggestLead)[[side]]),
                  biggest_scoring_run = .pleague_i(.pleague_obj(lead$biggestScoringRun)[[side]]),
                  time_leading_seconds = .pleague_i(.pleague_obj(lead$timeLeadingSeconds)[[side]]),
                  lead_changes = .pleague_i(lead$leadChanges), top_player_name = .pleague_s(top$name),
                  top_player_jersey = .pleague_s(top$jersey_number), top_player_points = .pleague_i(top$points),
                  top_player_rebounds = .pleague_i(top$rebound), top_player_assists = .pleague_i(top$assists))
      cmp <- .pleague_obj(d$team_comparison)
      for (key in names(.PLEAGUE_COMPARE)) {
        col <- .PLEAGUE_COMPARE[[key]]
        row[[col]] <- .pleague_cast(.pleague_obj(cmp[[key]])[[sv]], spec[[col]])
      }
      rows[[length(rows) + 1L]] <- row
    }
  }
  .pleague_frame("preciser_summary_teams", rows)
}

.pleague_score_rows <- function(d, uuid, items) {
  items <- .pleague_objs(items)
  lapply(seq_along(items), function(n) {
    r <- items[[n]]
    label <- .pleague_period_label(r$quarter)
    list(game_uuid = .pleague_uuid_or(uuid, d), seq = n, period = label, period_no = .pleague_period_no(label),
         clock = .pleague_s(r$time), seconds_left = .pleague_seconds(r$time), home_score = .pleague_i(r$home_score),
         away_score = .pleague_i(r$away_score), score_difference = .pleague_i(r$score_difference))
  })
}

.pleague_parse_preciser_score_log <- function(raw) {
  x <- .pleague_vdata(raw)
  .pleague_frame("preciser_score_log", .pleague_score_rows(x$d, x$uuid, x$d$pbp))
}

.pleague_parse_preciser_lead_flow <- function(raw) {
  x <- .pleague_vdata(raw)
  .pleague_frame("preciser_lead_flow", .pleague_score_rows(x$d, x$uuid, .pleague_obj(x$d$leadStats)$leadPerMinutes))
}

.pleague_parse_preciser_win_probability <- function(raw) {
  x <- .pleague_vdata(raw)
  probs <- x$d$home_team_probability_over_time
  probs <- if (.pleague_is_arr(probs)) probs else list()
  rows <- lapply(seq_along(probs), function(n) {
    list(game_uuid = .pleague_uuid_or(x$uuid, x$d), minute = n - 1L, home_win_pct = .pleague_f(probs[[n]]))
  })
  .pleague_frame("preciser_win_probability", rows)
}

.pleague_parse_preciser_rotation <- function(raw) {
  x <- .pleague_vdata(raw)
  rows <- list()
  for (sk in list(c("home", "homeTeam"), c("away", "awayTeam"))) {
    for (p in .pleague_objs(x$d[[sk[2]]])) {
      stints <- .pleague_objs(p$periods)
      for (n in seq_along(stints)) {
        st <- stints[[n]]
        rows[[length(rows) + 1L]] <- list(
          game_uuid = x$uuid, side = sk[1], name_zh = .pleague_s(p$name), jersey = .pleague_i(p$jerseyNumber),
          started = .pleague_lgl(p$started), stint_no = n, start_period = .pleague_period_label(st$startQuarter),
          start_clock = .pleague_s(st$startTime), start_seconds = .pleague_i(st$startSeconds),
          end_period = .pleague_period_label(st$endQuarter), end_clock = .pleague_s(st$endTime),
          end_seconds = .pleague_i(st$endSeconds)
        )
      }
    }
  }
  .pleague_frame("preciser_rotation", rows)
}

# Python json.dumps(x, ensure_ascii=False) of a decoded JSON value
.pleague_py_json <- function(x) {
  if (is.null(x)) return("null")
  if (.pleague_is_obj(x)) {
    return(paste0("{", paste0(vapply(names(x), .pleague_py_json, ""), ": ", vapply(x, .pleague_py_json, ""),
                              collapse = ", "), "}"))
  }
  if (is.list(x)) return(paste0("[", paste(vapply(x, .pleague_py_json, ""), collapse = ", "), "]"))
  if (is.logical(x)) return(if (x) "true" else "false")
  if (is.integer(x)) return(as.character(x))
  if (is.double(x)) {
    s <- format(x, digits = 17)
    return(if (grepl("^-?[0-9]+$", s)) paste0(s, ".0") else s)
  }
  as.character(jsonlite::toJSON(x, auto_unbox = TRUE))
}

.pleague_parse_preciser_injury <- function(raw) {
  x <- .pleague_vdata(raw)
  d <- x$d
  rows <- list()
  if (.pleague_is_obj(d$home_team) || .pleague_is_obj(d$away_team)) {
    report <- .pleague_obj(d$injury_report)
    for (side in c("home", "away")) {
      team <- .pleague_obj(d[[paste0(side, "_team")]])
      got <- report[[side]]
      rows[[length(rows) + 1L]] <- list(
        game_uuid = .pleague_uuid_or(x$uuid, d), side = side, team_uuid = .pleague_s(team$id),
        team_name_zh = .pleague_s(team$name), team_name_en = .pleague_s(team$english_name),
        color = .pleague_s(team$color), logo_url = .pleague_s(team$logo_url),
        injury_report = if (is.null(got)) NA_character_ else .pleague_py_json(got)
      )
    }
  }
  .pleague_frame("preciser_injury", rows)
}

# site team_id -> Preciser team uuid (the club-logo file name on the standings page)
.PLEAGUE_TEAMS <- c(`1` = "e86394aa-3d88-11ed-8ba8-7f44ba46b0b1", `2` = "e865bb20-3d88-11ed-a956-7f44ba46b0b1",
                    `3` = "e8674343-3d88-11ed-98b4-7f44ba46b0b1", `4` = "e869743f-3d88-11ed-925e-7f44ba46b0b1",
                    `5` = "e86cac11-3d88-11ed-8637-7f44ba46b0b1", `6` = "e86b0ecc-3d88-11ed-bed5-7f44ba46b0b1",
                    `7` = "3c3a601a-358a-11ed-ab92-711c34ed1298", `8` = "bf957f5a-9389-11f0-812c-a38482ec4d30")

.PLEAGUE_PARSERS <- list(
  schedule = .pleague_parse_schedule, game = .pleague_parse_game, periods = .pleague_parse_periods,
  officials = .pleague_parse_officials, box_players = .pleague_parse_box_players,
  box_teams = .pleague_parse_box_teams, pbp = .pleague_parse_pbp, standings = .pleague_parse_standings,
  stat_player = .pleague_parse_stat_player, player = .pleague_parse_player,
  player_seasons = .pleague_parse_player_seasons, preciser_shots = .pleague_parse_preciser_shots,
  preciser_summary_teams = .pleague_parse_preciser_summary_teams,
  preciser_score_log = .pleague_parse_preciser_score_log, preciser_lead_flow = .pleague_parse_preciser_lead_flow,
  preciser_win_probability = .pleague_parse_preciser_win_probability,
  preciser_rotation = .pleague_parse_preciser_rotation, preciser_injury = .pleague_parse_preciser_injury
)

# the parser contract: a typed zero-row tibble for anything it cannot read, never an error
.pleague_parse <- function(short, raw) {
  tryCatch(.PLEAGUE_PARSERS[[short]](raw), error = function(e) .pleague_frame(short, list()))
}

.PLEAGUE_TITLES <- c(
  schedule = "Schedule", game = "Game", periods = "Periods", officials = "Officials", box_players = "Player Box",
  box_teams = "Team Box", pbp = "Play-by-Play", standings = "Standings", stat_player = "Player Stats",
  player = "Player", player_seasons = "Player Seasons", preciser_shots = "Shots",
  preciser_summary_teams = "Summary Teams", preciser_score_log = "Score Log", preciser_lead_flow = "Lead Flow",
  preciser_win_probability = "Win Probability", preciser_rotation = "Rotation", preciser_injury = "Injury Report"
)

# fetch + parse + class: the body of every exported wrapper
.pleague_run <- function(short, p, call) {
  vendor <- startsWith(short, "preciser_")
  raw <- if (vendor) {
    kind <- c(preciser_shots = "shots", preciser_rotation = "rotation", preciser_injury = "injury")[short]
    .pleague_vendor_fetch(if (is.na(kind)) "summary" else unname(kind), p$uuid, p$gid, call)
  } else {
    .pleague_fetch(short, p, call)
  }
  src <- if (vendor) "api.preciser.io" else "pleagueofficial.com"
  make_hoopR_data(.pleague_parse(short, raw), paste("P. LEAGUE+", .PLEAGUE_TITLES[[short]], "from", src), Sys.time())
}
