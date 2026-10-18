# FIBA game pages: the RSC flight payload, parity with sdv-py on the same page, the URL built from
# GDAP and every refusal. Offline: the GDAP getter and the page transport are mocked.

gp_fx <- function(...) testthat::test_path("fixtures", ...)
gp_rsc <- function() {
  con <- gzfile(gp_fx("fiba_gamepage", "page_wc2023_final.rsc.gz"), encoding = "UTF-8")
  on.exit(close(con))
  paste(readLines(con, warn = FALSE), collapse = "\n")
}
gp_key <- "0123456789abcdef0123456789abcdef"
GP_PAGE <- .fiba_scrub(.fiba_extract_page(gp_rsc(), 100720L, "fixture"))
GP_GOOD <- "https://www.fiba.basketball/en/history/201-fiba-basketball-world-cup/208182/games/100720-GER-SRB"
GP_SCHEDULE <- list(list(gameId = 100720L, teamA = list(code = "ger", teamId = 279569L),
                         teamB = list(code = "SRB", teamId = 279961L), competition = list(competitionId = 208182L)))

gp_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
gp_resp <- function(body = "", status = 200L, ctype = "application/json", headers = list()) {
  txt <- if (is.character(body)) body else gp_json(body)
  httr2::response(status_code = status, url = "https://x/y", headers = c(list(`content-type` = ctype), headers),
                  body = charToRaw(enc2utf8(txt)))
}
# A text/x-component stand-in: the page's objects as "key":{...} literals among flight noise.
gp_flight <- function(page) {
  parts <- vapply(names(page), function(k) paste0('"', k, '":', gp_json(page[[k]])), "")
  paste0('0:["$","div",null,{"children":[', paste(parts, collapse = ","), '],"ui":{"playByPlay":{"timeout":5}}}]\n')
}
gp_ok <- function(page = GP_PAGE) gp_resp(gp_flight(page), ctype = "text/x-component; charset=utf-8")
GP_SHELL <- paste0('0:["$","html",null,{"ui":{"playByPlay":{"timeout":5}},"children":"', strrep("x", 120000), '"}]\n')

# Mock GDAP (answers by method) and the page transport (answers by URL, "*" = any). Returns the log.
gp_net <- function(gdap = list(), pages = list(), env = parent.frame()) {
  log <- new.env()
  log$gdap <- character()
  log$pages <- character()
  log$headers <- list()
  .fiba_cache_reset()
  withr::defer(.fiba_cache_reset(), envir = env)
  defaults <- list(getGdapCompetitionById = jsonlite::read_json(gp_fx("fiba_gdap", "competition_wc2023.json")),
                   getgdapgamesbycompetitionid = GP_SCHEDULE)
  defaults[names(gdap)] <- gdap
  gdap <- defaults
  testthat::local_mocked_bindings(
    .intl_response = function(url, query = list(), headers = NULL, ...) {
      if (identical(url, .FIBA_KEY_PAGE)) return(gp_resp(paste0('"NEXT_CLIENT_APIM_SUBSCRIPTION_KEY":"', gp_key, '"'), ctype = "text/html"))
      method <- sub(".*/", "", url)
      log$gdap <- c(log$gdap, method)
      a <- gdap[[method]]
      if (is.null(a)) stop("unexpected request: ", method)
      if (inherits(a, "httr2_response")) a else gp_resp(a)
    },
    .fiba_fetch_page = function(url, headers = list(), follow = TRUE, call = NULL) {
      log$pages <- c(log$pages, url)
      log$headers[[length(log$headers) + 1L]] <- headers
      a <- pages[[url]] %||% pages[["*"]]
      if (is.null(a)) stop("unexpected page: ", url)
      a
    },
    .package = "hoopR", .env = env
  )
  log
}

test_that("the live RSC payload extracts to exactly sdv-py's page fixture objects", {
  expect_identical(names(GP_PAGE), c("game", "playByPlay", "gameDetails", "playersTeamA", "playersTeamB"))
  expect_identical(GP_PAGE$gameDetails$id, 100720L)
  expect_true(length(GP_PAGE$playByPlay$items$Q1$items) > 0L)
})

