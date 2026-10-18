# IBBA (`ibba_*()`, `ibba_segev_*()`): offline tests against the sdv-py fixtures
# (tests/testthat/fixtures/ibba/, provenance in its README). Every request is mocked through
# httr2, so the runtime (throttle, retry policy, envelope and scope refusals) runs end to end;
# sleeps are mocked, never slept. Parity: fixtures/ibba/parity/<case>.csv is sdv-py's frame of
# the same wrapper call on the same fixture (manifest.json lists the calls and sdv-py's types).

ibba_fx <- function(...) testthat::test_path("fixtures", "ibba", ...)

ibba_text <- function(rel) {
  path <- ibba_fx(rel)
  con <- if (endsWith(rel, ".gz")) gzfile(path, encoding = "UTF-8") else file(path, encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}

ibba_json <- function(rel) jsonlite::parse_json(ibba_text(rel), simplifyVector = FALSE)
ibba_dump <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))

IBBA_JSON <- "application/json; charset=utf-8"
IBBA_HTML <- "text/html; charset=utf-8"

ibba_resp <- function(body, status = 200L, ctype = IBBA_JSON) {
  text <- if (is.character(body)) body else ibba_dump(body)
  httr2::response(status, headers = list("Content-Type" = ctype), body = charToRaw(enc2utf8(text)))
}

#' Mock the hosts: `handler(req)` returns a response (or a body to serve as JSON); `seen$reqs`
#' records every request, retries included.
local_ibba <- function(handler, env = parent.frame()) {
  seen <- new.env()
  seen$reqs <- list()
  withr::local_options(cli.width = 10000, .local_envir = env) # one-line messages for the matches
  rm(list = ls(.intl_clock), envir = .intl_clock)
  local_mocked_bindings(.intl_sleep = function(seconds) NULL, .intl_now = function() 0,
                        .package = "hoopR", .env = env)
  httr2::local_mocked_responses(function(req) {
    seen$reqs[[length(seen$reqs) + 1L]] <- req
    r <- handler(req)
    if (inherits(r, "httr2_response")) r else ibba_resp(r)
  }, env = env)
  seen
}

ibba_serve <- function(rel, ctype = IBBA_JSON) function(req) ibba_resp(ibba_text(rel), ctype = ctype)
ibba_query <- function(req) httr2::url_parse(req$url)$query

ibba_expect_error <- function(expr, pattern, class) {
  e <- expect_error(expr, class = class)
  expect_match(gsub("\\s+", " ", conditionMessage(e)), pattern, fixed = TRUE)
  invisible(e)
}

#' Mismatching cells between an R column and sdv-py's CSV column; NA-vs-value is a mismatch.
ibba_cell_mismatches <- function(got, want) {
  if (inherits(got, "POSIXct")) got <- format(got, "%Y-%m-%d %H:%M:%S")
  if (inherits(got, "Date")) got <- format(got, "%Y-%m-%d")
  if (is.logical(got)) {
    want <- ifelse(is.na(want), NA, want == "true")
  } else if (is.numeric(got)) {
    want <- suppressWarnings(as.numeric(want))
  }
  both <- !is.na(got) & !is.na(want)
  diff <- if (is.double(got)) abs(got[both] - want[both]) > 1e-9 else got[both] != want[both]
  sum(is.na(got) != is.na(want)) + sum(diff)
}

ibba_r_type <- function(x) {
  if (inherits(x, "POSIXct")) return("POSIXct")
  if (inherits(x, "Date")) return("Date")
  if (is.double(x)) "numeric" else class(x)[[1]]
}

IBBA_PY_TYPE <- c(Int64 = "integer", Float64 = "numeric", String = "character", Boolean = "logical", Date = "Date")

IBBA_MANIFEST <- jsonlite::read_json(ibba_fx("parity", "manifest.json"))

# --- parity: every wrapper, end to end, against sdv-py's frame on the same fixture ------------

