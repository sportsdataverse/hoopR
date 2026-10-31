# feb_utils.R -- internal runtime + parsers of the FEB `feb_*()` family.
#
# R mirror of sportsdataverse-py sportsdataverse/basketball/feb/ (feb_runtime.py + feb_parsers.py):
# same routes, refusals, casts and snake_case columns. Two hosts, one provider (the
# Spanish Basketball Federation):
#   API  https://intrafeb.feb.es/LiveStats.API/api/v1   per-game JSON envelopes + /overview
#   SITE https://baloncestoenvivo.feb.es                 calendario.aspx / resultados.aspx (HTML)
#
# * Bearer JWT: every API call needs `Authorization: Bearer <JWT>`. The token is public
#   (the hidden `#contentToken > input` of the site root), held in memory only (renewed a
#   minute before it expires, or once on a 401) and never printed, logged or put in a
#   condition: every FEB message passes through .feb_redact().
# * Season key: the site keys a season by its START year `t`; the public argument is the
#   END year, so `t = season - 1`.
# * Refused (fail closed): an error envelope, a stub or changed envelope (filled blocks),
#   a play-by-play naming another game, an overview game outside its competition, a
#   schedule page for another group / season, any final URL but /{page}/{g}/{t}.
# * HTTP 500 is retried (sportsdataverse-py RETRY_STATUSES holds 500): retry_500 = TRUE.

.feb_site <- "https://baloncestoenvivo.feb.es"
.feb_api <- "https://intrafeb.feb.es/LiveStats.API/api/v1"
.feb_jwt_re <- "eyJ[A-Za-z0-9_-]{5,}\\.[A-Za-z0-9_-]{5,}\\.[A-Za-z0-9_-]{5,}"

#' Every API body is this envelope; each route fills only its own blocks.
#' @noRd
.feb_envelope <- c("HEADER", "SCOREBOARD", "TEAMSTATS", "TICKER", "OVERVIEW", "PLAYBYPLAY",
                   "BANNER", "BOXSCORE", "SHOTCHART", "RANKING")

#' route -> filled blocks and the block the route exists for.
#' @noRd
.feb_routes <- list(
  BoxScore = list(filled = c("HEADER", "TICKER", "BOXSCORE"), main = "BOXSCORE"),
  KeyFacts = list(filled = c("HEADER", "SCOREBOARD", "TEAMSTATS", "TICKER", "PLAYBYPLAY", "BANNER"),
                  main = "PLAYBYPLAY"),
  ShotChart = list(filled = c("HEADER", "TICKER", "SHOTCHART"), main = "SHOTCHART"),
  TeamStats = list(filled = c("HEADER", "TICKER", "TEAMSTATS"), main = "TEAMSTATS"),
  Ranking = list(filled = c("HEADER", "TICKER", "RANKING"), main = "RANKING"),
  overview = list(filled = "OVERVIEW", main = "OVERVIEW")
)
.feb_error_keys <- c("type", "title", "status", "traceId", "detail", "errors", "error", "message")

# bearer cache: value, exp (epoch seconds)
.feb_tok <- new.env(parent = emptyenv())

.feb_redact <- function(x) gsub(.feb_jwt_re, "<redacted-jwt>", x, perl = TRUE)

#' `hoopR_asset_fetch` with a redacted message (`...`: condition fields, e.g. `status`).
#' @noRd
.feb_fail <- function(msg, call, transient = FALSE, ...) {
  msg <- .feb_redact(msg)
  .abort_asset_fetch("{msg}", transient = transient, ..., call = call)
}

# ------------------------------------------------------------------------- transport

#' One throttled, retried request (500 included); a transport failure is re-raised redacted.
#' @noRd
.feb_fetch <- function(url, query = list(), headers = NULL, call = rlang::caller_env()) {
  tryCatch(
    .intl_response(url, query = query, headers = headers, retry_500 = TRUE, timeout = 60, call = call),
    hoopR_asset_fetch = function(e) .feb_fail(conditionMessage(e), call, transient = TRUE)
  )
}

#' sportsdataverse-py feb_runtime._check_status: only 200 passes.
#' @noRd
.feb_check_status <- function(resp, where, call) {
  status <- httr2::resp_status(resp)
  if (status == 200L) return(invisible(resp))
  if (status == 404L) .abort_no_data("{where} answered HTTP 404.", status = status, call = call)
  if (status %in% c(400L, 422L)) {
    .abort_bad_request("{where} rejected the request: HTTP {status}.", status = status, call = call)
  }
  .feb_fail(paste0(where, " answered HTTP ", status, ", not 200."), call,
            transient = status %in% c(408L, 429L) || status >= 500L, status = status)
}

