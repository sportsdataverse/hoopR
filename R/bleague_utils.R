# bleague_utils.R -- internal runtime + parsers of the B.LEAGUE `bleague_*()` family.
#
# R mirror of sdv-py sportsdataverse/basketball/bleague/ (bleague_runtime.py,
# bleague_parsers.py, bleague_codes.py): same routes, refusals, casts and snake_case
# columns. Two keyless hosts:
#   S3   https://b-league.s3.amazonaws.com/web_json   game contexts (v2 / v1 feeds)
#   SITE https://www.bleague.jp                        game_detail / schedule / standings pages
#
# * Season key: the site's Year / year= is the season START year; the public `season`
#   is the END year, so the request sends `season - 1`.
# * Feed fallback (read at run time): v2_genius_contexts/{key}/latestid, then
#   v1_contexts, then the game_detail page's embedded context (the only copy of 2016-17
#   and 2017-18). S3's 403 AccessDenied for a key it does not hold moves on; all three
#   missing is hoopR_no_data.
# * Refused (hoopR_asset_fetch), fail closed: a body that is not the feed's context
#   shape, an error envelope, a context or row of another game, a box row of a team
#   that is not one of the game's two, a Year that differs from a given season, an
#   embed of another game, an unfinished game, a non-integer latestid, a schedule page
#   for another tab / season / event / day, a paged (truncated) schedule list,
#   standings of another season or tab, layout drift, and any non-200 other than the
#   403 miss / 404.
# * HTTP 500 is retried (sdv-py RETRY_STATUSES holds 500): retry_500 = TRUE.
# * Japanese text lives here as \u escapes (the PDF manual cannot build CJK).

.bleague_s3 <- "https://b-league.s3.amazonaws.com/web_json"
.bleague_site <- "https://www.bleague.jp"
.bleague_feed_names <- c(v2 = "v2_genius_contexts", v1 = "v1_contexts")
.bleague_feed_keys <- list(
  v2 = c("PlayByPlays", "HomeBoxscores", "AwayBoxscores", "Summaries", "Game"),
  v1 = c("PlayByPlays", "HomeBoxscores", "AwayBoxscores", "Summaries", "Game", "Leaders", "Points")
)
.bleague_error_keys <- c("message", "error", "errors", "status", "exception", "trace", "code")
#' Division tab -> the league-season competition type the schedule page defaults to.
#' @noRd
.bleague_default_event <- c(`1` = 2L, `2` = 7L, `3` = 15L)
.bleague_page_size <- 20L # the schedule pager's page; no league day has that many games

# ------------------------------------------------------------------------- conditions

#' @noRd
.bleague_fail <- function(msg, call, ...) .abort_asset_fetch("{msg}", ..., call = call)
#' @noRd
.bleague_none <- function(msg, call, ...) .abort_no_data("{msg}", ..., call = call)
#' @noRd
.bleague_bad <- function(msg, call, ...) .abort_bad_request("{msg}", ..., call = call)

#' A page that is not the data asked for (sdv-py `_NotParsed`); `empty` = right page, no games.
#' @noRd
.bleague_not_parsed <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "bleague_not_parsed", empty = empty)
}

# -------------------------------------------------------------------------- transport

#' One throttled, retried GET (500 included); the response unchecked.
#' @noRd
.bleague_fetch <- function(url, query = list(), call) {
  .intl_response(url, query = query, retry_500 = TRUE, timeout = 60, call = call)
}

#' sdv-py bleague_runtime._status: only 200 passes.
#' @noRd
.bleague_status <- function(url, resp, call) {
  status <- httr2::resp_status(resp)
  if (status == 200L) return(invisible(resp))
  where <- .intl_where(url)
  if (status == 404L) .bleague_none(paste0(where, " answered HTTP 404"), call, status = status)
  if (status %in% c(400L, 422L)) {
    .bleague_bad(paste0(where, " rejected the request: HTTP ", status), call, status = status)
  }
  .bleague_fail(paste0(where, " answered HTTP ", status, ", not 200"), call, status = status,
                transient = status %in% c(408L, 429L) || status >= 500L)
}

#' S3's answer for a key it does not hold: 403 with an AccessDenied XML body.
#' @noRd
.bleague_is_miss <- function(resp) {
  httr2::resp_status(resp) == 403L && grepl("AccessDenied", .intl_body_text(resp), fixed = TRUE)
}

#' A site page: HTTP 200, an HTML content type and a non-empty body.
#' @noRd
.bleague_html <- function(url, query, call) {
  resp <- .bleague_fetch(url, query, call)
  .bleague_status(url, resp, call)
  where <- .intl_where(url)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("html", ctype, fixed = TRUE)) {
    .bleague_fail(paste0(where, " answered ", if (nzchar(ctype)) ctype else "no content type", ", not HTML"), call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .bleague_fail(paste0(where, " answered HTTP 200 with an empty body"), call)
  text
}

#' sdv-py `_int_arg`: a non-negative whole number (or digit string), else `hoopR_bad_request`.
#' @return An integer.
#' @noRd
.bleague_int_arg <- function(value, what, call) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) &&
    ((is.numeric(value) && is.finite(value) && value >= 0 && value == trunc(value)) ||
       (is.character(value) && grepl("^\\s*[0-9]+\\s*$", value, perl = TRUE)))
  out <- if (ok) suppressWarnings(as.integer(as.numeric(value))) else NA_integer_
  if (is.na(out)) .bleague_bad(paste0(what, " must be an integer; got ", format(value)[1]), call)
  out
}

# --------------------------------------------------------------------------- JSON shape

.bleague_is_obj <- function(x) is.list(x) && !is.null(names(x))
.bleague_is_arr <- function(x) is.list(x) && is.null(names(x))
.bleague_dicts <- function(v) if (.bleague_is_arr(v)) Filter(.bleague_is_obj, v) else list()

#' Type-strict equality (`1L != "1"`, `TRUE != 1L`), sdv-py `_same`.
#' @noRd
.bleague_same <- function(a, b) {
  !is.null(a) && !is.list(a) && length(a) == 1L && length(b) == 1L && !is.na(a) &&
    typeof(a) == typeof(b) && a == b
}

.bleague_show <- function(v) {
  if (is.null(v)) return("None")
  if (is.list(v)) return(if (.bleague_is_obj(v)) "dict" else "list")
  if (is.character(v)) paste0("'", v, "'") else format(v)
}

# ---------------------------------------------------------------------------- contexts

#' Why `body` is not a final, in-scope context of game `key`, or `NULL` (sdv-py `_scope_error`).
#' @noRd
.bleague_scope_error <- function(body, feed, key, season) {
  keys <- .bleague_feed_keys[[feed]]
  if (!.bleague_is_obj(body) || anyDuplicated(names(body)) || !setequal(names(body), keys)) {
    got <- if (.bleague_is_obj(body)) paste(sort(names(body)), collapse = ", ") else class(body)[[1]]
    return(paste0("not a ", feed, " context: keys ", got))
  }
  if (all(names(body) %in% .bleague_error_keys)) return("error envelope")
  game <- if (.bleague_is_obj(body$Game)) body$Game else list()
  if (!.bleague_same(game$ScheduleKey, key)) {
    return(paste0("out of scope: Game.ScheduleKey ", .bleague_show(game$ScheduleKey), ", asked for ", key))
  }
  if (!is.null(season) && !.bleague_same(game$Year, season - 1L)) {
    return(paste0("out of scope: Year ", .bleague_show(game$Year), ", asked for season ", season,
                  " (Year ", season - 1L, ")"))
  }
  if (!isTRUE(game$GameEndedFlg) || !isTRUE(game$RecordFixedFlg)) {
    return("game not final (GameEndedFlg / RecordFixedFlg not both true)")
  }
  home <- game$HomeTeamID
  away <- game$AwayTeamID
  if (is.null(home) || is.null(away) || .bleague_same(home, away)) return("game header without two team ids")
  for (name in c("PlayByPlays", "HomeBoxscores", "AwayBoxscores", "Summaries", "Leaders", "Points")) {
    if (!name %in% names(body)) next
    rows <- body[[name]]
    if (!.bleague_is_arr(rows) || (name %in% c("PlayByPlays", "HomeBoxscores", "AwayBoxscores", "Summaries") &&
                                     !length(rows))) {
      return(paste0(name, " empty or not a list"))
    }
    for (r in rows) {
      if (!.bleague_is_obj(r) || !.bleague_same(r$ScheduleKey, key)) {
        return(paste0("out of scope: a ", name, " row of game ",
                      .bleague_show(if (.bleague_is_obj(r)) r$ScheduleKey else r)))
      }
      if (endsWith(name, "Boxscores")) {
        totals <- .bleague_same(r$Category, 3L) && is.null(r$TeamID)
        if (!totals && !.bleague_same(r$TeamID, home) && !.bleague_same(r$TeamID, away)) {
          return(paste0("out of scope: ", name, " row of team ", .bleague_show(r$TeamID)))
        }
      }
    }
  }
  NULL
}