test_that("every IBBA wrapper matches sdv-py's frame on the same fixture (columns, types, cells)", {
  exported <- grep("^ibba_", getNamespaceExports("hoopR"), value = TRUE)
  expect_setequal(setdiff(exported, "ibba_segev_game_crosswalk"), names(IBBA_MANIFEST$dtypes))
  for (name in names(IBBA_MANIFEST$cases)) {
    case <- IBBA_MANIFEST$cases[[name]]
    ctype <- if (startsWith(case$fn, "ibba_segev_")) IBBA_HTML else IBBA_JSON
    seen <- local_ibba(ibba_serve(case$fixture, ctype))
    got <- do.call(case$fn, case$args)
    path <- ibba_fx("parity", paste0(name, ".csv"))
    if (!file.exists(path)) path <- paste0(path, ".gz")
    want <- utils::read.csv(path, colClasses = "character", na.strings = "\\N", check.names = FALSE,
                            encoding = "UTF-8")
    expect_s3_class(got, "hoopR_data")
    expect_identical(names(got), names(want), label = name)
    expect_identical(nrow(got), as.integer(case$rows), label = name)
    expect_identical(nrow(got), nrow(want), label = name)
    dt <- unlist(IBBA_MANIFEST$dtypes[[case$fn]])
    want_types <- ifelse(startsWith(dt, "Datetime"), "POSIXct", IBBA_PY_TYPE[dt])
    expect_identical(vapply(got, ibba_r_type, character(1)), stats::setNames(unname(want_types), names(dt)),
                     label = name)
    bad <- vapply(names(got), function(n) ibba_cell_mismatches(got[[n]], want[[n]]), numeric(1))
    expect_identical(bad[bad > 0], stats::setNames(numeric(), character()), label = name)
    expect_length(seen$reqs, 1L)
  }
})

test_that("ids are integers, never stringified floats, and join across routes", {
  local_ibba(ibba_serve("full/Games.json.gz"))
  games <- ibba_games(season = 2026, board_id = 5, board_round = 1)
  for (col in c("game_id", "season", "home_team_id", "away_team_id", "board_id", "segev_game_id")) {
    expect_type(games[[col]], "integer")
  }
  local_ibba(ibba_serve("full/Boxscore.json.gz"))
  box <- ibba_box_score(game_id = 26392, season = 2026)
  expect_type(box$player_id, "integer")
  expect_true(26392L %in% games$game_id)
  expect_true(all(box$team_id %in% c(games$home_team_id, games$away_team_id)))
  expect_identical(sort(unique(box$row_type)), c("player", "team", "total"))
  expect_true(all(is.na(box$player_id[box$row_type != "player"]))) # 0 = no player on _TEAM / TOTAL rows
})

# --- requests: the season key, the WSDL parameter lists ----------------------------------------

test_that("season is sent as cYear unchanged, with every WSDL parameter in order (0 = all)", {
  seen <- local_ibba(ibba_serve("cap/Boards_2026.json"))
  b <- ibba_boards(season = 2026)
  expect_identical(ibba_query(seen$reqs[[1]]), list(cYear = "2026"))
  expect_true(startsWith(seen$reqs[[1]]$url, "https://basket.co.il/ws/ws.asmx/Boards?"))
  expect_identical(unique(b$season), 2026L)
  seen <- local_ibba(ibba_serve("cap/Boards_2005.json"))
  expect_identical(unique(ibba_boards(season = 2005)$season), 2005L)
  expect_identical(ibba_query(seen$reqs[[1]]), list(cYear = "2005"))

  seen <- local_ibba(ibba_serve("full/Games.json.gz"))
  expect_identical(nrow(ibba_games(season = 2026, board_id = 5, board_round = 1)), 7L)
  expect_identical(ibba_query(seen$reqs[[1]]), list(board_id = "5", board_round = "1", team_id = "0",
                                                     team_uid = "0", game_id = "0", cYear = "2026"))
  seen <- local_ibba(ibba_serve("cap/PlayerStatsById_21912_2026_true_false.json"))
  ibba_player_stats(player_id = 21912, season = 2026, is_averages = TRUE)
  expect_identical(ibba_query(seen$reqs[[1]]), list(player_id = "21912", cYear = "2026", isAverages = "true",
                                                     isPlayOff = "false"))
  seen <- local_ibba(ibba_serve("cap/StatsTypes.json"))
  expect_identical(nrow(ibba_stats_types()), 3L)
  expect_identical(seen$reqs[[1]]$url, "https://basket.co.il/ws/ws.asmx/StatsTypes")
  seen <- local_ibba(ibba_serve("full/getActions.json.gz", IBBA_HTML))
  expect_identical(nrow(ibba_segev_pbp(game_id = 50)), 768L)
  expect_identical(ibba_query(seen$reqs[[1]]), list(method = "getActions", game_id = "50"))
  expect_true(startsWith(seen$reqs[[1]]$url, "https://stats.segevstats.com/realtimestat_heb/api/?"))
})

