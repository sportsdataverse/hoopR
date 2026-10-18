# Offline tests of the LKL family (R/lkl.R, R/lkl_utils.R). Fixtures and the
# parity CSVs come from sdv-py (see fixtures/lkl/README.md); the transport is
# mocked at .intl_response(), so the status vocabulary, the content checks and
# every refusal run for real. Live checks at the bottom (HOOPR_INTL_LIVE_TESTS=1).

# one-line condition messages, so the expected-message regexes see no wrapping
withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

lkl_fx <- function(...) testthat::test_path("fixtures", "lkl", ...)
lkl_text <- function(rel) {
  path <- lkl_fx(rel)
  if (endsWith(rel, ".gz")) {
    con <- gzfile(path)
    on.exit(close(con))
    return(paste(readLines(con, encoding = "UTF-8", warn = FALSE), collapse = "\n"))
  }
  paste(readLines(path, encoding = "UTF-8", warn = FALSE), collapse = "\n")
}
lkl_full_path <- function(route) if (route %in% c("play-by-play", "shot-chart")) paste0("full/", route, ".json.gz") else paste0("full/", route, ".json")
lkl_full <- function(route) jsonlite::parse_json(lkl_text(lkl_full_path(route)), simplifyVector = FALSE)
lkl_html <- function(name) lkl_text(file.path("html", name))
lkl_to_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

GAME <- 11446L
PREPARING <- "<div>Informacija ruo\u0161iama</div>"
JSON <- "application/json"
HTML <- "text/html; charset=utf-8"

# Mock the transport: handler(path, query) returns list(status, ctype, body).
lkl_mock <- function(handler, env = parent.frame()) {
  log <- new.env()
  log$calls <- list()
  fake <- function(url, query = list(), body = NULL, body_type = "none", headers = NULL, proxy_env = NULL,
                   retry_500 = FALSE, timeout = 60, proxy = NULL, follow_redirects = TRUE, call = NULL) {
    path <- sub("^https://lkl\\.lt", "", url)
    query <- Filter(Negate(is.null), query)
    log$calls[[length(log$calls) + 1L]] <- list(path = path, query = query, retry_500 = retry_500)
    r <- handler(path, query)
    httr2::response(status_code = r$status %||% 200L, url = url, headers = list(`Content-Type` = r$ctype),
                    body = charToRaw(enc2utf8(r$body)))
  }
  testthat::local_mocked_bindings(.intl_response = fake, .package = "hoopR", .env = env)
  hoopR:::.lkl_clear_cache()
  withr::defer(hoopR:::.lkl_clear_cache(), envir = env)
  log
}
lkl_paths <- function(log) vapply(log$calls, `[[`, "", "path")

# a game site: the game page, then the livestream bodies (`routes` overrides by route: a list is
# served as JSON, a string as is, a function(query) returns list(status, ctype, body))
lkl_game_site <- function(routes = list(), page = NULL, status = 200L, ctype = JSON) {
  page_text <- page %||% lkl_html("game_11446.html")
  function(path, query) {
    if (startsWith(path, "/rungtynes/")) return(list(status = 200L, ctype = HTML, body = page_text))
    route <- strsplit(path, "/", fixed = TRUE)[[1]][4]
    if (!is.null(routes[[route]])) {
      v <- routes[[route]]
      if (is.function(v)) return(v(query))
      return(list(status = status, ctype = ctype, body = if (is.character(v)) v else lkl_to_json(v)))
    }
    list(status = status, ctype = ctype, body = lkl_text(lkl_full_path(route)))
  }
}

lkl_season_site <- function(results_pages = character(), standings = NULL, results_select = NULL) {
  function(path, query) {
    if (path == "/rezultatai") return(list(ctype = HTML, body = results_select %||% lkl_html("rezultatai_selects.html")))
    if (path == "/turnyrine-lentele") return(list(ctype = HTML, body = lkl_html("turnyrine_select.html")))
    if (path == "/loadResults") {
      n <- as.integer(query$page)
      return(list(ctype = HTML, body = if (n <= length(results_pages)) results_pages[[n]] else PREPARING))
    }
    if (startsWith(path, "/loadStandings/")) return(list(ctype = HTML, body = standings %||% ""))
    list(status = 404L, ctype = HTML, body = "")
  }
}

