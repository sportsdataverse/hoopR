# aba_utils.R -- runtime and parsers of the ABA League `aba_*()` family (the
# Adriatic leagues' own PHP sites, www.aba-liga.com and druga.aba-liga.com).
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/aba/ (aba_runtime.py +
# aba_parsers.py, e3d232e): same routes, same refusals, same column specs.
#
# * Season = END year; the site's `sez` is the START year minus 2000, so
#   sez = season - 2001 (2026 -> 25). league "aba" -> lea 1 on www, "aba2" ->
#   lea 2 on druga (one database behind both hosts).
# * Plain GETs through .intl_response() (>= 1 s per host on every attempt; 429 /
#   5xx retried, 500 included: retry_500 = TRUE as in sportsdataverse-py). Only HTTP 200 on
#   one of the two ABA hosts is an answer.
# * Silent wrong answers are refused, fail closed: the match page's hidden echo
#   (match_data_id / _sez / _lea) and every team / player link must carry the
#   request; a calendar / standings / player page's selected season option must
#   be the request; a game must be final (score printed, periods, team totals
#   and play-by-play adding up). The three live-match helpers echo nothing, so
#   the same game's match page is fetched first and the helper is checked
#   against it (minutes 0..40 + 5 per overtime ending on the final score; the
#   shot chart tallied per shooter against the box score).
# * hoopR_no_data: HTTP 404, the /match-not-defined/ redirect, a season the site
#   does not hold, a helper answering blank or [] (before 2017-18), a season
#   before 2001-02. hoopR_bad_request: a bad argument, HTTP 400 / 422.
#   hoopR_asset_fetch: everything else.
#
# HTML is walked with rvest (libxml2). The sportsdataverse-py text rules are kept: a <br>
# is a separator, whitespace (NBSP included) collapses to one space, and the
# "\n" mode splits on <br> and on literal newlines alike.

.ABA_HOSTS <- c(aba = "https://www.aba-liga.com", aba2 = "https://druga.aba-liga.com")
.ABA_LEAGUE_IDS <- c(aba = 1L, aba2 = 2L)
.ABA_LIVE <- "/live-match/rezultati-1718"
.ABA_HELPER_FILES <- c(shots = "create_shooting_chart.php", flow = "create_json.php",
                       scorediff = "create_scoredifference.php")
.ABA_SHOT_PLAYER_SLACK <- 1L
.ABA_SHOT_SUM_ATT_MAX <- 8L
.ABA_SHOT_SUM_MADE_MAX <- 4L
.ABA_SHOT_UNRECORDED_MAX <- 3L
.ABA_WS <- "[\\h\\v]+"

# ---------------------------------------------------------------------------
# Small helpers
# ---------------------------------------------------------------------------

.aba_is_obj <- function(x) is.list(x) && !is.null(names(x))
.aba_is_arr <- function(x) is.list(x) && is.null(names(x))
.aba_objs <- function(x) if (.aba_is_arr(x)) Filter(.aba_is_obj, x) else list()
.aba_str1 <- function(x) is.character(x) && length(x) == 1L && !is.na(x)
.aba_int1 <- function(x) is.numeric(x) && length(x) == 1L && !is.na(x) && x == trunc(x)

# Python's re.sub(r"\s+", " ", s).strip()
.aba_squish <- function(x) trimws(gsub(.ABA_WS, " ", x, perl = TRUE), whitespace = "[\\h\\v]")

# regmatches() of one string: the full match then the groups ("" for an unset group), or NULL
.aba_match <- function(pattern, x) {
  if (!.aba_str1(x)) return(NULL)
  m <- regmatches(x, regexec(pattern, x, perl = TRUE))[[1]]
  if (length(m)) m else NULL
}

# a refusal inside the page walk: sportsdataverse-py aba_parsers._NotParsed (`empty` = no data)
.aba_refuse <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "hoopR_aba_not_parsed", empty = empty)
}
.aba_need <- function(cond, msg) if (!isTRUE(cond)) .aba_refuse(msg)

.aba_int_text <- function(s) {
  s <- trimws(if (.aba_str1(s)) s else "", whitespace = "[\\h\\v]")
  if (grepl("^[+-]?[0-9]+$", s, perl = TRUE)) as.integer(s) else NA_integer_
}

.aba_num_text <- function(s) {
  s <- trimws(if (.aba_str1(s)) s else "", whitespace = "[\\h\\v]")
  if (grepl("^[+-]?[0-9]+(?:\\.[0-9]+)?$", s, perl = TRUE)) as.double(s) else NA_real_
}

# "/team/22/25/1/0/slug/" -> c(22, 25, 1); NULL when absent
.aba_path_ids <- function(href, kind) {
  m <- .aba_match(paste0("/", kind, "/([0-9]+)/([0-9]+)/([0-9]+)(?:/|$)"), href)
  if (is.null(m)) NULL else as.integer(m[2:4])
}

.aba_iso <- function(dmy) {
  m <- .aba_match("^([0-9]{2})\\.([0-9]{2})\\.([0-9]{4})$", trimws(if (.aba_str1(dmy)) dmy else ""))
  if (is.null(m)) return(NA_character_)
  d <- as.Date(sprintf("%s-%s-%s", m[4], m[3], m[2]), format = "%Y-%m-%d", optional = TRUE)
  if (is.na(d) || format(d, "%d.%m.%Y") != paste(m[2], m[3], m[4], sep = ".")) NA_character_ else format(d)
}

.ABA_WHEN <- paste0(
  "^(?:[A-Za-z]+, )?([0-9]{2}\\.[0-9]{2}\\.[0-9]{4})",
  "(?: - (?:[A-Za-z]+, )?([0-9]{2}\\.[0-9]{2}\\.[0-9]{4}))?",
  "(?: ([0-9]{2}:[0-9]{2}) (CET|Local time))?",
  "(?: \\(([0-9]{2}:[0-9]{2}) (.+?) local time\\))?$"
)

# "Monday, 06.10.2025 17:00 CET (19:00 Dubai local time)" -> date / time fields; "TBA" -> all NA
.aba_when <- function(text) {
  text <- .aba_squish(text)
  out <- list(when = text, date = NA_character_, date_to = NA_character_, time = NA_character_,
              time_zone = NA_character_, local_time = NA_character_, local_place = NA_character_)
  if (identical(text, "TBA")) return(out)
  m <- .aba_match(.ABA_WHEN, text)
  .aba_need(!is.null(m), sprintf("unreadable date/time '%s'", text))
  na_if_empty <- function(v) if (nzchar(v)) v else NA_character_
  out$date <- .aba_iso(m[2])
  out$date_to <- if (nzchar(m[3])) .aba_iso(m[3]) else NA_character_
  out$time <- na_if_empty(m[4])
  out$time_zone <- switch(m[5], CET = "CET", "Local time" = "local", NA_character_)
  out$local_time <- na_if_empty(m[6])
  out$local_place <- na_if_empty(m[7])
  .aba_need(!is.na(out$date), sprintf("bad date in '%s'", text))
  out
}

# ---------------------------------------------------------------------------
# DOM (rvest / libxml2), with the sportsdataverse-py _Node semantics
# ---------------------------------------------------------------------------

.aba_xp_class <- function(cls) sprintf("contains(concat(' ', normalize-space(@class), ' '), ' %s ')", cls)

.aba_xpath <- function(tag = NULL, cls = NULL, id = NULL, axis = ".//") {
  preds <- c(if (!is.null(cls)) .aba_xp_class(cls), if (!is.null(id)) sprintf("@id='%s'", id))
  paste0(axis, if (is.null(tag)) "*" else tag, if (length(preds)) paste0("[", paste(preds, collapse = " and "), "]"))
}

# xml2 node queries with an empty namespace map: rvest::html_elements() goes
# through xml2::xml_find_all()'s default `ns = xml_ns(x)`, which walks the
# whole document on every call (18 s for one full 478 KB match page).
.aba_xfind <- function(node, xpath) xml2::xml_find_all(node, xpath, ns = character())

# first descendant matching, or NULL
.aba_find <- function(node, tag = NULL, cls = NULL, id = NULL) {
  if (is.null(node)) return(NULL)
  hit <- xml2::xml_find_first(node, .aba_xpath(tag, cls, id), ns = character())
  if (inherits(hit, "xml_missing")) NULL else hit
}

# every descendant matching, as a list of nodes in document order
.aba_findall <- function(node, tag = NULL, cls = NULL, id = NULL) {
  if (is.null(node)) return(list())
  as.list(.aba_xfind(node, .aba_xpath(tag, cls, id)))
}

# direct element children with one of `tags`
.aba_kids <- function(node, tags) {
  if (is.null(node)) return(list())
  as.list(.aba_xfind(node, paste0("./*[", paste0("self::", tags, collapse = " or "), "]")))
}

.aba_cells <- function(tr) .aba_kids(tr, c("td", "th"))