test_that("every fiba_gamepage route matches sdv-py's frame on the same page (columns, types, values)", {
  dts <- utils::read.csv(gp_fx("fiba_gdap", "parity", "dtypes.csv"), stringsAsFactors = FALSE)
  rtype <- c(Int64 = "integer", Float64 = "double", Boolean = "logical", String = "character")
  elw <- jsonlite::read_json(gp_fx("fiba_gamepage", "page_elw2025.json"))
  cases <- c(lapply(c("box_players", "box_teams", "lineup", "pbp", "period_scores", "shots"),
                    function(r) list(route = r, page = GP_PAGE, csv = paste0(r, ".csv"))),
             list(list(route = "pbp", page = elw, csv = "pbp_elw2025.csv"))) # FLS
  for (cs in cases) {
    route <- paste0("fiba_gamepage_", cs$route)
    df <- .fiba_gamepage_parse(cs$route, cs$page)
    ref <- utils::read.csv(gp_fx("fiba_gamepage", "parity", cs$csv), colClasses = "character", na.strings = "NA",
                           check.names = FALSE, encoding = "UTF-8")
    expect_identical(names(df), names(ref), label = cs$csv)
    expect_equal(nrow(df), nrow(ref), label = cs$csv)
    d <- dts[dts$route == route, ]
    want <- rtype[d$dtype]
    want[d$column == "wall_time_ms"] <- "double"
    expect_identical(vapply(df, typeof, "")[d$column], stats::setNames(unname(want), d$column), label = cs$csv)
    mis <- vapply(names(ref), function(col) {
      x <- df[[col]]
      y <- ref[[col]]
      both <- !is.na(x) & !is.na(y)
      vals <- if (is.numeric(x)) abs(x[both] - as.numeric(y[both])) > 1e-9
              else if (is.logical(x)) tolower(as.character(x[both])) != y[both] else x[both] != y[both]
      sum(is.na(x) != is.na(y)) + sum(vals)
    }, numeric(1))
    expect_true(all(mis == 0), label = paste(cs$csv, paste(names(mis)[mis > 0], collapse = ",")))
  }
})

test_that("ids are integer and a page with no play-by-play parses to zero-row typed frames", {
  pbp <- .fiba_gamepage_parse("pbp", GP_PAGE)
  for (col in c("game_id", "competition_id", "organisation_id", "player_id")) expect_type(pbp[[col]], "integer")
  expect_type(pbp$wall_time_ms, "double")
  box_only <- GP_PAGE[names(GP_PAGE) != "playByPlay"]
  for (route in c("pbp", "shots")) {
    df <- .fiba_gamepage_parse(route, box_only)
    expect_equal(nrow(df), 0L)
    expect_identical(names(df), names(.FIBA_DTYPES[[paste0("fiba_gamepage_", route)]]))
  }
  for (route in c("box_players", "box_teams", "lineup", "pbp", "period_scores", "shots")) {
    expect_equal(nrow(.fiba_gamepage_parse(route, list())), 0L)
    expect_equal(nrow(.fiba_gamepage_parse(route, "junk")), 0L)
  }
})

test_that("the page URL is built from GDAP, the RSC header is sent and GDAP is read once per competition", {
  log <- gp_net(pages = list("*" = gp_ok()))
  df <- fiba_gamepage_pbp(game_id = 100720, comp = 208182)
  expect_s3_class(df, "hoopR_data")
  expect_equal(nrow(df), 497L)
  expect_identical(log$pages, GP_GOOD) # team codes upper-cased from the schedule, slug from the marketing name
  expect_identical(log$headers[[1]]$RSC, "1")
  raw <- fiba_gamepage_box_teams(game_id = 100720, comp = 208182, return_parsed = FALSE)
  expect_identical(names(raw), c("game", "playByPlay", "gameDetails", "playersTeamA", "playersTeamB"))
  expect_equal(sum(log$gdap == "getgdapgamesbycompetitionid"), 1L)
  expect_equal(sum(log$gdap == "getGdapCompetitionById"), 1L)
})

test_that("history slugs follow the documented rule", {
  expect_identical(.fiba_slugify("FIBA Basketball World Cup"), "fiba-basketball-world-cup")
  expect_identical(.fiba_slugify("FIBA Men\u2019s European Club Competitions \u2013 Tier 1"),
                   "fiba-mens-european-club-competitions-tier-1")
  expect_identical(.fiba_slugify("Men's Olympic Basketball Tournament"), "mens-olympic-basketball-tournament")
})

test_that("comp and game_id are checked before any request", {
  gp_net()
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182.5), class = "hoopR_bad_request")
  expect_error(fiba_gamepage_pbp(game_id = "x", comp = 208182), class = "hoopR_bad_request")
  expect_error(.fiba_page(100720L, NULL), "comp", class = "hoopR_bad_request")
})

test_that("an unknown game is no_data; a game of another edition is refused before any page request", {
  log <- gp_net(gdap = list(getgdapgamebyid = "{}"))
  expect_error(fiba_gamepage_pbp(game_id = 999, comp = 208182), "FIBA has no game 999", class = "hoopR_no_data")
  other <- jsonlite::read_json(gp_fx("fiba_gdap", "game_bcl2025.json"))
  log <- gp_net(gdap = list(getgdapgamebyid = other), pages = list("*" = gp_ok()))
  expect_error(fiba_gamepage_pbp(game_id = other$gameId, comp = 208182), "another\\s+edition", class = "hoopR_asset_fetch")
  expect_length(log$pages, 0L)
  expect_equal(sum(log$gdap == "getgdapgamesbycompetitionid"), 2L) # the cached schedule is refreshed once
})