#' A site page: HTTP 200, an HTML content type and a non-empty body.
#' @return `list(resp, text)`.
#' @noRd
.feb_html <- function(url, query = list(), call = rlang::caller_env()) {
  resp <- .feb_fetch(url, query = query, call = call)
  where <- .intl_where(url)
  .feb_check_status(resp, where, call)
  ctype <- httr2::resp_header(resp, "content-type", default = "")
  if (!grepl("html", tolower(ctype), fixed = TRUE)) {
    .feb_fail(paste0(where, " answered a non-HTML body (", if (nzchar(ctype)) ctype else "no content type", ")."), call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .feb_fail(paste0(where, " answered HTTP 200 with an empty body."), call)
  list(resp = resp, text = text)
}

#' The bearer JWT in a site page's `#contentToken > input` and its expiry (sportsdataverse-py `token_from_page`).
#' @return `list(token, exp)`.
#' @noRd
.feb_token_from_page <- function(html, now = as.numeric(Sys.time()), call = rlang::caller_env()) {
  m <- regmatches(html, regexec('<div[^>]*id="contentToken"[^>]*>\\s*<input[^>]*\\bvalue="([^"]+)"', html,
                                perl = TRUE))[[1]]
  if (length(m) < 2L) .feb_fail("the FEB site page carries no #contentToken > input", call)
  tok <- m[[2]]
  if (!grepl(paste0("^", .feb_jwt_re, "$"), tok, perl = TRUE)) .feb_fail("the FEB site token is not a JWT", call)
  claims <- tryCatch(
    jsonlite::parse_json(rawToChar(jsonlite::base64url_dec(strsplit(tok, ".", fixed = TRUE)[[1]][[2]])),
                         simplifyVector = FALSE),
    error = function(e) NULL
  )
  if (!.feb_is_obj(claims)) .feb_fail("the FEB site token has an unreadable payload", call)
  scope <- claims[["scope"]]
  if (!identical(claims[["client_id"]], "baloncestoenvivoapp") ||
      !(is.list(scope) && is.null(names(scope)) && "livestats.api" %in% scope)) {
    .feb_fail("the FEB site token is not a baloncestoenvivoapp livestats.api token", call)
  }
  exp <- claims[["exp"]]
  if (!is.numeric(exp) || length(exp) != 1L || is.na(exp) || exp <= now + 60) {
    .feb_fail("the FEB site token is expired or has no exp", call)
  }
  list(token = tok, exp = as.numeric(exp))
}

#' The cached bearer token, fetched from the site root when absent, near expiry or `renew`.
#' @noRd
.feb_bearer <- function(renew = FALSE, call = rlang::caller_env()) {
  if (renew || is.null(.feb_tok$value) || (.feb_tok$exp %||% 0) <= as.numeric(Sys.time()) + 60) {
    page <- .feb_html(paste0(.feb_site, "/"), call = call)
    tk <- .feb_token_from_page(page$text, call = call)
    .feb_tok$value <- tk$token
    .feb_tok$exp <- tk$exp
  }
  .feb_tok$value
}

#' sportsdataverse-py `_int_arg`: a non-negative whole number or digit string, else `hoopR_bad_request`.
#' @noRd
.feb_int_arg <- function(value, what, call = rlang::caller_env()) {
  ok <- length(value) == 1L && !is.logical(value) && !is.na(value) &&
    ((is.numeric(value) && is.finite(value) && value >= 0 && value == trunc(value)) ||
       (is.character(value) && grepl("^[0-9]+$", trimws(value))))
  if (!ok) .abort_bad_request("{.arg {what}} must be an integer.", call = call)
  as.numeric(value)
}

.feb_num <- function(x) sprintf("%.0f", x)

# ------------------------------------------------------------------------- API routes

.feb_is_obj <- function(x) is.list(x) && !is.null(names(x))
.feb_is_arr <- function(x) is.list(x) && is.null(names(x))
.feb_arr <- function(x) if (.feb_is_arr(x)) x else list()

#' Python truthiness of a JSON scalar.
#' @noRd
.feb_truthy <- function(x) {
  !is.null(x) && length(x) > 0L && !(length(x) == 1L && !is.list(x) &&
    (is.na(x) || isFALSE(x) || identical(x, "") || (is.numeric(x) && x == 0)))
}

#' Refuse everything that is not this route's envelope (sportsdataverse-py `_validate`).
#' @noRd
.feb_validate <- function(route, body, game_id, where, call) {
  spec <- .feb_routes[[route]]
  if (!.feb_is_obj(body)) .feb_fail(paste0(where, ": the body is not an object"), call)
  if (length(body) && all(names(body) %in% .feb_error_keys)) {
    .feb_fail(paste0(where, ": the body is an error envelope"), call)
  }
  if (!setequal(names(body), .feb_envelope)) .feb_fail(paste0(where, ": not the LiveStats envelope (keys differ)"), call)
  got <- .feb_envelope[!vapply(.feb_envelope, function(k) is.null(body[[k]]), logical(1))]
  want <- .feb_envelope[.feb_envelope %in% spec$filled]
  if (!identical(got, want)) {
    .feb_fail(sprintf("%s: filled blocks (%s) are not the route's (%s)", where,
                      paste(got, collapse = ", "), paste(want, collapse = ", ")), call)
  }
  block <- body[[spec$main]]
  if (!.feb_is_obj(block) || !length(block)) .feb_fail(paste0(where, ": the ", spec$main, " block is empty"), call)
  if (route == "overview") {
    comps <- block[["COMPETITIONS"]]
    if (!.feb_is_arr(comps) || !length(comps)) {
      .abort_no_data("{where}: no competitions have games in the window.", call = call)
    }
    for (cmp in comps) {
      games <- if (.feb_is_obj(cmp)) cmp[["GAMES"]] else NULL
      if (!.feb_is_arr(games) ||
          any(vapply(games, function(g) !.feb_is_obj(g) || !identical(g[["CompID"]], cmp[["id"]]), logical(1)))) {
        .feb_fail(paste0(where, ": a game lies outside its competition"), call)
      }
    }
    return(invisible(TRUE))
  }
  teams <- if (.feb_is_obj(body[["HEADER"]])) body[["HEADER"]][["TEAM"]] else NULL
  if (!.feb_is_arr(teams) || length(teams) != 2L ||
      !all(vapply(teams, function(t) .feb_is_obj(t) && .feb_truthy(t[["id"]]), logical(1)))) {
    .feb_fail(paste0(where, ": HEADER without two teams"), call)
  }
  if (route == "KeyFacts") {
    lines <- block[["LINES"]]
    if (!.feb_is_arr(lines) || !length(lines)) .feb_fail(paste0(where, ": PLAYBYPLAY without a LINES list"), call)
    want_id <- sprintf("%012.0f", game_id)
    for (ln in lines) {
      lp <- if (.feb_is_obj(ln)) ln[["logParam1"]] else NULL
      if (!is.character(lp) || length(lp) != 1L) next
      m <- regmatches(lp, regexec("^00000000-0000-000([12])-0000-(\\d{12})$", lp, perl = TRUE))[[1]]
      if (length(m) == 3L && m[[3]] != want_id) {
        .feb_fail(sprintf("%s: out of scope: a play of game %.0f, asked for %.0f", where, as.numeric(m[[3]]), game_id),
                  call)
      }
    }
  }
  invisible(TRUE)
}

#' GET one LiveStats route (one token renewal on a 401) and validate its envelope.
#' @return The parsed envelope (nested lists).
#' @noRd
.feb_api_get <- function(route, game_id = NULL, call = rlang::caller_env()) {
  url <- paste0(.feb_api, "/", route, if (!is.null(game_id)) paste0("/", .feb_num(game_id)))
  where <- .intl_where(url)
  for (renew in c(FALSE, TRUE)) {
    headers <- c(Authorization = paste("Bearer", .feb_bearer(renew, call = call)), Accept = "application/json")
    resp <- .feb_fetch(url, headers = headers, call = call)
    if (httr2::resp_status(resp) != 401L) break
  }
  if (httr2::resp_status(resp) == 401L) {
    .feb_fail(paste0(where, " rejected the bearer token (HTTP 401) after a renewal."), call, status = 401L)
  }
  .feb_check_status(resp, where, call)
  ctype <- tolower(httr2::resp_header(resp, "content-type", default = ""))
  if (!grepl("json", ctype, fixed = TRUE) || grepl("problem+json", ctype, fixed = TRUE)) {
    .feb_fail(paste0(where, " answered ", if (nzchar(ctype)) ctype else "no content type", ", not JSON."), call)
  }
  text <- .intl_body_text(resp)
  if (!nzchar(trimws(text))) .feb_fail(paste0(where, " answered HTTP 200 with an empty body."), call)
  body <- tryCatch(jsonlite::parse_json(text, simplifyVector = FALSE), error = function(e) e)
  if (inherits(body, "error")) .feb_fail(paste0(where, " answered a body that is not JSON."), call)
  .feb_validate(route, body, game_id, where, call)
  body
}

# --------------------------------------------------------------------- schedule pages

#' GET a schedule page for group `g`, season END year `season`, and parse its record.
#' @param kind `"calendar"` or `"results"`.
#' @noRd
.feb_page <- function(kind, group, season, call = rlang::caller_env()) {
  g <- .feb_int_arg(group, "group", call)
  season <- .feb_int_arg(season, "season", call)
  t <- season - 1 # the site keys a season by its START year
  segment <- c(calendar = "calendario", results = "resultados")[[kind]]
  url <- paste0(.feb_site, "/", segment, ".aspx")
  where <- .intl_where(url)
  page <- .feb_html(url, query = list(g = .feb_num(g), t = .feb_num(t)), call = call)
  final <- httr2::url_parse(page$resp$url)
  path <- sub("/+$", "", final$path %||% "")
  want <- paste0("/", segment, "/", .feb_num(g), "/", .feb_num(t))
  if (identical(path, "/error")) {
    gg <- .feb_num(g)
    .abort_no_data("{where}: the site has no group {gg} (redirected to /error).", call = call)
  }
  if (!identical(final$hostname, "baloncestoenvivo.feb.es") || !identical(path, want)) {
    .feb_fail(paste0(where, ": final URL ", .intl_where(page$resp$url), " is not ", want), call)
  }
  rec <- tryCatch(.feb_page_record(kind, page$text, g, t), feb_not_parsed = function(e) e)
  if (inherits(rec, "feb_not_parsed")) {
    msg <- conditionMessage(rec)
    if (isTRUE(rec$empty)) .abort_no_data("{where}: {msg}", call = call)
    .feb_fail(paste0(where, ": not the page asked for: ", msg), call)
  }
  rec
}

.feb_not_parsed <- function(msg, empty = FALSE) {
  rlang::abort(msg, class = "feb_not_parsed", empty = empty)
}

#' Collapsed, stripped text of a node (`<br>` was turned into a space before parsing).
#' @noRd
.feb_text <- function(node) {
  if (inherits(node, "xml_missing") || !length(node)) return("")
  .feb_strip(gsub("(*UCP)\\s+", " ", rvest::html_text(node), perl = TRUE))
}

.feb_strip <- function(x) gsub("(*UCP)^\\s+|\\s+$", "", x, perl = TRUE)

#' Regex groups of a scalar string (`character()` for no match, `NULL` or `NA`).
#' @noRd
.feb_match <- function(x, re) {
  if (!is.character(x) || length(x) != 1L || is.na(x)) return(character())
  regmatches(x, regexec(re, x, perl = TRUE))[[1]]
}

.feb_int_text <- function(s) {
  m <- .feb_match(if (is.character(s)) gsub(".", "", .feb_strip(s), fixed = TRUE), "^[+-]?\\d+$")
  if (length(m)) suppressWarnings(as.integer(m[[1]])) else NA_integer_
}

.feb_qint <- function(href, key) {
  m <- .feb_match(href, paste0("[?&]", key, "=(-?\\d+)"))
  if (length(m) == 2L) suppressWarnings(as.integer(m[[2]])) else NA_integer_
}

#' `dd/mm/yyyy` -> ISO date string, else `NA`.
#' @noRd
.feb_iso <- function(dmy) {
  m <- .feb_match(if (is.character(dmy)) .feb_strip(dmy), "^(\\d{2})/(\\d{2})/(\\d{4})$")
  if (length(m) != 4L) return(NA_character_)
  iso <- paste(m[[4]], m[[3]], m[[2]], sep = "-")
  if (is.na(as.Date(iso, format = "%Y-%m-%d"))) NA_character_ else iso
}

.feb_attr <- function(node, name) {
  if (inherits(node, "xml_missing")) return(NA_character_)
  rvest::html_attr(node, name)
}

.feb_ends <- function(x, suffix) !is.na(x) & endsWith(x, suffix)

#' First node under `root` with tag `tag` whose attribute `attr` ends with `suffix`, or `NULL`.
#' @noRd
.feb_find_end <- function(root, tag, attr, suffix) {
  nodes <- rvest::html_elements(root, tag)
  hit <- which(.feb_ends(rvest::html_attr(nodes, attr), suffix))
  if (length(hit)) nodes[[hit[[1]]]] else NULL
}

.feb_options <- function(select) {
  if (is.null(select)) return(list())
  lapply(rvest::html_elements(select, "option"), function(o) {
    list(value = .feb_int_text(.feb_attr(o, "value")), label = .feb_text(o), selected = !is.na(.feb_attr(o, "selected")))
  })
}

.feb_cells <- function(tr) rvest::html_elements(tr, xpath = "./td|./th")

.feb_rows <- function(table, header, what) {
  trs <- rvest::html_elements(table, xpath = ".//tr")
  if (!length(trs)) .feb_not_parsed(paste0(what, ": no rows"))
  got <- vapply(.feb_cells(trs[[1]]), .feb_text, character(1))
  if (!identical(got, header)) {
    .feb_not_parsed(sprintf("%s: header drift [%s] != [%s]", what, paste(got, collapse = ", "),
                            paste(header, collapse = ", ")))
  }
  lapply(trs[-1], function(tr) {
    cells <- .feb_cells(tr)
    if (length(cells) != length(header)) {
      .feb_not_parsed(sprintf("%s: row width %d != %d", what, length(cells), length(header)))
    }
    cells
  })
}

.feb_link <- function(cell, pattern, key, which = 1L, what) {
  links <- rvest::html_elements(cell, "a")
  links <- links[grepl(pattern, rvest::html_attr(links, "href"), fixed = TRUE)]
  if (length(links) < which) .feb_not_parsed(paste(what, "link missing"))
  a <- links[[which]]
  list(id = .feb_qint(.feb_attr(a, "href"), key), text = .feb_text(a))
}

# named with setNames() (a non-ASCII name in source is lost in a C locale); read with match()
.feb_weekdays <- stats::setNames(
  c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  c("LUNES", "MARTES", "MI\u00c9RCOLES", "JUEVES", "VIERNES", "S\u00c1BADO", "DOMINGO")
)

#' A scheduled calendar cell (`SABADO 17/10/2026 19:30`) -> English weekday, ISO date, time.
#' @noRd
.feb_when <- function(text) {
  m <- regmatches(text, regexec("^(\\S+)\\s+(\\d{2}/\\d{2}/\\d{4})(?:\\s+(\\d{1,2}:\\d{2}))?$", .feb_strip(text),
                                perl = TRUE))[[1]]
  day <- if (length(m)) stringi::stri_trans_toupper(m[[2]]) else ""
  hit <- match(day, names(.feb_weekdays))
  if (!length(m) || is.na(hit)) return(list(weekday = NA_character_, date = NA_character_, time = NA_character_))
  list(weekday = .feb_weekdays[[hit]], date = .feb_iso(m[[3]]), time = if (nzchar(m[[4]])) m[[4]] else NA_character_)
}

.feb_score <- function(text) {
  m <- regmatches(text, regexec("^(\\d+)-(\\d+)$", .feb_strip(text), perl = TRUE))[[1]]
  if (length(m) == 3L) list(home_score = as.integer(m[[2]]), away_score = as.integer(m[[3]]), status = "played")
  else list(home_score = NA_integer_, away_score = NA_integer_, status = "scheduled")
}

#' Page title block + season select, checked against the request (fails closed).
#' @noRd
.feb_header <- function(root, g, t) {
  logo <- .feb_find_end(root, "img", "id", "logoCategoriaImage")
  wrap <- rvest::html_element(root, "div.wrapper-text")
  liga <- if (!inherits(wrap, "xml_missing")) rvest::html_element(wrap, "span.liga")
  temporada <- if (!inherits(wrap, "xml_missing")) rvest::html_element(wrap, "span.temporada")
  seasons <- .feb_options(.feb_find_end(root, "select", "name", "temporadasDropDownList"))
  if (is.null(logo) || is.null(liga) || inherits(liga, "xml_missing") || is.null(temporada) ||
      inherits(temporada, "xml_missing") || !length(seasons)) {
    .feb_not_parsed("page header (logo, liga, temporada, season select) missing")
  }
  src <- .feb_attr(logo, "src")
  lg <- c(.feb_qint(src, "g"), .feb_qint(src, "t"))
  if (anyNA(lg) || any(lg != c(g, t))) {
    .feb_not_parsed(sprintf("out of scope: logo g/t (%s), asked for (%s)", paste(lg, collapse = ", "),
                            paste(.feb_num(c(g, t)), collapse = ", ")))
  }
  selected <- unlist(lapply(Filter(function(o) o$selected, seasons), function(o) o$value))
  label <- .feb_text(temporada)
  if (length(selected) != 1L || is.na(selected) || selected != t || !identical(label, paste0(.feb_num(t), "/", .feb_num(t + 1)))) {
    .feb_not_parsed(sprintf("out of scope: season [%s] / '%s', asked for %s", paste(selected, collapse = ", "), label,
                            .feb_num(t)))
  }
  list(group = as.integer(g), season = as.integer(t + 1), competition = .feb_s(.feb_text(liga)))
}

.feb_game_row <- function(home, away, game) {
  c(list(game_id = game$id, home_team_id = home$id, home_team = .feb_s(home$text), away_team_id = away$id,
         away_team = .feb_s(away$text), result_text = .feb_s(game$text)), .feb_score(game$text))
}

.feb_calendar_record <- function(root, g, t) {
  ctx <- .feb_header(root, g, t)
  page <- .feb_find_end(root, "div", "id", "page-calendario") %||% root
  nodes <- rvest::html_elements(page, xpath = paste0(
    ".//h1[contains(concat(' ', normalize-space(@class), ' '), ' titulo-modulo ')]",
    " | .//table[substring(@id, string-length(@id) - 8) = 'DataGrid3']"
  ))
  games <- list()
  rnd <- NULL
  for (n in nodes) {
    if (rvest::html_name(n) == "h1") {
      txt <- .feb_text(n)
      m <- regmatches(txt, regexec("^Jornada\\s+(\\d+)\\s*(.*)$", txt, perl = TRUE))[[1]]
      if (!length(m)) .feb_not_parsed(sprintf("round header drift: '%s'", txt))
      rnd <- list(round = as.integer(m[[2]]), round_label = .feb_s(txt), round_date = .feb_iso(m[[3]]))
    } else {
      if (is.null(rnd)) .feb_not_parsed("game table before any round header")
      for (cells in .feb_rows(n, c("Local", "Resultado", "Visitante"), "calendar")) {
        home <- .feb_link(cells[[1]], "Equipo.aspx", "i", what = "team")
        away <- .feb_link(cells[[3]], "Equipo.aspx", "i", what = "team")
        game <- .feb_link(cells[[2]], "Partido.aspx", "p", what = "game")
        games[[length(games) + 1L]] <- c(ctx, rnd, .feb_game_row(home, away, game), .feb_when(game$text))
      }
    }
  }
  if (!length(games)) .feb_not_parsed("calendar has zero games", empty = TRUE)
  list(games = games)
}

.feb_round_games <- function(table, ctx, section, title, what) {
  if (is.null(table)) return(list())
  lapply(.feb_rows(table, c("Equipos", "Resultado", "Fecha", "Hora"), what), function(cells) {
    home <- .feb_link(cells[[1]], "Equipo.aspx", "i", 1L, "team")
    away <- .feb_link(cells[[1]], "Equipo.aspx", "i", 2L, "team")
    game <- .feb_link(cells[[2]], "Partido.aspx", "p", what = "game")
    c(ctx, list(section = section, round_title = .feb_s(title)), .feb_game_row(home, away, game),
      list(date = .feb_iso(.feb_text(cells[[3]])), time = .feb_s(.feb_text(cells[[4]]))))
  })
}

.feb_pct_text <- function(s) {
  m <- .feb_match(if (is.character(s)) .feb_strip(s), "^(\\d+(?:,\\d+)?)%$")
  if (length(m) == 2L) as.numeric(sub(",", ".", m[[2]], fixed = TRUE)) else NA_real_
}

.feb_results_record <- function(root, g, t) {
  ctx <- .feb_header(root, g, t)
  inp <- .feb_find_end(root, "input", "id", "CodCategoriaHiddenField")
  comp <- if (is.null(inp)) NA_character_ else .feb_attr(inp, "value")
  if (is.na(comp) || !grepl("^[0-9]+$", comp)) .feb_not_parsed("CodCategoriaHiddenField (CompID) missing")
  ctx$comp_id <- .feb_i(comp)
  titles <- vapply(rvest::html_elements(root, "h1.titulo-modulo"), .feb_text, character(1))
  first <- function(prefix) {
    hit <- titles[startsWith(titles, prefix)]
    if (length(hit)) hit[[1]] else NA_character_
  }
  results <- .feb_round_games(.feb_find_end(root, "table", "id", "_jornadaDataGrid"), ctx, "results",
                              first("Resultados"), "results")
  next_round <- .feb_round_games(.feb_find_end(root, "table", "id", "_proximaJornadaDataGrid"), ctx, "next_round",
                                 first("Pr\u00f3xima"), "next round")
  standings <- list()
  st <- .feb_find_end(root, "table", "id", "_clasificacionDataGrid")
  if (!is.null(st)) {
    for (c in .feb_rows(st, c("Po", "Equipo", "PJ", "PG", "PP", "PF", "PC", "DIF", "%", "R"), "standings")) {
      tm <- .feb_link(c[[2]], "Equipo.aspx", "i", what = "team")
      tx <- vapply(c, .feb_text, character(1))
      standings[[length(standings) + 1L]] <- c(ctx, list(
        table = "live", position = .feb_int_text(tx[[1]]), team_id = tm$id, team = .feb_s(tm$text),
        played = .feb_int_text(tx[[3]]), won = .feb_int_text(tx[[4]]), lost = .feb_int_text(tx[[5]]),
        points_for = .feb_int_text(tx[[6]]), points_against = .feb_int_text(tx[[7]]),
        point_diff = .feb_int_text(tx[[8]]), win_pct = .feb_pct_text(tx[[9]]), streak = .feb_int_text(tx[[10]]),
        streak_text = .feb_s(tx[[10]])
      ))
    }
  }
  fin <- .feb_find_end(root, "table", "id", "_clasificacionFinalDataGrid")
  if (!is.null(fin)) {
    for (c in .feb_rows(fin, c("Po", "Equipo"), "final standings")) {
      tm <- .feb_link(c[[2]], "Equipo.aspx", "i", what = "team")
      standings[[length(standings) + 1L]] <- c(ctx, list(
        table = "final", position = .feb_int_text(.feb_text(c[[1]])), team_id = tm$id, team = .feb_s(tm$text)
      ))
    }
  }
  if (!length(results)) .feb_not_parsed("results page has zero result rows", empty = TRUE)
  list(results = c(results, next_round), standings = standings)
}

#' Parse a schedule page (`calendar` or `results`) for group `g`, season START year `t`.
#' Any parser error is a refusal (`feb_not_parsed`), never a crash.
#' @noRd
.feb_page_record <- function(kind, html, g, t) {
  html <- gsub("<br\\s*/?>", " ", html, ignore.case = TRUE, perl = TRUE)
  build <- switch(kind, calendar = .feb_calendar_record, results = .feb_results_record)
  tryCatch(
    build(rvest::read_html(html), g, t),
    error = function(e) {
      if (inherits(e, "feb_not_parsed")) stop(e)
      .feb_not_parsed(paste0("parser error: ", class(e)[[1]]))
    }
  )
}

# ------------------------------------------------------------------------------ casts

#' An id / count / seconds from the API's string or integer, else `NA` (never through a float).
#' @noRd
.feb_i <- function(v) {
  if (is.null(v) || is.list(v) || length(v) != 1L || is.logical(v) || is.na(v)) return(NA_integer_)
  if (is.integer(v)) return(v)
  if (is.character(v) && grepl("^\\s*[+-]?\\d+\\s*$", v, perl = TRUE)) return(suppressWarnings(as.integer(v)))
  NA_integer_
}

#' A number from a string (`"83,3"` decimal comma or `"63.47"`) or number, else `NA`.
#' @noRd
.feb_f <- function(v) {
  if (is.null(v) || is.list(v) || length(v) != 1L || is.logical(v) || is.na(v)) return(NA_real_)
  if (is.numeric(v)) return(as.double(v))
  if (is.character(v) && grepl("^\\s*[+-]?\\d+(?:[.,]\\d+)?\\s*$", v, perl = TRUE)) {
    return(as.double(sub(",", ".", .feb_strip(v), fixed = TRUE)))
  }
  NA_real_
}

#' A stripped non-empty string, else `NA` (numbers are stringified).
#' @noRd
.feb_s <- function(v) {
  if (is.null(v) || is.list(v) || length(v) != 1L || is.na(v)) return(NA_character_)
  x <- .feb_strip(as.character(v))
  if (nzchar(x)) x else NA_character_
}

.feb_flag <- function(v) {
  n <- .feb_i(v)
  if (is.na(n)) NA else n == 1L
}

#' `"08:34"` -> 514; `NA` for anything that is not `mm:ss`.
#' @noRd
.feb_clock_seconds <- function(v) {
  if (!is.character(v) || length(v) != 1L || is.na(v)) return(NA_integer_)
  m <- regmatches(v, regexec("^\\s*(\\d+):(\\d{2})\\s*$", v, perl = TRUE))[[1]]
  if (length(m) == 3L) as.integer(m[[2]]) * 60L + as.integer(m[[3]]) else NA_integer_
}

#' A datetime string matching one of `patterns` (regex with Y, m, d, H, M and optional S groups in
#' that order) -> `"YYYY-mm-dd HH:MM:SS"` (a wall-clock time), else `NA`.
#' @noRd
.feb_dt <- function(v, patterns) {
  if (!is.character(v) || length(v) != 1L || is.na(v)) return(NA_character_)
  v <- .feb_strip(v)
  for (p in patterns) {
    m <- regmatches(v, regexec(p$re, v, perl = TRUE))[[1]]
    if (!length(m)) next
    n <- as.integer(m[-1])[p$order]
    out <- sprintf("%04d-%02d-%02d %02d:%02d:%02d", n[[1]], n[[2]], n[[3]], n[[4]], n[[5]], if (length(n) > 5L) n[[6]] else 0L)
    ok <- !is.na(as.POSIXct(out, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")) && n[[4]] < 24L && n[[5]] < 60L &&
      (length(n) < 6L || n[[6]] < 60L)
    return(if (ok) out else NA_character_)
  }
  NA_character_
}

.feb_dt_local <- list( # "26-09-2026 - 19:00" (header) or ISO "2026-10-12T11:00:00"
  list(re = "^(\\d{1,2})-(\\d{1,2})-(\\d{4}) - (\\d{1,2}):(\\d{1,2})$", order = c(3, 2, 1, 4, 5)),
  list(re = "^(\\d{4})-(\\d{1,2})-(\\d{1,2})T(\\d{1,2}):(\\d{1,2}):(\\d{1,2})$", order = 1:6)
)
.feb_dt_utc <- list(list(re = "^(\\d{4})-(\\d{1,2})-(\\d{1,2})T(\\d{1,2}):(\\d{1,2}):(\\d{1,2})Z$", order = 1:6))
.feb_dt_log <- list(list(re = "^(\\d{4})-(\\d{1,2})-(\\d{1,2}) (\\d{1,2}):(\\d{1,2}):(\\d{1,2})$", order = 1:6))

# ----------------------------------------------------------------------------- frames

#' `rows` (named lists of typed scalars) as a tibble with exactly `spec`'s columns.
#'
#' `spec`: column -> `"integer"`, `"double"`, `"character"`, `"logical"`, `"Date"`,
#' `"madrid"` (Spain wall-clock -> POSIXct Europe/Madrid) or `"utc"` (POSIXct UTC).
#' Zero rows give a zero-row tibble with the same columns and types.
#' @noRd
.feb_frame <- function(rows, spec, what) {
  protos <- list(integer = NA_integer_, double = NA_real_, logical = NA, character = NA_character_)
  cols <- lapply(names(spec), function(col) {
    type <- spec[[col]]
    proto <- protos[[type]] %||% NA_character_
    x <- vapply(rows, function(r) {
      v <- r[[col]]
      if (is.null(v)) proto else v
    }, proto, USE.NAMES = FALSE)
    switch(type,
      Date = as.Date(x, format = "%Y-%m-%d"),
      madrid = as.POSIXct(x, format = "%Y-%m-%d %H:%M:%S", tz = "Europe/Madrid"),
      utc = as.POSIXct(x, format = "%Y-%m-%d %H:%M:%S", tz = "UTC"),
      x
    )
  })
  names(cols) <- names(spec)
  host <- if (what %in% c("schedule", "results", "standings")) "baloncestoenvivo.feb.es" else "intrafeb.feb.es"
  make_hoopR_data(dplyr::as_tibble(cols), paste0("FEB ", gsub("_", " ", what), " from ", host), Sys.time())
}

.feb_sides <- c("home", "away")

#' Side -> team object of a block's `TEAM` array (index 1 home, 2 away).
#' @noRd
.feb_teams <- function(raw, block) {
  b <- raw[[block]]
  teams <- if (.feb_is_obj(b)) .feb_arr(b[["TEAM"]]) else list()
  out <- list()
  for (i in seq_len(min(2L, length(teams)))) if (.feb_is_obj(teams[[i]])) out[[.feb_sides[[i]]]] <- teams[[i]]
  out
}

.feb_team_ctx <- function(team, side, game_id) {
  list(game_id = game_id, team_side = side, team_id = .feb_i(team[["id"]]), team = .feb_s(team[["name"]]))
}

.feb_shoot_int <- c("p1m", "p1a", "p2m", "p2a", "p3m", "p3a", "fgm", "fga")
.feb_shoot_pct <- c("p1p", "p2p", "p3p", "fgp")
.feb_count_int <- c("bs", "tc", "mt", "ro", "rd", "rt", "rf", "to", "st", "assist", "pf", "pts", "val")

.feb_stat_cells <- function(d) {
  out <- c(lapply(stats::setNames(nm = c(.feb_shoot_int, .feb_count_int)), function(k) .feb_i(d[[k]])),
           lapply(stats::setNames(nm = .feb_shoot_pct), function(k) .feb_f(d[[k]])))
  out$seconds_played <- .feb_i(d[["min"]])
  out$min_formatted <- .feb_s(d[["minFormatted"]])
  out
}

.feb_parse_game_info <- function(raw, game_id) {
  h <- raw[["HEADER"]]
  if (!.feb_is_obj(h) || !length(h)) return(.feb_frame(list(), .feb_specs$game_info, "game_info"))
  teams <- .feb_teams(raw, "HEADER")
  row <- list(
    game_id = game_id, comp_id = .feb_i(h[["CompID"]]), competition = .feb_s(h[["competition"]]),
    group_label = .feb_s(h[["round"]]), period = .feb_i(h[["quarter"]]), clock = .feb_s(h[["time"]]),
    start_time = .feb_dt(h[["starttime"]], .feb_dt_local), venue = .feb_s(h[["field"]]),
    address = .feb_s(h[["place"]]), referee1 = .feb_s(h[["referee1"]]), referee2 = .feb_s(h[["referee2"]]),
    referee3 = .feb_s(h[["referee3"]]), status = .feb_i(h[["status"]]), status_text = .feb_s(h[["statusText"]])
  )
  for (side in .feb_sides) {
    t <- teams[[side]] %||% list()
    row[[paste0(side, "_team_id")]] <- .feb_i(t[["id"]])
    row[[paste0(side, "_team")]] <- .feb_s(t[["name"]])
    row[[paste0(side, "_team_code")]] <- .feb_s(t[["teamCode"]])
    row[[paste0(side, "_club_code")]] <- .feb_s(t[["clubCode"]])
    row[[paste0(side, "_score")]] <- .feb_i(t[["pts"]])
  }
  .feb_frame(list(row), .feb_specs$game_info, "game_info")
}

.feb_parse_period_scores <- function(raw, game_id) {
  h <- raw[["HEADER"]]
  q <- if (.feb_is_obj(h) && .feb_is_obj(h[["QUARTERS"]])) h[["QUARTERS"]][["QUARTER"]] else NULL
  rows <- lapply(Filter(.feb_is_obj, .feb_arr(q)), function(p) {
    list(game_id = game_id, period = .feb_i(p[["n"]]), home_points = .feb_i(p[["scoreA"]]),
         away_points = .feb_i(p[["scoreB"]]))
  })
  .feb_frame(rows, .feb_specs$period_scores, "period_scores")
}

.feb_parse_player_box <- function(raw, game_id) {
  rows <- list()
  if (.feb_is_obj(raw[["BOXSCORE"]]) && length(raw[["BOXSCORE"]])) {
    teams <- .feb_teams(raw, "BOXSCORE")
    for (side in names(teams)) {
      team <- teams[[side]]
      for (p in Filter(.feb_is_obj, .feb_arr(team[["PLAYER"]]))) {
        rows[[length(rows) + 1L]] <- c(
          .feb_team_ctx(team, side, game_id),
          list(player_id = .feb_i(p[["id"]]), shirt_number = .feb_s(p[["no"]]), player = .feb_s(p[["name"]]),
               starter = .feb_flag(p[["inn"]]), captain = .feb_flag(p[["captain"]])),
          .feb_stat_cells(p),
          list(reb = .feb_i(p[["reb"]]))
        )
      }
    }
  }
  .feb_frame(rows, .feb_specs$player_box, "player_box")
}

.feb_parse_team_stats <- function(raw, game_id) {
  teams <- .feb_teams(raw, "TEAMSTATS")
  if (!length(teams)) { # the box score's per-team TOTAL block
    teams <- lapply(.feb_teams(raw, "BOXSCORE"), function(t) {
      tot <- t[["TOTAL"]]
      if (.feb_is_obj(tot)) for (k in names(tot)) t[k] <- list(tot[[k]])
      t
    })
  }
  rows <- lapply(names(teams), function(side) {
    t <- teams[[side]]
    c(.feb_team_ctx(t, side, game_id),
      list(team_code = .feb_s(t[["teamCode"]]), club_code = .feb_s(t[["clubCode"]])),
      .feb_stat_cells(t),
      lapply(stats::setNames(nm = c("fouls", "fastb", "ptsto", "secpts", "bench", "paint")), function(k) .feb_i(t[[k]])))
  })
  .feb_frame(rows, .feb_specs$team_stats, "team_stats")
}

.feb_position <- function(v) {
  m <- if (is.character(v) && length(v) == 1L && !is.na(v)) {
    regmatches(v, regexec("^\\s*(\\d+(?:\\.\\d+)?)\\|(\\d+(?:\\.\\d+)?)\\s*$", v, perl = TRUE))[[1]]
  }
  if (length(m) == 3L) as.numeric(m[2:3]) else c(NA_real_, NA_real_)
}

.feb_side_code <- function(v, codes) {
  if (is.null(v) || is.list(v) || length(v) != 1L || is.na(v)) return(NA_character_)
  unname(codes[as.character(v)])
}

.feb_parse_pbp <- function(raw, game_id) {
  pbp <- raw[["PLAYBYPLAY"]]
  lines <- if (.feb_is_obj(pbp)) .feb_arr(pbp[["LINES"]]) else list()
  rows <- lapply(Filter(.feb_is_obj, lines), function(ln) {
    xy <- .feb_position(ln[["Position"]])
    c(list(
      game_id = game_id, play_num = .feb_i(ln[["num"]]), period = .feb_i(ln[["quarter"]]),
      clock = .feb_s(ln[["time"]]), clock_seconds = .feb_clock_seconds(ln[["time"]]),
      team_side = .feb_side_code(ln[["team"]], c("1" = "home", "2" = "away")),
      team_id = .feb_i(ln[["idTeam"]]), player_id = .feb_i(ln[["idPlayer"]]), license_id = .feb_i(ln[["idLicense"]]),
      action = .feb_s(ln[["action"]]), text = .feb_s(ln[["text"]]), score_home = .feb_i(ln[["scoreA"]]),
      score_away = .feb_i(ln[["scoreB"]]), x = xy[[1]], y = xy[[2]]
    ),
    stats::setNames(lapply(1:10, function(n) .feb_s(ln[[paste0("logParam", n)]])), paste0("log_param", 1:10)),
    list(log_time = .feb_dt(ln[["LogTime"]], .feb_dt_log), log_time_utc = .feb_dt(ln[["LogTimeUtc"]], .feb_dt_log)))
  })
  num <- vapply(rows, function(r) r$play_num, integer(1))
  rows <- rows[order(is.na(num), ifelse(is.na(num), 0L, num))] # oldest first; the API lists newest first
  .feb_frame(rows, .feb_specs$pbp, "pbp")
}

.feb_parse_shots <- function(raw, game_id) {
  block <- raw[["SHOTCHART"]]
  shots <- if (.feb_is_obj(block)) block[["SHOTS"]] else NULL
  if (!.feb_is_arr(shots)) return(.feb_frame(list(), .feb_specs$shots, "shots"))
  teams <- .feb_teams(raw, "SHOTCHART")
  roster <- list() # "side|shirt" -> player id; a pair seen twice cannot name one player
  for (side in names(teams)) {
    for (p in .feb_arr(teams[[side]][["PLAYER"]])) {
      no <- if (.feb_is_obj(p)) .feb_s(p[["no"]]) else NA_character_
      if (is.na(no)) next
      key <- paste(side, no, sep = "|")
      roster[key] <- list(if (key %in% names(roster)) NA_integer_ else .feb_i(p[["id"]]))
    }
  }
  rows <- lapply(Filter(.feb_is_obj, shots), function(sh) {
    side <- .feb_side_code(sh[["team"]], c("0" = "home", "1" = "away"))
    no <- .feb_s(sh[["player"]])
    list(
      game_id = game_id, period = .feb_i(sh[["quarter"]]), clock = .feb_s(sh[["t"]]),
      clock_seconds = .feb_clock_seconds(sh[["t"]]), team_side = side,
      team_id = if (!is.na(side)) .feb_i(teams[[side]][["id"]]) else NA_integer_,
      shirt_number = no,
      player_id = if (!is.na(side) && !is.na(no)) roster[[paste(side, no, sep = "|")]] %||% NA_integer_ else NA_integer_,
      made = .feb_flag(sh[["m"]]), x = .feb_f(sh[["x"]]), y = .feb_f(sh[["y"]])
    )
  })
  .feb_frame(rows, .feb_specs$shots, "shots")
}

.feb_leader_cat <- list(Puntos = c("points", "pts"), Rebotes = c("rebounds", "reb"),
                        Asistencias = c("assists", "assist"), Faltas = c("fouls", "pf"))

.feb_parse_leaders <- function(raw, game_id) {
  block <- raw[["RANKING"]]
  teams <- if (.feb_is_obj(block)) .feb_arr(block[["TEAMS"]]) else list()
  rows <- list()
  for (i in seq_len(min(2L, length(teams)))) {
    team <- teams[[i]]
    if (!.feb_is_obj(team)) next
    for (key in names(.feb_leader_cat)) {
      cat <- .feb_leader_cat[[key]]
      ps <- .feb_arr(team[[key]])
      for (rank in seq_along(ps)) {
        p <- ps[[rank]]
        if (!.feb_is_obj(p)) next
        rows[[length(rows) + 1L]] <- c(
          .feb_team_ctx(team, .feb_sides[[i]], game_id),
          list(category = cat[[1]], rank = rank, player_id = .feb_i(p[["id"]]), shirt_number = .feb_s(p[["no"]]),
               player = .feb_s(p[["name"]]), starter = .feb_flag(p[["inn"]]), captain = .feb_flag(p[["captain"]]),
               value = .feb_i(p[[cat[[2]]]]))
        )
      }
    }
  }
  .feb_frame(rows, .feb_specs$leaders, "leaders")
}


.feb_parse_overview <- function(raw) {
  block <- raw[["OVERVIEW"]]
  comps <- if (.feb_is_obj(block)) .feb_arr(block[["COMPETITIONS"]]) else list()
  rows <- list()
  for (cmp in comps) {
    games <- if (.feb_is_obj(cmp)) .feb_arr(cmp[["GAMES"]]) else list()
    for (g in Filter(.feb_is_obj, games)) {
      # a quarter without both scores is skipped (sportsdataverse-py's f-string writes "None-None")
      qs <- Filter(function(q) .feb_is_obj(q) && !is.null(q[["scoreA"]]) && !is.null(q[["scoreB"]]),
                   .feb_arr(g[["Quarters"]]))
      ps <- paste(vapply(qs, function(q) paste0(as.character(q[["scoreA"]]), "-", as.character(q[["scoreB"]])),
                         character(1)), collapse = ";")
      rows[[length(rows) + 1L]] <- list(
        comp_id = .feb_i(g[["CompID"]]), comp_code = .feb_i(g[["CompCode"]]), competition = .feb_s(g[["Competition"]]),
        game_id = .feb_i(g[["ID"]]), round_id = .feb_i(g[["RoundID"]]), stage = .feb_s(g[["Stage"]]),
        venue = .feb_s(g[["Place"]]), start_time = .feb_dt(g[["StartTime"]], .feb_dt_local),
        start_time_utc = .feb_dt(g[["StartTimeUTC"]], .feb_dt_utc), period = .feb_i(g[["Quarter"]]),
        clock = .feb_s(g[["Time"]]), status = .feb_i(g[["Status"]]),
        home_team_id = .feb_i(g[["TeamAID"]]), home_team = .feb_s(g[["TeamA"]]),
        home_team_code = .feb_s(g[["TeamACode"]]), home_club_code = .feb_s(g[["TeamAClubCode"]]),
        home_abbreviation = .feb_s(g[["TeamASlug"]]), home_score = .feb_i(g[["ScoreA"]]),
        away_team_id = .feb_i(g[["TeamBID"]]), away_team = .feb_s(g[["TeamB"]]),
        away_team_code = .feb_s(g[["TeamBCode"]]), away_club_code = .feb_s(g[["TeamBClubCode"]]),
        away_abbreviation = .feb_s(g[["TeamBSlug"]]), away_score = .feb_i(g[["ScoreB"]]),
        period_scores = if (nzchar(ps)) ps else NA_character_
      )
    }
  }
  .feb_frame(rows, .feb_specs$overview, "overview")
}

# Column types per wrapper (sportsdataverse-py feb_parsers.SPECS; Int64 -> integer, Float64 -> double,
# naive local Datetime -> "madrid", naive UTC Datetime -> "utc").
.feb_specs <- list(
  game_info = c(
    game_id = "integer", comp_id = "integer", competition = "character", group_label = "character",
    period = "integer", clock = "character", start_time = "madrid", venue = "character", address = "character",
    referee1 = "character", referee2 = "character", referee3 = "character", status = "integer",
    status_text = "character", home_team_id = "integer", home_team = "character", home_team_code = "character",
    home_club_code = "character", home_score = "integer", away_team_id = "integer", away_team = "character",
    away_team_code = "character", away_club_code = "character", away_score = "integer"
  ),
  period_scores = c(
    game_id = "integer", period = "integer", home_points = "integer", away_points = "integer"
  ),
  team_stats = c(
    game_id = "integer", team_side = "character", team_id = "integer", team = "character", team_code = "character",
    club_code = "character", seconds_played = "integer", min_formatted = "character", pts = "integer",
    p1m = "integer", p1a = "integer", p1p = "double", p2m = "integer", p2a = "integer", p2p = "double", p3m = "integer",
    p3a = "integer", p3p = "double", fgm = "integer", fga = "integer", fgp = "double", ro = "integer", rd = "integer",
    rt = "integer", assist = "integer", st = "integer", `to` = "integer", bs = "integer", tc = "integer", mt = "integer",
    pf = "integer", rf = "integer", fouls = "integer", val = "integer", fastb = "integer", ptsto = "integer",
    secpts = "integer", bench = "integer", paint = "integer"
  ),
  player_box = c(
    game_id = "integer", team_side = "character", team_id = "integer", team = "character", player_id = "integer",
    shirt_number = "character", player = "character", starter = "logical", captain = "logical",
    seconds_played = "integer", min_formatted = "character", pts = "integer", p1m = "integer", p1a = "integer",
    p1p = "double", p2m = "integer", p2a = "integer", p2p = "double", p3m = "integer", p3a = "integer", p3p = "double",
    fgm = "integer", fga = "integer", fgp = "double", ro = "integer", rd = "integer", rt = "integer", reb = "integer",
    assist = "integer", st = "integer", `to` = "integer", bs = "integer", tc = "integer", mt = "integer", pf = "integer",
    rf = "integer", pllss = "integer", val = "integer"
  ),
  pbp = c(
    game_id = "integer", play_num = "integer", period = "integer", clock = "character", clock_seconds = "integer",
    team_side = "character", team_id = "integer", player_id = "integer", license_id = "integer", action = "character",
    text = "character", score_home = "integer", score_away = "integer", x = "double", y = "double",
    log_param1 = "character", log_param2 = "character", log_param3 = "character", log_param4 = "character",
    log_param5 = "character", log_param6 = "character", log_param7 = "character", log_param8 = "character",
    log_param9 = "character", log_param10 = "character", log_time = "madrid", log_time_utc = "utc"
  ),
  shots = c(
    game_id = "integer", period = "integer", clock = "character", clock_seconds = "integer", team_side = "character",
    team_id = "integer", shirt_number = "character", player_id = "integer", made = "logical", x = "double", y = "double"
  ),
  leaders = c(
    game_id = "integer", team_side = "character", team_id = "integer", team = "character", category = "character",
    rank = "integer", player_id = "integer", shirt_number = "character", player = "character", starter = "logical",
    captain = "logical", value = "integer"
  ),
  overview = c(
    comp_id = "integer", comp_code = "integer", competition = "character", game_id = "integer", round_id = "integer",
    stage = "character", venue = "character", start_time = "madrid", start_time_utc = "utc", period = "integer",
    clock = "character", status = "integer", home_team_id = "integer", home_team = "character",
    home_team_code = "character", home_club_code = "character", home_abbreviation = "character",
    home_score = "integer", away_team_id = "integer", away_team = "character", away_team_code = "character",
    away_club_code = "character", away_abbreviation = "character", away_score = "integer",
    period_scores = "character"
  ),
  schedule = c(
    group = "integer", season = "integer", competition = "character", round = "integer", round_label = "character",
    round_date = "Date", game_id = "integer", home_team_id = "integer", home_team = "character",
    away_team_id = "integer", away_team = "character", result_text = "character", home_score = "integer",
    away_score = "integer", status = "character", weekday = "character", date = "Date", time = "character"
  ),
  results = c(
    group = "integer", season = "integer", competition = "character", comp_id = "integer", section = "character",
    round_title = "character", game_id = "integer", home_team_id = "integer", home_team = "character",
    away_team_id = "integer", away_team = "character", result_text = "character", home_score = "integer",
    away_score = "integer", status = "character", date = "Date", time = "character"
  ),
  standings = c(
    group = "integer", season = "integer", competition = "character", comp_id = "integer", table = "character",
    position = "integer", team_id = "integer", team = "character", played = "integer", won = "integer",
    lost = "integer", points_for = "integer", points_against = "integer", point_diff = "integer", win_pct = "double",
    streak = "integer", streak_text = "character"
  )
)