# direct children, text nodes included (comments dropped, as sportsdataverse-py's builder does)
.aba_children <- function(node) as.list(.aba_xfind(node, "./node()[not(self::comment())]"))
.aba_is_text <- function(n) identical(xml2::xml_type(n), "text")
.aba_raw_text <- function(n) xml2::xml_text(n)
.aba_same_node <- function(a, b) identical(xml2::xml_path(a), xml2::xml_path(b))

.aba_attr <- function(node, name) {
  if (is.null(node)) return(NA_character_)
  rvest::html_attr(node, name)
}
.aba_has_attr <- function(node, name) xml2::xml_has_attr(node, name)

# sportsdataverse-py _Node.text(br): text descendants with each <br> as `br`; " " collapses
# whitespace, "\n" returns the collapsed lines (empty ones kept)
.aba_text <- function(node, br = " ") {
  if (is.null(node)) return(if (br == " ") "" else character())
  parts <- .aba_xfind(node, ".//text() | .//br")
  txt <- xml2::xml_text(parts)
  txt[xml2::xml_type(parts) != "text"] <- br
  out <- paste(txt, collapse = "")
  if (br == " ") return(.aba_squish(out))
  .aba_squish(strsplit(out, br, fixed = TRUE)[[1]])
}

.aba_lines <- function(node) {
  s <- .aba_text(node, br = "\n")
  s[nzchar(s)]
}

# text of a run of children: strings verbatim, elements by .aba_text()
.aba_join <- function(kids) {
  paste(vapply(kids, function(c) if (.aba_is_text(c)) .aba_raw_text(c) else .aba_text(c), ""), collapse = "")
}

.aba_dom <- function(html) rvest::read_html(html, encoding = "UTF-8")

# ---------------------------------------------------------------------------
# Season select
# ---------------------------------------------------------------------------

.aba_season_select <- function(root) {
  sel <- .aba_find(root, "select", id = "season")
  .aba_need(!is.null(sel), "no season select")
  chosen <- NULL
  opts <- list()
  for (o in .aba_findall(sel, "option")) {
    v <- .aba_attr(o, "value")
    if (is.na(v)) v <- ""
    m <- .aba_match("^([0-9]+)/([0-9]+)/$", v)
    if (!is.null(m)) opts[[length(opts) + 1L]] <- list(sez = as.integer(m[2]), lea = as.integer(m[3]), label = .aba_text(o))
    if (.aba_has_attr(o, "selected")) chosen <- v
  }
  list(chosen = chosen, opts = opts)
}

.aba_season_label <- function(chosen, seasons) {
  for (o in seasons) if (identical(sprintf("%d/%d/", o$sez, o$lea), chosen)) return(o$label)
  .aba_refuse("selected season has no option")
}

.aba_scoped_season <- function(root, want, has_games) {
  s <- .aba_season_select(root)
  if (is.null(s$chosen) && !has_games) {
    .aba_refuse(sprintf("the site has no season sez=%d lea=%d", want$sez, want$lea), empty = TRUE)
  }
  ask <- sprintf("%d/%d/", want$sez, want$lea)
  .aba_need(identical(s$chosen, ask),
            sprintf("out of scope: season '%s', asked for sez=%d lea=%d", s$chosen %||% "None", want$sez, want$lea))
  s
}

# ---------------------------------------------------------------------------
# Box score
# ---------------------------------------------------------------------------

# (group label, key, kind) -- kind: i = int, f = number (percent), t = mm:ss text
.ABA_BOX <- data.frame(
  token = c("Min", "overall Pts", "overall %", "FG2 M", "FG2 A", "FG2 %", "FG3 M", "FG3 A", "FG3 %", "FT M",
            "FT A", "FT %", "Rebs D", "Rebs O", "Rebs T", "Ass", "St", "To", "Blck Fv", "Blck Ag", "Foul Cm",
            "Foul Rv", "Points from Paint", "Points from 2ndCh", "Points from FstBr", "+/-", "Val"),
  key = c("minutes", "points", "fg_pct", "fg2_made", "fg2_att", "fg2_pct", "fg3_made", "fg3_att", "fg3_pct",
          "ft_made", "ft_att", "ft_pct", "reb_def", "reb_off", "reb_tot", "assists", "steals", "turnovers",
          "blocks", "blocks_against", "fouls", "fouls_drawn", "pts_paint", "pts_second_chance",
          "pts_fast_break", "plus_minus", "valuation"),
  kind = c("t", "i", "f", "i", "i", "f", "i", "i", "f", "i", "i", "f", "i", "i", "i", "i", "i", "i", "i", "i",
           "i", "i", "i", "i", "i", "i", "i"),
  stringsAsFactors = FALSE
)
.ABA_ADV <- c("Points from Paint", "Points from 2ndCh", "Points from FstBr")
.ABA_STAT_SPEC <- stats::setNames(c(t = "character", i = "integer", f = "double")[.ABA_BOX$kind], .ABA_BOX$key)

# the stat columns after the two lead cells (rows of .ABA_BOX); layout drift is refused
.aba_box_header <- function(table, what) {
  thead <- .aba_find(table, "thead")
  .aba_need(!is.null(thead), paste0(what, ": no thead"))
  rows <- .aba_kids(thead, "tr")
  .aba_need(length(rows) == 2L, sprintf("%s: %d header rows", what, length(rows)))
  spread <- function(tr) {
    unlist(lapply(.aba_cells(tr), function(c) {
      span <- .aba_attr(c, "colspan")
      n <- if (is.na(span) || !nzchar(span)) 1L else suppressWarnings(as.integer(span))
      .aba_need(!is.na(n), paste0(what, ": colspan"))
      rep(.aba_text(c), n)
    }))
  }
  groups <- spread(rows[[1]])
  labels <- spread(rows[[2]])
  .aba_need(length(groups) == length(labels), sprintf("%s: header widths %d != %d", what, length(groups), length(labels)))
  tokens <- trimws(paste(groups[-(1:2)], labels[-(1:2)]), whitespace = "[\\h\\v]")
  ok <- identical(tokens, .ABA_BOX$token) || identical(tokens, setdiff(.ABA_BOX$token, .ABA_ADV))
  .aba_need(ok, sprintf("%s: header drift (%s)", what, paste(tokens, collapse = ", ")))
  .ABA_BOX[.ABA_BOX$token %in% tokens, , drop = FALSE]
}

.aba_stat <- function(cell, kind, what) {
  s <- .aba_text(cell)
  if (kind == "t") {
    .aba_need(grepl("^[0-9]{1,3}:[0-9]{2}$", s, perl = TRUE), sprintf("%s: minutes '%s'", what, s))
    return(s)
  }
  v <- if (kind == "i") .aba_int_text(s) else .aba_num_text(s)
  .aba_need(!is.na(v), sprintf("%s: not a number '%s'", what, s))
  v
}

.aba_box_players <- function(table, side, team_id, want) {
  what <- paste(side, "box")
  cols <- .aba_box_header(table, what)
  tbody <- .aba_find(table, "tbody")
  .aba_need(!is.null(tbody), paste0(what, ": no tbody"))
  out <- list()
  for (tr in .aba_kids(tbody, "tr")) {
    cells <- .aba_cells(tr)
    # a did-not-play row: the minutes cell '00:00' plus one empty cell spanning the other stat columns
    dnp <- length(cells) == 4L && identical(.aba_attr(cells[[4]], "colspan"), as.character(nrow(cols) - 1L)) &&
      !nzchar(.aba_text(cells[[4]]))
    .aba_need(dnp || length(cells) == 2L + nrow(cols),
              sprintf("%s: row width %d != %d", what, length(cells), 2L + nrow(cols)))
    a <- .aba_find(cells[[2]], "a")
    .aba_need(!is.null(a), paste0(what, ": no player link"))
    ids <- .aba_path_ids(.aba_attr(a, "href"), "player")
    .aba_need(!is.null(ids) && identical(ids[2:3], c(want$sez, want$lea)),
              sprintf("%s: player link '%s' outside sez/lea", what, .aba_attr(a, "href")))
    row <- list(side = side, team_id = team_id, jersey = .aba_int_text(.aba_text(cells[[1]])), player_id = ids[1],
                player_name = .aba_text(a), starter = grepl("*", .aba_text(cells[[2]]), fixed = TRUE),
                on_court_at_end = !is.null(.aba_find(cells[[2]], "strong")), played = !dnp)
    for (i in seq_len(nrow(cols))) {
      row[[cols$key[i]]] <- if (!dnp || i == 1L) .aba_stat(cells[[2L + i]], cols$kind[i], what) else NULL
    }
    .aba_need(!dnp || identical(row$minutes, "00:00"),
              sprintf("%s: did-not-play row with minutes '%s'", what, row$minutes))
    out[[length(out) + 1L]] <- row
  }
  .aba_need(length(out) > 0L, paste0(what, ": no player rows"))
  out
}