#' The JSON value starting at the first non-blank character of `text` (Python `raw_decode`).
#' @noRd
.bleague_json_prefix <- function(text) {
  codes <- utf8ToInt(text)
  start <- which(!codes %in% c(32L, 9L, 10L, 13L))[1]
  if (is.na(start) || !codes[[start]] %in% c(123L, 91L)) .bleague_not_parsed("embed is not an object")
  special <- which(codes %in% c(34L, 92L, 123L, 125L, 91L, 93L))
  special <- special[special >= start]
  depth <- 0L
  in_str <- FALSE
  skip <- 0L
  end <- NA_integer_
  for (p in special) {
    if (p <= skip) next
    ch <- codes[[p]]
    if (in_str) {
      if (ch == 92L) skip <- p + 1L else if (ch == 34L) in_str <- FALSE
    } else if (ch == 34L) {
      in_str <- TRUE
    } else if (ch %in% c(123L, 91L)) {
      depth <- depth + 1L
    } else if (ch %in% c(125L, 93L)) {
      depth <- depth - 1L
      if (depth == 0L) {
        end <- p
        break
      }
    }
  }
  if (is.na(end)) .bleague_not_parsed("embed is not JSON: unterminated value")
  rec <- tryCatch(jsonlite::parse_json(intToUtf8(codes[start:end]), simplifyVector = FALSE),
                  error = function(e) .bleague_not_parsed(paste0("embed is not JSON: ", conditionMessage(e))))
  if (!.bleague_is_obj(rec)) .bleague_not_parsed("embed is not an object")
  rec
}

#' The object a game_detail page assigns to `_contexts_s3id.data` (sdv-py `_embed_context`).
#' @noRd
.bleague_embed_context <- function(html) {
  m <- regexpr("_contexts_s3id\\.data\\s*=\\s*", html, perl = TRUE)
  if (m < 0) .bleague_not_parsed("no _contexts_s3id.data embed on the page")
  .bleague_json_prefix(substring(html, m + attr(m, "match.length")))
}

#' The embedded context of game `key` and its feed (sdv-py `_embed_body`).
#' @noRd
.bleague_embed_body <- function(html, key) {
  rec <- .bleague_embed_context(html)
  admin <- rec$admin_name
  feed <- names(.bleague_feed_names)[vapply(.bleague_feed_names, function(n) .bleague_same(admin, n), logical(1))]
  if (!length(feed)) .bleague_not_parsed(paste0("embed admin_name ", .bleague_show(admin), " is not a known feed"))
  feed <- feed[[1]]
  if (!.bleague_same(rec$ScheduleKey, as.character(key))) {
    .bleague_not_parsed(paste0("out of scope: embed ScheduleKey ", .bleague_show(rec$ScheduleKey),
                               ", asked for '", key, "'"))
  }
  keys <- .bleague_feed_keys[[feed]]
  list(body = rec[intersect(keys, names(rec))], feed = feed)
}

.bleague_stamp <- function(body, key, feed) {
  body[["_request"]] <- list(schedule_key = key, feed = feed)
  body
}

#' The final context of game `schedule_key`: v2 feed, else v1 feed, else the game page's embed.
#' @noRd
.bleague_context <- function(schedule_key, season = NULL, call) {
  key <- .bleague_int_arg(schedule_key, "schedule_key", call)
  if (!is.null(season)) season <- .bleague_int_arg(season, "season", call)
  for (feed in names(.bleague_feed_names)) {
    base <- paste0(.bleague_s3, "/", .bleague_feed_names[[feed]], "/", key)
    resp <- .bleague_fetch(paste0(base, "/latestid"), call = call)
    if (.bleague_is_miss(resp)) next
    .bleague_status(paste0(base, "/latestid"), resp, call)
    latest <- trimws(.intl_body_text(resp))
    if (!grepl("^[0-9]{1,9}$", latest)) {
      .bleague_fail(paste0(.intl_where(base), "/latestid: not an integer snapshot id"), call)
    }
    url <- paste0(base, "/", latest, ".json")
    resp <- .bleague_fetch(url, call = call)
    .bleague_status(url, resp, call)
    body <- tryCatch(jsonlite::parse_json(.intl_body_text(resp), simplifyVector = FALSE),
                     error = function(e) .bleague_fail(paste0(.intl_where(url), " answered a body that is not JSON"),
                                                       call))
    why <- .bleague_scope_error(body, feed, key, season)
    if (!is.null(why)) .bleague_fail(paste0(.intl_where(url), ": ", why), call)
    return(.bleague_stamp(body, key, feed))
  }
  page <- paste0(.bleague_site, "/game_detail/")
  html <- .bleague_html(page, list(ScheduleKey = key, tab = 4L), call)
  emb <- tryCatch(.bleague_embed_body(html, key), bleague_not_parsed = function(e) {
    msg <- conditionMessage(e)
    if (grepl("no _contexts_s3id", msg, fixed = TRUE)) {
      .bleague_none(paste0("B.LEAGUE game ", key, ": no S3 context and no embedded context on the game page"), call)
    }
    .bleague_fail(paste0(.intl_where(page), ": ", msg), call)
  })
  why <- .bleague_scope_error(emb$body, emb$feed, key, season)
  if (!is.null(why)) .bleague_fail(paste0(.intl_where(page), ": ", why), call)
  .bleague_stamp(emb$body, key, emb$feed)
}

# ------------------------------------------------------------------------------- pages

#' The schedule page record of one game day (sdv-py `_schedule`).
#' @noRd
.bleague_schedule_page <- function(season, tab, month, day, event, call) {
  season <- .bleague_int_arg(season, "season", call)
  tab <- .bleague_int_arg(tab, "tab", call)
  mon <- .bleague_int_arg(month, "month", call)
  day <- .bleague_int_arg(day, "day", call)
  event <- if (!is.null(event)) .bleague_int_arg(event, "event", call) else .bleague_default_event[as.character(tab)]
  if (is.na(event) || !tab %in% 1:3 || mon < 1L || mon > 12L || day < 1L || day > 31L) {
    .bleague_bad("bleague_schedule needs tab 1-3, month 1-12, day 1-31 (and event when tab is not 1-3)", call)
  }
  event <- unname(event)
  year <- season - 1L
  url <- paste0(.bleague_site, "/schedule/")
  html <- .bleague_html(url, list(tab = tab, year = year, event = event, mon = sprintf("%02d", mon),
                                  day = sprintf("%02d", day)), call)
  tryCatch(.bleague_schedule_record(html, tab, year, event, mon, day, call), bleague_not_parsed = function(e) {
    if (isTRUE(e$empty)) .bleague_none(paste0(url, ": ", conditionMessage(e)), call)
    .bleague_fail(paste0(url, ": not the page asked for: ", conditionMessage(e)), call)
  })
}

#' The standings page record of one season and division (sdv-py `_standings`).
#' @noRd
.bleague_standings_page <- function(season, tab, call) {
  season <- .bleague_int_arg(season, "season", call)
  tab <- .bleague_int_arg(tab, "tab", call)
  if (!tab %in% 1:3) .bleague_bad("bleague_standings needs tab 1-3 (B1, B2, B3)", call)
  year <- season - 1L
  url <- paste0(.bleague_site, "/standings/")
  html <- .bleague_html(url, list(year = year, tab = tab), call)
  tryCatch(.bleague_standings_record(html, year, tab), bleague_not_parsed = function(e) {
    .bleague_fail(paste0(url, ": not the page asked for: ", conditionMessage(e)), call)
  })
}

