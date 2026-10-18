# Offline tests of the P. LEAGUE+ family (R/pleague.R, R/pleague_utils.R). Fixtures and the parity CSVs come
# from sdv-py (see fixtures/pleague/README.md). Requests are answered by httr2::local_mocked_responses() through
# the real transport (.intl_response() / .intl_perform(), on a fake clock), so the status vocabulary, the retry
# policy, the redirect rule and every refusal run for real. Live checks at the bottom (HOOPR_INTL_LIVE_TESTS=1).

# one-line condition messages, so the expected-message regexes see no wrapping
withr::local_options(list(cli.width = 400), .local_envir = testthat::teardown_env())

PL_UUID <- "e6f98675-3e5b-11ed-949e-5d17350689cf"
PL_UUID_206 <- "e74f5828-3e5b-11ed-899b-5d17350689cf"

pl_fx <- function(...) testthat::test_path("fixtures", "pleague", ...)
# a fixture's exact text (".gz" found when the plain file is absent)
pl_text <- function(rel) {
  path <- pl_fx(rel)
  if (!file.exists(path)) path <- paste0(path, ".gz")
  raw <- readBin(path, "raw", file.size(path))
  if (endsWith(path, ".gz")) raw <- memDecompress(raw, "gzip")
  txt <- rawToChar(raw)
  Encoding(txt) <- "UTF-8"
  txt
}
pl_json <- function(rel) jsonlite::parse_json(pl_text(rel), simplifyVector = FALSE)
pl_dump <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
pl_cases <- jsonlite::read_json(pl_fx("parity", "cases.json"), simplifyVector = FALSE)

PL_PAGES <- c(
  "/game/197" = "site/game_197.html", "/game/13" = "site/game_13.html", "/game/206" = "site/game_206.html",
  "/schedule-regular-season/2022-23" = "site/schedule_regular_2022-23.html",
  "/schedule-finals/2022-23" = "site/schedule_finals_2022-23.html",
  "/schedule-regular-season/2020-21" = "site/schedule_regular_2020-21.html",
  "/standings/2022-23" = "site/standings_2022-23.html", "/stat-player/2022-23/2" = "site/stat_player_2022-23_2.html",
  "/player/1JbPozLB" = "site/player_1JbPozLB.html", "/player/1P42uoZg" = "site/player_1P42uoZg.html"
)
PL_VENDOR <- c("/v1/chart-data/id/" = "vendor/chart_data_197.json", "/post/game/summary/o/plg/gameId/" = "vendor/summary_197.json",
               "/game/rotation/chart/o/plg/gameId/" = "vendor/rotation_197.json",
               "/game/injury/list/o/plg/gameId/" = "vendor/injury_197.json")
HTML <- "text/html; charset=UTF-8"
JSON <- "application/json; charset=utf-8"

# What the fake hosts answer: a body text, or list(status =, body =, type =, headers =, url =); NULL = HTTP 404.
pl_answer <- function(path, query, overrides) {
  if (!is.null(overrides[[path]])) {
    o <- overrides[[path]]
    return(if (is.function(o)) o(query) else o)
  }
  if (path == "/api/boxscore.preciser.php") {
    f <- sprintf("site/box_%s.json", query$id)
    if (!file.exists(pl_fx(f)) && !file.exists(pl_fx(paste0(f, ".gz")))) return(NULL)
    return(list(body = pl_text(f), type = HTML))
  }
  if (path == "/api/playbyplay.php") {
    f <- c(stats::setNames("site/pbp_197.json", PL_UUID), stats::setNames("site/pbp_206.json", PL_UUID_206))[query$uuid]
    return(if (is.na(f)) NULL else list(body = pl_text(f), type = "application/json"))
  }
  if (path %in% names(PL_PAGES)) return(list(body = pl_text(PL_PAGES[[path]]), type = HTML))
  for (route in names(PL_VENDOR)) {
    if (path == paste0(route, PL_UUID)) return(list(body = pl_text(PL_VENDOR[[route]]), type = JSON))
  }
  NULL
}