.aba_box_teams <- function(table, want) {
  cols <- .aba_box_header(table, "team compare")
  body <- .aba_find(table, "tbody")
  trs <- utils::head(.aba_kids(body, "tr"), 2L)
  out <- list()
  for (k in seq_along(trs)) {
    cells <- .aba_cells(trs[[k]])
    .aba_need(length(cells) == 1L + nrow(cols) && identical(.aba_attr(cells[[1]], "colspan"), "2"),
              sprintf("team compare: row %d", length(cells)))
    a <- .aba_find(cells[[1]], "a")
    ids <- .aba_path_ids(.aba_attr(a, "href"), "team")
    .aba_need(!is.null(ids) && identical(ids[2:3], c(want$sez, want$lea)), "team compare: team link outside sez/lea")
    row <- list(side = c("home", "away")[k], team_id = ids[1], team_name = .aba_text(a))
    for (i in seq_len(nrow(cols))) row[[cols$key[i]]] <- .aba_stat(cells[[1L + i]], cols$kind[i], "team compare")
    out[[length(out) + 1L]] <- row
  }
  .aba_need(length(out) == 2L, sprintf("team compare: %d rows", length(out)))
  out
}

# ---------------------------------------------------------------------------
# Play-by-play
# ---------------------------------------------------------------------------

.aba_team_img <- function(cell) {
  img <- .aba_find(cell, "img")
  m <- if (is.null(img)) NULL else .aba_match("/images/club/50x50/([0-9]+)\\.png", .aba_attr(img, "src"))
  if (is.null(m)) NA_integer_ else as.integer(m[2])
}

# "missed 3 points (jump shot)" -> c("missed 3 points", "jump shot"); "(offensive)" -> c(NA, "offensive")
.aba_split_event <- function(text) {
  t <- if (.aba_str1(text)) text else ""
  m <- .aba_match("^(.*?)\\s*\\(([^()]*)\\)$", t)
  if (is.null(m)) return(list(action = if (nzchar(t)) t else NA_character_, qualifier = NA_character_))
  list(action = if (nzchar(m[2])) m[2] else NA_character_, qualifier = m[3])
}

.aba_side_event <- function(cell, side, what) {
  a <- .aba_find(cell, "a")
  pid <- NA_integer_
  name <- NA_character_
  jersey <- NA_integer_
  if (!is.null(a)) {
    ids <- .aba_path_ids(.aba_attr(a, "href"), "player")
    .aba_need(!is.null(ids), sprintf("%s: player link '%s'", what, .aba_attr(a, "href")))
    pid <- ids[1]
    name <- .aba_text(a)
    kids <- .aba_children(cell)
    at <- which(vapply(kids, .aba_same_node, logical(1), b = a))
    .aba_need(length(at) == 1L, paste0(what, ": player link is not a direct child")) # sportsdataverse-py: list.index ValueError
    before <- kids[seq_len(at - 1L)]
    jersey <- .aba_int_text(paste(vapply(Filter(.aba_is_text, before), .aba_raw_text, ""), collapse = ""))
    after <- .aba_join(kids[-seq_len(at)])
    text <- sub("^\\.[\\h\\v]*", "", .aba_squish(after), perl = TRUE)
  } else {
    text <- .aba_text(cell)
  }
  ev <- .aba_split_event(text)
  list(side = side, team_id = .aba_team_img(cell), jersey = jersey, player_id = pid, player_name = name,
       text = text, action = ev$action, qualifier = ev$qualifier)
}

.aba_pbp <- function(root, home_id, away_id) {
  tabs <- .aba_find(root, "div", id = "tabs_for_quaters")
  if (is.null(tabs)) return(list()) # box-only seasons (before 2017-18) have no Play-by-play tab
  out <- list()
  for (pane in .aba_findall(tabs, "div", cls = "tab-pane")) {
    m <- .aba_match("^q([0-9]+)$", .aba_attr(pane, "id"))
    .aba_need(!is.null(m), sprintf("pbp: tab '%s'", .aba_attr(pane, "id")))
    period <- as.integer(m[2])
    what <- paste0("pbp q", period)
    table <- .aba_find(pane, "table", cls = "match_table_play_by_play")
    .aba_need(!is.null(table), paste0(what, ": no desktop table"))
    head_tr <- .aba_find(.aba_find(table, "thead"), "tr")
    head <- if (is.null(head_tr)) character() else vapply(.aba_cells(head_tr), .aba_text, "")
    .aba_need(length(head) == 3L && head[2] == "Minute | Score", sprintf("%s: header %s", what, paste(head, collapse = "|")))
    rows <- list()
    for (tr in .aba_kids(.aba_find(table, "tbody"), "tr")) {
      cells <- .aba_cells(tr)
      .aba_need(length(cells) == 3L, sprintf("%s: row width %d", what, length(cells)))
      mid <- .aba_lines(cells[[2]])
      clock <- mid[grepl("^[0-9]{2}:[0-9]{2}$", mid, perl = TRUE)][1]
      ev <- list(period = period, clock = clock, home_score = NA_integer_, away_score = NA_integer_)
      score <- .aba_find(cells[[2]], "span", cls = "td-rezultat")
      if (!is.null(score)) {
        sm <- .aba_match("^([0-9]+) : ([0-9]+)$", .aba_text(score))
        .aba_need(!is.null(sm), sprintf("%s: score '%s'", what, .aba_text(score)))
        ev$home_score <- as.integer(sm[2])
        ev$away_score <- as.integer(sm[3])
      }
      home_txt <- .aba_text(cells[[1]])
      away_txt <- .aba_text(cells[[3]])
      if (nzchar(home_txt) || nzchar(away_txt)) {
        .aba_need(!(nzchar(home_txt) && nzchar(away_txt)), paste0(what, ": both sides filled"))
        side <- if (nzchar(home_txt)) "home" else "away"
        se <- .aba_side_event(if (side == "home") cells[[1]] else cells[[3]], side, what)
        ev[names(se)] <- se
        .aba_need(is.na(ev$team_id) || ev$team_id == (if (side == "home") home_id else away_id),
                  sprintf("%s: %s badge %s", what, side, ev$team_id))
      } else { # a game / period / timeout marker in the middle column
        label <- mid[(is.na(clock) | mid != clock) & !grepl("^[0-9]+ : [0-9]+$", mid, perl = TRUE)]
        text <- paste(label, collapse = " ")
        tid <- .aba_team_img(cells[[2]])
        mark <- if (is.na(tid)) NA_character_ else if (tid == home_id) "home" else if (tid == away_id) "away" else "?"
        .aba_need(!identical(mark, "?"), sprintf("%s: timeout badge %s", what, tid))
        .aba_need(nzchar(text) || !is.na(clock), paste0(what, ": empty row"))
        ptext <- if (nzchar(text)) text else NA_character_ # a bare-clock row opens some periods
        sp <- if (is.na(ptext)) list(action = NA_character_, qualifier = NA_character_) else .aba_split_event(ptext)
        ev[c("side", "team_id", "jersey", "player_id", "player_name", "text", "action", "qualifier")] <-
          list(mark, tid, NA_integer_, NA_integer_, NA_character_, ptext, sp$action, sp$qualifier)
      }
      rows[[length(rows) + 1L]] <- ev
    }
    out <- c(out, rev(rows)) # newest first on the page -> game order
  }
  for (i in seq_along(out)) out[[i]]$seq <- i
  out
}

# ---------------------------------------------------------------------------
# Page records (sportsdataverse-py aba_parsers.record_for)
# ---------------------------------------------------------------------------

.ABA_ROUND <- "^(.+), Season ([0-9]{4}/[0-9]{2})(?: - (.+))?$"

.aba_hidden <- function(root, ident) {
  n <- .aba_find(root, "input", id = ident)
  if (is.null(n)) NA_character_ else .aba_attr(n, "value")
}

.aba_officials <- function(root) {
  out <- list(commissioner = NA_character_, referees = list())
  for (span in .aba_findall(root, "span", cls = "smallCaps")) {
    label <- trimws(sub(":+$", "", .aba_text(span)), whitespace = "[\\h\\v]")
    kids <- .aba_children(xml2::xml_parent(span))
    at <- which(vapply(kids, .aba_same_node, logical(1), b = span))
    val <- character()
    for (sib in kids[-seq_len(at)]) {
      if (!.aba_is_text(sib) && xml2::xml_name(sib) %in% c("br", "span")) break
      val <- c(val, if (.aba_is_text(sib)) .aba_raw_text(sib) else .aba_text(sib))
    }
    v <- .aba_squish(paste(val, collapse = ""))
    if (label == "Commissioner") {
      out$commissioner <- if (nzchar(v)) v else NA_character_
    } else if (label == "Referees") {
      r <- trimws(strsplit(v, ",", fixed = TRUE)[[1]], whitespace = "[\\h\\v]")
      out$referees <- as.list(r[nzchar(r)])
    } else {
      .aba_refuse(sprintf("unknown official label '%s'", label))
    }
  }
  out
}

