# Offline tests of the ABA League family (R/aba.R, R/aba_utils.R). Fixtures and
# the parity CSVs come from sdv-py (see fixtures/aba/README.md); the transport is
# mocked at .intl_response(), so the status vocabulary, the redirect checks and
# every refusal run for real. Live checks at the bottom (HOOPR_INTL_LIVE_TESTS=1).

# one-line condition messages, so the expected-message regexes see no wrapping
withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

aba_fx <- function(...) testthat::test_path("fixtures", "aba", ...)
aba_text <- function(rel) paste(readLines(aba_fx(rel), encoding = "UTF-8", warn = FALSE), collapse = "\n")
aba_read <- function(rel) jsonlite::read_json(aba_fx(rel), simplifyVector = FALSE)
aba_manifest <- jsonlite::read_json(aba_fx("parity", "manifest.json"), simplifyVector = FALSE)
ABA_WWW <- "https://www.aba-liga.com"
ABA_DRUGA <- "https://druga.aba-liga.com"
ABA_LIVE <- "/live-match/rezultati-1718"
ABA_M6 <- list(game_no = 6L, sez = 25L, lea = 1L)

# the input sdv-py parsed for one manifest case
aba_case_raw <- function(c) {
  switch(c$source,
    html = hoopR:::.aba_record_for(c$kind, aba_text(c$fixture), lapply(c$want, as.integer)),
    record = aba_read(c$fixture),
    helper = list(rows = aba_read(c$fixture), `_request` = c$request)
  )
}

aba_stamped <- function(rows) list(rows = rows, `_request` = list(game_no = 6L, season = 2026L, league_id = 1L, league = "aba"))

# The committed pages and helper bodies, keyed by path; `overrides` replaces a path.
# A value is the body text, or list(status =, body =, url = <final URL after redirects>).
aba_pages <- function(overrides = list()) {
  table <- list(
    "/match/6/25/1/Overview" = aba_text("match_6_25_1.html"),
    "/match/1/8/1/Overview" = aba_text("match_1_8_1.html"),
    "/calendar/25/1/" = aba_text("calendar_25_1.html"),
    "/standings/25/1/" = aba_text("standings_25_1.html"),
    "/player/4807/25/1/" = aba_text("player_4807_25_1.html"),
    "/live-match/rezultati-1718/create_shooting_chart.php" = aba_text("create_shooting_chart_6_25_1.json"),
    "/live-match/rezultati-1718/create_json.php" = aba_text("create_json_6_25_1.json"),
    "/live-match/rezultati-1718/create_scoredifference.php" = aba_text("create_json_6_25_1.json")
  )
  table[names(overrides)] <- overrides
  table
}

# Mock the transport; `site` is a list as aba_pages() returns, or a function(url, query).
aba_mock <- function(site = aba_pages(), env = parent.frame()) {
  log <- new.env()
  log$calls <- list()
  fake <- function(url, query = list(), body = NULL, body_type = "none", headers = NULL, proxy_env = NULL,
                   retry_500 = FALSE, timeout = 60, proxy = NULL, follow_redirects = TRUE, call = NULL) {
    log$calls[[length(log$calls) + 1L]] <- list(url = url, query = query, retry_500 = retry_500)
    r <- if (is.function(site)) site(url, query) else site[[sub("^https://[^/]+", "", url)]]
    if (is.null(r)) r <- list(status = 404L, body = "not found")
    if (!is.list(r)) r <- list(body = r)
    httr2::response(status_code = r$status %||% 200L, url = r$url %||% url,
                    headers = list(`Content-Type` = "text/html; charset=UTF-8"),
                    body = charToRaw(enc2utf8(r$body)))
  }
  testthat::local_mocked_bindings(.intl_response = fake, .package = "hoopR", .env = env)
  log
}
aba_urls <- function(log) vapply(log$calls, `[[`, "", "url")

aba_mutate_match <- function(fn) {
  out <- fn(aba_text("match_6_25_1.html"))
  stopifnot(!identical(out, aba_text("match_6_25_1.html")))
  out
}