lkl_parity_site <- function() {
  game <- lkl_game_site()
  pages <- vapply(1:3, function(n) lkl_html(sprintf("results_49436_p%d.html", n)), "")
  standings <- c("35" = "standings_35.html", "34" = "standings_34.html", "3" = "standings_3.html")
  season <- lkl_season_site(pages)
  function(path, query) {
    if (startsWith(path, "/rungtynes/") || startsWith(path, "/api/")) return(game(path, query))
    if (startsWith(path, "/loadStandings/")) {
      return(list(ctype = HTML, body = lkl_html(standings[[sub("/loadStandings/", "", path, fixed = TRUE)]])))
    }
    season(path, query)
  }
}

# sdv-py frame (CSV, null = "<null>") vs the R tibble, cell by cell; NA-vs-value is a mismatch
lkl_mismatches <- function(r, w) {
  if (is.numeric(r)) {
    wn <- suppressWarnings(as.numeric(w))
    bad <- is.na(r) != is.na(wn) | (!is.na(r) & !is.na(wn) & abs(r - wn) > 1e-9)
  } else {
    rs <- if (is.logical(r)) tolower(as.character(r)) else as.character(r)
    bad <- is.na(rs) != is.na(w) | (!is.na(rs) & !is.na(w) & rs != w)
  }
  sum(bad)
}
lkl_read_parity <- function(case) {
  rel <- if (case == "pbp") "parity/pbp.csv.gz" else paste0("parity/", case, ".csv")
  con <- if (endsWith(rel, ".gz")) gzfile(lkl_fx(rel)) else file(lkl_fx(rel))
  utils::read.csv(con, colClasses = "character", na.strings = "<null>", check.names = FALSE, encoding = "UTF-8")
}
lkl_requests <- jsonlite::read_json(lkl_fx("parity", "requests.json"), simplifyVector = FALSE)
lkl_dtypes <- jsonlite::read_json(lkl_fx("parity", "dtypes.json"), simplifyVector = FALSE)
R_TYPE <- c(Int64 = "integer", Float64 = "numeric", String = "character", Boolean = "logical", Date = "Date")

# "path?k=v&..." with the query keys sorted, from a logged call or a requests.json entry
lkl_request_key <- function(x) {
  q <- unlist(lapply(x$query, as.character))
  if (is.null(q)) return(x$path)
  q <- q[order(names(q))]
  paste0(x$path, "?", paste0(names(q), "=", q, collapse = "&"))
}

# body with the value at `path` (names or 1-based positions) replaced; NULL is kept as a JSON null
lkl_swap <- function(x, path, value) {
  k <- path[[1]]
  if (length(path) == 1L) {
    x[k] <- list(value)
    return(x)
  }
  x[[k]] <- lkl_swap(x[[k]], path[-1], value)
  x
}

lkl_call <- function(case) {
  e <- lkl_requests[[case]]
  do.call(getExportedValue("hoopR", e$`function`), e$args)
}

test_that("every wrapper matches sdv-py's frame on the same bodies (columns, order, dtypes, cells, requests)", {
  expect_length(lkl_requests, 16L)
  wrappers <- grep("^lkl_", getNamespaceExports("hoopR"), value = TRUE)
  expect_setequal(wrappers, unique(vapply(lkl_requests, `[[`, "", "function")))
  for (case in names(lkl_requests)) {
    log <- lkl_mock(lkl_parity_site())
    got <- lkl_call(case)
    want <- lkl_read_parity(case)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), info = case)
    expect_identical(names(got), names(lkl_dtypes[[case]]), info = case)
    expect_identical(unname(vapply(got, function(x) class(x)[1], "")), unname(R_TYPE[unlist(lkl_dtypes[[case]])]),
                     info = case)
    expect_identical(nrow(got), nrow(want), info = case)
    expect_identical(nrow(got), as.integer(lkl_requests[[case]]$rows), info = case)
    bad <- vapply(names(got), function(col) lkl_mismatches(got[[col]], want[[col]]), integer(1))
    expect_identical(bad[bad > 0], stats::setNames(integer(0), character(0)), info = case)
    expect_identical(vapply(log$calls, lkl_request_key, ""), vapply(lkl_requests[[case]]$requests, lkl_request_key, ""),
                     info = case)
    expect_true(all(vapply(log$calls, function(x) isTRUE(x$retry_500), logical(1))), info = case)
  }
})