# ----------------------------------------------------------------------------- HTML walk

#' Text of a node (script / style excluded), whitespace collapsed (sdv-py `_Node.text`).
#' @noRd
.bleague_text <- function(node) {
  if (inherits(node, "xml_missing")) return(NA_character_)
  parts <- rvest::html_elements(node, xpath = ".//text()[not(ancestor::script) and not(ancestor::style)]")
  .bleague_strip(gsub("(*UCP)\\s+", " ", paste(rvest::html_text(parts), collapse = ""), perl = TRUE))
}

.bleague_strip <- function(x) gsub("(*UCP)^\\s+|\\s+$", "", x, perl = TRUE)

.bleague_has_class <- function(cls) sprintf("contains(concat(' ', normalize-space(@class), ' '), ' %s ')", cls)

#' Attribute value, or `NA` (also for a missing node).
#' @noRd
.bleague_attr <- function(node, name) {
  if (inherits(node, "xml_missing")) return(NA_character_)
  rvest::html_attr(node, name)
}

.bleague_options <- function(select) {
  if (inherits(select, "xml_missing")) return(list())
  lapply(rvest::html_elements(select, "option"), function(o) {
    list(value = rvest::html_attr(o, "value"), label = .bleague_text(o), selected = !is.na(rvest::html_attr(o, "selected")))
  })
}

.bleague_select <- function(root, name) rvest::html_element(root, xpath = sprintf(".//select[@name='%s']", name))

#' The value of the single selected option of `select[name=...]`, else `NA`.
#' @noRd
.bleague_selected <- function(root, name) {
  opts <- .bleague_options(.bleague_select(root, name))
  sel <- Filter(function(o) o$selected, opts)
  if (length(sel) == 1L) sel[[1]]$value else NA_character_
}

.bleague_selected_label <- function(root, name) {
  sel <- Filter(function(o) o$selected, .bleague_options(.bleague_select(root, name)))
  if (length(sel)) sel[[1]]$label else NA_character_
}

#' `data-tab` of every division tab button marked `is-active` (on the button or its parent).
#' @noRd
.bleague_active_tabs <- function(root) {
  btns <- rvest::html_elements(root, "button.tab-btn")
  out <- character()
  for (b in btns) {
    tab <- rvest::html_attr(b, "data-tab")
    if (is.na(tab)) next
    own <- strsplit(.bleague_or(.bleague_attr(b, "class"), ""), "\\s+")[[1]]
    par <- strsplit(.bleague_or(.bleague_attr(rvest::html_element(b, xpath = ".."), "class"), ""), "\\s+")[[1]]
    if ("is-active" %in% c(own, par)) out <- c(out, tab)
  }
  sort(unique(out))
}

.bleague_or <- function(a, b) if (length(a) != 1L || is.na(a)) b else a
.bleague_title <- c(home = "Home", away = "Away")

#' Refuse unless `got` equals `want` (sdv-py `_check`; sets compare as sorted unique vectors).
#' @noRd
.bleague_check <- function(what, got, want) {
  if (!identical(got, want)) {
    show <- function(x) if (length(x) == 1L && !is.na(x)) paste0("'", x, "'") else paste0("{", paste(x, collapse = ", "), "}")
    .bleague_not_parsed(paste0("out of scope: ", what, " ", show(got), ", asked for ", show(want)))
  }
}

.bleague_more_label <- "\u3082\u3063\u3068\u898b\u308b" # "see more"

#' A 'more' pager: its element id, its `schedule_bN_more()` link, or its label.
#' @noRd
.bleague_paged <- function(root) {
  nodes <- rvest::html_elements(root, xpath = "//*")
  re <- "schedule_b[0-9]_more"
  if (any(grepl(re, rvest::html_attr(nodes, "id")) | grepl(re, rvest::html_attr(nodes, "href")))) return(TRUE)
  ab <- rvest::html_elements(root, xpath = "//a|//button")
  any(vapply(ab, .bleague_text, character(1)) == .bleague_more_label)
}

#' Seasons run September to June: months 7-12 fall in the START year, 1-6 in the next one.
#' @noRd
.bleague_season_date <- function(year, mon, day) {
  as.Date(sprintf("%04d-%02d-%02d", if (mon >= 7L) year else year + 1L, mon, day), format = "%Y-%m-%d")
}

.bleague_round_re <- "^\u7b2c([0-9]+)\u7bc0$" # "dai N setsu" = round N

#' One game day of one competition and division (sdv-py `_schedule_record`). Fails closed.
#' @noRd
.bleague_schedule_record <- function(html, tab, year, event, mon, day, call) {
  root <- rvest::read_html(html)
  .bleague_check("active tab", .bleague_active_tabs(root), as.character(tab))
  .bleague_check("selected year", .bleague_selected(root, "year"), as.character(year))
  .bleague_check("selected event", .bleague_selected(root, "event"), as.character(event))
  .bleague_check("selected month", .bleague_selected(root, "mon"), sprintf("%02d", mon))
  current <- character()
  for (slide in rvest::html_elements(root, "div.is-current")) {
    a <- rvest::html_element(slide, "a")
    month <- rvest::html_element(slide, "span.month")
    dd <- .bleague_attr(a, "data-day")
    if (!inherits(a, "xml_missing") && !is.na(dd) && !inherits(month, "xml_missing")) {
      current <- c(current, paste0("(", sub("/+$", "", .bleague_text(month)), ", ", dd, ")"))
    }
  }
  .bleague_check("current day (month, day)", sort(unique(current)), sprintf("(%02d, %02d)", mon, day))
  if (.bleague_paged(root)) .bleague_not_parsed("list is paged (a 'more' button is present): truncated, refused")
  clubs <- Filter(function(c) !is.na(c$team_id) && nzchar(c$team_id),
                  lapply(.bleague_options(.bleague_select(root, "club")),
                         function(o) list(team_id = o$value, name = o$label)))
  club_names <- vapply(clubs, `[[`, character(1), "name")
  lists <- rvest::html_elements(root, "ul.round-list")
  ids <- vapply(lists, function(u) .bleague_attr(u, "id"), character(1))
  filled <- vapply(lists, function(u) !inherits(rvest::html_element(u, "li.list-item"), "xml_missing"), logical(1))
  want_id <- paste0("schedule-b", tab)
  if (!identical(ids[filled], want_id)) {
    .bleague_not_parsed(paste0("game list ids [", paste(ids, collapse = ", "), "] != ['", want_id, "']"))
  }
  games <- list()
  for (li in rvest::html_elements(lists[[which(ids == want_id)[1]]], "li.list-item")) {
    li_id <- .bleague_attr(li, "id")
    key <- .bleague_i(li_id)
    href <- .bleague_or(.bleague_attr(rvest::html_element(li, "a.data-game"), "href"), "")
    if (is.na(key) || !grepl(paste0("ScheduleKey=", key, "&"), paste0(href, "&"), fixed = TRUE)) {
      .bleague_not_parsed(paste0("game item ", .bleague_show(li_id), " without a matching game_detail link"))
    }
    teams <- list()
    for (side in c("home", "away")) {
      name <- .bleague_text(rvest::html_element(rvest::html_element(li, paste0("span.team.", side)), "span.team-name"))
      if (is.na(name) || !nzchar(name) || !name %in% club_names) {
        .bleague_not_parsed(paste0("game ", key, ": ", side, " team ", .bleague_show(name), " not in the club select"))
      }
      score <- rvest::html_element(li, paste0("span.", side, "-score"))
      teams[[side]] <- list(id = clubs[[max(which(club_names == name))]]$team_id, name = name,
                            score = if (inherits(score, "xml_missing")) NA_integer_ else .bleague_i(.bleague_text(score)))
    }
    arena <- rvest::html_element(li, "div.info-arena")
    spans <- if (inherits(arena, "xml_missing")) character() else
      vapply(rvest::html_elements(arena, "span"), .bleague_text, character(1))
    if (length(spans) < 2L) .bleague_not_parsed(paste0("game ", key, ": info-arena drift"))
    place <- strsplit(spans[[2]], "|", fixed = TRUE)[[1]]
    if (!length(place) || endsWith(spans[[2]], "|")) place <- c(place, "") # Python split keeps a trailing ""
    state <- rvest::html_element(li, "div.info-scorestate")
    rnd <- regmatches(spans[[1]], regexec(.bleague_round_re, spans[[1]], perl = TRUE))[[1]]
    date <- .bleague_season_date(year, mon, day)
    if (is.na(date)) .bleague_bad(paste0("day ", day, " is not a day of month ", mon), call)
    tip <- if (length(spans) > 2L && grepl("^[0-9]{1,2}:[0-9]{2}$", spans[[3]])) spans[[3]] else NA_character_
    games[[length(games) + 1L]] <- list(
      schedule_key = key, date = format(date), round_label = spans[[1]],
      round = if (length(rnd) == 2L) as.integer(rnd[[2]]) else NA_integer_,
      home_team_id = teams$home$id, home_team = teams$home$name, home_score = teams$home$score,
      away_team_id = teams$away$id, away_team = teams$away$name, away_score = teams$away$score,
      prefecture = if (length(place) == 2L) .bleague_strip(place[[1]]) else NA_character_,
      venue = .bleague_strip(place[[length(place)]]), tip_time = tip,
      state = if (inherits(state, "xml_missing")) NA_character_ else .bleague_text(state)
    )
  }
  if (!length(games)) .bleague_not_parsed("schedule day has zero games", empty = TRUE)
  if (length(games) >= .bleague_page_size) {
    .bleague_not_parsed(paste0(length(games), " games: as many as one page of the site's pager, possibly truncated"))
  }
  days <- vapply(rvest::html_elements(root, "a.js_click_data"),
                 function(a) .bleague_i(rvest::html_attr(a, "data-day")), integer(1))
  list(
    tab = tab, year = year, event = event, mon = mon, day = day,
    season_label = .bleague_selected_label(root, "year"),
    event_label = .bleague_selected_label(root, "event"),
    events = lapply(.bleague_options(.bleague_select(root, "event")),
                    function(o) list(event = .bleague_i(o$value), label = o$label)),
    game_days = as.list(sort(unique(days[!is.na(days) & days != 0L]))),
    clubs = clubs, games = games
  )
}