# sdv-py frame (CSV) vs the R tibble, cell by cell; NA-vs-value is a mismatch
aba_mismatches <- function(r, w) {
  if (is.numeric(r)) {
    wn <- suppressWarnings(as.numeric(w))
    bad <- is.na(r) != is.na(wn) | (!is.na(r) & !is.na(wn) & abs(r - wn) > 1e-9)
  } else {
    rs <- if (is.logical(r)) tolower(as.character(r)) else as.character(r)
    bad <- is.na(rs) != is.na(w) | (!is.na(rs) & !is.na(w) & rs != w)
  }
  sum(bad)
}

# ------------------------------------------------------------------ parsers

test_that("every route matches the sdv-py frame on the same fixture (parity)", {
  expect_length(aba_manifest, 38L)
  expect_setequal(unique(vapply(aba_manifest, `[[`, "", "short")), names(hoopR:::.ABA_SPECS))
  for (name in names(aba_manifest)) {
    c <- aba_manifest[[name]]
    got <- hoopR:::.aba_parse(c$short, aba_case_raw(c))
    want <- utils::read.csv(aba_fx("parity", paste0(name, ".csv")), colClasses = "character", na.strings = "",
                            encoding = "UTF-8", check.names = FALSE)
    expect_identical(names(got), names(want), info = name)
    expect_identical(nrow(got), nrow(want), info = name)
    expect_identical(nrow(got), as.integer(c$rows), info = name)
    bad <- vapply(names(got), function(col) aba_mismatches(got[[col]], want[[col]]), integer(1))
    expect_identical(bad[bad > 0], stats::setNames(integer(0), character(0)), info = name)
  }
})

test_that("ids are integers, never stringified floats; types follow the sdv-py dtypes", {
  for (name in names(aba_manifest)) {
    c <- aba_manifest[[name]]
    got <- hoopR:::.aba_parse(c$short, aba_case_raw(c))
    spec <- hoopR:::.ABA_SPECS[[c$short]]
    expect_identical(vapply(got, function(x) class(x)[1], ""), ifelse(spec == "double", "numeric", spec), info = name)
    for (col in grep("(_id|^game_no|^season)$", names(got), value = TRUE)) expect_type(got[[col]], "integer")
    expect_false(any(grepl("^[0-9]+\\.0$", unlist(Filter(is.character, got)))), info = name)
  }
  box <- hoopR:::.aba_parse("box_players", aba_read("full/match_6_25_1.json"))
  shots <- hoopR:::.aba_parse("shots", aba_stamped(aba_read("create_shooting_chart_6_25_1.json")))
  pbp <- hoopR:::.aba_parse("pbp", aba_read("full/match_6_25_1.json"))
  expect_true(all(stats::na.omit(shots$player_id) %in% box$player_id))
  expect_true(all(stats::na.omit(pbp$player_id) %in% box$player_id))
  expect_identical(sum(is.na(shots$player_id)), 1L) # the site's "0": shooter not recorded
  expect_type(box$fg_pct, "double")
  expect_type(box$minutes, "character")
  expect_identical(sum(!box$played), 2L)
  expect_true(all(is.na(box$points[!box$played])))
})

test_that("the full game: header, periods, play-by-play and helpers add up", {
  rec <- aba_read("full/match_6_25_1.json")
  g <- hoopR:::.aba_parse("game", rec)
  expect_identical(c(g$game_no, g$season, g$league_id, g$home_score, g$away_score), c(6L, 2026L, 1L, 93L, 97L))
  expect_identical(c(g$home_team_id, g$away_team_id, g$attendance), c(12L, 91L, 1200L))
  expect_identical(g$date, as.Date("2025-10-05"))
  expect_identical(c(g$time, g$time_zone, g$season_label, g$group), c("19:30", "CET", "2025/26", "B"))
  p <- hoopR:::.aba_parse("periods", rec)
  expect_identical(p$period, c("Q1", "Q2", "Q3", "Q4", "OT1"))
  expect_identical(c(sum(p$home_points), sum(p$away_points)), c(93L, 97L))
  pbp <- hoopR:::.aba_parse("pbp", rec)
  expect_identical(pbp$seq, seq_len(659L))
  expect_identical(pbp$text[659], "game finished")
  expect_identical(unique(pbp$seconds_left[which(pbp$clock == "08:34")]), 514L)
  flow <- hoopR:::.aba_parse("score_flow", aba_stamped(aba_read("create_json_6_25_1.json")))
  expect_identical(flow$minute, 0:45)
  expect_identical(c(flow$home_score[46], flow$away_score[46]), c(93L, 97L))
})