# Mock both hosts at httr2 and the throttle clock; returns the request log (and the recorded sleeps).
local_pleague <- function(overrides = list(), env = parent.frame()) {
  .pleague_clear_cache()
  withr::defer(.pleague_clear_cache(), envir = env)
  log <- new.env()
  log$reqs <- list()
  log$sleeps <- numeric()
  log$now <- 1000
  # the fake clock's slots must not outlive the mock: the real clock would sleep until them
  local_intl_clock(env)
  testthat::local_mocked_bindings(
    .intl_sleep = function(seconds) {
      log$sleeps <- c(log$sleeps, seconds)
      log$now <- log$now + seconds
    },
    .intl_now = function() log$now,
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    u <- httr2::url_parse(req$url)
    log$reqs[[length(log$reqs) + 1L]] <- list(url = req$url, host = u$hostname, path = u$path,
                                              query = u$query %||% list(), req = req)
    r <- pl_answer(u$path, u$query %||% list(), overrides)
    if (is.null(r)) r <- list(status = 404L, body = "not found", type = "text/html")
    if (!is.list(r)) r <- list(body = r)
    if (isTRUE(r$fail)) stop("secret-host-detail")
    httr2::response(status_code = r$status %||% 200L, url = r$url %||% req$url,
                    headers = c(list(`Content-Type` = r$type %||% HTML), r$headers),
                    body = charToRaw(enc2utf8(r$body %||% "")))
  }, env = env)
  log
}
pl_paths <- function(log) vapply(log$reqs, `[[`, "", "path")

pl_mutate <- function(rel, fn) {
  out <- fn(pl_text(rel))
  stopifnot(!identical(out, pl_text(rel)))
  out
}
pl_box_with <- function(fn) {
  b <- pl_json("site/box_197.json")
  pl_dump(fn(b))
}
pl_vendor_with <- function(rel, fn) {
  b <- pl_json(rel)
  b[[1]] <- fn(b[[1]])
  pl_dump(b)
}

# cells that differ, NA-vs-value counted as a mismatch
pl_mismatches <- function(got, want_chr) {
  if (is.logical(got)) {
    want <- ifelse(is.na(want_chr), NA, want_chr == "true")
  } else if (is.numeric(got)) {
    want <- suppressWarnings(as.numeric(want_chr))
  } else {
    want <- want_chr
  }
  got_v <- if (inherits(got, "Date")) format(got) else got
  na_diff <- is.na(got_v) != is.na(want)
  both <- !is.na(got_v) & !is.na(want)
  val_diff <- if (is.double(got_v)) abs(got_v[both] - want[both]) > 1e-9 else got_v[both] != want[both]
  sum(na_diff) + sum(val_diff)
}
pl_read_parity <- function(name) {
  path <- pl_fx("parity", paste0(name, ".csv"))
  # a path, not a re-encoding connection (which breaks in a C locale); read.csv reads the gzip too
  if (!file.exists(path)) path <- paste0(path, ".gz")
  utils::read.csv(path, colClasses = "character", na.strings = "<null>", check.names = FALSE, encoding = "UTF-8")
}
PL_RTYPE <- c(Int64 = "integer", String = "character", Float64 = "numeric", Boolean = "logical", Date = "Date")
pl_types <- function(df) vapply(df, function(x) if (is.double(x) && !inherits(x, "Date")) "numeric" else class(x)[[1]], "")
pl_query <- function(q) if (length(q)) lapply(q, as.character)[order(names(q))] else list()

# ------------------------------------------------------------------ parity