test_that("ids are integers, never stringified floats; the box adds up and every slug resolves", {
  lkl_mock(lkl_parity_site())
  box <- lkl_player_box(game_id = GAME)
  team <- lkl_team_box(game_id = 11446)
  per <- lkl_period_scores(game_id = "11446")
  for (df in list(box, team, per, lkl_shots(GAME), lkl_pbp(GAME), lkl_leaders(GAME), lkl_results(2027))) {
    for (col in grep("_id$", names(df), value = TRUE)) expect_type(df[[col]], "integer")
    expect_false(any(grepl("\\.0$", unlist(Filter(is.character, df)))))
  }
  expect_identical(team$team_side, c("home", "away"))
  expect_identical(team$team_id, c(11L, 41L))
  expect_identical(c(sum(box$points[box$team_side == "home"]), sum(box$points[box$team_side == "away"])), c(88L, 85L))
  expect_identical(sum(per$points[per$team_id == 11L]), 88L)
  expect_identical(max(per$period), 5L)
  expect_identical(unique(per$period_type[per$period == 5L]), "overtime")
  expect_false(anyNA(box$player_id))
  row <- box[box$player_slug == "justinas-marcinkevicius", ]
  expect_identical(list(row$fg_made, row$fg_attempted, row$fg_pct, row$seconds_played, row$player_id),
                   list(4L, 9L, 44.4, 1974L, 1762L))
  expect_identical(row$player, "J. Marcinkevi\u010dius")
  pbp <- lkl_pbp(GAME)
  last <- pbp[nrow(pbp), ]
  expect_identical(list(last$type, last$subtype, last$period, last$score_home, last$score_away),
                   list("game", "end", 5L, 88L, 85L))
  expect_identical(pbp$event_num, seq_len(nrow(pbp)))
  shots <- lkl_shots(GAME)
  roster <- lkl_game_players(GAME)
  expect_identical(typeof(shots$player_id), typeof(roster$player_id))
  expect_identical(shots$player_slug, roster$slug[match(shots$player_id, roster$player_id)])
  info <- lkl_game_info(GAME)
  expect_identical(info$start_date, as.Date("2026-02-14"))
  expect_identical(list(info$start_time, info$attendance_count, info$home_winner), list("16:50", 1097L, TRUE))
})

test_that("an empty or malformed body parses to a zero-row tibble with the documented columns", {
  lkl_mock(lkl_parity_site())
  for (short in names(hoopR:::.LKL_SPECS)) {
    spec <- hoopR:::.LKL_SPECS[[short]]
    for (raw in list(list(), NULL, "junk", list(x = 1L), structure(list(), names = character(0)))) {
      empty <- hoopR:::.lkl_parse(short, raw)
      expect_identical(nrow(empty), 0L, info = short)
      expect_identical(names(empty), names(spec), info = short)
      expect_identical(unname(vapply(empty, function(x) class(x)[1], "")),
                       unname(c(integer = "integer", double = "numeric", character = "character",
                                logical = "logical", Date = "Date")[spec]), info = short)
    }
  }
  # a body without the stamp keeps the schema and nulls what it cannot know
  box <- hoopR:::.lkl_parse("player_box", lkl_full("boxscore"))
  expect_identical(nrow(box), 22L)
  expect_true(all(is.na(box$player_id)) && all(is.na(box$team_id)))
  team <- hoopR:::.lkl_parse("team_box", lkl_full("boxscore"))
  expect_true(all(is.na(team$team_side)))
  expect_setequal(team$team_id, c(11L, 41L))
})

test_that("casts mirror sdv-py _i / _f / _s / _mmss / _made_att / _lt_date", {
  expect_identical(hoopR:::.lkl_i(5L), 5L)
  expect_identical(hoopR:::.lkl_i(" 12 "), 12L)
  expect_identical(hoopR:::.lkl_i(5), NA_integer_) # a float never becomes an id
  expect_identical(hoopR:::.lkl_i(TRUE), NA_integer_)
  expect_identical(hoopR:::.lkl_i("4.0"), NA_integer_)
  expect_identical(hoopR:::.lkl_f("71.4%"), 71.4)
  expect_identical(hoopR:::.lkl_f("46.67"), 46.67)
  expect_identical(hoopR:::.lkl_f("-"), NA_real_)
  expect_identical(hoopR:::.lkl_s(17L), "17")
  expect_identical(hoopR:::.lkl_s(17), "17.0")
  expect_identical(hoopR:::.lkl_s("  "), NA_character_)
  expect_identical(hoopR:::.lkl_s(FALSE), NA_character_)
  expect_identical(hoopR:::.lkl_mmss("32:54"), 1974L)
  expect_identical(hoopR:::.lkl_mmss("225:00"), 13500L)
  expect_identical(hoopR:::.lkl_made_att("4/9"), c(4L, 9L))
  expect_identical(hoopR:::.lkl_lt_date("2026  m. Spalio 3 d."), "2026-10-03")
  expect_identical(hoopR:::.lkl_lt_date("2026 m. Vasario 30 d."), NA_character_)
  expect_identical(hoopR:::.lkl_label_end_year("2025-2026 m. sezonas"), 2026L)
  expect_identical(hoopR:::.lkl_label_end_year("2025-2027 m. sezonas"), NA_integer_)
  expect_identical(hoopR:::.lkl_unescape("a &amp; b &lt;c&gt; &quot;d&quot;"), "a & b <c> \"d\"")
})