test_that("segev_game_id exists only from 2025-26 and the crosswalk reads it", {
  local_ibba(ibba_serve("full/Games.json.gz"))
  games <- ibba_games(season = 2026, board_id = 5, board_round = 1)
  expect_false(anyNA(games$segev_game_id))
  expect_identical(games$segev_game_id[games$game_id == 26392L], 50L)
  expect_false(any(games$is_external))
  local_ibba(ibba_serve("cap/Games_5_0_0_0_0_2005.json"))
  old <- ibba_games(season = 2005, board_id = 5)
  expect_true(all(is.na(old$segev_game_id)))
  xw <- ibba_segev_game_crosswalk(games)
  expect_s3_class(xw, "hoopR_data")
  expect_identical(names(xw), c("game_id", "segev_game_id"))
  expect_identical(nrow(xw), 7L)
  expect_identical(nrow(ibba_segev_game_crosswalk(old)), 0L)
  empty <- ibba_segev_game_crosswalk(games[0, ])
  expect_identical(vapply(empty, class, ""), c(game_id = "integer", segev_game_id = "integer"))
  bad <- games
  bad$segev_game_id <- as.numeric(bad$segev_game_id)
  ibba_expect_error(ibba_segev_game_crosswalk(bad), "segev_game_id is numeric, expected integer", "hoopR_bad_request")
  dup <- games
  dup$segev_game_id[2] <- dup$segev_game_id[1]
  ibba_expect_error(ibba_segev_game_crosswalk(dup), "maps to more than one", "hoopR_bad_request")
  ibba_expect_error(ibba_segev_game_crosswalk(games["game_id"]), "has no column", "hoopR_bad_request")
  ibba_expect_error(ibba_segev_game_crosswalk(list()), "expected a data frame", "hoopR_bad_request")
})

test_that("ASMX text is HTML-unescaped and stripped, empty text is NA; Segev text is not unescaped", {
  local_ibba(ibba_serve("full/Games.json.gz"))
  games <- ibba_games(season = 2026, board_id = 5, board_round = 1)
  expect_false(any(grepl("&quot;|&#39;", unlist(games[vapply(games, is.character, NA)]))))
  expect_true(any(grepl("\u05ea\"\u05d0", games$venue_he, fixed = TRUE))) # "&quot;" unescaped
  x <- .ibba_text(list("  a&#39;b&nbsp;", "", "   ", NULL, list(1), "&utm_source=x", "x &amp; y", TRUE, 5L))
  expect_identical(x, c("a'b", NA, NA, NA, NA, "&utm_source=x", "x & y", "True", "5"))
})

# --- refusals ------------------------------------------------------------------------------

test_that("the ASMX runtime refuses every wrong answer with the sdv-py vocabulary", {
  cases <- list(
    list(ibba_resp("", 404L), "hoopR_no_data", "answered HTTP 404"),
    list(ibba_resp(""), "hoopR_no_data", "empty 200 body"),
    list(ibba_resp(list(boxscore = list())), "hoopR_no_data", "no rows for game_id=26392, cYear=2026"),
    list(ibba_resp("no connection", ctype = IBBA_HTML), "hoopR_asset_fetch", "not JSON"),
    list(ibba_resp("no connection"), "hoopR_asset_fetch", "not JSON"),
    list(ibba_resp(list(error = "x")), "hoopR_asset_fetch", "not the Boxscore envelope"),
    list(ibba_resp(list(boxscore = list(), extra = 1)), "hoopR_asset_fetch", "not the Boxscore envelope"),
    list(ibba_resp(list(boxscore = "x")), "hoopR_asset_fetch", "list of objects"),
    list(ibba_resp(list(boxscore = list(a = 1))), "hoopR_asset_fetch", "list of objects"),
    list(ibba_resp("", 500L), "hoopR_asset_fetch", "HTTP 500"),
    list(ibba_resp("", 400L), "hoopR_bad_request", "HTTP 400")
  )
  for (cs in cases) {
    seen <- local_ibba(function(req) cs[[1]])
    ibba_expect_error(ibba_box_score(game_id = 26392, season = 2026), cs[[3]], cs[[2]])
    expect_length(seen$reqs, 1L) # a 500 is the host's stack trace: never retried
  }
})

