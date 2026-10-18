# Offline tests of the CBA family: R/cba.R, R/cba_runtime.R, R/cba_parsers.R. Every request is
# mocked through httr2 and answered with the fixture body ENCRYPTED under the public key, so the
# decrypt, the JSON bodies, the scope checks and the error vocabulary run end to end; sleeps are
# recorded, never slept. Parity: tests/testthat/fixtures/cba/parity/<wrapper>.csv is sdv-py's frame
# of the same wrapper on the same bodies (see fixtures/cba/README.md).

cba_fixture <- function(...) test_path("fixtures", "cba", ...)
cba_read <- function(name) {
  con <- if (endsWith(name, ".gz")) gzfile(cba_fixture(name), encoding = "UTF-8") else file(cba_fixture(name), encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}
cba_body <- function(name) jsonlite::parse_json(cba_read(name), simplifyVector = FALSE, bigint_as_char = TRUE)
CBA_ROUTES <- jsonlite::read_json(test_path("fixtures", "cba", "routes.json"))

# The wire form of a body: a JSON string literal holding base64 of AES-128-ECB / PKCS#7.
cba_encrypt <- function(x, key = .CBA_KEY) {
  text <- if (is.character(x)) x else as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
  raw <- charToRaw(enc2utf8(text))
  pad <- 16L - length(raw) %% 16L
  cipher <- digest::AES(charToRaw(key), mode = "ECB")$encrypt(c(raw, as.raw(rep(pad, pad))))
  paste0("\"", gsub("\n", "", jsonlite::base64_enc(cipher), fixed = TRUE), "\"")
}
cba_resp <- function(body, status = 200L, headers = list()) {
  text <- if (is.character(body) && length(body) == 1L && startsWith(body, "\"")) body else cba_encrypt(body)
  httr2::response(status, headers = c(list("Content-Type" = "application/json;charset=UTF-8"), headers),
                  body = charToRaw(text))
}
cba_route <- function(req) {
  path <- sub("^/api/", "", httr2::url_parse(req$url)$path)
  for (p in .CBA_PATH_ID) if (startsWith(path, paste0(p, "/"))) return(p)
  path
}

# The default server: every route answers its fixture; play-by-play answers the requested period.
cba_server <- function(overrides = list()) {
  function(req) {
    route <- cba_route(req)
    if (!is.null(overrides[[route]])) return(overrides[[route]](req))
    body <- cba_body(CBA_ROUTES[[route]])
    if (route == "schedule-eventses/filterPage") body <- body[[as.character(req$body$data$quarterNum)]]
    cba_resp(body)
  }
}

# Mock the transport; `seen` records every request and sleep. The caches, the throttle clock and
# every proxy setting are cleared, so the direct fast path is the one under test.
local_cba <- function(api = cba_server(), env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  seen$sleeps <- numeric()
  rm(list = ls(.intl_clock), envir = .intl_clock)
  rm(list = ls(.cba_cache), envir = .cba_cache)
  withr::defer(rm(list = ls(.cba_cache), envir = .cba_cache), envir = env)
  withr::local_envvar(c(CBA_PROXY = NA, CBA_DIRECT = NA), .local_envir = env)
  withr::local_options(list(hoopR.proxy = NULL, cli.width = 10000), .local_envir = env)
  local_mocked_bindings(
    .intl_sleep = function(seconds) seen$sleeps <- c(seen$sleeps, seconds),
    .intl_now = function() sum(seen$sleeps), # the clock moves only by what was slept
    .package = "hoopR", .env = env
  )
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    api(req)
  }, env = env)
  seen
}

CBA_RTYPE <- c(Int64 = "integer", Float64 = "numeric", Boolean = "logical", String = "character")
r_types <- function(df) vapply(df, function(x) if (is.double(x)) "numeric" else class(x)[[1]], character(1))

# cells that differ, NA-vs-value counted as a mismatch
parity_mismatches <- function(got, want_chr) {
  if (is.logical(got)) {
    want <- ifelse(is.na(want_chr), NA, want_chr == "true")
  } else if (is.numeric(got)) {
    want <- suppressWarnings(as.numeric(want_chr))
  } else {
    want <- want_chr
  }
  na_diff <- is.na(got) != is.na(want)
  both <- !is.na(got) & !is.na(want)
  val_diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 else got[both] != want[both]
  sum(na_diff) + sum(val_diff)
}