test_that("overtime periods are derived from the period-end lines", {
  line <- function(t, st) list(is_home = TRUE, type = t, subtype = st, clock = "00:00")
  # newest first, as the site lists them: OT2 (end, game end, a play, its start, a sub) then OT1
  ot <- list(line("game", "end"), line("period", "end"), line("2pt", "layup"), line("period", "start"),
             line("substitution", "in"), line("period", "end"), line("2pt", "layup"), line("period", "start"))
  got <- hoopR:::.lkl_chronological(list(regular = structure(list(), names = character(0)), overtime = ot))
  expect_identical(vapply(got, `[[`, integer(1), "period"), c(5L, 5L, 5L, 6L, 6L, 6L, 6L, 6L))
  expect_identical(got[[8]]$line$type, "game")
})

# ------------------------------------------------------------------ HTML readers

test_that("the game page reader reads the real page and refuses another game, a preview or drift", {
  rec <- hoopR:::.lkl_game_record(lkl_html("game_11590.html"), 11590L)
  expect_identical(rec$game_id, 11590L)
  expect_identical(rec$game_status, "Pasibaig\u0117")
  expect_identical(list(rec$start_date, rec$start_time, rec$attendance_count), list("2026-10-03", "16:50", 3012L))
  expect_identical(c(rec$teams_info$home$id, rec$teams_info$away$id), c(6L, 60L))
  expect_identical(rec$referees, "Saulius Ra\u010dys, Dovydas Kairys, Milita Stalau\u010dinskait\u0117")
  expect_false(any(c("players_stats_columns", "main_tabs", "leaders_tabs") %in% names(rec)))
  # the page built from sdv-py's record reads back to that record
  mine <- hoopR:::.lkl_game_record(lkl_html("game_11446.html"), GAME)
  theirs <- lkl_full("rungtynes")
  expect_setequal(names(mine), names(theirs))
  expect_identical(mine[names(theirs)], theirs)
  expect_error(hoopR:::.lkl_game_record(lkl_html("game_11590.html"), 11591L), "out of scope", class = "hoopR_lkl_not_parsed")
  expect_error(hoopR:::.lkl_game_record("<html><body>preview</body></html>", 11590L), "no <game-info-component>",
               class = "hoopR_lkl_not_parsed")
  bad <- sub(':teams-info="{', ':teams-info="{{', lkl_html("game_11590.html"), fixed = TRUE)
  expect_error(hoopR:::.lkl_game_record(bad, 11590L), "not JSON", class = "hoopR_lkl_not_parsed")
})

test_that("results pages merge into one record; a short, repeated, unconfirmed or out-of-season list is refused", {
  idx <- lkl_html("rezultatai_selects.html")
  p <- lapply(1:3, function(n) lkl_html(sprintf("results_49436_p%d.html", n)))
  rec <- hoopR:::.lkl_results_record(49436L, idx, p)
  expect_identical(list(rec$season_label, rec$season_end_year, rec$pages, rec$game_count),
                   list("2026-2027 m. sezonas", 2027L, 3L, 22L))
  np <- function(expr, pattern) expect_error(expr, pattern, class = "hoopR_lkl_not_parsed")
  np(hoopR:::.lkl_results_record(1L, idx, p), "not in the /rezultatai season select")
  np(hoopR:::.lkl_results_record(41936L, idx, p), "outside 2025-2026")
  np(hoopR:::.lkl_results_record(49436L, idx, p[1:2]), "walked 2 pages")
  np(hoopR:::.lkl_results_record(49436L, idx, p[c(1, 3, 3)]), "has 2 games")
  np(hoopR:::.lkl_results_record(49436L, idx, list(gsub("loadResults\\?page=\\d+", "x", p[[1]], perl = TRUE))), "no paginator")
  np(hoopR:::.lkl_results_record(49436L, idx, p[c(1, 1, 3)]), "duplicate games")
  one <- gsub("loadResults\\?page=\\d+", "loadResults?page=1", p[[1]], perl = TRUE)
  np(hoopR:::.lkl_results_record(49436L, idx, list(one)), "was not checked")
  np(hoopR:::.lkl_results_record(49436L, idx, list(one), after = p[[2]]), "after the paginator's last page")
  ok <- hoopR:::.lkl_results_record(49436L, idx, list(one), after = PREPARING)
  expect_identical(c(ok$game_count, ok$pages), c(10L, 1L))
  e <- expect_error(hoopR:::.lkl_results_record(49436L, idx, list(PREPARING)), class = "hoopR_lkl_not_parsed")
  expect_true(e$empty)
  np(hoopR:::.lkl_results_record(49436L, idx, list(gsub("rungtynes/", "rungtynes-x/", p[[3]], fixed = TRUE))), "drift")
})