test_that("a JSON body served as HTML is refused; a response whose headers httr2 could not parse is read", {
  local_ibba(function(req) ibba_resp(ibba_text("cap/Boards_2026.json"), ctype = IBBA_HTML))
  ibba_expect_error(ibba_boards(season = 2026), "answered text/html; charset=utf-8, not JSON", "hoopR_asset_fetch")
  # basket.co.il's Set-Cookie carries a raw 0xA0 byte: curl::parse_headers() then drops every header
  local_ibba(function(req) {
    r <- httr2::response(200L, body = charToRaw(enc2utf8(ibba_text("cap/Boards_2026.json"))))
    r$headers <- structure(list(), class = "httr2_headers")
    r
  })
  expect_identical(nrow(ibba_boards(season = 2026)), 3L)
})

test_that("a row for another game, season, board or team is a fetch error, never an empty frame", {
  other <- ibba_json("full/Boxscore.json.gz")
  other$boxscore <- lapply(other$boxscore, function(r) utils::modifyList(r, list(game_id = "26393")))
  local_ibba(function(req) other)
  ibba_expect_error(ibba_box_score(game_id = 26392, season = 2026), "out of scope: game_id='26393'",
                    "hoopR_asset_fetch")
  local_ibba(ibba_serve("full/Boxscore.json.gz"))
  ibba_expect_error(ibba_box_score(game_id = 26392, season = 2027), "out of scope: year_id='2026'",
                    "hoopR_asset_fetch")
  local_ibba(ibba_serve("cap/Boards_2026.json"))
  ibba_expect_error(ibba_boards(season = 2005), "out of scope: year_id", "hoopR_asset_fetch")
  local_ibba(ibba_serve("full/Games.json.gz"))
  ibba_expect_error(ibba_games(season = 2026, team_id = 1111), "a game without team 1111", "hoopR_asset_fetch")
  ibba_expect_error(ibba_games(season = 2026, board_id = 10), "out of scope: BOARD_ID='5'", "hoopR_asset_fetch")
  ints <- ibba_json("cap/Boards_2026.json")
  ints$boards <- lapply(ints$boards, function(r) utils::modifyList(r, list(year_id = 2026L)))
  local_ibba(function(req) ints)
  ibba_expect_error(ibba_boards(season = 2026), "out of scope", "hoopR_asset_fetch") # an int echo never matches
})

test_that("a box score that is not a finished two-team game is refused", {
  box_with <- function(over) {
    body <- ibba_json("full/Boxscore.json.gz")
    body$boxscore <- lapply(body$boxscore, function(r) {
      if (identical(r$jersy, "TOTAL") && !is.null(over[[r$team_id]])) utils::modifyList(r, over[[r$team_id]]) else r
    })
    body
  }
  local_ibba(function(req) box_with(list(`1109` = list(minutes = "150"), `1120` = list(minutes = "150"))))
  ibba_expect_error(ibba_box_score(game_id = 26392, season = 2026), "not final: TOTAL minutes 150",
                    "hoopR_asset_fetch")
  local_ibba(function(req) box_with(list(`1109` = list(pts = "92"))))
  ibba_expect_error(ibba_box_score(game_id = 26392, season = 2026), "tied at '92'", "hoopR_asset_fetch")
  one <- ibba_json("full/Boxscore.json.gz")
  one$boxscore <- Filter(function(r) identical(r$team_id, "1109"), one$boxscore)
  local_ibba(function(req) one)
  ibba_expect_error(ibba_box_score(game_id = 26392, season = 2026), "two-team box score", "hoopR_asset_fetch")
  local_ibba(function(req) box_with(list(`1109` = list(minutes = "225"), `1120` = list(minutes = "225"))))
  expect_identical(nrow(ibba_box_score(game_id = 26392, season = 2026)), 27L) # 200 + 25 x 1 overtime is final
})

test_that("bad ASMX parameters never reach the host", {
  seen <- local_ibba(ibba_serve("cap/Boards_2026.json"))
  ibba_expect_error(ibba_box_score(game_id = "abc", season = 2026), "non-negative integer", "hoopR_bad_request")
  ibba_expect_error(ibba_boards(season = -1), "non-negative integer", "hoopR_bad_request")
  ibba_expect_error(ibba_boards(season = 2026.5), "non-negative integer", "hoopR_bad_request")
  ibba_expect_error(ibba_boards(season = TRUE), "non-negative integer", "hoopR_bad_request")
  ibba_expect_error(ibba_player_stats(player_id = 1, season = 2026, is_averages = "yes"), "must be a bool",
                    "hoopR_bad_request")
  ibba_expect_error(ibba_leaders(stat_type = " ", season = 2026), "non-empty string", "hoopR_bad_request")
  ibba_expect_error(ibba_teams(season = 2026, board_id = NULL), "needs board_id", "hoopR_bad_request")
  expect_length(seen$reqs, 0L)
})