test_that("the HTML walk equals the refs capture of the same page", {
  rec <- hoopR:::.aba_record_for("match", aba_text("match_6_25_1.html"), ABA_M6)
  cap <- aba_read("cap/match_6_25_1.json")
  expect_identical(hoopR:::.aba_parse("game", rec), hoopR:::.aba_parse("game", cap))
  expect_identical(hoopR:::.aba_parse("box_players", rec)[1, ], hoopR:::.aba_parse("box_players", cap)[1, ])
  cal <- hoopR:::.aba_record_for("calendar", aba_text("calendar_25_1.html"), list(sez = 25L, lea = 1L))
  expect_identical(cal$season, aba_read("cap/calendar_25_1.json")$season)
  old <- hoopR:::.aba_record_for("match", aba_text("match_1_8_1.html"), list(game_no = 1L, sez = 8L, lea = 1L))
  expect_length(old$pbp, 0L)
  box <- hoopR:::.aba_parse("box_players", old)
  expect_true(all(is.na(box$starter)) && all(is.na(box$on_court_at_end)) && all(is.na(box$pts_paint)))
})

test_that("an empty or malformed body parses to a zero-row tibble with the documented columns", {
  bads <- list(list(), NULL, "x", 7, list(game = NULL), list(rows = "x"), list(games = list()), list(rows = list(1, 2)))
  for (short in names(hoopR:::.ABA_SPECS)) {
    spec <- hoopR:::.ABA_SPECS[[short]]
    for (raw in bads) {
      got <- hoopR:::.aba_parse(short, raw)
      expect_identical(nrow(got), 0L)
      expect_identical(names(got), names(spec))
      expect_identical(unname(vapply(got, function(x) class(x)[1], "")),
                       unname(ifelse(spec == "double", "numeric", spec)), info = short)
    }
  }
})

test_that("season maps the END year to the site's sez", {
  sez <- function(s) hoopR:::.aba_sez_for_season(s)
  expect_identical(c(sez(2026), sez(2009), sez(2018), sez(2002), sez("2026")), c(25L, 8L, 17L, 1L, 25L))
  expect_error(sez(2001), class = "hoopR_no_data")
  for (bad in list("x", NULL, 2.5, TRUE, 2101)) expect_error(sez(bad), class = "hoopR_bad_request")
})

# ------------------------------------------------------------------ runtime

test_that("wrappers build the site's URL, retry 500 and return hoopR_data", {
  log <- aba_mock()
  game <- aba_game(game_no = 6, season = 2026)
  expect_s3_class(game, "hoopR_data")
  expect_identical(c(nrow(game), game$season), c(1L, 2026L))
  expect_identical(nrow(aba_pbp(game_no = 6, season = 2026)), 95L)
  expect_identical(nrow(aba_calendar(season = 2026)), 5L)
  expect_identical(nrow(aba_standings(season = "2026")), 36L)
  expect_identical(aba_urls(log), c(rep(paste0(ABA_WWW, "/match/6/25/1/Overview"), 2),
                                    paste0(ABA_WWW, c("/calendar/25/1/", "/standings/25/1/"))))
  expect_true(all(vapply(log$calls, `[[`, NA, "retry_500")))
  rec <- hoopR:::.aba_fetch("box_teams", list(game_no = 6, season = 2026, league = "aba"), rlang::current_env())
  expect_identical(rec[["_request"]], list(league = "aba", league_id = 1L, kind = "match", season = 2026L, sez = 25L,
                                           game_no = 6L))
})