test_that("standings tables parse; tab, header, colour and select drift are refused", {
  sel <- lkl_html("turnyrine_select.html")
  t35 <- lkl_html("standings_35.html")
  rec <- hoopR:::.lkl_standings_record(t35, 35L, sel)
  expect_identical(list(rec$season_label, rec$season_end_year), list("2026-2027 m. sezonas", 2027L))
  for (t in c("full", "home", "away")) {
    pos <- vapply(rec[[t]], `[[`, integer(1), "position")
    expect_identical(pos, sort(pos))
    expect_true(all(vapply(rec[[t]], function(r) r$won + r$lost == r$played, logical(1))))
  }
  old <- hoopR:::.lkl_standings_record(lkl_html("standings_3.html"), 3L, sel)
  expect_length(old$final, 0L)
  expect_true(is.na(old$full[[1]]$win_pct))
  np <- function(expr, pattern) expect_error(expr, pattern, class = "hoopR_lkl_not_parsed")
  np(hoopR:::.lkl_standings_record(t35, 99L, sel), "not in the /turnyrine-lentele")
  np(hoopR:::.lkl_standings_record(sub("Laim.%", "Win%", t35, fixed = TRUE), 35L, sel), "header drift")
  np(hoopR:::.lkl_standings_record(sub('data-id="away"', 'data-id="neutral"', t35, fixed = TRUE), 35L, sel), "tabs drift")
  np(hoopR:::.lkl_standings_record(sub("bg-green", "bg-purple", t35, fixed = TRUE), 35L, sel), "colour drift")
  np(hoopR:::.lkl_standings_record(t35, 35L, "<html></html>"), "no select")
})

test_that("the season END year maps through the site's selects", {
  results <- lkl_html("rezultatai_selects.html")
  standings <- lkl_html("turnyrine_select.html")
  results_ids <- c(`2027` = 49436, `2026` = 41936, `2025` = 39252, `2024` = 34698, `2023` = 34514, `2022` = 30527,
                   `2021` = 28293, `2020` = 25195, `2019` = 21837, `2018` = 18743, `2017` = 9225, `2016` = 3120,
                   `2015` = 3118, `2014` = 3116, `2013` = 3094, `2012` = 3095, `2011` = 3093, `2010` = 3092,
                   `2009` = 3091, `2008` = 3090, `2007` = 3096, `2006` = 3107, `2005` = 3106, `2004` = 3105,
                   `2003` = 3104, `2002` = 3103, `2001` = 3112, `2000` = 3111, `1999` = 3110, `1998` = 3109,
                   `1997` = 3108, `1996` = 3115, `1995` = 3117, `1994` = 3114)
  standings_ids <- c(`2027` = 35, `2026` = 34, `2025` = 33, `2024` = 32, `2023` = 31, `2022` = 30, `2021` = 29,
                     `2020` = 28, `2019` = 27, `2018` = 2, `2017` = 1, `2016` = 26, `2015` = 10, `2014` = 9,
                     `2013` = 7, `2012` = 8, `2011` = 6, `2010` = 5, `2009` = 4, `2008` = 3, `2007` = 11,
                     `2006` = 12, `2005` = 13, `2004` = 14, `2003` = 15, `1994` = 24)
  env <- rlang::current_env()
  for (y in names(results_ids)) {
    expect_identical(hoopR:::.lkl_season_id(results, "season-lkl", as.integer(y), "x", env), as.integer(results_ids[[y]]))
  }
  for (y in names(standings_ids)) {
    expect_identical(hoopR:::.lkl_season_id(standings, "season", as.integer(y), "x", env), as.integer(standings_ids[[y]]))
  }
  expect_error(hoopR:::.lkl_season_id(results, "season-lkl", 2099L, "x", env), "no season ending in 2099", class = "hoopR_no_data")
  dup <- sub("2007-2008 m. sezonas", "2008-2009 m. sezonas", results, fixed = TRUE)
  expect_error(hoopR:::.lkl_season_id(dup, "season-lkl", 2009L, "x", env), "ambiguous", class = "hoopR_asset_fetch")
  expect_error(hoopR:::.lkl_season_id("<html></html>", "season-lkl", 2026L, "x", env), "no select", class = "hoopR_asset_fetch")
})