.bleague_standings_header <- c(
  "\u9806\u4f4d", "\u30af\u30e9\u30d6", "\u52dd", "\u8ca0", "\u52dd\u7387", "\u5dee", "\u5f97\u70b9",
  "\u5931\u70b9", "\u5f97\u5931\u70b9\u5dee", "\u30db\u30fc\u30e0\uff08W-L\uff09",
  "\u30a2\u30a6\u30a7\u30fc\uff08W-L\uff09", NA, "\u9023\u52dd/\u9023\u6557", "\u5730\u533a\u512a\u52dd",
  "\u5bfe\u6226\u6210\u7e3e"
)
# names built from \u escapes (a non-ASCII name in source breaks in a C locale); look up with match()
.bleague_last_n <- stats::setNames(c(5L, 10L), c("\u904e\u53bb5\u8a66\u5408", "\u904e\u53bb10\u8a66\u5408"))
.bleague_sections <- stats::setNames(c("East", "Central", "West", "Wild card"),
                                     c("\u6771\u5730\u533a", "\u4e2d\u5730\u533a", "\u897f\u5730\u533a", "\u30ef\u30a4\u30eb\u30c9\u30ab\u30fc\u30c9"))

.bleague_num <- function(s) {
  s <- .bleague_strip(.bleague_or(s, ""))
  if (grepl("^([0-9]*\\.[0-9]+|[0-9]+)$", s)) as.double(s) else NA_real_
}

#' Standings of one season and division (sdv-py `_standings_record`). Fails closed.
#' @noRd
.bleague_standings_record <- function(html, year, tab) {
  root <- rvest::read_html(html)
  .bleague_check("active tab", .bleague_active_tabs(root), as.character(tab))
  .bleague_check("selected year", .bleague_selected(root, paste0("year-b", tab)), as.character(year))
  rows <- list()
  section <- NA_character_
  nodes <- rvest::html_elements(root, xpath = sprintf("//h3[%s] | //table[%s]", .bleague_has_class("box-container"),
                                                      .bleague_has_class("table-standings")))
  n <- length(.bleague_standings_header)
  for (node in nodes) {
    if (rvest::html_name(node) == "h3") {
      section <- .bleague_text(node)
      next
    }
    trs <- rvest::html_elements(node, xpath = ".//tr")
    head <- if (length(trs)) vapply(rvest::html_elements(trs[[1]], xpath = "./td|./th"), .bleague_text, character(1)) else
      character()
    fixed <- !is.na(.bleague_standings_header)
    if (length(head) != n || any(head[fixed] != .bleague_standings_header[fixed]) ||
        !head[[12]] %in% names(.bleague_last_n)) {
      .bleague_not_parsed(paste0("standings header drift: [", paste(head, collapse = ", "), "]"))
    }
    body <- lapply(trs[-1], function(tr) rvest::html_elements(tr, xpath = "./td"))
    if (!length(body)) .bleague_not_parsed(paste0("standings table ", .bleague_show(section), " has zero rows"))
    for (cells in body) {
      if (length(cells) != n) .bleague_not_parsed(paste0("standings row width ", length(cells), " != ", n))
      team <- cells[[2]]
      href <- .bleague_or(.bleague_attr(rvest::html_element(team, "a.team"), "href"), "")
      m <- regmatches(href, regexec("TeamID=([0-9]+)", href))[[1]]
      if (length(m) != 2L) .bleague_not_parsed("standings row without a club_detail TeamID link")
      t <- vapply(cells, .bleague_text, character(1))
      rows[[length(rows) + 1L]] <- list(
        section = section, section_en = if (is.na(section)) NA_character_ else unname(.bleague_sections[match(section, names(.bleague_sections))]),
        rank = .bleague_i(t[[1]]), team_id = m[[2]],
        team = .bleague_text(rvest::html_element(team, "span.sp-dn")),
        team_short = .bleague_text(rvest::html_element(team, "span.pc-tab-dn")),
        wins = .bleague_i(t[[3]]), losses = .bleague_i(t[[4]]), win_pct = .bleague_num(t[[5]]),
        games_behind = .bleague_num(t[[6]]), points_for = .bleague_i(t[[7]]), points_against = .bleague_i(t[[8]]),
        point_diff = .bleague_i(t[[9]]), home_record = t[[10]], away_record = t[[11]],
        last_n = unname(.bleague_last_n[match(head[[12]], names(.bleague_last_n))]), last_n_record = t[[12]], streak = t[[13]],
        division_title = if (t[[14]] %in% c("--", "")) NA_character_ else t[[14]]
      )
    }
    section <- NA_character_
  }
  if (!length(rows)) .bleague_not_parsed("no standings table")
  list(year = year, tab = tab, season_label = .bleague_selected_label(root, paste0("year-b", tab)), rows = rows)
}

# ------------------------------------------------------------------------------- casts

.bleague_scalar <- function(v) !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)