test_that("the league argument picks the host and lea; a bad league or id is refused before any request", {
  log <- aba_mock(function(url, query) stop("no fetch expected"))
  expect_error(aba_game(game_no = 1, season = 2026, league = "nba"), class = "hoopR_bad_request")
  expect_error(aba_game(game_no = "six", season = 2026), class = "hoopR_bad_request")
  expect_error(aba_player(player_id = 4807.5, season = 2026), class = "hoopR_bad_request")
  expect_error(aba_calendar(season = 2001), "first season", class = "hoopR_no_data")
  expect_length(log$calls, 0L)
  log <- aba_mock(function(url, query) aba_text("match_6_25_1.html"))
  expect_error(aba_game(game_no = 1, season = 2026, league = "aba2"), "out of scope", class = "hoopR_asset_fetch")
  expect_identical(aba_urls(log), paste0(ABA_DRUGA, "/match/1/25/2/Overview"))
})

test_that("a player page may redirect to its slug URL", {
  aba_mock(aba_pages(list("/player/4807/25/1/" = list(body = aba_text("player_4807_25_1.html"),
                                                      url = paste0(ABA_WWW, "/player/4807/25/1/carlik-jones/")))))
  bio <- aba_player(player_id = 4807, season = 2026)
  expect_identical(c(bio$player_id, bio$team_id, bio$season, bio$height_cm), c(4807L, 22L, 2026L, 185L))
  expect_identical(bio$birth_date, as.Date("1997-12-23"))
  expect_identical(nrow(aba_player_games(player_id = 4807, season = 2026)), 2L)
})

test_that("the status vocabulary and the redirect checks", {
  aba_mock(aba_pages(list("/match/9999/25/1/Overview" = list(body = "<html>Error</html>",
                                                             url = paste0(ABA_WWW, "/match-not-defined/")))))
  expect_error(aba_game(game_no = 9999, season = 2026), "no such game", class = "hoopR_no_data")
  for (st in c(404L, 422L, 403L, 503L)) {
    aba_mock(aba_pages(list("/match/6/25/1/Overview" = list(status = st, body = "x"))))
    cls <- switch(as.character(st), "404" = "hoopR_no_data", "422" = "hoopR_bad_request", "hoopR_asset_fetch")
    err <- expect_error(aba_game(game_no = 6, season = 2026), class = cls)
    expect_identical(err$status, st)
    if (st == 503L) expect_true(err$transient)
  }
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = list(status = 204L, body = ""))))
  expect_error(aba_game(game_no = 6, season = 2026), "not 200", class = "hoopR_asset_fetch")
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = list(body = aba_text("match_6_25_1.html"),
                                                          url = "https://example.com/match/6/25/1/Overview"))))
  expect_error(aba_game(game_no = 6, season = 2026), "redirected off", class = "hoopR_asset_fetch")
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = list(body = aba_text("match_6_25_1.html"),
                                                          url = paste0(ABA_WWW, "/news/")))))
  expect_error(aba_game(game_no = 6, season = 2026), "not the page asked for", class = "hoopR_asset_fetch")
})

test_that("a match page for another game, season or league is refused", {
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = aba_text("match_1_8_1.html"))))
  expect_error(aba_game(game_no = 6, season = 2026), "out of scope", class = "hoopR_asset_fetch")
  lea <- aba_mutate_match(function(h) sub('value="1" id="match_data_lea"', 'value="2" id="match_data_lea"', h, fixed = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = lea)))
  expect_error(aba_game(game_no = 6, season = 2026), "match_data_lea", class = "hoopR_asset_fetch")
  sez <- aba_mutate_match(function(h) sub('value="25" id="match_data_sez"', 'value="24" id="match_data_sez"', h, fixed = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = sez)))
  expect_error(aba_game(game_no = 6, season = 2026), "match_data_sez", class = "hoopR_asset_fetch")
  foreign <- aba_mutate_match(function(h) {
    for (i in 1:3) h <- sub("/25/1/", "/24/1/", h, fixed = TRUE)
    h
  })
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = foreign)))
  expect_error(aba_box_players(game_no = 6, season = 2026), class = "hoopR_asset_fetch")
})