# ------------------------------------------------------------------ runtime: game routes

test_that("game wrappers run end to end and the game page is fetched once", {
  log <- lkl_mock(lkl_game_site())
  expect_identical(nrow(lkl_player_box(game_id = GAME)), 22L)
  expect_identical(nrow(lkl_pbp(game_id = GAME)), 668L)
  expect_identical(nrow(lkl_shots(game_id = GAME)), 148L)
  expect_identical(nrow(lkl_game_info(game_id = GAME)), 1L) # served from the cached page
  expect_identical(lkl_paths(log), c("/rungtynes/11446", "/api/livestream/boxscore/11446",
                                     "/api/livestream/play-by-play/11446", "/api/livestream/shot-chart/11446"))
  raw <- hoopR:::.lkl_raw("player_box", GAME, rlang::current_env())
  req <- raw[["_request"]]
  expect_identical(list(req$game_id, req$home_team_id, req$away_team_id, req$players[["justinas-marcinkevicius"]]),
                   list(GAME, 11L, 41L, 1762L))
})

test_that("an unfinished, unplayed or other game's page is a fetch failure and no route is asked for", {
  page <- lkl_html("game_11446.html")
  for (status in c("Vyksta", "Neprad\u0117ta", "")) {
    log <- lkl_mock(lkl_game_site(page = sub('game-status="Pasibaig\u0117"', sprintf('game-status="%s"', status), page,
                                             fixed = TRUE)))
    expect_error(lkl_player_box(GAME), "not finished", class = "hoopR_asset_fetch")
    expect_error(lkl_game_info(GAME), "not finished", class = "hoopR_asset_fetch")
    expect_identical(unique(lkl_paths(log)), "/rungtynes/11446")
  }
  lkl_mock(lkl_game_site(page = "<html><body>preview</body></html>"))
  expect_error(lkl_game_score(GAME), "no <game-info-component>", class = "hoopR_asset_fetch")
  lkl_mock(lkl_game_site(page = sub('game-id="11446"', 'game-id="11447"', page, fixed = TRUE)))
  expect_error(lkl_player_box(GAME), "out of scope: game-id", class = "hoopR_asset_fetch")
})

test_that("404 is no data for the page and for a route; 400 is a bad request; other statuses fail", {
  lkl_mock(function(path, query) list(status = 404L, ctype = HTML, body = "<html>nope</html>"))
  expect_error(lkl_player_box(6000), "HTTP 404", class = "hoopR_no_data")
  lkl_mock(lkl_game_site(list(leaders = function(q) list(status = 404L, ctype = HTML, body = "x"))))
  expect_error(lkl_leaders(GAME), "HTTP 404", class = "hoopR_no_data")
  lkl_mock(lkl_game_site(list(boxscore = ""), status = 400L))
  expect_error(lkl_player_box(GAME), "HTTP 400", class = "hoopR_bad_request")
  lkl_mock(lkl_game_site(list(boxscore = ""), status = 403L))
  expect_error(lkl_player_box(GAME), "HTTP 403", class = "hoopR_asset_fetch")
  log <- lkl_mock(lkl_game_site(list(`shot-chart` = ""), status = 500L))
  e <- expect_error(lkl_shots(GAME), "HTTP 500", class = "hoopR_asset_fetch")
  expect_true(e$transient)
  expect_true(all(vapply(log$calls, function(x) isTRUE(x$retry_500), logical(1)))) # lkl retries HTTP 500
  lkl_mock(lkl_game_site(list(summary = "{}"), status = 204L))
  expect_error(lkl_summary(GAME), "not 200", class = "hoopR_asset_fetch")
})