read_parity <- function(short) {
  name <- if (short == "pbp") "pbp.csv.gz" else paste0(short, ".csv")
  # a path, not a re-encoding connection: file() reads the gzip too, and encoding = marks UTF-8 in any locale
  utils::read.csv(cba_fixture("parity", name), colClasses = "character", na.strings = "<null>", check.names = FALSE, encoding = "UTF-8")
}

req_json <- function(x) {
  if (is.null(x)) return("null")
  as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
}

test_that("the real wire body decrypts to the match types; anything else is refused", {
  body <- .cba_decrypt_body(cba_read("wire_getMatchType.txt"))
  expect_true(all(c("1", "2", "3", "4", "9") %in% vapply(body, function(r) r$value, "")))
  obj <- list(a = list(1L, 2L, "\u4e2d\u6587"))
  expect_identical(.cba_decrypt_body(cba_encrypt(obj)), obj)
  wrong <- cba_encrypt(obj, key = "0123456789abcdef")
  for (bad in list('{"title":"x","status":500}', "", "not base64!", "\"abc", wrong, "\"QUJD\"")) {
    expect_error(.cba_decrypt_body(bad), class = "hoopR_cba_undecryptable", label = bad)
  }
})

test_that("every wrapper matches sdv-py's frame on the same bodies (columns, order, dtypes, cells, requests)", {
  dtypes <- jsonlite::read_json(cba_fixture("parity", "dtypes.json"))
  requests <- jsonlite::read_json(cba_fixture("parity", "requests.json"))
  wrappers <- grep("^cba_", getNamespaceExports("hoopR"), value = TRUE)
  expect_setequal(paste0("cba_", names(requests)), wrappers)
  expect_length(wrappers, 27L)
  for (short in names(requests)) {
    seen <- local_cba()
    got <- do.call(paste0("cba_", short), requests[[short]]$args)
    want <- read_parity(short)
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = short)
    expect_identical(nrow(got), nrow(want), label = short)
    want_types <- stats::setNames(unname(CBA_RTYPE[unlist(dtypes[[short]])]), names(dtypes[[short]]))
    if (short == "rosters") want_types[["id"]] <- "character" # 19-digit id: exact digits in R
    expect_identical(r_types(got), want_types, label = short)
    bad <- vapply(names(got), function(n) parity_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(names(bad)[bad > 0], character(), label = paste(short, "mismatched columns"))
    # the same requests sdv-py sends, in the same order: method, URL, query and JSON body
    want_reqs <- requests[[short]]$requests
    expect_identical(length(seen$reqs), length(want_reqs), label = short)
    for (i in seq_along(want_reqs)) {
      req <- seen$reqs[[i]]
      w <- want_reqs[[i]]
      expect_identical(if (is.null(req$body)) "GET" else "POST", w$method, label = short)
      expect_identical(sub("\\?.*$", "", req$url), w$url, label = short)
      q <- httr2::url_parse(req$url)$query %||% list()
      flat <- function(q) paste(names(q), unlist(q), sep = "=", collapse = "&")
      expect_identical(flat(q), flat(w$query), label = short)
      expect_identical(req_json(req$body$data), req_json(w$body), label = short)
      expect_identical(req$headers$Referer, "https://www.cbaleague.com/data/")
    }
  }
})

test_that("ids keep one type; the 19-digit roster id keeps its exact digits", {
  local_cba()
  box <- cba_player_box(schedule_id = 100105799)
  for (col in c("schedule_id", "player_id")) expect_type(box[[col]], "integer")
  expect_identical(unique(box$schedule_id), 100105799L)
  ros <- cba_rosters(schedule_id = 100105799)
  expect_type(ros$id, "character")
  expect_true(all(grepl("^[0-9]{19}$", ros$id)))
  expect_identical(ros$id, read_parity("rosters")$id)
  best <- cba_best_stats(schedule_id = 100105799) # a string on the wire, cast to the box's integer id
  expect_type(best$player_id, "integer")
  pbp <- cba_pbp(schedule_id = 100105799)
  expect_identical(nrow(pbp), 319L)
  expect_type(pbp$schedule_id, "integer")
})