test_that("every wrapper matches sdv-py's frame on the same fixtures (columns, dtypes, cells, requests)", {
  wrappers <- grep("^pleague_", getNamespaceExports("hoopR"), value = TRUE)
  expect_setequal(unique(vapply(pl_cases, `[[`, "", "fn")), wrappers)
  expect_length(wrappers, 19L)
  for (name in names(pl_cases)) {
    c <- pl_cases[[name]]
    log <- local_pleague()
    got <- do.call(c$fn, c$args)
    want <- pl_read_parity(c$csv)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = name)
    expect_identical(nrow(got), as.integer(c$rows), label = name)
    expect_identical(nrow(got), nrow(want), label = name)
    expect_identical(pl_types(got), stats::setNames(unname(PL_RTYPE[unlist(c$dtypes)]), names(c$dtypes)), label = name)
    if ("action_en" %in% names(got) && any(got$action %in% c("ft_made", "ft_missed"))) {
      # documented divergence (R/pleague_utils.R `.PLEAGUE_ACTION_EN`): sdv-py e3d232e gives every free throw the
      # last phrase per code ("free throw 1 of 3 awarded, ..."); hoopR reads each row's own trip. Partitioned:
      # free-throw rows against the text derived from ft_number / ft_awarded, every other row against sdv-py.
      ft <- got$action %in% c("ft_made", "ft_missed")
      derived <- paste0("free throw ", got$ft_number[ft],
                        ifelse(is.na(got$ft_awarded[ft]), "", paste0(" of ", got$ft_awarded[ft], " awarded")),
                        ", ", sub("^ft_", "", got$action[ft]))
      expect_identical(got$action_en[ft], derived, label = name)
      expect_true(all(grepl("^free throw 1 of 3 awarded, ", want$action_en[ft])), label = name)
      if (name == "pbp_206") {
        expect_identical(got$action_en[ft], c("free throw 1 of 2 awarded, made", "free throw 2, made"))
      }
      want$action_en[ft] <- derived
    }
    bad <- vapply(names(got), function(n) pl_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(name, "mismatched columns"))
    # the same requests sdv-py sends, in the same order: URL and query
    want_reqs <- c$requests
    expect_identical(length(log$reqs), length(want_reqs), label = name)
    for (i in seq_along(want_reqs)) {
      r <- log$reqs[[i]]
      expect_identical(paste0("https://", r$host, r$path), want_reqs[[i]]$url, label = name)
      expect_identical(pl_query(r$query), pl_query(want_reqs[[i]]$query), label = name)
    }
  }
})

test_that("ids are integers, never stringified floats; uuids and page ids are character", {
  chr_ids <- c("person_id", "random_id", "player_page_id", "synergy_play_id", "video_uuid")
  for (short in setdiff(names(.PLEAGUE_SPECS), "team_crosswalk")) {
    spec <- .PLEAGUE_SPECS[[short]]
    ids <- grep("_id$", names(spec), value = TRUE)
    expect_true(all(spec[setdiff(ids, chr_ids)] == "integer"), label = short)
    expect_true(all(spec[intersect(ids, chr_ids)] == "character"), label = short)
  }
  for (name in c("box_players_197", "pbp_197", "stat_player_2023_2", "preciser_shots")) {
    local_pleague()
    c <- pl_cases[[name]]
    got <- do.call(c$fn, c$args)
    expect_false(any(grepl("^[0-9]+\\.0$", unlist(Filter(is.character, got)))), label = name)
  }
  local_pleague()
  box <- pleague_box_players(gid = 197)
  shots <- pleague_preciser_shots(uuid = PL_UUID)
  expect_true(all(stats::na.omit(shots$person_id) %in% box$person_id)) # box to shots on person_id
  expect_identical(sum(!box$played), 3L)
  expect_true(all(is.na(box$points[!box$played])))
  expect_identical(nrow(pleague_team_crosswalk()), 8L)
  expect_true(all(stats::na.omit(shots$team_uuid) %in% pleague_team_crosswalk()$team_uuid))
})

test_that("an empty or malformed payload parses to a typed zero-row tibble", {
  bad <- list(list(), NULL, "x", 7L, list(data = NULL), list(games = list()), list(events = "x"),
              list(teams = list(1L, 2L)), list(data = list(home = "x")))
  for (short in names(.PLEAGUE_PARSERS)) {
    for (b in bad) {
      got <- .pleague_parse(short, b)
      expect_identical(nrow(got), 0L, label = short)
      expect_identical(names(got), names(.PLEAGUE_SPECS[[short]]), label = short)
      want <- ifelse(.PLEAGUE_SPECS[[short]] == "double", "numeric", .PLEAGUE_SPECS[[short]])
      expect_identical(unname(pl_types(got)), unname(want), label = short)
    }
  }
})