test_that("the Segev runtime refuses every wrong answer with the sdv-py vocabulary", {
  actions <- ibba_json("full/getActions.json.gz")
  with <- function(path, value) {
    out <- actions
    out[[path]] <- value
    out
  }
  err <- function(code, message = "x") {
    list(jsonrpc = "2.0", id = "1", result = list(success = FALSE), error = list(code = code, message = message))
  }
  no_info <- actions
  no_info$result["gameInfo"] <- list(NULL)
  cases <- list(
    list(ibba_resp("", 404L), "hoopR_no_data", "answered HTTP 404"),
    list(ibba_resp(err("-32000", "game not found")), "hoopR_no_data", "game 50 not found"),
    list(ibba_resp(err("-33000")), "hoopR_asset_fetch", "rpc error code '-33000'"),
    list(ibba_resp(err(-32000L)), "hoopR_asset_fetch", "rpc error code -32000"), # an int code is not the string
    list(ibba_resp("", ctype = IBBA_HTML), "hoopR_asset_fetch", "empty body"),
    list(ibba_resp("<html>maintenance</html>", ctype = IBBA_HTML), "hoopR_asset_fetch", "not JSON"),
    list(ibba_resp(list(hello = 1)), "hoopR_asset_fetch", "not a JSON-RPC envelope"),
    list(ibba_resp(with(c("result", "success"), FALSE)), "hoopR_asset_fetch", "success is not true"),
    list(ibba_resp(with(c("result", "gameInfo", "gameId"), "51")), "hoopR_asset_fetch", "out of scope: gameId='51'"),
    list(ibba_resp(with(c("result", "gameInfo", "gameId"), 50L)), "hoopR_asset_fetch", "out of scope: gameId=50"),
    list(ibba_resp(with(c("result", "gameInfo", "gameFinished"), FALSE)), "hoopR_asset_fetch", "is not final"),
    list(ibba_resp(with(c("result", "actions"), list())), "hoopR_no_data", "has no actions"),
    list(ibba_resp(no_info), "hoopR_asset_fetch", "no gameInfo"),
    list(ibba_resp("", 500L), "hoopR_asset_fetch", "HTTP 500"),
    list(ibba_resp("", 400L), "hoopR_bad_request", "HTTP 400")
  )
  for (cs in cases) {
    seen <- local_ibba(function(req) cs[[1]])
    ibba_expect_error(ibba_segev_pbp(game_id = 50), cs[[3]], cs[[2]])
    expect_length(seen$reqs, 1L)
  }
  box <- ibba_json("full/getBoxScore.json.gz")
  b <- box
  b$result$boxscore$gameInfo$gameId <- "419"
  local_ibba(function(req) b)
  ibba_expect_error(ibba_segev_player_box(game_id = 50), "out of scope: gameId='419'", "hoopR_asset_fetch")
  b <- box
  b$result$boxscore$gameInfo$gameFinished <- FALSE
  local_ibba(function(req) b)
  ibba_expect_error(ibba_segev_team_box(game_id = 50), "not final", "hoopR_asset_fetch")
  b <- box
  b$result$boxscore["awayTeam"] <- list(NULL)
  local_ibba(function(req) b)
  ibba_expect_error(ibba_segev_period_scores(game_id = 50), "no boxscore with two teams", "hoopR_asset_fetch")
  local_ibba(ibba_serve("full/getGameInfo.json.gz", IBBA_HTML))
  ibba_expect_error(ibba_segev_game_info(game_id = 419), "out of scope: gameId='50'", "hoopR_asset_fetch")
})

test_that("bad Segev game ids never reach the host", {
  seen <- local_ibba(ibba_serve("full/getGameInfo.json.gz", IBBA_HTML))
  for (bad in list("abc", 0, -3, NULL, TRUE, 2.5, NA)) {
    ibba_expect_error(ibba_segev_game_info(game_id = bad), "game_id must be a positive integer", "hoopR_bad_request")
  }
  expect_length(seen$reqs, 0L)
  expect_identical(nrow(ibba_segev_game_info(game_id = "50")), 1L)
})