.aba_match_record <- function(html, want) {
  root <- .aba_dom(html)
  echo <- list(id = .aba_int_text(.aba_hidden(root, "match_data_id")),
               sez = .aba_int_text(.aba_hidden(root, "match_data_sez")),
               lea = .aba_int_text(.aba_hidden(root, "match_data_lea")))
  for (k in c("id", "sez", "lea")) {
    w <- if (k == "id") want$game_no else want[[k]]
    .aba_need(identical(echo[[k]], w), sprintf("out of scope: match_data_%s=%s, asked for %s", k, echo[[k]], w))
  }
  info <- .aba_find(root, "div", id = "basic_match_info")
  .aba_need(!is.null(info), "no #basic_match_info")
  rn_text <- .aba_text(.aba_find(info, "span", cls = "roundNumber"))
  rm <- .aba_match(.ABA_ROUND, rn_text)
  .aba_need(!is.null(rm), sprintf("round line '%s'", rn_text))
  cut <- regexpr(", (?!.*, )", rm[2], perl = TRUE) # rpartition(", ")
  round_label <- if (cut > 0) substr(rm[2], 1L, cut - 1L) else ""
  competition <- if (cut > 0) substr(rm[2], cut + 2L, nchar(rm[2])) else ""
  .aba_need(nzchar(round_label) && nzchar(competition), sprintf("round line '%s'", rn_text))
  lines <- .aba_lines(.aba_find(info, "div", cls = "dateAndVenue_container"))
  .aba_need(length(lines) > 0L, "no date line")
  game <- list(game_no = echo$id, sez = echo$sez, lea = echo$lea, round = round_label, competition = competition,
               season = rm[3])
  if (nzchar(rm[4])) {
    gm <- .aba_match("(*UCP)^Group (\\w+)$", rm[4])
    .aba_need(!is.null(gm), sprintf("group '%s'", rm[4]))
    game$group <- gm[2]
  }
  game <- c(game, .aba_when(lines[1]))
  game$attendance <- NA_integer_
  for (s in lines[-1]) {
    if (grepl("^[0-9]+$", s, perl = TRUE)) {
      game$attendance <- as.integer(s)
    } else if (startsWith(s, "Venue:")) {
      game$venue <- trimws(substring(s, 7L), whitespace = "[\\h\\v]")
    } else {
      .aba_refuse(sprintf("unknown header line '%s'", s))
    }
  }
  clubs <- .aba_find(root, "div", id = "match_clubs_and_results_info_table")
  .aba_need(!is.null(clubs), "no clubs table")
  teams <- list()
  for (td in .aba_findall(clubs, "td", cls = "hidden-xs")) {
    a <- .aba_find(.aba_find(td, "span", cls = "club"), "a")
    ids <- .aba_path_ids(.aba_attr(a, "href"), "team")
    .aba_need(!is.null(ids) && identical(ids[2:3], c(want$sez, want$lea)), "team link outside sez/lea")
    city <- .aba_find(td, "span", cls = "city")
    teams[[length(teams) + 1L]] <- list(id = ids[1], name = .aba_text(a),
                                        city = if (is.null(city)) NA_character_ else .aba_text(city))
  }
  .aba_need(length(teams) == 2L, sprintf("%d teams in the header", length(teams)))
  sc <- .aba_match("^([0-9]+) : ([0-9]+)$", .aba_text(.aba_find(clubs, "td", cls = "gameScore")))
  .aba_need(!is.null(sc), "no final score: the game is not finished") # an unplayed game shows ' : '
  for (k in 1:2) {
    side <- c("home", "away")[k]
    game[[paste0(side, "_team_id")]] <- teams[[k]]$id
    game[[paste0(side, "_team")]] <- teams[[k]]$name
    game[[paste0(side, "_city")]] <- teams[[k]]$city
    game[[paste0(side, "_score")]] <- as.integer(sc[k + 1L])
  }
  .aba_need(identical(.aba_hidden(root, "match_data_home"), game$home_team) &&
              identical(.aba_hidden(root, "match_data_guest"), game$away_team),
            "match_data_home/guest differ from the header teams")
  game <- c(game, .aba_officials(root))
  q <- .aba_find(root, "table", id = "match_cetrtine_rezultat")
  .aba_need(!is.null(q), "no quarter table")
  qrows <- .aba_kids(q, "tr")
  if (!length(qrows)) qrows <- .aba_kids(.aba_find(q, "tbody"), "tr")
  .aba_need(length(qrows) == 2L, "quarter table shape")
  labels <- vapply(.aba_cells(qrows[[1]]), .aba_text, "")
  scores <- vapply(.aba_cells(qrows[[2]]), .aba_text, "")
  .aba_need(length(labels) == length(scores) && identical(labels[1:4], c("Q1", "Q2", "Q3", "Q4")),
            sprintf("quarter labels %s", paste(labels, collapse = ",")))
  periods <- list()
  for (i in seq_along(labels)) {
    m <- .aba_match("^([0-9]+):\\s*([0-9]+)$", scores[i])
    .aba_need(!is.null(m) && grepl("^(?:Q[1-4]|OT[0-9])$", labels[i], perl = TRUE),
              sprintf("period %s '%s'", labels[i], scores[i]))
    periods[[i]] <- list(period = labels[i], home = as.integer(m[2]), away = as.integer(m[3]))
  }
  .aba_need(sum(vapply(periods, `[[`, 0L, "home")) == game$home_score &&
              sum(vapply(periods, `[[`, 0L, "away")) == game$away_score,
            "period scores do not add up to the final score: the game is not final")
  box <- .aba_find(root, "div", id = "Boxscore")
  .aba_need(!is.null(box), "no #Boxscore")
  ptables <- .aba_findall(box, "table", cls = "match_boxscore_team_table")
  ttable <- .aba_find(box, "table", cls = "match_boxscore_teams_compare_table")
  .aba_need(length(ptables) == 2L && !is.null(ttable), sprintf("%d box tables", length(ptables)))
  head_ids <- unlist(lapply(.aba_findall(box, "h4"), function(h) {
    if (is.null(.aba_find(h, "a", cls = "team"))) return(NULL)
    ids <- .aba_path_ids(.aba_attr(.aba_find(h, "a"), "href"), "team")
    if (is.null(ids)) NA_integer_ else ids[1]
  }))
  .aba_need(identical(head_ids, c(game$home_team_id, game$away_team_id)), "box tables are not home then away")
  players <- c(.aba_box_players(ptables[[1]], "home", game$home_team_id, want),
               .aba_box_players(ptables[[2]], "away", game$away_team_id, want))
  tteams <- .aba_box_teams(ttable, want)
  .aba_need(identical(vapply(tteams, `[[`, 0L, "team_id"), c(game$home_team_id, game$away_team_id)),
            "team compare is not home then away")
  .aba_need(identical(vapply(tteams, `[[`, 0L, "points"), c(game$home_score, game$away_score)),
            "team totals differ from the final score")
  for (flag in c("starter", "on_court_at_end")) { # '*' and bold exist only with play-by-play (2017-18 on)
    if (!any(vapply(players, `[[`, NA, flag))) for (i in seq_along(players)) players[[i]][flag] <- list(NULL)
  }
  pbp <- .aba_pbp(root, game$home_team_id, game$away_team_id)
  if (length(pbp)) {
    .aba_need(any(vapply(pbp, function(e) identical(e$text, "game finished"), logical(1))),
              "play-by-play without 'game finished': not final")
    scored <- Filter(function(e) !is.na(e$home_score), pbp)
    last <- if (length(scored)) scored[[length(scored)]] else NULL
    .aba_need(!is.null(last) && last$home_score == game$home_score && last$away_score == game$away_score,
              "last play-by-play score differs from the final score")
    .aba_need(max(vapply(pbp, `[[`, 0L, "period")) == length(periods), "play-by-play periods differ from the quarters")
  }
  list(game = game, periods = periods, players = players, teams = tteams, pbp = pbp)
}

.ABA_CAL_HEAD <- list(c("Game", "Result", "Date and Time", "Info"), c("Game", "Result", "Date and Time", "Info", "Group"))

# "<a>Home <span>:</span> Away</a>" -> c(home, away); an unset playoff pairing -> c(NA, NA)
.aba_pair <- function(a, what) {
  kids <- .aba_children(a)
  is_span <- vapply(kids, function(k) !.aba_is_text(k) && xml2::xml_name(k) == "span", logical(1))
  .aba_need(sum(is_span) == 1L && .aba_text(kids[[which(is_span)]]) == ":", sprintf("calendar: %s '%s'", what, .aba_text(a)))
  i <- which(is_span)
  side <- function(parts) {
    s <- .aba_squish(.aba_join(parts))
    if (nzchar(s)) s else NA_character_
  }
  c(side(kids[seq_len(i - 1L)]), side(kids[-seq_len(i)]))
}