test_that("the play-by-play vocabulary is the 82 observed phrases plus the unlabelled row", {
  tab <- .pleague_action_table()
  expect_identical(nrow(tab), 83L)
  expect_identical(sum(tab$events), 258183L)
  expect_identical(length(.PLEAGUE_ACTIONS$code), 82L)
  expect_identical(tab$events[tab$action_zh == "\u6436\u5230\u9632\u5b88\u7c43\u677f"], 29537L)
  expect_identical(tab$action[tab$action_zh == "\u704c\u7c43\u5f97\u5206"], "fg2_dunk_made")
  expect_identical(tab$action[!nzchar(tab$action_zh)], "unlabelled")
  rec <- .pleague_pbp_record(pl_json("site/pbp_206.json"))
  fts <- Filter(function(e) !is.na(e$ft_number), rec$events)
  expect_true(length(fts) > 0L && all(vapply(fts, `[[`, 1L, "ft_number") %in% 1:3))
  expect_false(grepl("key=", pl_dump(rec), fixed = TRUE))
})

# ------------------------------------------------------------------ seasons and arguments

test_that("the season END year maps to the site's slug; earlier or garbage seasons are refused", {
  for (case in list(c(2025, "2024-25"), c(2021, "2020-21"), c(2027, "2026-27"), c(2100, "2099-00"))) {
    expect_identical(.pleague_season_slug(as.numeric(case[1])), case[2])
  }
  expect_identical(.pleague_season_slug("2023"), "2022-23")
  for (bad in list(2020, 1999, 0)) expect_error(.pleague_season_slug(bad), "first season", class = "hoopR_no_data")
  for (bad in list("x", NULL, 2025.5, TRUE, -1, "", NA)) expect_error(.pleague_season_slug(bad), class = "hoopR_bad_request")
  log <- local_pleague()
  pleague_standings(season = 2023)
  expect_identical(pl_paths(log), "/standings/2022-23")
})

test_that("argument checks happen before any request", {
  log <- local_pleague()
  expect_error(pleague_schedule(season = 2023, stage = "exhibition"), "stage must", class = "hoopR_bad_request")
  expect_error(pleague_schedule(season = 2023, stage = NULL), "stage must", class = "hoopR_bad_request")
  expect_error(pleague_stat_player(season = 2023, stage_sn = 9), "stage_sn", class = "hoopR_bad_request")
  expect_error(pleague_player(player_page_id = "a b"), "player_page_id", class = "hoopR_bad_request")
  expect_error(pleague_game(gid = "abc"), "gid", class = "hoopR_bad_request")
  expect_error(pleague_box_players(gid = 1.5), "gid", class = "hoopR_bad_request")
  expect_error(pleague_standings(season = 2019), "first season", class = "hoopR_no_data")
  expect_error(pleague_preciser_shots(uuid = "197"), "uuid must be", class = "hoopR_bad_request")
  expect_error(pleague_preciser_shots(uuid = PL_UUID, gid = "x"), "gid", class = "hoopR_bad_request")
  expect_length(log$reqs, 0L)
})

# ------------------------------------------------------------------ site transport

test_that("wrappers build the site's URLs; the game page is fetched once and shared", {
  log <- local_pleague()
  expect_identical(nrow(pleague_game(gid = 197)), 1L)
  expect_identical(nrow(pleague_periods(gid = 197)), 4L)
  expect_identical(nrow(pleague_box_players(gid = 197)), 26L)
  expect_identical(nrow(pleague_box_teams(gid = 197)), 2L)
  expect_true(nrow(pleague_pbp(gid = 197)) > 10L)
  expect_identical(pl_paths(log), c("/game/197", "/api/boxscore.preciser.php", "/api/playbyplay.php"))
  req <- log$reqs[[1]]$req
  expect_match(req$headers$`User-Agent`, "^Mozilla/5.0")
  expect_identical(req$options$followlocation, 0L) # redirects are never followed
  expect_identical(nrow(pleague_schedule(season = 2023, stage = "finals")), 6L)
  expect_identical(pl_paths(log)[4], "/schedule-finals/2022-23")
})

test_that("status codes follow the error vocabulary; a redirect is no data", {
  local_pleague(list("/game/197" = list(status = 404L, body = "x")))
  expect_error(pleague_game(gid = 197), "404", class = "hoopR_no_data")
  local_pleague(list("/game/197" = list(status = 422L, body = "x")))
  expect_error(pleague_game(gid = 197), "422", class = "hoopR_bad_request")
  local_pleague(list("/game/197" = list(status = 403L, body = "<html>Just a moment</html>")))
  err <- expect_error(pleague_game(gid = 197), "403", class = "hoopR_asset_fetch")
  expect_false(err$transient)
  local_pleague(list("/game/999999" = list(status = 302L, body = "", headers = list(Location = "/"))))
  expect_error(pleague_game(gid = 999999), "redirected to /", class = "hoopR_no_data")
  local_pleague(list("/standings/2022-23" = list(status = 302L, body = "",
                                                 headers = list(Location = "https://pleagueofficial.com/standings"))))
  expect_error(pleague_standings(season = 2023), "redirected to /standings", class = "hoopR_no_data")
})

