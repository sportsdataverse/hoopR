# FEB (`feb_*()`): offline tests against the sdv-py fixtures (tests/testthat/fixtures/feb/,
# provenance in its README). The transport is mocked at `.intl_response()`, so every
# wrapper runs end to end: token fetch, envelope validation, HTML parsing, casts.

feb_fx <- function(...) testthat::test_path("fixtures", "feb", ...)
feb_dtypes <- jsonlite::read_json(feb_fx("parity", "dtypes.json"))

feb_read <- function(name) {
  path <- feb_fx(name)
  con <- if (grepl("\\.gz$", path)) gzfile(path) else file(path)
  on.exit(close(con))
  paste(readLines(con, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}

feb_json <- function(name) jsonlite::parse_json(feb_read(name), simplifyVector = FALSE)

feb_jwt <- function(exp = as.numeric(Sys.time()) + 86400, client = "baloncestoenvivoapp",
                    scope = list("livestats.api")) {
  seg <- function(x) gsub("\\s", "", jsonlite::base64url_enc(as.character(jsonlite::toJSON(x, auto_unbox = TRUE, digits = NA))))
  paste(seg(list(alg = "RS256", typ = "JWT")), seg(list(client_id = client, scope = scope, exp = exp)),
        seg(list(sig = strrep("x", 10))), sep = ".")
}

feb_home <- function(token) {
  sprintf('<html><body><div id="contentToken"><input name="_ctl0:token" value="%s"/></div></body></html>', token)
}

#' `expect_error()` on the class, then the pattern on the message with cli's line wrapping undone.
feb_expect_error <- function(expr, pattern, class) {
  e <- expect_error(expr, class = class)
  expect_match(gsub("\\s+", " ", conditionMessage(e)), pattern, fixed = TRUE)
  invisible(e)
}

FEB_JSON <- list("content-type" = "application/json; charset=utf-8")
FEB_HTML <- list("content-type" = "text/html; charset=utf-8")
FEB_GAME <- 2535725L

#' Mock the transport: `handler(url, query, headers)` returns
#' `list(status, headers, body, final)`; the site root serves `token` unless the
#' handler answers it. Returns an environment whose `log` lists every request.
local_feb_site <- function(handler, token = feb_jwt(), env = parent.frame()) {
  seen <- new.env()
  seen$log <- list()
  rm(list = ls(.feb_tok), envir = .feb_tok)
  withr::defer(rm(list = ls(.feb_tok), envir = .feb_tok), envir = env)
  local_mocked_bindings(
    .intl_response = function(url, query = list(), body = NULL, body_type = "none", headers = NULL,
                              proxy_env = NULL, retry_500 = FALSE, ...) {
      seen$log[[length(seen$log) + 1L]] <- list(url = url, query = query, headers = headers, retry_500 = retry_500)
      r <- handler(url, query, headers)
      if (is.null(r)) r <- list(headers = FEB_HTML, body = feb_home(token))
      httr2::response(status_code = r$status %||% 200L, url = r$final %||% url, headers = r$headers %||% FEB_JSON,
                      body = charToRaw(enc2utf8(r$body %||% "")))
    },
    .env = env
  )
  seen
}

#' An API site: the site root serves the token, every API route the fixture body `body_for(route)`.
feb_api_handler <- function(body_for, status = 200L, headers = FEB_JSON) {
  function(url, query, headers_in) {
    if (identical(sub("/$", "", url), .feb_site)) return(NULL)
    route <- sub("^.*/api/v1/([^/]+).*$", "\\1", url)
    b <- body_for(route)
    list(status = status, headers = headers, body = if (is.character(b)) b else jsonlite::toJSON(b, auto_unbox = TRUE, null = "null", digits = NA))
  }
}

feb_fixture_for <- function(route) {
  feb_read(c(BoxScore = "BoxScore.json", KeyFacts = "KeyFacts.json.gz", ShotChart = "ShotChart.json",
             TeamStats = "TeamStats.json", Ranking = "Ranking.json", overview = "overview.json")[[route]])
}

feb_page_handler <- function(page, final) {
  function(url, query, headers) list(headers = FEB_HTML, body = page, final = final)
}

#' Mismatching cells between an R frame and sdv-py's frame (CSV) on the same fixture;
#' NA-vs-value counts as a mismatch.
feb_mismatches <- function(df, name) {
  path <- feb_fx("parity", paste0(name, ".csv"))
  if (!file.exists(path)) path <- paste0(path, ".gz") # read.csv reads gzip transparently
  csv <- intl_read_oracle(path)
  expect_identical(names(df), names(csv))
  expect_identical(intl_r_types(df), intl_oracle_types(feb_dtypes[[name]]), label = name) # sdv-py's dtypes
  expect_identical(nrow(df), nrow(csv))
  sum(vapply(names(csv), function(col) {
    r <- df[[col]]
    p <- csv[[col]]
    if (is.double(r) && !inherits(r, c("POSIXct", "Date"))) {
      pv <- as.numeric(p)
      return(sum(xor(is.na(r), is.na(pv)) | (!is.na(r) & !is.na(pv) & abs(r - pv) > 1e-9)))
    }
    rs <- if (inherits(r, "POSIXct")) format(r, "%Y-%m-%d %H:%M:%S") else as.character(r)
    sum(xor(is.na(rs), is.na(p)) | (!is.na(rs) & !is.na(p) & rs != p))
  }, integer(1)))
}

feb_expect_types <- function(df, short) {
  spec <- .feb_specs[[short]]
  expect_identical(names(df), names(spec))
  cls <- vapply(df, function(x) class(x)[[1]], character(1))
  want <- c(integer = "integer", double = "numeric", character = "character", logical = "logical",
            Date = "Date", madrid = "POSIXct", utc = "POSIXct")[spec]
  expect_identical(unname(cls), unname(want))
  ids <- names(df)[endsWith(names(df), "_id") | names(df) %in% c("group", "season")]
  expect_true(all(vapply(df[ids], is.integer, logical(1))))
}

# --- parity: every route, end to end, against sdv-py's frame on the same fixture ----------

test_that("FEB game wrappers match sdv-py on the fixtures and fetch the token once", {
  tok <- feb_jwt()
  site <- local_feb_site(feb_api_handler(feb_fixture_for), token = tok)
  frames <- list(
    game_info = feb_game_info(FEB_GAME), period_scores = feb_period_scores(FEB_GAME),
    team_stats = feb_team_stats(FEB_GAME), player_box = feb_player_box(FEB_GAME), pbp = feb_pbp(FEB_GAME),
    shots = feb_shots(FEB_GAME), leaders = feb_leaders(FEB_GAME), overview = feb_overview()
  )
  for (short in names(frames)) {
    expect_s3_class(frames[[short]], "hoopR_data")
    feb_expect_types(frames[[short]], short)
    expect_identical(feb_mismatches(frames[[short]], short), 0L, label = short)
  }
  urls <- vapply(site$log, `[[`, character(1), "url")
  expect_identical(sum(urls == paste0(.feb_site, "/")), 1L)
  api <- Filter(function(x) grepl("intrafeb", x$url), site$log)
  expect_length(api, 8L)
  expect_true(all(vapply(api, function(x) identical(x$headers[["Authorization"]], paste("Bearer", tok)), logical(1))))
  expect_true(all(vapply(site$log, `[[`, logical(1), "retry_500")))
  expect_identical(api[[4]]$url, "https://intrafeb.feb.es/LiveStats.API/api/v1/BoxScore/2535725")
  expect_identical(nrow(frames$pbp), 570L)
  expect_false(is.unsorted(frames$pbp$play_num))
  expect_identical(attr(frames$game_info$start_time, "tzone"), "Europe/Madrid")
  expect_identical(attr(frames$overview$start_time_utc, "tzone"), "UTC")
})

test_that("FEB 2020-21 play-by-play is text only and keeps the schema", {
  site <- local_feb_site(feb_api_handler(function(route) feb_read("KeyFacts_2171130.json")))
  pbp <- feb_pbp(2171130)
  feb_expect_types(pbp, "pbp")
  expect_identical(feb_mismatches(pbp, "pbp_2171130"), 0L)
  expect_true(all(is.na(pbp$action)) && all(is.na(pbp$player_id)))
})

test_that("FEB schedule pages match sdv-py and map the END-year season to the site's START year", {
  site <- local_feb_site(feb_page_handler(feb_read("calendario_g1_t2026.html"),
                                          "https://baloncestoenvivo.feb.es/calendario/1/2026"))
  sched <- feb_schedule(group = 1, season = 2027)
  expect_identical(site$log[[1]]$query, list(g = "1", t = "2026"))
  expect_identical(site$log[[1]]$url, "https://baloncestoenvivo.feb.es/calendario.aspx")
  expect_identical(unique(sched$season), 2027L)
  feb_expect_types(sched, "schedule")
  expect_identical(feb_mismatches(sched, "schedule"), 0L)

  local_feb_site(feb_page_handler(feb_read("resultados_g1_t2026.html"),
                                  "https://baloncestoenvivo.feb.es/resultados/1/2026"))
  res <- feb_results(group = "1", season = 2027)
  feb_expect_types(res, "results")
  expect_identical(feb_mismatches(res, "results"), 0L)
  st <- feb_standings(group = 1, season = 2027)
  feb_expect_types(st, "standings")
  expect_identical(feb_mismatches(st, "standings"), 0L)

  site <- local_feb_site(feb_page_handler(feb_read("resultados_g1_t2025.html"),
                                          "https://baloncestoenvivo.feb.es/resultados/1/2025"))
  fin <- feb_standings(group = 1, season = 2026)
  expect_identical(site$log[[1]]$query$t, "2025")
  expect_identical(unique(fin$table), "final")
  expect_identical(feb_mismatches(fin, "standings_final"), 0L)
})

# --- empty payloads ---------------------------------------------------------------------------

test_that("FEB overview skips a quarter without both scores, never writing Python's \"None-None\"", {
  q <- list(list(scoreA = 16L, scoreB = 14L), list(scoreA = 3L, scoreB = NULL), list(scoreA = NULL, scoreB = NULL))
  raw <- list(OVERVIEW = list(COMPETITIONS = list(list(GAMES = list(list(ID = 1L, Quarters = q))))))
  expect_identical(.feb_parse_overview(raw)$period_scores, "16-14")
  raw$OVERVIEW$COMPETITIONS[[1]]$GAMES[[1]]$Quarters <- q[3]
  expect_true(is.na(.feb_parse_overview(raw)$period_scores))
})

test_that("FEB parsers give a typed zero-row frame on an empty or malformed payload", {
  parsers <- list(
    game_info = .feb_parse_game_info, period_scores = .feb_parse_period_scores,
    team_stats = .feb_parse_team_stats, player_box = .feb_parse_player_box, pbp = .feb_parse_pbp,
    shots = .feb_parse_shots, leaders = .feb_parse_leaders
  )
  for (bad in list(list(), list(HEADER = NULL, BOXSCORE = list()), list(1, 2))) {
    for (short in names(parsers)) {
      df <- parsers[[short]](bad, FEB_GAME)
      expect_identical(nrow(df), 0L)
      feb_expect_types(df, short)
    }
    ov <- .feb_parse_overview(bad)
    expect_identical(nrow(ov), 0L)
    feb_expect_types(ov, "overview")
  }
  for (short in c("schedule", "results", "standings")) {
    df <- .feb_frame(list(), .feb_specs[[short]], short)
    expect_identical(nrow(df), 0L)
    feb_expect_types(df, short)
  }
})

# --- refusals: the API -------------------------------------------------------------------------

test_that("FEB API statuses map to the classed conditions", {
  local_feb_site(feb_api_handler(function(r) "{}", status = 404L,
                                 headers = list("content-type" = "application/problem+json")))
  expect_error(feb_player_box(FEB_GAME), class = "hoopR_no_data")
  local_feb_site(feb_api_handler(function(r) "{}", status = 400L))
  expect_error(feb_player_box(FEB_GAME), class = "hoopR_bad_request")
  local_feb_site(feb_api_handler(function(r) "{}", status = 503L))
  e <- expect_error(feb_player_box(FEB_GAME), class = "hoopR_asset_fetch")
  expect_true(e$transient)
  expect_identical(e$status, 503L)
  local_feb_site(feb_api_handler(function(r) "{}", status = 403L))
  e <- expect_error(feb_player_box(FEB_GAME), class = "hoopR_asset_fetch")
  expect_false(e$transient)
})

test_that("FEB renews the bearer token once on a 401, then gives up", {
  tokens <- c(feb_jwt(exp = as.numeric(Sys.time()) + 5000), feb_jwt(exp = as.numeric(Sys.time()) + 9000))
  n_home <- 0L
  site <- local_feb_site(function(url, query, headers) {
    if (identical(sub("/$", "", url), .feb_site)) {
      n_home <<- n_home + 1L
      return(list(headers = FEB_HTML, body = feb_home(tokens[[n_home]])))
    }
    if (identical(headers[["Authorization"]], paste("Bearer", tokens[[1]]))) return(list(status = 401L, body = ""))
    list(body = feb_fixture_for("BoxScore"))
  })
  expect_identical(nrow(feb_player_box(FEB_GAME)), 24L)
  expect_identical(n_home, 2L)

  local_feb_site(feb_api_handler(function(r) "", status = 401L))
  e <- feb_expect_error(feb_player_box(FEB_GAME), "rejected the bearer token", class = "hoopR_asset_fetch")
  expect_identical(e$status, 401L)
})

test_that("FEB refuses error envelopes, stubs and non-JSON bodies", {
  bodies <- list(
    list("", FEB_JSON), list("not json", FEB_JSON),
    list('{"title": "Bad", "status": 500, "traceId": "t"}', FEB_JSON), list("[1, 2]", FEB_JSON),
    list('{"HEADER": {}}', FEB_JSON), list("{}", FEB_JSON), list("{}", list("content-type" = "text/plain")),
    list("{}", list("content-type" = "application/problem+json"))
  )
  for (b in bodies) {
    local_feb_site(feb_api_handler(function(r) b[[1]], headers = b[[2]]))
    expect_error(feb_pbp(FEB_GAME), class = "hoopR_asset_fetch")
  }
})

test_that("FEB refuses a changed or empty filled-block set", {
  changed <- feb_json("BoxScore.json")
  changed$RANKING <- list(TEAMS = list())
  local_feb_site(feb_api_handler(function(r) changed))
  feb_expect_error(feb_player_box(FEB_GAME), "filled blocks", class = "hoopR_asset_fetch")
  empty <- feb_json("BoxScore.json")
  empty$BOXSCORE <- structure(list(), names = character())
  local_feb_site(feb_api_handler(function(r) empty))
  feb_expect_error(feb_player_box(FEB_GAME), "BOXSCORE block is empty", class = "hoopR_asset_fetch")
  noteams <- feb_json("BoxScore.json")
  noteams$HEADER$TEAM <- noteams$HEADER$TEAM[1]
  local_feb_site(feb_api_handler(function(r) noteams))
  feb_expect_error(feb_player_box(FEB_GAME), "HEADER without two teams", class = "hoopR_asset_fetch")
})

test_that("FEB refuses a play-by-play of another game (wrong scope), not an empty frame", {
  local_feb_site(feb_api_handler(feb_fixture_for))
  feb_expect_error(feb_pbp(99), "out of scope: a play of game 2535725, asked for 99", class = "hoopR_asset_fetch")
})

test_that("FEB overview: an off day is no data, a game outside its competition is refused", {
  off <- feb_json("overview.json")
  off$OVERVIEW$COMPETITIONS <- list()
  local_feb_site(feb_api_handler(function(r) off))
  expect_error(feb_overview(), class = "hoopR_no_data")
  crossed <- feb_json("overview.json")
  crossed$OVERVIEW$COMPETITIONS[[1]]$GAMES[[1]]$CompID <- "999"
  local_feb_site(feb_api_handler(function(r) crossed))
  feb_expect_error(feb_overview(), "outside its competition", class = "hoopR_asset_fetch")
})

test_that("FEB validates ids before any request", {
  site <- local_feb_site(function(url, query, headers) list(status = 500L))
  for (bad in list("abc", NULL, TRUE, 1.5, -3, NA, c(1, 2))) {
    expect_error(feb_player_box(bad), class = "hoopR_bad_request")
  }
  for (bad in list(list(NULL, 2027), list("x", 2027), list(1, 2027.5))) {
    expect_error(feb_schedule(bad[[1]], bad[[2]]), class = "hoopR_bad_request")
  }
  expect_length(site$log, 0L)
})

test_that("FEB refuses a bad token page and never puts the token in a condition", {
  pages <- list(
    "<html><body>no token</body></html>", feb_home("not-a-jwt"),
    feb_home(feb_jwt(client = "someone-else")), feb_home(feb_jwt(scope = list("other"))),
    feb_home(feb_jwt(exp = as.numeric(Sys.time()) + 10))
  )
  for (p in pages) {
    local_feb_site(function(url, query, headers) {
      if (identical(sub("/$", "", url), .feb_site)) list(headers = FEB_HTML, body = p) else list(status = 500L)
    })
    expect_error(feb_player_box(FEB_GAME), class = "hoopR_asset_fetch")
  }
  tok <- feb_jwt()
  local_feb_site(feb_api_handler(function(r) paste("echo", tok), status = 500L), token = tok)
  e <- expect_error(feb_player_box(FEB_GAME), class = "hoopR_asset_fetch")
  expect_false(grepl("eyJ", conditionMessage(e), fixed = TRUE))
  local_mocked_bindings(.intl_response = function(...) {
    .abort_asset_fetch("transport failed: Authorization: Bearer {tok}", transient = TRUE)
  })
  rm(list = ls(.feb_tok), envir = .feb_tok)
  e <- expect_error(feb_schedule(1, 2027), class = "hoopR_asset_fetch")
  expect_false(grepl("eyJ", conditionMessage(e), fixed = TRUE))
  expect_true(e$transient)
})

# --- refusals: the schedule pages --------------------------------------------------------------

test_that("FEB refuses a schedule page for another season or group", {
  local_feb_site(feb_page_handler(feb_read("calendario_g1_t2026.html"),
                                  "https://baloncestoenvivo.feb.es/calendario/1/2025"))
  feb_expect_error(feb_schedule(1, 2026), "out of scope", class = "hoopR_asset_fetch")
  local_feb_site(feb_page_handler(feb_read("calendario_g1_t2026.html"),
                                  "https://baloncestoenvivo.feb.es/calendario/4/2026"))
  feb_expect_error(feb_schedule(4, 2027), "out of scope", class = "hoopR_asset_fetch")
})

test_that("FEB: an unknown group (redirect to /error) is no data; any other final URL is refused", {
  local_feb_site(feb_page_handler("<html><body>error</body></html>", "https://baloncestoenvivo.feb.es/error"))
  feb_expect_error(feb_schedule(999, 2027), "no group 999", class = "hoopR_no_data")
  local_feb_site(feb_page_handler(feb_read("calendario_g1_t2026.html"), "https://baloncestoenvivo.feb.es/login"))
  feb_expect_error(feb_schedule(1, 2027), "final URL", class = "hoopR_asset_fetch")
})

test_that("FEB refuses empty, non-HTML and drifted pages; a right page with no games is no data", {
  final <- "https://baloncestoenvivo.feb.es/calendario/1/2026"
  local_feb_site(function(url, query, headers) list(headers = FEB_HTML, body = "  ", final = final))
  feb_expect_error(feb_schedule(1, 2027), "empty body", class = "hoopR_asset_fetch")
  local_feb_site(function(url, query, headers) list(headers = FEB_JSON, body = "{}", final = final))
  feb_expect_error(feb_schedule(1, 2027), "non-HTML", class = "hoopR_asset_fetch")
  page <- feb_read("calendario_g1_t2026.html")
  local_feb_site(feb_page_handler(sub(">Local<", ">Home<", page, fixed = TRUE), final))
  feb_expect_error(feb_schedule(1, 2027), "header drift", class = "hoopR_asset_fetch")
  local_feb_site(feb_page_handler("<html><body><p>no header</p></body></html>", final))
  feb_expect_error(feb_schedule(1, 2027), "page header", class = "hoopR_asset_fetch")
  nogames <- gsub("(?s)<table\\b[^>]*DataGrid3.*?</table>", "", page, perl = TRUE)
  local_feb_site(feb_page_handler(nogames, final))
  feb_expect_error(feb_schedule(1, 2027), "zero games", class = "hoopR_no_data")
  local_feb_site(function(url, query, headers) list(status = 404L, headers = FEB_HTML, body = "x", final = final))
  expect_error(feb_schedule(1, 2027), class = "hoopR_no_data")
})

# --- live (HOOPR_INTL_LIVE_TESTS=1) --------------------------------------------------------------

test_that("FEB live: a game and a schedule page", {
  skip_intl_live()
  info <- feb_game_info(FEB_GAME)
  expect_identical(names(info), names(.feb_specs$game_info))
  expect_identical(info$game_id, FEB_GAME)
  sched <- feb_schedule(group = 1, season = 2027)
  expect_identical(names(sched), names(.feb_specs$schedule))
  expect_true(FEB_GAME %in% sched$game_id)
})