.aba_calendar_record <- function(html, want) {
  root <- .aba_dom(html)
  games <- list()
  for (panel in .aba_findall(root, "div", cls = "panel")) {
    title <- .aba_find(panel, "h4", cls = "panel-title")
    table <- .aba_find(panel, "table", cls = "league_calendar_table")
    if (is.null(title) || is.null(table)) next
    rnd <- trimws(gsub("[\\x{E000}-\\x{F8FF}]", "", .aba_text(title), perl = TRUE), whitespace = "[\\h\\v]")
    thead <- .aba_find(table, "thead")
    tbody <- .aba_find(table, "tbody")
    .aba_need(!is.null(thead) && !is.null(tbody) && !is.null(.aba_find(thead, "tr")), "calendar: table shape")
    head <- vapply(.aba_cells(.aba_find(thead, "tr")), .aba_text, "")
    .aba_need(any(vapply(.ABA_CAL_HEAD, identical, logical(1), head)), sprintf("calendar header %s", paste(head, collapse = "|")))
    for (tr in .aba_kids(tbody, "tr")) {
      cells <- .aba_cells(tr)
      .aba_need(length(cells) == length(head), sprintf("calendar row width %d", length(cells)))
      a <- .aba_find(.aba_find(cells[[1]], "p", cls = "hidden-xs"), "a")
      m <- if (is.null(a)) NULL else .aba_match("/match/([0-9]+)/([0-9]+)/([0-9]+)/Overview", .aba_attr(a, "href"))
      .aba_need(!is.null(m), "calendar: no match link")
      ids <- as.integer(m[2:4])
      .aba_need(identical(ids[2:3], c(want$sez, want$lea)),
                sprintf("calendar: game link %d/%d outside the season", ids[2], ids[3]))
      names_ <- .aba_pair(a, "teams") # a name can hold ':' ('Igokea m:tel'): split on the <span>:</span>
      sa <- .aba_find(.aba_find(cells[[1]], "p", cls = "visible-xs"), "a")
      .aba_need(!is.null(sa), "calendar: no abbreviations")
      abbr <- .aba_pair(sa, "abbreviations")
      res <- .aba_text(cells[[2]])
      rm <- .aba_match("^([0-9]+) : ([0-9]+)$", res)
      .aba_need(!is.null(rm) || res == "", sprintf("calendar: result '%s'", res))
      g <- list(round = rnd, game_no = ids[1], sez = ids[2], lea = ids[3], home_team = names_[1], away_team = names_[2],
                home_abbr = abbr[1], away_abbr = abbr[2],
                home_score = if (is.null(rm)) NA_integer_ else as.integer(rm[2]),
                away_score = if (is.null(rm)) NA_integer_ else as.integer(rm[3]))
      g <- c(g, .aba_when(.aba_text(cells[[3]])))
      if (length(head) == 5L) {
        grp <- .aba_text(cells[[5]])
        g$group <- if (nzchar(grp)) grp else NA_character_
      }
      games[[length(games) + 1L]] <- g
    }
  }
  s <- .aba_scoped_season(root, want, length(games) > 0L)
  .aba_need(length(games) > 0L, "calendar: no games")
  gnos <- vapply(games, `[[`, 0L, "game_no")
  .aba_need(!anyDuplicated(gnos), "calendar: duplicate game numbers")
  list(season = list(sez = want$sez, lea = want$lea, label = .aba_season_label(s$chosen, s$opts)),
       seasons = s$opts, games = games)
}

.ABA_STAND_HEAD <- c("#", "Club", "GP", "W", "L", "Overall", "Diff", "Points")

.aba_standings_record <- function(html, want) {
  root <- .aba_dom(html)
  main <- .aba_find(root, "section", id = "main_content")
  .aba_need(!is.null(main), "no #main_content")
  rows <- list()
  title <- NA_character_
  stage <- NA_character_
  xp <- sprintf(".//h2[%s] | .//table[%s]", .aba_xp_class("main_title"), .aba_xp_class("league_standings_table"))
  for (n in as.list(.aba_xfind(main, xp))) {
    if (xml2::xml_name(n) == "h2") {
      t <- .aba_text(n)
      if (grepl("(*UCP)^Group \\w+$", t, perl = TRUE)) {
        title <- t
      } else {
        stage <- t
        title <- NA_character_
      }
      next
    }
    thead <- .aba_find(n, "thead")
    tbody <- .aba_find(n, "tbody")
    .aba_need(!is.null(thead) && !is.null(tbody) && !is.null(.aba_find(thead, "tr")), "standings: table shape")
    head <- vapply(.aba_cells(.aba_find(thead, "tr")), .aba_text, "")
    .aba_need(identical(head, .ABA_STAND_HEAD), sprintf("standings header %s", paste(head, collapse = "|")))
    for (tr in .aba_kids(tbody, "tr")) {
      cells <- .aba_cells(tr)
      .aba_need(length(cells) == length(head), sprintf("standings row width %d", length(cells)))
      a <- .aba_find(cells[[2]], "a")
      ids <- .aba_path_ids(.aba_attr(a, "href"), "team")
      .aba_need(!is.null(ids) && identical(ids[2:3], c(want$sez, want$lea)), "standings: team link outside season")
      pm <- .aba_match("^([0-9]+):([0-9]+)$", .aba_text(cells[[6]]))
      .aba_need(!is.null(pm), sprintf("standings: overall '%s'", .aba_text(cells[[6]])))
      r <- list(table = stage, group = title, rank = .aba_int_text(.aba_text(cells[[1]])), team_id = ids[1],
                team_name = .aba_text(a), games = .aba_int_text(.aba_text(cells[[3]])),
                wins = .aba_int_text(.aba_text(cells[[4]])), losses = .aba_int_text(.aba_text(cells[[5]])),
                points_for = as.integer(pm[2]), points_against = as.integer(pm[3]),
                point_diff = .aba_int_text(.aba_text(cells[[7]])),
                standing_points = .aba_int_text(.aba_text(cells[[8]])))
      .aba_need(!anyNA(unlist(r[c("rank", "games", "wins", "losses", "point_diff", "standing_points")])),
                "standings: non-numeric cell")
      rows[[length(rows) + 1L]] <- r
    }
  }
  s <- .aba_scoped_season(root, want, length(rows) > 0L)
  .aba_need(length(rows) > 0L, "standings: no rows")
  for (r in rows) {
    .aba_need(r$games == r$wins + r$losses, sprintf("standings: %s games != wins + losses", r$team_name))
    .aba_need(r$points_for - r$points_against == r$point_diff, sprintf("standings: %s diff != for - against", r$team_name))
  }
  keys <- vapply(rows, function(r) paste(r$table, r$group, sep = "\r"), "")
  for (k in unique(keys)) {
    grp <- rows[keys == k]
    stage_k <- grp[[1]]$table
    if (!is.na(stage_k) && startsWith(stage_k, "Regular Season")) { # a closed round robin
      sum_of <- function(f) sum(vapply(grp, `[[`, 0L, f))
      .aba_need(sum_of("wins") == sum_of("losses") && sum_of("points_for") == sum_of("points_against"),
                sprintf("standings: %s wins/losses or points for/against do not balance (a row is missing)",
                        gsub("\r", " / ", k, fixed = TRUE)))
    }
  }
  list(season = list(sez = want$sez, lea = want$lea, label = .aba_season_label(s$chosen, s$opts)), rows = rows)
}

.ABA_PLAYER_INFO <- c("Club:" = "club", "Position:" = "position", "Height:" = "height_cm",
                      "Date of Birth:" = "birth_date", "Place of Birth:" = "birth_place", "Nationality:" = "nationality")
.ABA_LOG_TOTAL_LABELS <- c("Average", "Total")