test_that("error envelopes, stubs, changed bodies and non-JSON answers are refused", {
  cases <- list(
    list("boxscore", lkl_player_box, '{"message":"Server Error"}', "error envelope"),
    list("boxscore", lkl_player_box, "{}", "empty or not an object"),
    list("boxscore", lkl_player_box, "[1]", "empty or not an object"),
    list("boxscore", lkl_player_box, "<html>oops</html>", "not JSON"),
    list("boxscore", lkl_player_box, "", "empty body"),
    list("game-score", lkl_game_score, '{"home":null,"away":null,"clock":"x"}', "game not final"),
    list("game-stats", lkl_game_stats, '{"comparison":{}}', "layout drift"),
    list("play-by-play", lkl_pbp, '{"quarters":{"regular":{"1":[]}}}', "layout drift")
  )
  for (cs in cases) {
    routes <- list()
    routes[[cs[[1]]]] <- cs[[3]]
    lkl_mock(lkl_game_site(routes))
    expect_error(cs[[2]](GAME), cs[[4]], class = "hoopR_asset_fetch")
  }
  lkl_mock(lkl_game_site(ctype = "text/html"))
  expect_error(lkl_player_box(GAME), "not JSON", class = "hoopR_asset_fetch")
})

test_that("wrong-scope bodies are refused, not returned empty", {
  box <- lkl_full("boxscore")
  other <- gsub('"game_id":11446', '"game_id":11447', lkl_text("full/boxscore.json"), fixed = TRUE)
  gs <- box$gameStatistics
  cases <- list(
    list("boxscore", lkl_player_box, other, "is not game 11446's row"),
    list("boxscore", lkl_player_box, lkl_swap(box, list("gameStatistics"), list(`99` = gs[["11"]], `41` = gs[["41"]])), "gameStatistics teams"),
    list("boxscore", lkl_player_box, lkl_swap(box, list("boxscore", "home", "players", 1, "slug"), "somebody-else"), "not a home player"),
    list("boxscore", lkl_player_box, lkl_swap(box, list("boxscore", "away", "team", "points", "value"), 1L), "!= gameStatistics"),
    list("boxscore", lkl_player_box, lkl_swap(box, list("gameStatistics", "11", "points"), NULL), "game not final"),
    list("leaders", lkl_leaders, lkl_swap(lkl_full("leaders"), list("leaders", "points", "home", "slug"), "somebody-else"), "not a home player"),
    list("play-by-play", lkl_pbp, lkl_swap(lkl_full("play-by-play"), list("quarters", "regular", "1", 6, "player", "slug"), "somebody-else"), "not a"),
    list("shot-chart", lkl_shots, lkl_swap(lkl_full("shot-chart"), list("quarters", "regular", "1", 1, "player_id"), 99999L), "not a")
  )
  for (cs in cases) {
    routes <- list()
    routes[[cs[[1]]]] <- cs[[3]]
    lkl_mock(lkl_game_site(routes))
    expect_error(cs[[2]](GAME), cs[[4]], class = "hoopR_asset_fetch", fixed = TRUE)
  }
  pbp <- lkl_full("play-by-play")
  pbp$quarters$overtime <- Filter(function(ln) !identical(ln$type, "game"), pbp$quarters$overtime)
  lkl_mock(lkl_game_site(list(`play-by-play` = pbp)))
  expect_error(lkl_pbp(GAME), "game-end line", class = "hoopR_asset_fetch")
})

test_that("a finished game before 2024-25 has no play-by-play or shots", {
  for (empty in c('{"quarters":{"regular":[],"overtime":[]}}', '{"regular":[],"overtime":[]}')) {
    lkl_mock(lkl_game_site(list(`play-by-play` = empty, `shot-chart` = empty)))
    expect_error(lkl_pbp(GAME), "2024-25", class = "hoopR_no_data")
    expect_error(lkl_shots(GAME), "2024-25", class = "hoopR_no_data")
  }
})

test_that("a bad game id or season is a bad request before any request", {
  log <- lkl_mock(lkl_game_site())
  for (bad in list("abc", NULL, TRUE, 1.5, -3, NA, c(1, 2))) {
    expect_error(lkl_player_box(bad), "must be an integer", class = "hoopR_bad_request")
    expect_error(lkl_standings(bad), "must be an integer", class = "hoopR_bad_request")
    if (!is.null(bad)) expect_error(lkl_results(bad), "must be an integer", class = "hoopR_bad_request")
  }
  expect_error(lkl_results(NULL), "needs season", class = "hoopR_bad_request")
  expect_length(log$calls, 0L)
})

test_that("personal fields are redacted by key name in raw bodies", {
  body <- lkl_full("leaders")
  body$leaders$points$home$birth_date <- "1990-01-01"
  body$leaders$points$home$others[[1]]$Email <- "x@y.z"
  lkl_mock(lkl_game_site(list(leaders = body)))
  raw <- hoopR:::.lkl_raw("leaders", GAME, rlang::current_env())
  expect_identical(raw$leaders$points$home$birth_date, "<redacted>")
  expect_identical(raw$leaders$points$home$others[[1]]$Email, "<redacted>")
  expect_false(grepl("1990-01-01", lkl_to_json(raw), fixed = TRUE))
  expect_identical(nrow(lkl_leaders(GAME)), 60L)
})