test_that("429 / 503 are retried three times, waiting their turn; a dead connection is a fetch error", {
  n <- 0L
  seen <- local_ibba(function(req) {
    n <<- n + 1L
    if (n < 3L) ibba_resp("", 503L) else ibba_resp(ibba_text("cap/Boards_2026.json"))
  })
  expect_identical(nrow(ibba_boards(season = 2026)), 3L)
  expect_length(seen$reqs, 3L)
  seen <- local_ibba(function(req) ibba_resp("", 429L))
  e <- ibba_expect_error(ibba_boards(season = 2026), "HTTP 429", "hoopR_asset_fetch")
  expect_true(e$transient)
  expect_length(seen$reqs, 3L)
  local_ibba(function(req) stop("connection reset"))
  e <- ibba_expect_error(ibba_segev_pbp(game_id = 50), "fetch failed after 3 attempts", "hoopR_asset_fetch")
  expect_true(e$transient)
})

# --- empty payloads ------------------------------------------------------------------------

test_that("an empty valid payload is a zero-row frame with the documented columns and types", {
  for (short in names(.IBBA_ROUTES)) {
    df <- .ibba_parse(short, list())
    expect_identical(nrow(df), 0L)
    want <- .ibba_spec(short)
    expect_identical(vapply(df, function(x) class(x)[[1]], ""), stats::setNames(sub("double", "numeric", want), names(want)),
                     label = short)
  }
  info <- ibba_json("full/getBoxScore.json.gz")$result$boxscore$gameInfo
  bare <- list(jsonrpc = "2.0", error = NULL, result = list(
    success = TRUE, boxscore = list(gameInfo = utils::modifyList(info, list(currentQuarter = 0L)),
                                    homeTeam = list(name = "x"), awayTeam = list(name = "y"))
  ))
  local_ibba(function(req) bare)
  for (fn in c("ibba_segev_player_box", "ibba_segev_team_box", "ibba_segev_period_scores")) {
    df <- do.call(fn, list(game_id = 50))
    short <- sub("^ibba_segev_", "", fn)
    expect_identical(nrow(df), 0L, label = fn)
    want <- .IBBA_SEGEV_SPECS[[short]]
    expect_identical(vapply(df, function(x) class(x)[[1]], ""), stats::setNames(sub("double", "numeric", want), names(want)),
                     label = fn)
  }
  empty <- list(result = list(gameInfo = NULL))
  expect_identical(nrow(.ibba_segev_game_info_frame(empty)), 0L)
  expect_identical(names(.ibba_segev_game_info_frame(empty)), names(.IBBA_SEGEV_SPECS$game_info))
  expect_identical(nrow(.ibba_segev_pbp_frame(empty)), 0L)
  expect_identical(names(.ibba_segev_pbp_frame(empty)), names(.IBBA_SEGEV_SPECS$pbp))
  expect_identical(names(.ibba_segev_rosters_frame(empty)), names(.IBBA_SEGEV_SPECS$rosters))
})

test_that("Segev frames: pbp in game order with away-home scores, box lines add up, tip-off in Israel time", {
  local_ibba(ibba_serve("full/getActions.json.gz", IBBA_HTML))
  pbp <- ibba_segev_pbp(game_id = 50)
  expect_false(is.unsorted(pbp$action_id))
  last <- utils::tail(pbp[!is.na(pbp$score_home), ], 1)
  expect_identical(c(last$score_home, last$score_away), c(92L, 104L)) # Beer Sheva 92-104 Maccabi
  local_ibba(ibba_serve("full/getBoxScore.json.gz", IBBA_HTML))
  team <- ibba_segev_team_box(game_id = 50)
  local_ibba(ibba_serve("full/getBoxScore.json.gz", IBBA_HTML))
  players <- ibba_segev_player_box(game_id = 50)
  expect_identical(as.integer(tapply(players$pts, players$team_side, sum)[c("away", "home")]),
                   team$pts[match(c("away", "home"), team$team_side)])
  expect_identical(team$score, team$pts)
  local_ibba(ibba_serve("full/getGameInfo.json.gz", IBBA_HTML))
  info <- ibba_segev_game_info(game_id = 50)
  expect_identical(attr(info$start_time, "tzone"), "Asia/Jerusalem")
  expect_identical(format(info$start_time, "%Y-%m-%d %H:%M"), "2025-10-12 18:40")
})

# --- live (HOOPR_INTL_LIVE_TESTS=1): two polite requests ------------------------------------

test_that("live: the ASMX boards and a Segev game header answer in the documented shape", {
  skip_intl_live()
  b <- ibba_boards(season = 2026)
  expect_identical(names(b), names(.ibba_spec("boards")))
  expect_true(5L %in% b$board_id)
  g <- ibba_segev_game_info(game_id = 50)
  expect_identical(g$game_id, 50L)
  expect_identical(g$competition, "Winner League")
})