test_that("an empty or malformed payload parses to a zero-row frame with the documented columns", {
  dtypes <- jsonlite::read_json(cba_fixture("parity", "dtypes.json"))
  expect_setequal(names(.cba_routes), names(.cba_dtypes))
  for (short in names(.cba_dtypes)) {
    for (payload in list(list(), stats::setNames(list(), character()), NULL, "x", list(1L, "a"),
                         list(records = list(), total = 0L))) {
      out <- .cba_frame(short, payload)
      expect_identical(nrow(out), 0L, label = short)
      expect_identical(names(out), names(.cba_dtypes[[short]]), label = short)
    }
    want <- stats::setNames(unname(CBA_RTYPE[unlist(dtypes[[short]])]), names(dtypes[[short]]))
    if (short == "rosters") want[["id"]] <- "character"
    expect_identical(r_types(out), want, label = short)
  }
  # a valid empty page through the wrapper is a zero-row tibble too
  local_cba(cba_server(list("player-base-list" = function(req) cba_resp(list(records = list(), total = 0L)))))
  out <- cba_player_base(season = 2026)
  expect_identical(nrow(out), 0L)
  expect_identical(names(out), names(.cba_dtypes$player_base))
})

test_that("season is the END year, sent as the START year; ids and seasons must be integers", {
  expect_identical(.cba_wire_season(2026), 2025L)
  expect_identical(.cba_wire_season("2026"), 2025L)
  for (bad in list(2026.5, "x", "20a6", TRUE, NA, c(2025, 2026), NULL, list(2026))) {
    expect_error(.cba_wire_season(bad), class = "hoopR_bad_request")
  }
  seen <- local_cba()
  expect_error(cba_game_info(schedule_id = "abc"), class = "hoopR_bad_request")
  expect_error(cba_player_box(schedule_id = 1.5), class = "hoopR_bad_request")
  expect_error(cba_team_counts(season = "2026-27"), class = "hoopR_bad_request")
  expect_error(cba_pbp(schedule_id = 100105799, quarter_num = "x"), class = "hoopR_bad_request")
  expect_length(seen$reqs, 0L) # every argument is checked before any request
  seen <- local_cba()
  cba_team_counts(season = 2026)
  expect_match(seen$reqs[[1]]$url, "season=2025$")
  out <- cba_player_base(season = 2026, team_id = 29128)
  expect_identical(unique(out$season), 2025L) # the wire START year, kept
  expect_identical(seen$reqs[[2]]$body$data$season, 2025L)
})

test_that("the error vocabulary matches sdv-py", {
  cases <- list(
    list(httr2::response(404), "hoopR_no_data", 404L),
    list(httr2::response(400), "hoopR_bad_request", 400L),
    list(httr2::response(422), "hoopR_bad_request", 422L),
    list(httr2::response(500, body = charToRaw('{"title":"x","status":500}')), "hoopR_asset_fetch", 500L),
    list(httr2::response(403), "hoopR_asset_fetch", 403L),
    list(httr2::response(201, body = charToRaw(cba_encrypt(list()))), "hoopR_asset_fetch", 201L)
  )
  for (cs in cases) {
    seen <- local_cba(function(req) cs[[1]])
    err <- expect_error(cba_teams(), class = cs[[2]], label = cs[[3]])
    expect_identical(err$status, cs[[3]])
    expect_length(seen$reqs, 1L) # 500 is never retried, nor is any other final status
  }
  err <- expect_error({local_cba(function(req) httr2::response(500)); cba_teams()}, class = "hoopR_asset_fetch")
  expect_false(err$transient)
  expect_match(conditionMessage(err), "not retried")
  # 200 bodies that are not an encrypted answer
  for (body in list(raw(), charToRaw("  "), charToRaw('{"title":"x","status":500}'), charToRaw("<html>x</html>"),
                    charToRaw(cba_encrypt(list(a = 1L), key = "0123456789abcdef")))) {
    local_cba(function(req) httr2::response(200, body = body))
    expect_error(cba_teams(), class = "hoopR_asset_fetch")
  }
  local_cba(function(req) httr2::response(200, body = charToRaw('{"title":"x"}')))
  expect_error(cba_teams(), "did not decrypt", class = "hoopR_asset_fetch")
})