# ------------------------------------------------------------------ runtime: season pages

test_that("results walk every page of the mapped season id and confirm a full last page", {
  p <- vapply(1:3, function(n) lkl_html(sprintf("results_49436_p%d.html", n)), "")
  log <- lkl_mock(lkl_season_site(p))
  df <- lkl_results(season = 2027)
  expect_identical(nrow(df), 22L)
  expect_identical(unique(df$season_end_year), 2027L)
  expect_identical(lkl_paths(log), c("/rezultatai", rep("/loadResults", 3)))
  expect_identical(vapply(log$calls[-1], function(x) x$query$page, integer(1)), 1:3)
  expect_identical(unique(vapply(log$calls[-1], function(x) x$query$season, integer(1))), 49436L)
  raw <- hoopR:::.lkl_raw("results", 2027, rlang::current_env())
  expect_identical(raw[["_request"]], list(season = 2027L, season_id = 49436L))
  one <- gsub("loadResults\\?page=\\d+", "loadResults?page=1", p[[1]], perl = TRUE)
  log <- lkl_mock(lkl_season_site(one))
  expect_identical(nrow(lkl_results(2027)), 10L)
  expect_identical(lkl_paths(log), c("/rezultatai", "/loadResults", "/loadResults")) # page 2 fetched to confirm
  lkl_mock(lkl_season_site(c(one, p[2:3])))
  expect_error(lkl_results(2027), "after the paginator's last page", class = "hoopR_asset_fetch")
  lkl_mock(lkl_season_site(p))
  expect_error(lkl_results(2026), "outside 2025-2026", class = "hoopR_asset_fetch")
  lkl_mock(lkl_season_site(p[c(1, 3, 3)]))
  expect_error(lkl_results(2027), "expected 10 on all but the last page", class = "hoopR_asset_fetch")
})

test_that("a season without played games or missing from the selects is no data", {
  lkl_mock(lkl_season_site(PREPARING))
  expect_error(lkl_results(2027), "no played games", class = "hoopR_no_data")
  expect_error(lkl_results(2099), "no season ending in 2099", class = "hoopR_no_data")
  expect_error(lkl_standings(2099), "no season ending in 2099", class = "hoopR_no_data")
})

test_that("standings map the season, read the fragment and refuse drift", {
  log <- lkl_mock(lkl_season_site(standings = lkl_html("standings_35.html")))
  df <- lkl_standings(season = 2027)
  expect_identical(unique(df$season_id), 35L)
  expect_identical(unique(df$season_end_year), 2027L)
  expect_setequal(df$table, c("full", "home", "away"))
  expect_identical(lkl_paths(log), c("/turnyrine-lentele", "/loadStandings/35"))
  log <- lkl_mock(lkl_season_site(standings = lkl_html("standings_3.html")))
  expect_identical(unique(lkl_standings(2008)$season_id), 3L)
  lkl_mock(lkl_season_site(standings = sub("Poz.", "Pos.", lkl_html("standings_35.html"), fixed = TRUE)))
  expect_error(lkl_standings(2027), "header drift", class = "hoopR_asset_fetch")
  lkl_mock(function(path, query) {
    if (path == "/turnyrine-lentele") return(list(ctype = HTML, body = lkl_html("turnyrine_select.html")))
    list(status = 404L, ctype = HTML, body = "x")
  })
  expect_error(lkl_standings(2027), "HTTP 404", class = "hoopR_no_data")
  lkl_mock(function(path, query) list(ctype = HTML, body = "<html>no select</html>"))
  expect_error(lkl_standings(2027), "no select", class = "hoopR_asset_fetch")
  lkl_mock(function(path, query) list(ctype = JSON, body = "{}"))
  expect_error(lkl_results(2027), "not HTML", class = "hoopR_asset_fetch")
})

# ------------------------------------------------------------------ live

test_that("live: a finished game and a season (HOOPR_INTL_LIVE_TESTS=1)", {
  skip_intl_live()
  box <- lkl_player_box(game_id = 11446)
  expect_identical(names(box), names(hoopR:::.LKL_SPECS$player_box))
  expect_gt(nrow(box), 0L)
  st <- lkl_standings(season = 2026)
  expect_identical(unique(st$season_end_year), 2026L)
})