.aba_player_record <- function(html, want) {
  root <- .aba_dom(html)
  h1 <- .aba_find(root, "h1", cls = "main_title")
  .aba_need(!is.null(h1) && nzchar(.aba_text(h1)), "no player name")
  sel <- .aba_find(root, "select", id = "season")
  .aba_need(!is.null(sel), "no season select")
  seasons <- list()
  chosen <- NULL
  for (o in .aba_findall(sel, "option")) {
    m <- .aba_match("(*UCP)^([0-9]+)/([0-9]+)/([0-9]+)/[\\w-]+/$", .aba_attr(o, "value"))
    .aba_need(!is.null(m), sprintf("player season option '%s'", .aba_attr(o, "value")))
    ids <- as.integer(m[2:4])
    .aba_need(ids[1] == want$player_id, sprintf("out of scope: season option of player %d", ids[1]))
    seasons[[length(seasons) + 1L]] <- list(sez = ids[2], lea = ids[3], label = .aba_text(o))
    if (.aba_has_attr(o, "selected")) chosen <- ids
  }
  ask <- c(want$player_id, want$sez, want$lea)
  .aba_need(identical(chosen, ask), sprintf("out of scope: selected %s, asked for %s",
                                            paste(chosen %||% "None", collapse = "/"), paste(ask, collapse = "/")))
  info <- .aba_find(root, "table", id = "player_basic_info_table")
  .aba_need(!is.null(info), "no player info table")
  p <- list(player_id = want$player_id, sez = want$sez, lea = want$lea, name = .aba_text(h1), seasons = seasons)
  ibody <- .aba_find(info, "tbody")
  .aba_need(!is.null(ibody), "player info: no tbody")
  for (tr in .aba_kids(ibody, "tr")) {
    cells <- .aba_cells(tr)
    .aba_need(length(cells) == 2L, "player info row width")
    label <- .aba_text(cells[[1]])
    .aba_need(label %in% names(.ABA_PLAYER_INFO), sprintf("unknown player info '%s'", label))
    key <- .ABA_PLAYER_INFO[[label]]
    val <- .aba_text(cells[[2]])
    if (key == "club") {
      a <- .aba_find(cells[[2]], "a")
      ids <- .aba_path_ids(.aba_attr(a, "href"), "team")
      .aba_need(!is.null(ids) && identical(ids[2:3], c(want$sez, want$lea)), "player club link outside sez/lea")
      p$team_id <- ids[1]
      p$club <- .aba_text(a)
    } else if (key == "height_cm") {
      hm <- .aba_match("^([0-9]+) cm$", val)
      p$height_cm <- if (is.null(hm)) NA_integer_ else as.integer(hm[2])
    } else if (key == "birth_date") {
      p$birth_date <- .aba_iso(val)
    } else {
      p[[key]] <- if (nzchar(val)) val else NA_character_
    }
  }
  clubs <- .aba_find(root, "div", id = "players_clubs_container")
  h3 <- .aba_find(clubs, "h3")
  .aba_need(!is.null(clubs) && !is.null(h3), "no Clubs box")
  .aba_need(.aba_same_node(xml2::xml_parent(h3), clubs), "Clubs heading is not a direct child") # list.remove ValueError
  xml2::xml_remove(h3) # the 'Clubs' heading is not a career line
  p$career <- as.list(.aba_lines(clubs))
  table <- .aba_find(root, "table", id = "player_game_stats_table")
  .aba_need(!is.null(table), "no game log")
  cols <- .aba_box_header(table, "game log")
  gbody <- .aba_find(table, "tbody")
  .aba_need(!is.null(gbody), "game log: no tbody")
  games <- list()
  for (tr in .aba_kids(gbody, "tr")) {
    cells <- .aba_cells(tr)
    .aba_need(length(cells) == 2L + nrow(cols), sprintf("game log row width %d", length(cells)))
    a <- .aba_find(cells[[2]], "a")
    m <- if (is.null(a)) NULL else .aba_match("/match/([0-9]+)/([0-9]+)/([0-9]+)/", .aba_attr(a, "href"))
    if (is.null(m)) { # only the season totals / averages row has no game link
      .aba_need(.aba_text(cells[[2]]) %in% .ABA_LOG_TOTAL_LABELS,
                sprintf("game log row without a game link: '%s'", .aba_text(cells[[2]])))
      next
    }
    ids <- as.integer(m[2:4])
    .aba_need(identical(ids[2:3], c(want$sez, want$lea)), "game log: game outside sez/lea")
    g <- list(round_no = .aba_int_text(.aba_text(cells[[1]])), game_no = ids[1], game = .aba_text(a))
    for (i in seq_len(nrow(cols))) g[[cols$key[i]]] <- .aba_stat(cells[[2L + i]], cols$kind[i], "game log")
    games[[length(games) + 1L]] <- g
  }
  .aba_need(length(games) > 0L, "player: empty game log")
  p$games <- games
  p
}

#' The page record of one ABA page, scoped to `want` (sportsdataverse-py `record_for`).
#'
#' Any error inside the walk becomes a `hoopR_aba_not_parsed` refusal.
#' @noRd
.aba_record_for <- function(kind, html, want) {
  fn <- switch(kind, match = .aba_match_record, calendar = .aba_calendar_record,
               standings = .aba_standings_record, player = .aba_player_record)
  tryCatch(fn(html, want), error = function(e) {
    if (inherits(e, "hoopR_aba_not_parsed")) stop(e)
    .aba_refuse(paste0("parser error: ", class(e)[1]))
  })
}

# ---------------------------------------------------------------------------
# Live-match helper checks (sportsdataverse-py helper_scope_error)
# ---------------------------------------------------------------------------

.aba_shot_scope_error <- function(body, match) {
  keys <- character()
  att <- integer()
  made <- integer()
  for (p in match$players) {
    k <- paste(p$side, p$player_id)
    played <- isTRUE(p$played)
    att[k] <- if (played) p$fg2_att + p$fg3_att else 0L
    made[k] <- if (played) p$fg2_made + p$fg3_made else 0L
    if (!k %in% keys) keys <- c(keys, k)
  }
  t_att <- stats::setNames(integer(length(keys)), keys)
  t_made <- t_att
  unrecorded <- 0L
  for (r in body) {
    e <- r$ekipa
    side <- if (identical(e, "1")) "home" else if (identical(e, "2")) "away" else NA_character_
    if (is.na(side)) return(sprintf("shot with ekipa %s", format(e %||% "None")))
    pid <- r$player_id
    us <- r$koordinata_uspeh
    if (!.aba_str1(pid) || !(identical(us, "0") || identical(us, "1"))) {
      return(sprintf("shot with player_id %s, koordinata_uspeh %s", format(pid %||% "None"), format(us %||% "None")))
    }
    if (pid == "0") { # shooter not recorded (player_name ' ')
      unrecorded <- unrecorded + 1L
      next
    }
    pid_n <- .aba_int_text(pid)
    k <- paste(side, pid_n)
    if (is.na(pid_n) || !k %in% keys) return(sprintf("out of scope: shot by player '%s', not in the %s box score", pid, side))
    t_att[k] <- t_att[k] + 1L
    t_made[k] <- t_made[k] + (us == "1")
  }
  if (unrecorded > .ABA_SHOT_UNRECORDED_MAX) {
    return(sprintf("out of scope: %d shots without a recorded shooter (max %d)", unrecorded, .ABA_SHOT_UNRECORDED_MAX))
  }
  d_att <- 0L
  d_made <- 0L
  for (k in keys) {
    if (abs(t_att[[k]] - att[[k]]) > .ABA_SHOT_PLAYER_SLACK || abs(t_made[[k]] - made[[k]]) > .ABA_SHOT_PLAYER_SLACK) {
      return(sprintf("out of scope: player %s has %d shots / %d made on the chart, %d / %d in the box",
                     sub("^\\S+ ", "", k), t_att[[k]], t_made[[k]], att[[k]], made[[k]]))
    }
    d_att <- d_att + abs(t_att[[k]] - att[[k]])
    d_made <- d_made + abs(t_made[[k]] - made[[k]])
  }
  if (d_att > .ABA_SHOT_SUM_ATT_MAX || d_made > .ABA_SHOT_SUM_MADE_MAX) {
    return(sprintf("out of scope: per-player differences add up to %d attempts / %d made against the box score",
                   d_att, d_made))
  }
  NULL
}

#' Why a live-match helper body is not this game's (`NULL` when it is).
#' @noRd
.aba_helper_scope_error <- function(kind, body, match) {
  if (!.aba_is_arr(body) || !all(vapply(body, .aba_is_obj, logical(1)))) {
    return(sprintf("not a list of objects: %s", if (.aba_is_obj(body)) "dict" else class(body)[1]))
  }
  if (kind == "shots") return(.aba_shot_scope_error(body, match))
  g <- match$game
  want_last <- 40L + 5L * (length(match$periods) - 4L)
  minutes <- lapply(body, `[[`, "minuta")
  ok <- length(minutes) == want_last + 1L &&
    all(vapply(seq_along(minutes), function(i) .aba_int1(minutes[[i]]) && !is.logical(minutes[[i]]) &&
                 minutes[[i]] == i - 1L, logical(1)))
  if (!ok) {
    lastm <- if (length(minutes)) format(minutes[[length(minutes)]] %||% "None") else "None"
    return(sprintf("out of scope: minutes 0..%s, the game ran 0..%d", lastm, want_last))
  }
  last <- body[[length(body)]]
  if (!(identical(last$domaci_rez, as.character(g$home_score)) && identical(last$tuji_rez, as.character(g$away_score)))) {
    return(sprintf("out of scope: last minute %s:%s != final %d:%d", format(last$domaci_rez %||% "None"),
                   format(last$tuji_rez %||% "None"), g$home_score, g$away_score))
  }
  NULL
}

# ---------------------------------------------------------------------------
# Season / arguments
# ---------------------------------------------------------------------------

# the site's sez for a season END year (2026 -> 25)
.aba_sez_for_season <- function(season, call = rlang::caller_env()) {
  ok <- (is.numeric(season) && !is.logical(season) && length(season) == 1L && is.finite(season) &&
           season >= 0 && season == trunc(season)) ||
    (is.character(season) && length(season) == 1L && !is.na(season) && grepl("^[0-9]+$", trimws(season)))
  if (!ok) .abort_bad_request("{.arg season} must be an integer END year; got {.val {format(season)}}.", call = call)
  season <- as.integer(trimws(season))
  sez <- season - 2001L
  if (sez < 1L) {
    .abort_no_data("The ABA League's first season is 2001-02 (season = 2002); got season = {season}.", call = call)
  }
  if (sez > 99L) .abort_bad_request("Season {season} does not fit the site's two-digit season key.", call = call)
  sez
}

.aba_int_arg <- function(value, what, call) {
  ok <- (is.numeric(value) && !is.logical(value) && length(value) == 1L && is.finite(value) && value >= 0 &&
           value == trunc(value)) ||
    (is.character(value) && length(value) == 1L && !is.na(value) && grepl("^[0-9]+$", trimws(value)))
  if (!ok) .abort_bad_request("{.arg {what}} must be an integer; got {.val {format(value)}}.", call = call)
  as.integer(trimws(value))
}