test_that("429 / 502 / 503 / 504 are retried three times, spaced 2 s and 4 s or Retry-After", {
  seen <- local_cba(function(req) httr2::response(503))
  err <- expect_error(cba_teams(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(seen$reqs, 3L)
  expect_identical(seen$sleeps, c(2, 4)) # the backoff already spaces past the 1 s throttle
  n <- 0L
  seen <- local_cba(function(req) {
    n <<- n + 1L
    if (n == 1L) httr2::response(429, headers = list("Retry-After" = "7")) else cba_resp(cba_body("teams.json"))
  })
  expect_identical(nrow(cba_teams()), 3L)
  expect_identical(seen$sleeps, 7)
})

test_that("a connection refused at connect fails fast without a proxy; anything else is retried", {
  refused <- function(req) {
    stop(structure(class = c("curl_error_couldnt_connect", "error", "condition"),
                   list(message = "Failed to connect to host port 443: Couldn't connect to server", call = NULL)))
  }
  seen <- local_cba(refused)
  err <- expect_error(cba_teams(), class = "hoopR_asset_fetch")
  expect_true(err$transient)
  expect_length(seen$reqs, 1L)
  expect_match(conditionMessage(err), "on the first attempt.*CBA_PROXY")
  expect_identical(seen$reqs[[1]]$options$connecttimeout, 5)
  seen <- local_cba(function(req) stop("connection reset by peer"))
  expect_error(cba_teams(), "after 3 attempts", class = "hoopR_asset_fetch")
  expect_length(seen$reqs, 3L)
  # CBA_DIRECT=1: direct, the full timeout and retries
  seen <- local_cba(refused)
  withr::local_envvar(CBA_DIRECT = "1")
  expect_error(cba_teams(), class = "hoopR_asset_fetch")
  expect_length(seen$reqs, 3L)
  expect_identical(seen$reqs[[1]]$options$connecttimeout, 0)
})

test_that("a proxy is used, retried like a direct request, and never printed", {
  secret <- "http://user:hunter2@proxy.invalid:10001"
  seen <- local_cba(function(req) stop(paste("could not reach", secret)))
  withr::local_envvar(CBA_PROXY = secret)
  err <- expect_error(cba_teams(), class = "hoopR_asset_fetch")
  expect_length(seen$reqs, 3L)
  expect_identical(seen$reqs[[1]]$options$proxy, secret)
  expect_false(grepl("hunter2", conditionMessage(err), fixed = TRUE))
  expect_false(grepl("hunter2", paste(format(err), collapse = "\n"), fixed = TRUE))
})

test_that("game wrappers serve finished games only, and the header is read once per session", {
  for (info in list(list(hostScore = NULL, guestScore = NULL, hostTeamId = 1L, guestTeamId = 2L),
                    list(hostScore = 0L, guestScore = 0L, hostTeamId = 1L, guestTeamId = 2L),
                    list(hostScore = 88, guestScore = 74.5, hostTeamId = 1L, guestTeamId = 2L),
                    list(1L, 2L))) {
    local_cba(cba_server(list("team-match-datas/getMatchDataReport/baseInfo" = function(req) cba_resp(info))))
    expect_error(cba_player_box(schedule_id = 100105799), class = "hoopR_asset_fetch")
  }
  seen <- local_cba()
  cba_player_advanced(schedule_id = 100105799)
  cba_player_extras(schedule_id = 100105799)
  routes <- vapply(seen$reqs, cba_route, "")
  expect_identical(sum(routes == "team-match-datas/getMatchDataReport/baseInfo"), 1L)
  expect_identical(sum(routes == "player-match-datas/data-count"), 1L)
})

test_that("a game body for another game or team is refused", {
  box <- cba_body("player_box.json")
  set <- function(x, path, value) {
    x[[path]] <- value
    x
  }
  adv <- cba_body("player_advanced.json")
  adv_other <- adv
  adv_other$homes[[1]]$playerId <- 1L
  adv_team <- adv
  adv_team$homes[[1]]$teamId <- 1L
  ros <- cba_body("rosters.json")
  ros$hostPlayers[[1]]$teamId <- 1L
  best <- cba_body("best_stats.json")
  best$hostTeamBestData[[1]]$playerId <- "1"
  shots <- cba_body("game_team_shots.json")
  shots[[1]]$teamId <- 1L
  q <- cba_body("period_scores.json")
  q$home$oneScore <- q$home$oneScore + 1L
  box_pts <- box
  box_pts$homeCounts[[1]]$points <- 99L
  cases <- list(
    list("player-match-datas/data-count", box_pts, quote(cba_player_box(schedule_id = 100105799)), "points"),
    list("player-match-datas/data-count", set(box, "homeCounts", list()), quote(cba_player_box(schedule_id = 100105799)), "no homeCounts"),
    list("schedule-quarters/getQuarterInfo", q, quote(cba_period_scores(schedule_id = 100105799)), "period points"),
    list("player-match-datas/advance-count", adv_other, quote(cba_player_advanced(schedule_id = 100105799)), "box score"),
    list("player-match-datas/advance-count", adv_team, quote(cba_player_advanced(schedule_id = 100105799)), "not team"),
    list("player-match-datas/schedule-other-data", list(homePlayers = list()), quote(cba_player_extras(schedule_id = 100105799)), "no homePlayers"),
    list("schedules/getPlayersByScheduleId", ros, quote(cba_rosters(schedule_id = 100105799)), "hostPlayers"),
    list("team-match-datas/getMatchDataReport/bestDataQuota", best, quote(cba_best_stats(schedule_id = 100105799)), "box score"),
    list("team-match-datas/schedule-shoot-list", shots, quote(cba_game_team_shots(schedule_id = 100105799)), "two teams"),
    list("teams/schedule-four-elements", list(), quote(cba_game_team_four(schedule_id = 100105799)), "no rows"),
    list("team-match-datas/getMatchDataReport/bestPlayer", list(x = 1L), quote(cba_best_player(schedule_id = 100105799)), "hostBestPlayer"),
    list("team-match-datas/getMatchDataReportStatues", list(isReport = 1L), quote(cba_report_status(schedule_id = 100105799)), "isReport")
  )
  for (cs in cases) {
    local_cba(cba_server(stats::setNames(list(function(req) cba_resp(cs[[2]])), cs[[1]])))
    expect_error(eval(cs[[3]]), cs[[4]], class = "hoopR_asset_fetch", label = cs[[1]])
  }
})

test_that("play-by-play: every period, checked; none is no data, a partial set is a failed fetch", {
  pages <- cba_body("pbp.json.gz")
  serve <- function(f) cba_server(list("schedule-eventses/filterPage" = function(req) {
    cba_resp(f(as.character(req$body$data$quarterNum)))
  }))
  empty <- list(records = list(), total = 0L)
  local_cba(serve(function(q) empty))
  expect_error(cba_pbp(schedule_id = 100105799), "no play-by-play", class = "hoopR_no_data")
  local_cba(serve(function(q) if (q == "1") pages[[q]] else empty))
  expect_error(cba_pbp(schedule_id = 100105799), "partial", class = "hoopR_asset_fetch")
  local_cba(serve(function(q) empty))
  expect_error(cba_pbp(schedule_id = 100105799, quarter_num = 2), "no plays in period 2", class = "hoopR_no_data")
  trunc <- function(q) utils::modifyList(pages[[q]], list(total = 999L))
  local_cba(serve(trunc))
  expect_error(cba_pbp(schedule_id = 100105799), "truncated", class = "hoopR_asset_fetch")
  echo <- function(q) {
    p <- pages[[q]]
    p$records[[1]]$quarterNum <- 9L
    p
  }
  local_cba(serve(echo))
  expect_error(cba_pbp(schedule_id = 100105799), "another period", class = "hoopR_asset_fetch")
  clock <- function(q) {
    p <- pages[[q]]
    p$records <- rev(p$records)
    p$records <- lapply(p$records, function(r) utils::modifyList(r, list(quarterNum = as.integer(q))))
    p
  }
  local_cba(serve(clock))
  expect_error(cba_pbp(schedule_id = 100105799), "count down", class = "hoopR_asset_fetch")
  short <- function(q) if (q == "4") {
    p <- pages[[q]]
    p$records <- p$records[1:5]
    p$total <- 5L
    p
  } else pages[[q]]
  local_cba(serve(short))
  expect_error(cba_pbp(schedule_id = 100105799), "not the final", class = "hoopR_asset_fetch")
  seen <- local_cba()
  one <- cba_pbp(schedule_id = 100105799, quarter_num = 2)
  expect_identical(unique(one$quarter_num), 2L)
  expect_identical(nrow(one), length(pages[["2"]]$records))
})

test_that("the non-game lists are refused when they echo another season, team or day", {
  base <- cba_body("player_base.json")
  base_season <- base
  base_season$records[[1]]$season <- 2024L
  base_team <- base
  base_team$records[[1]]$teamId <- 1L
  basic <- cba_body("team_basic.json")
  basic[[1]]$teamId <- 1L
  ov <- cba_body("team_overview.json")
  ov$records[[1]]$teamId <- 1L
  day <- cba_body("schedule_day.json")
  day[[1]]$scheduleTime <- "2025-12-13 19:35:00"
  cases <- list(
    list("player-base-list", base_season, quote(cba_player_base(season = 2026)), "another season"),
    list("player-base-list", base_team, quote(cba_player_base(season = 2026, team_id = 29128)), "another team"),
    list("player-base-list", list(records = "x"), quote(cba_player_base(season = 2026)), "no records"),
    list("teams/basic-data", basic, quote(cba_team_basic(team_id = 29128)), "another team"),
    list("team-match-datas/team-entirety-list", ov, quote(cba_team_overview(team_id = 29128)), "another team"),
    list("schedules/day", day, quote(cba_schedule_day(day = "2025-12-12")), "another day")
  )
  for (cs in cases) {
    local_cba(cba_server(stats::setNames(list(function(req) cba_resp(cs[[2]])), cs[[1]])))
    expect_error(eval(cs[[3]]), cs[[4]], class = "hoopR_asset_fetch", label = cs[[1]])
  }
})

test_that("operator ids and mobile numbers are removed from every body", {
  body <- list(list(teamId = 29128L, createdBy = "x", lastModifiedBy = "13812345678", club = "13812345678",
                    nest = list(createdBy = 1L, n = "2")))
  out <- .cba_redact(body)
  expect_identical(out, list(list(teamId = 29128L, club = "<redacted>", nest = list(n = "2"))))
  local_cba(cba_server(list("teams/teamList" = function(req) cba_resp(body))))
  teams <- cba_teams()
  expect_identical(teams$club, "<redacted>")
  expect_false(any(c("created_by", "last_modified_by") %in% names(teams)))
})

test_that("display strings are cast per column code, percents to 0-1 fractions", {
  cast <- function(vals, code) .cba_cast_col(as.list(vals), code)
  expect_equal(cast(list("39.4%", "100", 0.5, "1,234.5%", "nan", "", NULL), "p"),
               c(0.394, 1, 0.5, 12.345, NA, NA, NA))
  expect_equal(cast(list("15.3%", "21.6", 3L, "inf", TRUE, list(1)), "f"), c(15.3, 21.6, 3, NA, NA, NA))
  expect_identical(cast(list("1,234", "12.0", "12.5", 7.0, TRUE, "0x1A"), "i"), c(1234L, 12L, NA, 7L, NA, NA))
  expect_identical(cast(list(TRUE, 1L, "true"), "b"), c(TRUE, NA, NA))
  expect_identical(cast(list(5L, 21.6, 100, TRUE, list("a", 1L), list(a = NULL)), "s"),
                   c("5", "21.6", "100.0", "True", "[\"a\",1]", "{\"a\":null}"))
})

test_that("live: the match types decrypt through CBA_PROXY", {
  skip_intl_live("CBA_PROXY")
  types <- cba_match_types()
  expect_true(all(c("1", "2") %in% types$value))
  Sys.sleep(1)
  info <- cba_game_info(schedule_id = 100105799)
  expect_identical(info$host_score, 88L)
})