test_that("a scheduled game without its teams (a null teamA / teamB included) is no_data and never looked up", {
  for (bad in list(list(teamB = list(code = NULL)), list(teamA = NULL), list(teamB = NULL))) {
    sched <- GP_SCHEDULE
    sched[[1]][names(bad)] <- bad
    log <- gp_net(gdap = list(getgdapgamesbycompetitionid = sched))
    expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "without its two team codes",
                 class = "hoopR_no_data")
    expect_false("getgdapgamebyid" %in% log$gdap)
  }
})

test_that("the not-found shell is refused after the event page and Champions League fallbacks", {
  log <- gp_net(pages = list("*" = gp_resp(GP_SHELL, ctype = "text/x-component")))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "not-found shell", class = "hoopR_asset_fetch")
  expect_true(any(grepl("championsleague", log$pages)))
  event <- "https://www.fiba.basketball/en/events/world-cup-2023/games/100720-GER-SRB"
  redirect <- gp_resp("", 307L, "text/html", list(location = "https://www.fiba.basketball/en/events/world-cup-2023"))
  pages <- list(gp_resp(GP_SHELL, ctype = "text/x-component"), redirect, gp_ok())
  names(pages) <- c(GP_GOOD, "https://www.fiba.basketball/en/history/201-fiba-basketball-world-cup/208182", event)
  log <- gp_net(pages = pages)
  expect_equal(nrow(fiba_gamepage_lineup(game_id = 100720, comp = 208182)), 24L)
  expect_identical(log$pages[[3]], event)
  expect_length(log$pages, 3L)
})

test_that("a page of another game, competition or box score, a header-only page and a live game are refused", {
  other <- GP_PAGE
  other$game$gameId <- 555L
  gp_net(pages = list("*" = gp_ok(other)))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "not-found shell", class = "hoopR_asset_fetch")
  other <- GP_PAGE
  other$game$competition$competitionId <- 208722L
  gp_net(pages = list("*" = gp_ok(other)))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "competition", class = "hoopR_asset_fetch")
  other <- GP_PAGE
  other$gameDetails$id <- "100720" # a string is not the integer the page sends
  gp_net(pages = list("*" = gp_ok(other)))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "box score is for game", class = "hoopR_asset_fetch")
  gp_net(pages = list("*" = gp_ok(GP_PAGE[c("game", "playersTeamA", "playersTeamB")])))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "no box score", class = "hoopR_no_data")
  live <- GP_PAGE
  live$game$isLive <- TRUE
  gp_net(pages = list("*" = gp_ok(live)))
  expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), "still live", class = "hoopR_asset_fetch")
})

test_that("page HTTP failures use the error vocabulary", {
  cases <- list(
    list(gp_resp("<html>denied</html>", 403L, "text/html"), "hoopR_asset_fetch"),
    list(gp_resp("", 404L, "text/html"), "hoopR_no_data"),
    list(gp_resp("<html>page</html>", 200L, "text/html"), "hoopR_asset_fetch"),
    list(gp_resp("", 200L, "text/x-component"), "hoopR_asset_fetch"),
    list(gp_resp("x", 400L, "text/html"), "hoopR_bad_request")
  )
  for (cs in cases) {
    gp_net(pages = list("*" = cs[[1]]))
    expect_error(fiba_gamepage_pbp(game_id = 100720, comp = 208182), class = cs[[2]])
  }
})

test_that("flight tokens are resolved, back-references copied, and unknown tokens fail closed", {
  page <- GP_PAGE
  page$gameDetails$teamA <- "$1a:props:gameDetails:c:0"
  page$playByPlay$items$Q1$items[[1]]$txt <- "$undefined"
  page$game$note <- "$$literal"
  page$game$when <- "$D2023-09-10T20:00:00"
  out <- .fiba_extract_page(gp_flight(page), 100720L, "w")
  expect_identical(out$gameDetails$teamA, GP_PAGE$gameDetails$c[[1]])
  expect_true("txt" %in% names(out$playByPlay$items$Q1$items[[1]]))
  expect_null(out$playByPlay$items$Q1$items[[1]]$txt)
  expect_identical(out$game$note, "$literal")
  expect_identical(out$game$when, "2023-09-10T20:00:00")
  for (token in c("$Zweird", "$L12", "$1a:props:nowhere:x", "$1a:props:gameDetails:c:99", "$1a:props:gameDetails:nope")) {
    bad <- GP_PAGE
    bad$game$note <- token
    expect_error(.fiba_extract_page(gp_flight(bad), 100720L, "w"), "flight", class = "hoopR_asset_fetch")
  }
  # the UI's {"playByPlay":{"timeout":5}} config is not the play-by-play
  out <- .fiba_extract_page(gp_flight(GP_PAGE), 100720L, "w")
  expect_true("items" %in% names(out$playByPlay))
  expect_false("timeout" %in% names(out$playByPlay))
})

test_that("live: the World Cup 2023 final play-by-play", {
  skip_intl_live()
  .fiba_cache_reset()
  df <- fiba_gamepage_pbp(game_id = 100720, comp = 208182)
  expect_gt(nrow(df), 400L)
  expect_identical(names(df), names(.FIBA_DTYPES$fiba_gamepage_pbp))
})