.aba_league <- function(league, call) {
  if (!(is.character(league) && length(league) == 1L && !is.na(league) && league %in% names(.ABA_LEAGUE_IDS))) {
    .abort_bad_request("{.arg league} must be one of {.val {names(.ABA_LEAGUE_IDS)}}; got {.val {format(league)}}.",
                       call = call)
  }
  league
}

# ---------------------------------------------------------------------------
# Transport
# ---------------------------------------------------------------------------

# GET; HTTP 200 on one of the two ABA hosts -> list(path = <final path>, text = <body>)
.aba_body <- function(url, query = list(), call) {
  where <- .intl_where(url)
  resp <- .intl_response(url, query = query, retry_500 = TRUE, timeout = 60, call = call)
  .intl_check_status(resp, where = where, call = call)
  status <- httr2::resp_status(resp)
  if (status != 200L) .abort_asset_fetch("{where} answered HTTP {status}, not 200.", status = status, call = call)
  final <- httr2::url_parse(resp$url %||% url)
  hosts <- vapply(.ABA_HOSTS, function(h) httr2::url_parse(h)$hostname, "")
  if (!isTRUE(final$hostname %in% hosts)) {
    off <- final$hostname %||% "an unknown host"
    .abort_asset_fetch("{where}: redirected off the ABA sites to {off}.", call = call)
  }
  list(path = final$path %||% "/", text = .intl_body_text(resp))
}

.aba_page <- function(kind, url, want, final_ok, call) {
  b <- .aba_body(url, call = call)
  where <- .intl_where(url)
  path <- b$path
  if (grepl("match-not-defined", path, fixed = TRUE)) {
    .abort_no_data("{where}: the site has no such game (redirected to {path}).", call = call)
  }
  if (!grepl(final_ok, path, perl = TRUE)) .abort_asset_fetch("{where}: final path {.val {path}} is not the page asked for.", call = call)
  if (!nzchar(trimws(b$text, whitespace = "[\\h\\v]"))) .abort_asset_fetch("{where} answered HTTP 200 with an empty body.", call = call)
  tryCatch(.aba_record_for(kind, b$text, want), hoopR_aba_not_parsed = function(e) {
    msg <- conditionMessage(e)
    if (isTRUE(e$empty)) .abort_no_data("{where}: {msg}", call = call)
    .abort_asset_fetch("{where}: not the page asked for: {msg}", call = call)
  })
}

.aba_match_page <- function(host, game_no, sez, lea, call) {
  .aba_page("match", sprintf("%s/match/%d/%d/%d/Overview", host, game_no, sez, lea),
            list(game_no = game_no, sez = sez, lea = lea),
            sprintf("^/match/%d/%d/%d/Overview/?$", game_no, sez, lea), call)
}

#' Fetch one ABA route and refuse every wrong answer (sportsdataverse-py `aba_runtime._get`).
#'
#' @param short Wrapper short name.
#' @param p Named list of the wrapper arguments.
#' @return The page record, or `list(rows = <helper body>)`, with `_request` stamped.
#' @noRd
.aba_fetch <- function(short, p, call) {
  league <- .aba_league(p$league, call)
  lea <- .ABA_LEAGUE_IDS[[league]]
  host <- .ABA_HOSTS[[league]]
  helper <- switch(short, shots = "shots", score_flow = "flow", score_difference = "scorediff", NULL)
  stamp <- list(league = league, league_id = lea)
  if (!is.null(helper)) {
    game_no <- .aba_int_arg(p$game_no, "game_no", call)
    sez <- .aba_sez_for_season(p$season, call)
    season <- sez + 2001L
    match <- .aba_match_page(host, game_no, sez, lea, call)
    url <- paste0(host, .ABA_LIVE, "/", .ABA_HELPER_FILES[[helper]])
    where <- .intl_where(url)
    text <- .aba_body(url, query = list(id = game_no, sez = sez, lea = lea), call)$text
    if (!nzchar(trimws(text, whitespace = "[\\h\\v]"))) {
      .abort_no_data("{where}: the helper answered a blank body (no data before 2017-18).", call = call)
    }
    body <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) {
      .abort_asset_fetch("{where} answered a body that is not JSON.", call = call)
    })
    if (is.list(body) && !length(body) && is.null(names(body))) {
      .abort_no_data("{where}: the helper answered [] (no data before 2017-18).", call = call)
    }
    why <- .aba_helper_scope_error(helper, body, match)
    if (!is.null(why)) .abort_asset_fetch("{where}: {why}", call = call)
    return(list(rows = body, `_request` = c(stamp, list(kind = helper, game_no = game_no, season = season, sez = sez))))
  }
  kind <- switch(short, calendar = "calendar", standings = "standings", player = , player_games = "player", "match")
  ids <- list(season = .aba_int_arg(p$season, "season", call))
  if (kind == "match") ids$game_no <- .aba_int_arg(p$game_no, "game_no", call)
  if (kind == "player") ids$player_id <- .aba_int_arg(p$player_id, "player_id", call)
  sez <- .aba_sez_for_season(ids$season, call)
  stamp <- c(stamp, list(kind = kind, season = ids$season, sez = sez))
  rec <- switch(kind,
    match = {
      stamp$game_no <- ids$game_no
      .aba_match_page(host, ids$game_no, sez, lea, call)
    },
    player = {
      stamp$player_id <- ids$player_id
      .aba_page("player", sprintf("%s/player/%d/%d/%d/", host, ids$player_id, sez, lea),
                list(player_id = ids$player_id, sez = sez, lea = lea),
                sprintf("(*UCP)^/player/%d/%d/%d/(?:[\\w-]+/)?$", ids$player_id, sez, lea), call)
    },
    .aba_page(kind, sprintf("%s/%s/%d/%d/", host, kind, sez, lea), list(sez = sez, lea = lea),
              sprintf("^/%s/%d/%d/?$", kind, sez, lea), call)
  )
  rec[["_request"]] <- stamp
  rec
}

# ---------------------------------------------------------------------------
# Frames (sportsdataverse-py parse_aba_*)
# ---------------------------------------------------------------------------

.ABA_CTX_SPEC <- c(game_no = "integer", season = "integer", league_id = "integer", league = "character")
.ABA_SEASON_SPEC <- c(season = "integer", league_id = "integer", league = "character")

.ABA_SPECS <- list(
  game = c(.ABA_CTX_SPEC, season_label = "character", round = "character", competition = "character",
           group = "character", when = "character", date = "Date", date_to = "Date", time = "character",
           time_zone = "character", local_time = "character", local_place = "character", attendance = "integer",
           venue = "character", home_team_id = "integer", home_team = "character", home_city = "character",
           home_score = "integer", away_team_id = "integer", away_team = "character", away_city = "character",
           away_score = "integer", commissioner = "character", referees = "character"),
  periods = c(.ABA_CTX_SPEC, period = "character", period_no = "integer", home_points = "integer",
              away_points = "integer"),
  box_players = c(.ABA_CTX_SPEC, side = "character", team_id = "integer", jersey = "integer", player_id = "integer",
                  player_name = "character", starter = "logical", on_court_at_end = "logical", played = "logical",
                  .ABA_STAT_SPEC),
  box_teams = c(.ABA_CTX_SPEC, side = "character", team_id = "integer", team_name = "character", .ABA_STAT_SPEC),
  pbp = c(.ABA_CTX_SPEC, seq = "integer", period = "integer", clock = "character", seconds_left = "integer",
          home_score = "integer", away_score = "integer", side = "character", team_id = "integer",
          jersey = "integer", player_id = "integer", player_name = "character", text = "character",
          action = "character", qualifier = "character"),
  shots = c(.ABA_CTX_SPEC, side = "character", x = "double", y = "double", made = "logical", player_id = "integer",
            player_name = "character"),
  score_flow = c(.ABA_CTX_SPEC, minute = "integer", home_score = "integer", away_score = "integer"),
  calendar = c(game_no = "integer", .ABA_SEASON_SPEC, season_label = "character", round = "character",
               group = "character", home_team = "character", away_team = "character", home_abbr = "character",
               away_abbr = "character", home_score = "integer", away_score = "integer", when = "character",
               date = "Date", date_to = "Date", time = "character", time_zone = "character",
               local_time = "character", local_place = "character"),
  standings = c(.ABA_SEASON_SPEC, season_label = "character", table = "character", group = "character",
                rank = "integer", team_id = "integer", team_name = "character", games = "integer", wins = "integer",
                losses = "integer", points_for = "integer", points_against = "integer", point_diff = "integer",
                standing_points = "integer"),
  player = c(player_id = "integer", .ABA_SEASON_SPEC, name = "character", team_id = "integer", club = "character",
             position = "character", height_cm = "integer", birth_date = "Date", birth_place = "character",
             nationality = "character", career = "character"),
  player_games = c(player_id = "integer", .ABA_SEASON_SPEC, round_no = "integer", game_no = "integer",
                   game = "character", .ABA_STAT_SPEC)
)
.ABA_SPECS$score_difference <- .ABA_SPECS$score_flow