test_that("an unfinished game, unbalanced periods, a live pbp and layout drift are refused", {
  unplayed <- aba_mutate_match(function(h) sub('(?s)(<td class="gameScore">).*?(</td>)', "\\1 : \\2", h, perl = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = unplayed)))
  expect_error(aba_game(game_no = 6, season = 2026), "not finished", class = "hoopR_asset_fetch")
  broken <- aba_mutate_match(function(h) sub("<td>31:21</td>", "<td>30:21</td>", h, fixed = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = broken)))
  expect_error(aba_periods(game_no = 6, season = 2026), "not final", class = "hoopR_asset_fetch")
  live <- aba_mutate_match(function(h) gsub("game finished", "game running", h, fixed = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = live)))
  expect_error(aba_pbp(game_no = 6, season = 2026), "game finished", class = "hoopR_asset_fetch")
  for (body in c("", "   ", "<html><body>maintenance</body></html>", "not html at all")) {
    aba_mock(aba_pages(list("/match/6/25/1/Overview" = body)))
    expect_error(aba_game(game_no = 6, season = 2026), class = "hoopR_asset_fetch")
  }
  drift <- aba_mutate_match(function(h) gsub(">Rebs<", ">Rebz<", h, fixed = TRUE))
  aba_mock(aba_pages(list("/match/6/25/1/Overview" = drift)))
  expect_error(aba_box_players(game_no = 6, season = 2026), "header drift", class = "hoopR_asset_fetch")
})

test_that("calendar, standings and player pages: scope, unknown season and balance checks", {
  aba_mock(aba_pages(list("/calendar/8/1/" = aba_text("calendar_25_1.html"))))
  expect_error(aba_calendar(season = 2009), "outside the season", class = "hoopR_asset_fetch")
  aba_mock(aba_pages(list("/standings/8/1/" = aba_text("standings_25_1.html"))))
  expect_error(aba_standings(season = 2009), "outside", class = "hoopR_asset_fetch")
  empty <- '<html><select id="season"><option value="25/1/">Season 2025/26</option></select><section id="main_content"></section></html>'
  aba_mock(aba_pages(list("/calendar/99/1/" = empty, "/standings/99/1/" = empty)))
  expect_error(aba_calendar(season = 2100), "no season", class = "hoopR_no_data")
  expect_error(aba_standings(season = 2100), "no season", class = "hoopR_no_data")
  for (kind in c("calendar", "standings")) {
    html <- sub('value="25/1/" selected', 'value="24/1/" selected', aba_text(paste0(kind, "_25_1.html")), fixed = TRUE)
    aba_mock(aba_pages(stats::setNames(list(html), paste0("/", kind, "/25/1/"))))
    fn <- if (kind == "calendar") aba_calendar else aba_standings
    expect_error(fn(season = 2026), "out of scope: season", class = "hoopR_asset_fetch")
  }
  html <- aba_text("standings_25_1.html")
  start <- regexpr("Regular Season", html, fixed = TRUE)
  tail_ <- substring(html, start)
  from <- regexpr("<tbody>", tail_, fixed = TRUE)
  row <- regmatches(substring(tail_, from), regexpr('(?s)<tr class="standings[^>]*>(?:(?!</tr>).)*</tr>',
                                                    substring(tail_, from), perl = TRUE))
  expect_length(row, 1L)
  lost <- paste0(substr(html, 1, start - 1), sub(row, "", tail_, fixed = TRUE))
  aba_mock(aba_pages(list("/standings/25/1/" = lost)))
  expect_error(aba_standings(season = 2026), "balance|games != wins", class = "hoopR_asset_fetch")
  other <- sub("4807/25/1/carlik-jones/", "4808/25/1/carlik-jones/", aba_text("player_4807_25_1.html"), fixed = TRUE)
  aba_mock(aba_pages(list("/player/4807/25/1/" = other)))
  expect_error(aba_player(player_id = 4807, season = 2026), "out of scope", class = "hoopR_asset_fetch")
})