#' A count / key from an integer or an integer string, else `NA` (never via a double).
#' @noRd
.bleague_i <- function(v) {
  if (!.bleague_scalar(v) || is.logical(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+\\s*$", v, perl = TRUE)) return(suppressWarnings(as.integer(v)))
  NA_integer_
}

#' A number from a number or a decimal string, else `NA`.
#' @noRd
.bleague_f <- function(v) {
  if (!.bleague_scalar(v) || is.logical(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("^\\s*[+-]?[0-9]+(?:\\.[0-9]+)?\\s*$", v, perl = TRUE)) return(as.double(v))
  NA_real_
}

#' A stripped non-empty string, else `NA`; integers are stringified, doubles and logicals are not text.
#' @noRd
.bleague_s <- function(v) {
  if (!.bleague_scalar(v) || is.logical(v) || is.double(v)) return(NA_character_)
  x <- .bleague_strip(as.character(v))
  if (nzchar(x)) x else NA_character_
}

#' A flag from a logical or 0 / 1, else `NA`.
#' @noRd
.bleague_b <- function(v) {
  if (!.bleague_scalar(v)) return(NA)
  if (is.logical(v)) return(v)
  if (is.integer(v) && v %in% c(0L, 1L)) return(v == 1L)
  NA
}

#' Epoch seconds (UTC) from the feeds' three date forms: `/Date(ms+0900)/`, epoch seconds
#' as a string (the 2016-17 embed) and `YYYY-MM-DD HH:MM:SS` (already UTC); else `NA`.
#' @noRd
.bleague_dt <- function(v) {
  if (!.bleague_scalar(v) || !is.character(v)) return(NA_real_)
  t <- .bleague_strip(v)
  m <- regmatches(t, regexec("^/Date\\((-?[0-9]+)(?:[+-][0-9]{4})?\\)/$", t, perl = TRUE))[[1]]
  if (length(m) == 2L) return(floor(as.numeric(m[[2]]) / 1000))
  if (grepl("^[0-9]{9,11}$", t)) return(as.numeric(t))
  m <- regmatches(t, regexec("^([0-9]{4}-[0-9]{2}-[0-9]{2})[ T]([0-9]{2}:[0-9]{2}:[0-9]{2})(?:\\.[0-9]+)?$", t,
                             perl = TRUE))[[1]]
  if (length(m) == 3L) {
    return(as.numeric(as.POSIXct(paste(m[[2]], m[[3]]), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")))
  }
  NA_real_
}

#' Seconds in an `mm:ss` clock (`"8:50"` = 530); `"DNP"` and `""` give `NA`.
#' @noRd
.bleague_mmss <- function(v) {
  if (!.bleague_scalar(v) || !is.character(v)) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*([0-9]{1,3}):([0-9]{2})\\s*$", v, perl = TRUE))[[1]]
  if (length(m) == 3L) as.integer(m[[2]]) * 60L + as.integer(m[[3]]) else NA_integer_
}

.bleague_date <- function(v) {
  if (.bleague_scalar(v) && is.character(v) && grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", v)) v else NA_character_
}

.bleague_cast <- function(type, v) {
  switch(type, integer = .bleague_i(v), double = .bleague_f(v), logical = .bleague_b(v), utc = .bleague_dt(v),
         Date = .bleague_date(v), .bleague_s(v))
}

# ------------------------------------------------------------------------------ frames

#' `rows` (named lists of typed scalars) as a `hoopR_data` tibble with exactly `spec`'s columns.
#'
#' `spec`: column -> `"integer"`, `"double"`, `"character"`, `"logical"`, `"Date"` (ISO
#' text) or `"utc"` (epoch seconds -> POSIXct UTC). Zero rows give a zero-row tibble.
#' @noRd
.bleague_frame <- function(rows, spec, what) {
  protos <- list(integer = NA_integer_, double = NA_real_, logical = NA, character = NA_character_,
                 Date = NA_character_, utc = NA_real_)
  cols <- lapply(names(spec), function(col) {
    proto <- protos[[spec[[col]]]]
    x <- vapply(rows, function(r) {
      v <- r[[col]]
      if (is.null(v)) proto else v
    }, proto, USE.NAMES = FALSE)
    switch(spec[[col]],
      Date = as.Date(x, format = "%Y-%m-%d"),
      utc = as.POSIXct(x, origin = "1970-01-01", tz = "UTC"),
      x
    )
  })
  names(cols) <- names(spec)
  host <- if (what %in% c("schedule", "schedule_clubs", "schedule_events", "schedule_days", "standings")) {
    "www.bleague.jp"
  } else {
    "b-league.s3.amazonaws.com"
  }
  make_hoopR_data(dplyr::as_tibble(cols), paste0("B.LEAGUE ", gsub("_", " ", what), " from ", host), Sys.time())
}

#' A wire table: rows of (wire key, column, type).
#' @noRd
.bleague_tbl <- function(...) {
  x <- matrix(c(...), ncol = 3L, byrow = TRUE)
  data.frame(key = x[, 1], col = x[, 2], type = x[, 3], stringsAsFactors = FALSE)
}

.bleague_row <- function(src, tbl) {
  out <- lapply(seq_len(nrow(tbl)), function(i) .bleague_cast(tbl$type[[i]], src[[tbl$key[[i]]]]))
  names(out) <- tbl$col
  out
}

.bleague_spec_of <- function(tbl) stats::setNames(tbl$type, tbl$col)

# ------------------------------------------------------------------------- game context

.bleague_game <- function(raw) {
  g <- if (.bleague_is_obj(raw)) raw$Game else NULL
  if (.bleague_is_obj(g)) g else list()
}

.bleague_req <- function(raw) {
  r <- if (.bleague_is_obj(raw)) raw[["_request"]] else NULL
  if (.bleague_is_obj(r)) r else list()
}

#' `"v1"` / `"v2"`: what the runtime stamped, else inferred (v2 sends team ids as strings, v1 as integers).
#' @noRd
.bleague_feed <- function(raw) {
  f <- .bleague_req(raw)$feed
  if (.bleague_scalar(f) && is.character(f) && f %in% c("v1", "v2")) return(f)
  tid <- .bleague_game(raw)$HomeTeamID
  if (.bleague_scalar(tid) && is.character(tid)) return("v2")
  if (.bleague_scalar(tid) && is.integer(tid)) return("v1")
  NA_character_
}

.bleague_key <- function(raw) {
  g <- .bleague_game(raw)
  if (length(g)) .bleague_i(g$ScheduleKey) else .bleague_i(.bleague_req(raw)$schedule_key)
}

.bleague_season <- function(year) {
  y <- .bleague_i(year)
  if (is.na(y)) NA_integer_ else y + 1L
}

.bleague_side_ids <- function(raw) {
  g <- .bleague_game(raw)
  list(home = .bleague_s(g$HomeTeamID), away = .bleague_s(g$AwayTeamID))
}

#' The columns every game frame starts with.
#' @noRd
.bleague_base <- function(raw) {
  list(schedule_key = .bleague_key(raw), season = .bleague_season(.bleague_game(raw)$Year), feed = .bleague_feed(raw))
}

.bleague_game_text <- c(
  ConventionNameJ = "convention_name_j", ConventionNameE = "convention_name_e",
  ConventionTitleJ = "convention_title_j", ConventionTitleE = "convention_title_e",
  StadiumNameJ = "stadium_name_j", StadiumNameE = "stadium_name_e", Court = "court", Report = "report",
  Weather = "weather", ScheduleClassNameJ = "schedule_class_name_j", ScheduleClassNameE = "schedule_class_name_e",
  ScheduleClassShortNameJ = "schedule_class_short_name_j", ScheduleClassShortNameE = "schedule_class_short_name_e",
  CommissionerNameJ = "commissioner_name_j", CommissionerNameE = "commissioner_name_e",
  RefereeNameJ = "referee_name_j", RefereeNameE = "referee_name_e", SubRefereeNameJ1 = "sub_referee_name_j1",
  SubRefereeNameE1 = "sub_referee_name_e1", SubRefereeNameJ2 = "sub_referee_name_j2",
  SubRefereeNameE2 = "sub_referee_name_e2"
)
.bleague_game_team <- .bleague_tbl(
  "ID", "team_id", "character", "NameJ", "team_name_j", "character", "NameE", "team_name_e", "character",
  "ShortNameJ", "team_short_name_j", "character", "ShortNameE", "team_short_name_e", "character",
  "SubNameJ", "team_sub_name_j", "character", "SubNameE", "team_sub_name_e", "character",
  "Score", "score", "integer", "WinningCount", "winning_count", "integer", "LosingCount", "losing_count", "integer"
)
.bleague_game_tbl <- rbind(
  .bleague_tbl(
    "ScheduleKey", "schedule_key", "integer", "Year", "year", "integer", "Code", "code", "integer",
    "Event", "event", "integer", "ConventionKey", "convention_key", "character",
    "ConventionClass", "convention_class", "integer", "Setu", "round", "integer", "GameNo", "game_no", "integer",
    "ScheduleState", "schedule_state", "integer", "ScheduleConference", "schedule_conference", "integer",
    "InterleagueFlg", "interleague", "logical", "StadiumCD", "stadium_cd", "character",
    "Attendance", "attendance", "integer", "GameDateTime", "game_datetime", "utc",
    "GameStartTime", "game_start_time", "utc", "GameEndTime", "game_end_time", "utc",
    "MaxPeriod", "max_period", "integer", "GameCurrentPeriod", "current_period", "integer",
    "GameRestTime", "rest_time", "integer", "GameEndedFlg", "game_ended", "logical",
    "RecordFixedFlg", "record_fixed", "logical", "BoxscoreExistsFlg", "box_exists", "logical",
    "PlayByPlayExistsFlg", "pbp_exists", "logical", "PictureExistsFlg", "picture_exists", "logical",
    "ReportExistsFlg", "report_exists", "logical", "HomeTeamWinFlg", "home_win", "logical",
    "CommissionerID", "commissioner_id", "character", "RefereeID", "referee_id", "character",
    "SubRefereeID1", "sub_referee_id1", "character", "SubRefereeID2", "sub_referee_id2", "character",
    "Temperature", "temperature", "double", "Humidity", "humidity", "double"
  ),
  data.frame(key = names(.bleague_game_text), col = unname(.bleague_game_text), type = "character",
             stringsAsFactors = FALSE),
  do.call(rbind, lapply(c("home", "away"), function(side) {
    data.frame(key = paste0(.bleague_title[[side]], "Team", .bleague_game_team$key),
               col = paste0(side, "_", .bleague_game_team$col), type = .bleague_game_team$type,
               stringsAsFactors = FALSE)
  })),
  do.call(rbind, lapply(c("home", "away"), function(side) {
    data.frame(key = sprintf("%sTeamScore%02d", .bleague_title[[side]], 1:14), col = paste0(side, "_score_p", 1:14),
               type = "integer", stringsAsFactors = FALSE)
  }))
)

.bleague_specs <- list()
.bleague_specs$game_info <- c(schedule_key = "integer", season = "integer", feed = "character",
                              .bleague_spec_of(.bleague_game_tbl[-1, ]))

.bleague_parse_game_info <- function(raw) {
  g <- .bleague_game(raw)
  if (!length(g)) return(.bleague_frame(list(), .bleague_specs$game_info, "game_info"))
  row <- c(.bleague_row(g, .bleague_game_tbl), list(season = .bleague_season(g$Year), feed = .bleague_feed(raw)))
  row$schedule_key <- .bleague_key(raw)
  .bleague_frame(list(row), .bleague_specs$game_info, "game_info")
}

.bleague_specs$period_scores <- c(schedule_key = "integer", season = "integer", feed = "character", period = "integer",
                                  team_side = "character", team_id = "character", points = "integer")

.bleague_parse_period_scores <- function(raw) {
  g <- .bleague_game(raw)
  if (!length(g)) return(.bleague_frame(list(), .bleague_specs$period_scores, "period_scores"))
  mp <- .bleague_i(g$MaxPeriod)
  last <- max(if (is.na(mp) || mp == 0L) 4L else mp, 4L)
  ids <- .bleague_side_ids(raw)
  base <- .bleague_base(raw)
  rows <- list()
  for (p in seq_len(min(last, 14L))) {
    for (side in c("home", "away")) {
      pts <- .bleague_i(g[[sprintf("%sTeamScore%02d", .bleague_title[[side]], p)]])
      if (!is.na(pts)) {
        rows[[length(rows) + 1L]] <- c(base, list(period = p, team_side = side, team_id = ids[[side]], points = pts))
      }
    }
  }
  .bleague_frame(rows, .bleague_specs$period_scores, "period_scores")
}

# ------------------------------------------------------------------------------ box scores

.bleague_box_stats <- .bleague_tbl(
  "Point", "points", "integer", "PT3M", "fg3_made", "integer", "PT3A", "fg3_attempted", "integer",
  "PT2M", "fg2_made", "integer", "PT2A", "fg2_attempted", "integer", "FTM", "ft_made", "integer",
  "FTA", "ft_attempted", "integer", "FOUL", "fouls", "integer", "FOULON", "fouls_drawn", "integer",
  "RB_OFF", "reb_off", "integer", "RB_DEF", "reb_def", "integer", "RB_TOT", "reb", "integer",
  "TO", "turnovers", "integer", "AS", "assists", "integer", "ST", "steals", "integer", "BS", "blocks", "integer",
  "BSON", "blocks_received", "integer", "PTFB", "ptfb", "integer", "PT2IN", "pt2in", "integer",
  "PT2ND", "pt2nd", "integer", "PTPFT", "ptpft", "integer", "PT2DUNK", "dunks", "integer",
  "EFF", "efficiency", "integer", "PLUSMINUS", "plus_minus", "integer", "AST_TO", "ast_to", "double",
  "EFG", "efg", "double", "TS", "ts", "double", "USG", "usg", "double", "OFFRTG", "off_rtg", "double",
  "DEFRTG", "def_rtg", "double", "NETRTG", "net_rtg", "double", "POSS", "poss", "double"
)
.bleague_box_ident <- .bleague_tbl(
  "Category", "category", "integer", "PeriodCategory", "period_category", "integer",
  "TeamNameJ", "team_name_j", "character", "TeamNameE", "team_name_e", "character",
  "PlayerID", "player_id", "character", "PlayerNo", "player_no", "character",
  "PlayerNameJ", "player_name_j", "character", "PlayerNameE", "player_name_e", "character",
  "PlayTime", "play_time", "character", "PlayingFlg", "on_court", "logical", "No", "display_order", "integer"
)
.bleague_specs$player_box <- c(schedule_key = "integer", season = "integer", feed = "character",
                               team_side = "character", team_id = "character", .bleague_spec_of(.bleague_box_ident),
                               starter = "logical", seconds_played = "integer", .bleague_spec_of(.bleague_box_stats))
.bleague_specs$team_box <- .bleague_specs$player_box

#' sdv-py `StartingFlg in (1, True, "1")` (Python: 1 == True == 1.0).
#' @noRd
.bleague_starting <- function(v) {
  .bleague_scalar(v) && ((is.logical(v) && v) || (is.numeric(v) && v == 1) || identical(v, "1"))
}

.bleague_box_rows <- function(raw, categories) {
  ids <- .bleague_side_ids(raw)
  base <- .bleague_base(raw)
  out <- list()
  for (side in c("home", "away")) {
    name <- paste0(.bleague_title[[side]], "Boxscores")
    for (r in .bleague_dicts(if (.bleague_is_obj(raw)) raw[[name]] else NULL)) {
      cat <- .bleague_i(r$Category)
      if (is.na(cat) || !cat %in% categories) next
      tid <- .bleague_s(r$TeamID)
      row <- c(base, list(team_side = side, team_id = if (is.na(tid)) ids[[side]] else tid),
               .bleague_row(r, .bleague_box_ident), .bleague_row(r, .bleague_box_stats))
      row$starter <- if (cat == 1L) .bleague_starting(r$StartingFlg) else NA
      row$seconds_played <- .bleague_mmss(r$PlayTime)
      out[[length(out) + 1L]] <- row
    }
  }
  out
}

.bleague_parse_player_box <- function(raw) .bleague_frame(.bleague_box_rows(raw, 1L), .bleague_specs$player_box, "player_box")
.bleague_parse_team_box <- function(raw) .bleague_frame(.bleague_box_rows(raw, 2:3), .bleague_specs$team_box, "team_box")

# --------------------------------------------------------------------------- team summary

.bleague_summary_fields <- .bleague_tbl(
  "ID", "team_id", "character", "NameJ", "team_name_j", "character", "NameE", "team_name_e", "character",
  "PTM", "fg_made", "integer", "PTA", "fg_attempted", "integer", "PTR", "fg_pct", "double",
  "PT2M", "fg2_made", "integer", "PT2A", "fg2_attempted", "integer", "PT2R", "fg2_pct", "double",
  "PT3M", "fg3_made", "integer", "PT3A", "fg3_attempted", "integer", "PT3R", "fg3_pct", "double",
  "FTM", "ft_made", "integer", "FTA", "ft_attempted", "integer", "FTR", "ft_pct", "double",
  "RB_OFF", "reb_off", "integer", "RB_DEF", "reb_def", "integer", "RB_TOT", "reb", "integer",
  "AS", "assists", "integer", "TO", "turnovers", "integer", "ST", "steals", "integer", "BS", "blocks", "integer",
  "BSON", "blocks_received", "integer", "FOUL", "fouls", "integer", "FOULON", "fouls_drawn", "integer",
  "PT2IN", "paint_points", "integer", "PTPFT", "points_off_turnover", "integer",
  "PT2ND", "second_chance_points", "integer", "PTFB", "fast_break_points", "integer",
  "MaxDifference", "max_lead", "integer", "LeadLast", "lead_last", "integer",
  "LeadLastHome", "lead_last_home", "integer", "LeadLastAway", "lead_last_away", "integer"
)
.bleague_specs$team_summary <- c(schedule_key = "integer", season = "integer", feed = "character",
                                 period_category = "integer", team_side = "character",
                                 .bleague_spec_of(.bleague_summary_fields), lead_changes = "integer", ties = "integer")

.bleague_parse_team_summary <- function(raw) {
  base <- .bleague_base(raw)
  rows <- list()
  for (r in .bleague_dicts(if (.bleague_is_obj(raw)) raw$Summaries else NULL)) {
    for (side in c("home", "away")) {
      tbl <- .bleague_summary_fields
      tbl$key <- paste0(.bleague_title[[side]], "Team", tbl$key)
      rows[[length(rows) + 1L]] <- c(base, list(period_category = .bleague_i(r$PeriodCategory), team_side = side,
                                                lead_changes = .bleague_i(r$LeadCount), ties = .bleague_i(r$TieCount)),
                                     .bleague_row(r, tbl))
    }
  }
  .bleague_frame(rows, .bleague_specs$team_summary, "team_summary")
}

# ------------------------------------------------------------------------------ code tables

.bleague_actions <- c(
  `1` = "fg3_made", `2` = "fg3_missed", `3` = "fg2_made_outside_paint", `4` = "fg2_made_inside_paint",
  `5` = "fg2_missed_outside_paint", `6` = "fg2_missed_inside_paint", `7` = "ft_made", `8` = "ft_missed",
  `9` = "rebound_def", `10` = "rebound_off", `11` = "block", `12` = "assist", `13` = "turnover", `14` = "steal",
  `15` = "foul_drawn", `16` = "and_one", `17` = "team_turnover", `22` = "foul_personal", `23` = "foul_offensive",
  `24` = "foul_technical", `25` = "foul_unsportsmanlike", `80` = "game_start", `81` = "game_end",
  `82` = "period_start", `83` = "period_end", `84` = "clock_start", `85` = "clock_stop", `86` = "player_in",
  `87` = "player_out", `88` = "timeout", `89` = "substitution"
)
#' Field-goal attempts: code -> shot type, made, inside the paint (`NA` when the code does not say).
#' @noRd
.bleague_shot_actions <- list(
  `1` = list("3pt", TRUE, NA), `2` = list("3pt", FALSE, NA), `3` = list("2pt", TRUE, FALSE),
  `4` = list("2pt", TRUE, TRUE), `5` = list("2pt", FALSE, FALSE), `6` = list("2pt", FALSE, TRUE)
)
.bleague_qualifiers <- c(
  `27` = "jump_shot", `28` = "layup", `29` = "dunk", `30` = "free_throws_awarded_0", `31` = "free_throws_awarded_1",
  `32` = "free_throws_awarded_2", `33` = "free_throws_awarded_3", `34` = "violation_24s", `35` = "fast_break",
  `36` = "points_off_turnover", `37` = "second_chance", `38` = "fast_break_points_off_turnover",
  `39` = "shooting_foul", `40` = "foul_out", `47` = "fast_break_second_chance",
  `48` = "points_off_turnover_second_chance", `90` = "timeout"
)
.bleague_areas <- c(
  `1` = "restricted_area", `2` = "paint", `3` = "baseline_mid_range", `4` = "wing_mid_range",
  `5` = "top_of_key_mid_range", `6` = "wing_mid_range", `7` = "baseline_mid_range", `8` = "corner_3",
  `9` = "wing_3", `10` = "top_3", `11` = "wing_3", `12` = "corner_3", `13` = "deep_3"
)

.bleague_lookup <- function(table, code) {
  if (is.na(code)) return(NA_character_)
  out <- table[as.character(code)]
  if (is.na(out)) NA_character_ else unname(out)
}

#' English slug of an `ActionCD1` code; the team-rebound codes 18 / 19 swap between the feeds.
#' @noRd
.bleague_action_name <- function(code, feed) {
  if (!is.na(code) && code %in% c(18L, 19L)) {
    if (is.na(feed)) return(NA_character_)
    return(if ((code == 18L) == (feed == "v2")) "team_rebound_def" else "team_rebound_off")
  }
  .bleague_lookup(.bleague_actions, code)
}

# ------------------------------------------------------------------------------ play-by-play

.bleague_specs$pbp <- c(
  schedule_key = "integer", season = "integer", feed = "character", period = "integer", event_no = "integer",
  action_code = "integer", action = "character", qualifier_code2 = "integer", qualifier2 = "character",
  qualifier_code3 = "integer", qualifier3 = "character", team_side = "character", team_id = "character",
  team_name_j = "character", player_id = "character", player_no = "character", player_name_j = "character",
  player2_id = "character", player2_no = "character", player2_name_j = "character", rest_time = "character",
  clock_seconds = "integer", score = "character", home_score = "integer", away_score = "integer",
  period_end = "logical", game_end = "logical", x = "double", y = "double", area_code = "integer",
  area = "character", success = "logical", side = "character", play_text = "character", recorded_at = "utc",
  edited_at = "utc", code = "integer"
)

.bleague_pbp_rows <- function(raw) {
  feed <- .bleague_feed(raw)
  base <- .bleague_base(raw)
  lapply(.bleague_dicts(if (.bleague_is_obj(raw)) raw$PlayByPlays else NULL), function(r) {
    a1 <- .bleague_i(r$ActionCD1)
    a2 <- .bleague_i(r$ActionCD2)
    a3 <- .bleague_i(r$ActionCD3)
    area <- .bleague_i(r$AreaCD)
    ha <- .bleague_i(r$HomeAway)
    score <- .bleague_s(r$Score)
    m <- regmatches(.bleague_or(score, ""), regexec("^([0-9]+)-([0-9]+)$", .bleague_or(score, "")))[[1]]
    c(base, list(
      period = .bleague_i(r$Period), event_no = .bleague_i(r$No), action_code = a1,
      action = .bleague_action_name(a1, feed), qualifier_code2 = a2,
      qualifier2 = .bleague_lookup(.bleague_qualifiers, a2), qualifier_code3 = a3,
      qualifier3 = .bleague_lookup(.bleague_qualifiers, a3),
      team_side = if (is.na(ha)) NA_character_ else if (ha == 1L) "home" else if (ha == 2L) "away" else NA_character_,
      team_id = .bleague_s(r$TeamID), team_name_j = .bleague_s(r$TeamNameJ), player_id = .bleague_s(r$PlayerID1),
      player_no = .bleague_s(r$PlayerNo1), player_name_j = .bleague_s(r$PlayerNameJ1),
      player2_id = .bleague_s(r$PlayerID2), player2_no = .bleague_s(r$PlayerNo2),
      player2_name_j = .bleague_s(r$PlayerNameJ2), rest_time = .bleague_s(r$RestTime),
      clock_seconds = .bleague_mmss(r$RestTime), score = score,
      home_score = if (length(m) == 3L) as.integer(m[[2]]) else NA_integer_,
      away_score = if (length(m) == 3L) as.integer(m[[3]]) else NA_integer_,
      period_end = .bleague_b(r$PeriodEndRowFlg), game_end = .bleague_b(r$GameEndRowFlg),
      x = .bleague_f(r$X), y = .bleague_f(r$Y), area_code = area, area = .bleague_lookup(.bleague_areas, area),
      success = .bleague_b(r$Success), side = .bleague_s(r$Side), play_text = .bleague_s(r$PlayText),
      recorded_at = .bleague_dt(r$RecordDateTime), edited_at = .bleague_dt(r$RecordEditDateTime),
      code = .bleague_i(r$Code)
    ))
  })
}

.bleague_parse_pbp <- function(raw) .bleague_frame(.bleague_pbp_rows(raw), .bleague_specs$pbp, "pbp")

.bleague_specs$shots <- c(
  schedule_key = "integer", season = "integer", feed = "character", period = "integer", event_no = "integer",
  team_side = "character", team_id = "character", player_id = "character", player_no = "character",
  player_name_j = "character", shot_type = "character", in_paint = "logical", made = "logical",
  qualifier2 = "character", qualifier3 = "character", x = "double", y = "double", area_code = "integer",
  area = "character", side = "character", rest_time = "character", clock_seconds = "integer", score = "character"
)

.bleague_parse_shots <- function(raw) {
  rows <- list()
  for (r in .bleague_pbp_rows(raw)) {
    info <- if (is.na(r$action_code)) NULL else .bleague_shot_actions[[as.character(r$action_code)]]
    if (is.null(info) || is.na(r$x) || is.na(r$y)) next
    r$shot_type <- info[[1]]
    r$made <- info[[2]]
    r$in_paint <- info[[3]]
    rows[[length(rows) + 1L]] <- r
  }
  .bleague_frame(rows, .bleague_specs$shots, "shots")
}

# ------------------------------------------------------------------- v1 leaders, score track

.bleague_leader_categories <- c(`1` = "points", `2` = "assists", `3` = "steals", `4` = "blocks", `5` = "rebounds",
                                `8` = "blocks_received")
.bleague_specs$leaders <- c(
  schedule_key = "integer", season = "integer", feed = "character", period_category = "integer",
  category = "integer", category_name = "character", rank = "integer", tie_order = "integer",
  team_side = "character", team_id = "character", team_name_j = "character", player_id = "character",
  player_no = "character", player_name_j = "character", count = "integer", reb_off_count = "integer",
  reb_def_count = "integer"
)

.bleague_parse_leaders <- function(raw) {
  ids <- .bleague_side_ids(raw)
  base <- .bleague_base(raw)
  rows <- lapply(.bleague_dicts(if (.bleague_is_obj(raw)) raw$Leaders else NULL), function(r) {
    cat <- .bleague_i(r$Category)
    tid <- .bleague_s(r$TeamID)
    side <- if (is.na(tid)) NA_character_ else if (identical(tid, ids$away)) "away" else
      if (identical(tid, ids$home)) "home" else NA_character_
    c(base, list(
      period_category = .bleague_i(r$PeriodCategory), category = cat,
      category_name = .bleague_lookup(.bleague_leader_categories, cat), rank = .bleague_i(r$Ranking),
      tie_order = .bleague_i(r$No), team_side = side, team_id = tid, team_name_j = .bleague_s(r$TeamNameJ),
      player_id = .bleague_s(r$PlayerID), player_no = .bleague_s(r$PlayerNo),
      player_name_j = .bleague_s(r$PlayerNameJ), count = .bleague_i(r$Count),
      reb_off_count = .bleague_i(r$RB_OFFCount), reb_def_count = .bleague_i(r$RB_DEFCount)
    ))
  })
  .bleague_frame(rows, .bleague_specs$leaders, "leaders")
}

.bleague_specs$score_track <- c(schedule_key = "integer", season = "integer", feed = "character", period = "integer",
                                event_index = "integer", home_points = "integer", away_points = "integer")

.bleague_parse_score_track <- function(raw) {
  base <- .bleague_base(raw)
  rows <- lapply(.bleague_dicts(if (.bleague_is_obj(raw)) raw$Points else NULL), function(r) {
    c(base, list(period = .bleague_i(r$Period), event_index = .bleague_i(r$Time),
                 home_points = .bleague_i(r$HomePointsTotal), away_points = .bleague_i(r$AwayPointsTotal)))
  })
  .bleague_frame(rows, .bleague_specs$score_track, "score_track")
}

# ------------------------------------------------------------------- the page records as frames

.bleague_rec <- function(raw) if (.bleague_is_obj(raw)) raw else list()

.bleague_page_base <- function(rec) {
  list(season = .bleague_season(rec$year), tab = .bleague_i(rec$tab), event = .bleague_i(rec$event))
}

.bleague_specs$schedule <- c(
  season = "integer", tab = "integer", event = "integer", schedule_key = "integer", date = "Date",
  round_label = "character", round = "integer", home_team_id = "character", home_team = "character",
  home_score = "integer", away_team_id = "character", away_team = "character", away_score = "integer",
  prefecture = "character", venue = "character", tip_time = "character", state = "character"
)

.bleague_parse_schedule <- function(raw) {
  rec <- .bleague_rec(raw)
  base <- .bleague_page_base(rec)
  spec <- .bleague_specs$schedule
  fields <- setdiff(names(spec), names(base))
  rows <- lapply(.bleague_dicts(rec$games), function(g) {
    c(base, stats::setNames(lapply(fields, function(k) .bleague_cast(spec[[k]], g[[k]])), fields))
  })
  .bleague_frame(rows, spec, "schedule")
}

.bleague_specs$schedule_clubs <- c(season = "integer", tab = "integer", event = "integer", team_id = "character",
                                   name = "character")

.bleague_parse_schedule_clubs <- function(raw) {
  rec <- .bleague_rec(raw)
  base <- .bleague_page_base(rec)
  rows <- lapply(.bleague_dicts(rec$clubs), function(c) c(base, list(team_id = .bleague_s(c$team_id),
                                                                         name = .bleague_s(c$name))))
  .bleague_frame(rows, .bleague_specs$schedule_clubs, "schedule_clubs")
}

.bleague_specs$schedule_events <- c(season = "integer", tab = "integer", event_id = "integer", label = "character",
                                    selected = "logical")

.bleague_parse_schedule_events <- function(raw) {
  rec <- .bleague_rec(raw)
  base <- .bleague_page_base(rec)
  rows <- lapply(.bleague_dicts(rec$events), function(e) {
    ev <- .bleague_i(e$event)
    list(season = base$season, tab = base$tab, event_id = ev, label = .bleague_s(e$label),
         selected = if (is.na(ev)) NA else isTRUE(ev == base$event))
  })
  .bleague_frame(rows, .bleague_specs$schedule_events, "schedule_events")
}

.bleague_specs$schedule_days <- c(season = "integer", tab = "integer", event = "integer", date = "Date")

.bleague_parse_schedule_days <- function(raw) {
  rec <- .bleague_rec(raw)
  base <- .bleague_page_base(rec)
  year <- .bleague_i(rec$year)
  mon <- .bleague_i(rec$mon)
  rows <- list()
  days <- if (is.list(rec$game_days)) rec$game_days else list()
  for (d in days) {
    day <- .bleague_i(d)
    if (is.na(year) || is.na(mon) || is.na(day) || mon < 1L || mon > 12L) next
    date <- .bleague_season_date(year, mon, day)
    if (!is.na(date)) rows[[length(rows) + 1L]] <- c(base, list(date = format(date)))
  }
  .bleague_frame(rows, .bleague_specs$schedule_days, "schedule_days")
}

.bleague_specs$standings <- c(
  season = "integer", tab = "integer", season_label = "character", section = "character", section_en = "character",
  rank = "integer", team_id = "character", team = "character", team_short = "character", wins = "integer",
  losses = "integer", win_pct = "double", games_behind = "double", points_for = "integer",
  points_against = "integer", point_diff = "integer", home_record = "character", away_record = "character",
  last_n = "integer", last_n_record = "character", streak = "character", division_title = "character"
)

.bleague_parse_standings <- function(raw) {
  rec <- .bleague_rec(raw)
  base <- list(season = .bleague_season(rec$year), tab = .bleague_i(rec$tab), season_label = .bleague_s(rec$season_label))
  spec <- .bleague_specs$standings
  fields <- setdiff(names(spec), names(base))
  rows <- lapply(.bleague_dicts(rec$rows), function(r) {
    c(base, stats::setNames(lapply(fields, function(k) .bleague_cast(spec[[k]], r[[k]])), fields))
  })
  .bleague_frame(rows, spec, "standings")
}