test_that("429 / 503 are retried (Retry-After honoured); 500 is not; a dead connection names no detail", {
  log <- local_pleague(list("/game/197" = list(status = 503L, body = "busy", headers = list(`Retry-After` = "7"))))
  err <- expect_error(pleague_game(gid = 197), "503", class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(log$reqs, 3L)
  expect_true(max(log$sleeps) >= 7)
  n <- 0L
  log <- local_pleague(list("/game/197" = function(q) {
    n <<- n + 1L
    if (n == 1L) list(status = 429L, body = "slow", headers = list(`Retry-After` = "3")) else
      list(body = pl_text("site/game_197.html"), type = HTML)
  }))
  expect_identical(nrow(pleague_game(gid = 197)), 1L)
  expect_length(log$reqs, 2L)
  expect_true(max(log$sleeps) >= 3)
  log <- local_pleague(list("/api/boxscore.preciser.php" = list(status = 500L, body = "")))
  expect_error(pleague_box_players(gid = 197), "500", class = "hoopR_asset_fetch")
  expect_identical(sum(pl_paths(log) == "/api/boxscore.preciser.php"), 1L)
  log <- local_pleague(list("/game/197" = list(fail = TRUE)))
  err <- expect_error(pleague_game(gid = 197), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(log$reqs, 3L)
})

test_that("a page for another game, an unfinished game and layout drift are refused", {
  local_pleague(list("/game/197" = pl_text("site/game_206.html")))
  expect_error(pleague_game(gid = 197), "out of scope", class = "hoopR_asset_fetch")
  local_pleague(list("/game/197" = pl_mutate("site/game_197.html", function(h) gsub("\u5df2\u5b8c\u8cfd", "\u672a\u958b\u8cfd", h, fixed = TRUE))))
  expect_error(pleague_game(gid = 197), "not final", class = "hoopR_asset_fetch")
  for (body in list(pl_mutate("site/game_197.html", function(h) gsub("game_header", "game_hdr", h, fixed = TRUE)),
                    "<html><body>hello</body></html>")) {
    local_pleague(list("/game/197" = body))
    expect_error(pleague_game(gid = 197), "not the page asked for", class = "hoopR_asset_fetch")
  }
  local_pleague(list("/game/197" = "  "))
  expect_error(pleague_game(gid = 197), "empty body", class = "hoopR_asset_fetch")
  local_pleague(list("/game/197" = list(body = pl_text("site/game_197.html"), type = "application/json")))
  expect_error(pleague_game(gid = 197), "not HTML", class = "hoopR_asset_fetch")
})

test_that("schedule, standings, stat-player and player pages are scope checked; a missing stage is no data", {
  empty <- "<html><head><title>2022-23-\u4f8b\u884c\u8cfd\u8cfd\u7a0b\u2502P. LEAGUE+</title></head><body></body></html>"
  local_pleague(list("/schedule-regular-season/2022-23" = empty))
  expect_error(pleague_schedule(season = 2023), "zero games", class = "hoopR_no_data")
  for (other in c("site/schedule_regular_2020-21.html", "site/schedule_finals_2022-23.html")) {
    local_pleague(list("/schedule-regular-season/2022-23" = pl_text(other)))
    expect_error(pleague_schedule(season = 2023), "out of scope", class = "hoopR_asset_fetch")
  }
  local_pleague(list("/standings/2022-23" = gsub("2022-23", "2021-22", pl_text("site/standings_2022-23.html"), fixed = TRUE)))
  expect_error(pleague_standings(season = 2023), "out of scope", class = "hoopR_asset_fetch")
  local_pleague(list("/stat-player/2022-23/2" = pl_mutate("site/stat_player_2022-23_2.html", function(h) {
    gsub('value="2" selected', 'value="2"', h, fixed = TRUE)
  })))
  expect_error(pleague_stat_player(season = 2023, stage_sn = 2), "stage select", class = "hoopR_asset_fetch")
  local_pleague(list("/player/1P42uoZg" = pl_text("site/player_1JbPozLB.html")))
  expect_error(pleague_player(player_page_id = "1P42uoZg"), "out of scope", class = "hoopR_asset_fetch")
})

test_that("a box that is not the game's box is refused", {
  cases <- list(
    list(function(b) { b$data$score_home <- 103L; b }, "score"),
    list(function(b) { b$data$q2_away <- 99L; b }, "q2_away"),
    list(function(b) { b$data$ot1_home <- 7L; b }, "ot1_home"),
    list(function(b) { b$data$home[[1]]$points <- 40L; b }, "player points"),
    list(function(b) { b$data$home <- list(); b$data$away <- list(); b }, "no player rows"),
    list(function(b) { b$error <- "boom"; b }, "error field"),
    list(function(b) { b$data$home_total <- NULL; b }, "lacks"),
    list(function(b) { b$data <- list(); b }, "not an object")
  )
  for (case in cases) {
    local_pleague(list("/api/boxscore.preciser.php" = pl_box_with(case[[1]])))
    expect_error(pleague_box_players(gid = 197), case[[2]], class = "hoopR_asset_fetch")
  }
  local_pleague(list("/api/boxscore.preciser.php" = "<html>nope</html>"))
  expect_error(pleague_box_players(gid = 197), "not JSON", class = "hoopR_asset_fetch")
})

test_that("a play-by-play that is not the game's is refused; 2020-21 has a box but no play-by-play", {
  pbp_with <- function(fn) {
    b <- pl_json("site/pbp_197.json")
    out <- fn(b$data)
    stopifnot(!identical(out, b$data))
    b$data <- out
    pl_dump(b)
  }
  cases <- list(
    list(function(h) sub("94 - 102", "94 - 103", h, fixed = TRUE), "final"),
    list(function(h) gsub("\u52a9\u653b", "\u795e\u79d8\u653bX", h, fixed = TRUE), "unknown play-by-play phrase"),
    list(function(h) gsub("pbplay", "pbplayx", h, fixed = TRUE), "pbplay table"),
    list(function(h) substr(h, 1, regexpr('<tr class="all-tr quater-tr">', h, fixed = TRUE) - 1L), "truncated"),
    list(function(h) gsub('(?s)<tr class="Q4-tr quater-tr">.*?</tr>', "", h, perl = TRUE), "period")
  )
  for (case in cases) {
    local_pleague(list("/api/playbyplay.php" = list(body = pbp_with(case[[1]]), type = "application/json")))
    expect_error(pleague_pbp(gid = 197), case[[2]], class = "hoopR_asset_fetch")
  }
  local_pleague(list("/api/playbyplay.php" = list(body = '{"error":"bad","data":""}', type = "application/json")))
  expect_error(pleague_pbp(gid = 197), "error field", class = "hoopR_asset_fetch")
  local_pleague()
  expect_error(pleague_pbp(gid = 13), "no play-by-play", class = "hoopR_no_data")
  expect_true(nrow(pleague_box_players(gid = 13)) > 0L)
  local_pleague()
  real <- .pleague_pbp_record
  local_mocked_bindings(.pleague_pbp_record = function(body) {
    rec <- real(body)
    rec$events[[1]]$text_zh <- paste0(rec$events[[1]]$text_zh, "?key=0123456789abcdef0123")
    rec
  }, .package = "hoopR")
  expect_error(pleague_pbp(gid = 197), "access key", class = "hoopR_asset_fetch")
})

# ------------------------------------------------------------------ the Preciser vendor

test_that("vendor statuses follow the vocabulary; 500 is not retried; [] and empty rotations are no data", {
  shots <- paste0("/v1/chart-data/id/", PL_UUID)
  summary <- paste0("/post/game/summary/o/plg/gameId/", PL_UUID)
  rotation <- paste0("/game/rotation/chart/o/plg/gameId/", PL_UUID)
  local_pleague(stats::setNames(list(list(status = 404L, body = "x")), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID), "404", class = "hoopR_no_data")
  local_pleague(stats::setNames(list(list(status = 422L, body = "x")), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID), "422", class = "hoopR_bad_request")
  local_pleague(stats::setNames(list(list(status = 403L, body = "x")), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID), "403", class = "hoopR_asset_fetch")
  log <- local_pleague(stats::setNames(list(list(status = 500L, body = "<html>err</html>")), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID), "500", class = "hoopR_asset_fetch")
  expect_length(log$reqs, 1L)
  local_pleague(stats::setNames(list(list(body = "[]", type = JSON)), summary))
  expect_error(pleague_preciser_summary_teams(uuid = PL_UUID), "\\[\\]", class = "hoopR_no_data")
  local_pleague(stats::setNames(list(list(body = '[{"awayTeam":[],"homeTeam":[]}]', type = JSON)), rotation))
  expect_error(pleague_preciser_rotation(uuid = PL_UUID), "empty rotation", class = "hoopR_no_data")
})

test_that("non-JSON, wrong-shape and off-host vendor answers are refused", {
  shots <- paste0("/v1/chart-data/id/", PL_UUID)
  for (case in list(list(list(body = "<html>", type = "text/html"), "not JSON"),
                    list(list(body = "not json{", type = JSON), "not JSON"),
                    list(list(body = "{}", type = JSON), "one-element list"),
                    list(list(body = "[1]", type = JSON), "one-element list"),
                    list(list(body = "[{}]", type = JSON, url = "https://example.com/v1"), "off the Preciser host"))) {
    local_pleague(stats::setNames(list(case[[1]]), shots))
    expect_error(pleague_preciser_shots(uuid = PL_UUID), case[[2]], class = "hoopR_asset_fetch")
  }
})

test_that("a vendor body that is not this game's is refused", {
  cases <- list(
    list("summary_teams", "vendor/summary_197.json", function(b) { b$game_id <- "00000000-0000-0000-0000-000000000000"; b }, "game_id"),
    list("summary_teams", "vendor/summary_197.json", function(b) { b$pbp <- list(); b }, "play log is empty"),
    list("summary_teams", "vendor/summary_197.json", function(b) { b$home_team$id <- NULL; b }, "team id is missing"),
    list("injury", "vendor/injury_197.json", function(b) { b$game_id <- "x"; b }, "game_id"),
    list("shots", "vendor/chart_data_197.json", function(b) { b$game_status <- "live"; b }, "not post"),
    list("shots", "vendor/chart_data_197.json", function(b) { b$shot[[1]]$player <- "nobody"; b }, "names a player")
  )
  routes <- c(summary_teams = "/post/game/summary/o/plg/gameId/", injury = "/game/injury/list/o/plg/gameId/",
              shots = "/v1/chart-data/id/")
  for (case in cases) {
    local_pleague(stats::setNames(list(list(body = pl_vendor_with(case[[2]], case[[3]]), type = JSON)),
                                  paste0(routes[[case[[1]]]], PL_UUID)))
    expect_error(do.call(paste0("pleague_preciser_", case[[1]]), list(uuid = PL_UUID)), case[[4]], class = "hoopR_asset_fetch")
  }
})

test_that("the vendor access key is scrubbed from the body; a survivor is refused", {
  key <- "0123456789abcdef0123456789abcdef"
  body <- pl_vendor_with("vendor/chart_data_197.json", function(b) {
    b$shot[[1]]$video_url <- paste0("https://c/v.mp4?key=", key)
    b
  })
  local_pleague(stats::setNames(list(list(body = body, type = JSON)), paste0("/v1/chart-data/id/", PL_UUID)))
  raw <- .pleague_vendor_fetch("shots", PL_UUID, NULL, rlang::current_env())
  expect_false(grepl(key, pl_dump(raw), fixed = TRUE))
  expect_match(raw$data$shot[[1]]$video_url, "\\?key=<redacted>$")
  expect_identical(raw[["_request"]], list(kind = "shots", uuid = PL_UUID, verified = FALSE, gid = NULL))
  local_mocked_bindings(.pleague_scrub = function(obj) obj, .package = "hoopR")
  expect_error(pleague_preciser_shots(uuid = PL_UUID), "access key survived", class = "hoopR_asset_fetch")
})

test_that("verified mode checks the vendor body against the site's game page and box", {
  log <- local_pleague()
  expect_identical(nrow(pleague_preciser_shots(uuid = PL_UUID, gid = 197)), 168L)
  expect_identical(pl_paths(log), c("/game/197", "/api/boxscore.preciser.php",
                                    paste0("/post/game/summary/o/plg/gameId/", PL_UUID),
                                    paste0("/v1/chart-data/id/", PL_UUID)))
  expect_identical(nrow(pleague_preciser_rotation(uuid = PL_UUID, gid = 197)), 101L)
  expect_identical(nrow(pleague_preciser_injury(uuid = PL_UUID, gid = 197)), 2L)
  local_pleague()
  expect_error(pleague_preciser_shots(uuid = PL_UUID, gid = 206), "has uuid", class = "hoopR_asset_fetch")
  shots <- paste0("/v1/chart-data/id/", PL_UUID)
  summary <- paste0("/post/game/summary/o/plg/gameId/", PL_UUID)
  injury <- paste0("/game/injury/list/o/plg/gameId/", PL_UUID)
  rotation <- paste0("/game/rotation/chart/o/plg/gameId/", PL_UUID)
  miss <- pl_vendor_with("vendor/chart_data_197.json", function(b) {
    i <- which(vapply(b$shot, function(s) isTRUE(s$success) && identical(s$type, "2pt"), TRUE))[1]
    b$shot[[i]]$success <- FALSE
    b
  })
  local_pleague(stats::setNames(list(list(body = miss, type = JSON)), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID, gid = 197), "made 2pt/3pt", class = "hoopR_asset_fetch")
  expect_identical(nrow(pleague_preciser_shots(uuid = PL_UUID)), 168L) # unverified: the body alone passes
  off <- pl_vendor_with("vendor/summary_197.json", function(b) {
    b$pbp[[length(b$pbp)]]$home_score <- 1L
    b
  })
  local_pleague(stats::setNames(list(list(body = off, type = JSON)), summary))
  expect_error(pleague_preciser_summary_teams(uuid = PL_UUID, gid = 197), "final score", class = "hoopR_asset_fetch")
  teams <- pl_vendor_with("vendor/chart_data_197.json", function(b) {
    b$home_id <- "x"
    b
  })
  local_pleague(stats::setNames(list(list(body = teams, type = JSON)), shots))
  expect_error(pleague_preciser_shots(uuid = PL_UUID, gid = 197), "home_id / away_id", class = "hoopR_asset_fetch")
  inj <- pl_vendor_with("vendor/injury_197.json", function(b) {
    b$home_team$id <- "x"
    b
  })
  local_pleague(stats::setNames(list(list(body = inj, type = JSON)), injury))
  expect_error(pleague_preciser_injury(uuid = PL_UUID, gid = 197), "team ids differ", class = "hoopR_asset_fetch")
  stranger <- pl_vendor_with("vendor/rotation_197.json", function(b) {
    b$homeTeam[[1]]$name <- "nobody"
    b
  })
  local_pleague(stats::setNames(list(list(body = stranger, type = JSON)), rotation))
  expect_error(pleague_preciser_rotation(uuid = PL_UUID, gid = 197), "not on the home box roster", class = "hoopR_asset_fetch")
  long <- pl_vendor_with("vendor/rotation_197.json", function(b) {
    b$homeTeam[[1]]$periods[[1]]$endSeconds <- b$homeTeam[[1]]$periods[[1]]$endSeconds + 100L
    b
  })
  local_pleague(stats::setNames(list(list(body = long, type = JSON)), rotation))
  expect_error(pleague_preciser_rotation(uuid = PL_UUID, gid = 197), "on court", class = "hoopR_asset_fetch")
})

# ------------------------------------------------------------------ live

test_that("live: a finished game, its box and the vendor summary (HOOPR_INTL_LIVE_TESTS=1)", {
  skip_intl_live()
  .pleague_clear_cache()
  game <- pleague_game(gid = 197)
  expect_identical(c(game$away_score, game$home_score), c(94L, 102L))
  expect_identical(nrow(pleague_box_teams(gid = 197)), 2L)
  expect_identical(nrow(pleague_preciser_summary_teams(uuid = PL_UUID)), 2L)
})