test_that("helpers fetch the match page first, then the helper with id / sez / lea", {
  log <- aba_mock()
  expect_identical(nrow(aba_shots(game_no = 6, season = 2026)), 152L)
  expect_identical(aba_urls(log), c(paste0(ABA_WWW, "/match/6/25/1/Overview"),
                                    paste0(ABA_WWW, ABA_LIVE, "/create_shooting_chart.php")))
  expect_identical(log$calls[[2]]$query, list(id = 6L, sez = 25L, lea = 1L))
  flow <- aba_score_flow(game_no = 6, season = 2026)
  diff <- aba_score_difference(game_no = 6, season = 2026)
  expect_identical(c(nrow(flow), nrow(diff)), c(46L, 46L))
  for (col in names(flow)) expect_identical(flow[[col]], diff[[col]], info = col)
  rec <- hoopR:::.aba_fetch("score_flow", list(game_no = 6, season = 2026, league = "aba"), rlang::current_env())
  expect_identical(names(rec), c("rows", "_request"))
  expect_identical(rec[["_request"]]$kind, "flow")
})

test_that("a helper with no data is hoopR_no_data; a body for another game is refused", {
  for (body in c("", "\n\n  \n", "[]\n\n")) {
    aba_mock(aba_pages(list("/live-match/rezultati-1718/create_shooting_chart.php" = body)))
    expect_error(aba_shots(game_no = 6, season = 2026), "2017-18", class = "hoopR_no_data")
  }
  aba_mock(aba_pages(list("/live-match/rezultati-1718/create_scoredifference.php" = aba_text("create_scoredifference_unknown.json"))))
  expect_error(aba_score_difference(game_no = 6, season = 2026), "out of scope", class = "hoopR_asset_fetch")
  wrong <- aba_read("create_json_6_25_1.json")
  wrong[[length(wrong)]]$domaci_rez <- "99"
  aba_mock(aba_pages(list("/live-match/rezultati-1718/create_json.php" = jsonlite::toJSON(wrong, auto_unbox = TRUE))))
  expect_error(aba_score_flow(game_no = 6, season = 2026), "final", class = "hoopR_asset_fetch")
  shots <- aba_read("create_shooting_chart_6_25_1.json")
  rematch <- lapply(shots, function(s) {
    if (s$player_id != "0") s$player_id <- "999999"
    s
  })
  aba_mock(aba_pages(list("/live-match/rezultati-1718/create_shooting_chart.php" = jsonlite::toJSON(rematch, auto_unbox = TRUE))))
  expect_error(aba_shots(game_no = 6, season = 2026), "not in the", class = "hoopR_asset_fetch")
  aba_mock(aba_pages(list("/live-match/rezultati-1718/create_shooting_chart.php" = jsonlite::toJSON(shots[1:100], auto_unbox = TRUE))))
  expect_error(aba_shots(game_no = 6, season = 2026), "shots / ", class = "hoopR_asset_fetch")
  for (body in c("<html>error</html>", '{"error": "x"}', "[1, 2]")) {
    aba_mock(aba_pages(list("/live-match/rezultati-1718/create_json.php" = body)))
    expect_error(aba_score_flow(game_no = 6, season = 2026), class = "hoopR_asset_fetch")
  }
  match <- hoopR:::.aba_record_for("match", aba_text("match_6_25_1.html"), ABA_M6)
  expect_null(hoopR:::.aba_helper_scope_error("shots", aba_read("create_shooting_chart_6_25_1.json"), match))
  expect_null(hoopR:::.aba_helper_scope_error("flow", aba_read("create_json_6_25_1.json"), match))
})

# ------------------------------------------------------------------ live

test_that("live: a finished 2025-26 game and its helper (HOOPR_INTL_LIVE_TESTS=1)", {
  skip_intl_live()
  game <- aba_game(game_no = 6, season = 2026)
  expect_identical(c(game$home_score, game$away_score), c(93L, 97L))
  flow <- aba_score_flow(game_no = 6, season = 2026)
  expect_identical(nrow(flow), 46L)
  expect_identical(names(aba_calendar(season = 2026)), names(hoopR:::.ABA_SPECS$calendar))
})