# one JSON-ish value -> a length-1 value of the column type (NA otherwise)
.aba_cast <- function(v, type) {
  one <- !is.null(v) && !is.list(v) && length(v) == 1L && !is.na(v)
  switch(type,
    integer = if (one && .aba_int1(v) && !is.logical(v)) as.integer(v) else NA_integer_,
    double = if (one && is.numeric(v)) as.double(v) else NA_real_,
    character = if (one && is.character(v)) v else NA_character_,
    logical = if (one && is.logical(v)) v else NA,
    Date = if (one && is.character(v) && grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", v) &&
                 !is.na(as.Date(v, format = "%Y-%m-%d", optional = TRUE))) v else NA_character_
  )
}

.ABA_PROTO <- list(integer = NA_integer_, double = NA_real_, character = NA_character_, logical = NA,
                   Date = NA_character_)

# rows as a tibble with exactly the spec's columns and types (zero rows when there are none)
.aba_frame <- function(short, rows) {
  spec <- .ABA_SPECS[[short]]
  cols <- lapply(names(spec), function(col) {
    type <- spec[[col]]
    v <- vapply(rows, function(r) .aba_cast(r[[col]], type), .ABA_PROTO[[type]], USE.NAMES = FALSE)
    if (type == "Date") v <- as.Date(v, format = "%Y-%m-%d")
    v
  })
  names(cols) <- names(spec)
  dplyr::as_tibble(cols)
}

.aba_record <- function(raw, key = NULL) {
  if (!.aba_is_obj(raw)) return(NULL)
  got <- if (is.null(key)) raw else raw[[key]]
  if (.aba_is_obj(got) && length(got)) got else NULL
}

.aba_lists <- function(raw, key) if (.aba_is_obj(raw)) .aba_objs(raw[[key]]) else list()

.aba_strict_int <- function(x) is.integer(x) && length(x) == 1L && !is.na(x)

.aba_ctx_row <- function(sez, lea, ...) {
  sez <- if (.aba_strict_int(sez)) sez else NA_integer_
  lea <- if (.aba_strict_int(lea)) lea else NA_integer_
  c(list(...), list(season = if (is.na(sez)) NA_integer_ else 2001L + sez, league_id = lea,
                    league = if (is.na(lea)) NA_character_ else c("aba", "aba2", NA_character_)[match(lea, 1:2, 3L)]))
}

# {**a, **b}: b's entries win
.aba_merge <- function(a, b) {
  for (k in names(b)) a[k] <- list(b[[k]])
  a
}

.aba_match_ctx <- function(raw) {
  g <- .aba_record(raw, "game") %||% list()
  .aba_ctx_row(g$sez, g$lea, game_no = g$game_no)
}

.aba_joined <- function(v) {
  if (is.list(v) && length(v)) paste(vapply(v, function(x) as.character(x), ""), collapse = "; ") else NA_character_
}

.aba_seconds <- function(v) {
  m <- .aba_match("^[\\h\\v]*([0-9]+):([0-9]{2})[\\h\\v]*$", v)
  if (is.null(m)) NA_integer_ else as.integer(m[2]) * 60L + as.integer(m[3])
}

.aba_float_any <- function(v) {
  if (is.null(v) || is.logical(v) || length(v) != 1L) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v)) .aba_num_text(v) else NA_real_
}

.aba_helper_ctx <- function(raw) {
  req <- if (.aba_is_obj(raw)) raw[["_request"]] else NULL
  if (!.aba_is_obj(req)) req <- list()
  lea <- req$league_id
  list(game_no = req$game_no, season = req$season, league_id = lea,
       league = if (.aba_int1(lea) && lea %in% 1:2) c("aba", "aba2")[lea] else NA_character_)
}

.aba_rows <- function(short, raw) {
  switch(short,
    game = {
      g <- .aba_record(raw, "game")
      if (is.null(g)) return(list())
      list(.aba_merge(.aba_match_ctx(raw), c(
        list(season_label = g$season), g[intersect(names(g), c("round", "competition", "group", "when", "date",
                                                                 "date_to", "time", "time_zone", "local_time",
                                                                 "local_place", "attendance", "venue",
                                                                 "home_team_id", "home_team", "home_city",
                                                                 "home_score", "away_team_id", "away_team",
                                                                 "away_city", "away_score", "commissioner"))],
        list(referees = .aba_joined(g$referees))
      )))
    },
    periods = {
      ctx <- .aba_match_ctx(raw)
      ps <- .aba_lists(raw, "periods")
      lapply(seq_along(ps), function(i) {
        .aba_merge(ctx, list(period = ps[[i]]$period, period_no = i, home_points = ps[[i]]$home,
                             away_points = ps[[i]]$away))
      })
    },
    box_players = lapply(.aba_lists(raw, "players"), function(p) .aba_merge(.aba_match_ctx(raw), p)),
    box_teams = lapply(.aba_lists(raw, "teams"), function(p) .aba_merge(.aba_match_ctx(raw), p)),
    pbp = {
      ctx <- .aba_match_ctx(raw)
      lapply(.aba_lists(raw, "pbp"), function(e) .aba_merge(.aba_merge(ctx, e), list(seconds_left = .aba_seconds(e$clock))))
    },
    shots = {
      ctx <- .aba_helper_ctx(raw)
      lapply(.aba_lists(raw, "rows"), function(r) {
        pid <- if (.aba_str1(r$player_id)) .aba_int_text(r$player_id) else NA_integer_
        name <- if (.aba_str1(r$player_name)) trimws(r$player_name, whitespace = "[\\h\\v]") else ""
        e <- r$ekipa
        u <- r$koordinata_uspeh
        .aba_merge(ctx, list(
          side = if (identical(e, "1")) "home" else if (identical(e, "2")) "away" else NA_character_,
          x = .aba_float_any(r$koordinata_x), y = .aba_float_any(r$koordinata_y),
          made = if (identical(u, "1")) TRUE else if (identical(u, "0")) FALSE else NA,
          player_id = if (is.na(pid) || pid == 0L) NA_integer_ else pid,
          player_name = if (nzchar(name)) name else NA_character_
        ))
      })
    },
    score_flow = ,
    score_difference = {
      ctx <- .aba_helper_ctx(raw)
      cum <- function(v) {
        if (is.numeric(v) && !is.logical(v)) return(if (.aba_int1(v) && is.integer(v)) v else NA_integer_)
        if (.aba_str1(v)) .aba_int_text(v) else NA_integer_
      }
      lapply(.aba_lists(raw, "rows"), function(r) {
        .aba_merge(ctx, list(minute = if (is.integer(r$minuta)) r$minuta else NA_integer_,
                             home_score = cum(r$domaci_rez), away_score = cum(r$tuji_rez)))
      })
    },
    calendar = {
      s <- .aba_record(raw, "season") %||% list()
      lapply(.aba_lists(raw, "games"), function(g) {
        keep <- g[intersect(names(g), c("round", "group", "home_team", "away_team", "home_abbr", "away_abbr",
                                        "home_score", "away_score", "when", "date", "date_to", "time",
                                        "time_zone", "local_time", "local_place"))]
        .aba_merge(.aba_ctx_row(g$sez, g$lea, game_no = g$game_no), c(list(season_label = s$label), keep))
      })
    },
    standings = {
      s <- .aba_record(raw, "season") %||% list()
      ctx <- c(.aba_ctx_row(s$sez, s$lea), list(season_label = s$label))
      lapply(.aba_lists(raw, "rows"), function(r) .aba_merge(ctx, r))
    },
    player = {
      p <- .aba_record(raw)
      if (is.null(p) || !"name" %in% names(p)) return(list())
      keep <- p[intersect(names(p), c("name", "team_id", "club", "position", "height_cm", "birth_place",
                                      "nationality", "birth_date"))]
      list(.aba_merge(.aba_ctx_row(p$sez, p$lea, player_id = p$player_id), c(keep, list(career = .aba_joined(p$career)))))
    },
    player_games = {
      p <- .aba_record(raw) %||% list()
      ctx <- .aba_ctx_row(p$sez, p$lea, player_id = p$player_id)
      lapply(.aba_lists(p, "games"), function(g) .aba_merge(ctx, g))
    }
  )
}

#' Parse a record into the wrapper's tibble (sportsdataverse-py `parse_aba_<short>`).
#'
#' A malformed record is a typed zero-row tibble, never an error.
#' @noRd
.aba_parse <- function(short, raw) {
  rows <- tryCatch(.aba_rows(short, raw), error = function(e) list())
  .aba_frame(short, rows)
}

#' Fetch + parse one wrapper's route: the exported functions' single body.
#' @noRd
.aba_wrap <- function(short, params, type, call = rlang::caller_env()) {
  withr::local_options(list(scipen = 999, stringsAsFactors = FALSE))
  raw <- .aba_fetch(short, params, call)
  make_hoopR_data(.aba_parse(short, raw), type, Sys.time())
}
