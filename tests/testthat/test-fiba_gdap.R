# FIBA GDAP wrappers: parity with sdv-py on the same fixtures, the refusal vocabulary, the key,
# the scope checks and the per-competition aliases. Offline: the runtime getter is mocked.

fiba_fx <- function(...) testthat::test_path("fixtures", ...)
fiba_json <- function(name) jsonlite::read_json(fiba_fx("fiba_gdap", name))
fiba_key <- "0123456789abcdef0123456789abcdef"

# An httr2 response; a list body is sent as JSON.
fiba_resp <- function(body = NULL, status = 200L, ctype = "application/json", headers = list()) {
  txt <- if (is.character(body)) body else if (is.null(body)) "" else
    as.character(jsonlite::toJSON(body, auto_unbox = TRUE, null = "null"))
  httr2::response(status_code = status, url = "https://digital-api.fiba.basketball/hapi/x",
                  headers = c(list(`content-type` = ctype), headers), body = charToRaw(enc2utf8(txt)))
}

# Mock the runtime getter: answers by GDAP method (a body, a fiba_resp(), a function of the query,
# or a list of those consumed in order via `seq`). Returns the call log.
fiba_net <- function(answers = list(), env = parent.frame()) {
  log <- new.env()
  log$calls <- list()
  .fiba_cache_reset()
  withr::defer(.fiba_cache_reset(), envir = env)
  testthat::local_mocked_bindings(
    .intl_response = function(url, query = list(), headers = NULL, retry_500 = FALSE, ...) {
      log$calls[[length(log$calls) + 1L]] <- list(url = url, query = query, headers = headers, retry_500 = retry_500)
      if (identical(url, .FIBA_KEY_PAGE)) {
        return(fiba_resp(paste0('self.__next_f.push([1,"{\\"NEXT_CLIENT_APIM_SUBSCRIPTION_KEY\\":\\"',
                                fiba_key, '\\",\\"x\\":1}"])'), ctype = "text/html"))
      }
      method <- sub(".*/", "", url)
      a <- answers[[method]]
      if (is.null(a)) stop("unexpected request: ", method)
      if (inherits(a, "fiba_seq")) {
        answers[[method]] <<- structure(a[-1], class = "fiba_seq")
        a <- a[[1]]
      }
      if (is.function(a)) a <- a(query)
      if (inherits(a, "httr2_response")) a else fiba_resp(a)
    },
    .package = "hoopR", .env = env
  )
  log
}
fiba_seq <- function(...) structure(list(...), class = "fiba_seq")
gdap_calls <- function(log) Filter(function(c) !identical(c$url, .FIBA_KEY_PAGE), log$calls)

fiba_parity_routes <- function() {
  readme <- readLines(fiba_fx("fiba_gdap", "README.md"))
  tab <- grep("^\\| fiba_gdap_", readme, value = TRUE)
  lapply(strsplit(tab, "|", fixed = TRUE), function(f) {
    f <- trimws(f)
    list(route = sub("fiba_gdap_", "", f[[2]]), csv = f[[3]], fixture = sub(".* -> ", "", f[[4]]))
  })
}

# R type of each sdv-py polars dtype (wall_time_ms is Int64 held as double: see fiba_gdap_dtypes.R)
fiba_rtype <- c(Int64 = "integer", Float64 = "double", Boolean = "logical", String = "character")

# Mismatches of an R frame against an sdv-py CSV; NA-vs-value counts as a mismatch.
fiba_mismatches <- function(df, ref) {
  vapply(names(ref), function(col) {
    x <- df[[col]]
    y <- ref[[col]]
    both <- !is.na(x) & !is.na(y)
    vals <- if (is.numeric(x)) abs(x[both] - as.numeric(y[both])) > 1e-9
            else if (is.logical(x)) tolower(as.character(x[both])) != y[both]
            else x[both] != y[both]
    sum(is.na(x) != is.na(y)) + sum(vals)
  }, numeric(1))
}

fiba_dtypes <- function() utils::read.csv(fiba_fx("fiba_gdap", "parity", "dtypes.csv"), stringsAsFactors = FALSE)

test_that("every fiba_gdap route matches sdv-py's frame on the same fixture (columns, types, values)", {
  dts <- fiba_dtypes()
  routes <- fiba_parity_routes()
  expect_length(routes, 31L)
  for (r in routes) {
    df <- .fiba_gdap_parse(r$route, fiba_json(r$fixture))
    ref <- intl_read_oracle(fiba_fx("fiba_gdap", r$csv))
    route <- paste0("fiba_gdap_", r$route)
    expect_identical(names(df), names(ref), label = route)
    expect_identical(names(df), names(.FIBA_DTYPES[[route]]), label = route)
    expect_equal(nrow(df), nrow(ref), label = route)
    d <- dts[dts$route == route, ]
    want <- fiba_rtype[d$dtype]
    want[d$column == "wall_time_ms"] <- "double"
    expect_identical(vapply(df, typeof, "")[d$column], stats::setNames(unname(want), d$column), label = route)
    mis <- fiba_mismatches(df, ref)
    expect_true(all(mis == 0), label = paste(route, paste(names(mis)[mis > 0], collapse = ",")))
  }
})

test_that("ids are integer, never a stringified float", {
  sched <- .fiba_gdap_parse("schedule", fiba_json("schedule_wc2023.json"))
  for (col in c("game_id", "team_a_team_id", "team_a_organisation_id", "competition_competition_id")) {
    expect_type(sched[[col]], "integer")
  }
  expect_identical(.fiba_gdap_parse("gateway_competition_ids", fiba_json("gateway_competition_ids.json"))$competition_id,
                   vapply(fiba_json("gateway_competition_ids.json")$competitionIds, as.integer, 1L))
})

test_that("an empty or malformed body parses to a zero-row tibble with the documented columns", {
  for (route in sub("fiba_gdap_", "", grep("^fiba_gdap_", names(.FIBA_DTYPES), value = TRUE))) {
    for (raw in list(list(), NULL, "junk", list(list(1, 2)))) {
      df <- .fiba_gdap_parse(route, raw)
      expect_equal(nrow(df), 0L, label = route)
      expect_identical(names(df), names(.FIBA_DTYPES[[paste0("fiba_gdap_", route)]]), label = route)
    }
  }
  empty <- .fiba_gdap_parse("schedule", list())
  expect_type(empty$game_id, "integer")
  expect_type(empty$game_name, "character")
})

test_that("a wrapper sends the documented query, the APIM key and never retries HTTP 500", {
  log <- fiba_net(list(getgdapcompetitionfinalstandingbycompetitionid = fiba_json("final_standings_wc2023.json")))
  df <- fiba_gdap_final_standings(comp = 208182)
  expect_s3_class(df, "hoopR_data")
  calls <- gdap_calls(log)
  expect_length(calls, 1L)
  expect_identical(calls[[1]]$query, list(profile = "true", gdapCompetitionId = 208182L))
  expect_identical(calls[[1]]$headers[[.FIBA_KEY_HEADER]], fiba_key)
  expect_false(calls[[1]]$retry_500)
  raw <- fiba_gdap_final_standings(comp = "208182", return_parsed = FALSE)
  expect_identical(raw$competition$competitionId, 208182L)
})

test_that("the key page is read once; an unreadable page falls back to the documented key", {
  log <- fiba_net(list(getgdaprankingzones = fiba_json("ranking_zones.json")))
  fiba_gdap_ranking_zones()
  fiba_gdap_ranking_zones()
  expect_equal(sum(vapply(log$calls, function(c) identical(c$url, .FIBA_KEY_PAGE), TRUE)), 1L)
  .fiba_cache_reset()
  testthat::local_mocked_bindings(.intl_get = function(...) .abort_asset_fetch("down"), .package = "hoopR")
  expect_identical(.fiba_api_key(), .FIBA_FALLBACK_KEY)
})

test_that("a 401 re-reads the key once; two 401s raise without the key in the message", {
  log <- fiba_net(list(getgdaprankingzones = fiba_seq(fiba_resp("", 401L), fiba_json("ranking_zones.json"))))
  expect_equal(nrow(fiba_gdap_ranking_zones()), 3L)
  expect_equal(sum(vapply(log$calls, function(c) identical(c$url, .FIBA_KEY_PAGE), TRUE)), 2L)
  fiba_net(list(getgdaprankingzones = fiba_seq(fiba_resp("", 401L), fiba_resp("", 401L))))
  err <- expect_error(fiba_gdap_ranking_zones(), class = "hoopR_asset_fetch")
  expect_false(grepl(fiba_key, conditionMessage(err)))
  expect_equal(err$status, 401L)
})

test_that("the error vocabulary: 404 / {} / [] / null are no_data, 400 is bad_request, the rest asset_fetch", {
  cases <- list(
    list(fiba_resp("", 404L), "hoopR_no_data"),
    list(fiba_resp("{}"), "hoopR_no_data"),
    list(fiba_resp("[]"), "hoopR_no_data"),
    list(fiba_resp("null"), "hoopR_no_data"),
    list(fiba_resp("x", 400L), "hoopR_bad_request"),
    list(fiba_resp("", 500L), "hoopR_asset_fetch"),
    list(fiba_resp("<html>", 200L, "text/html"), "hoopR_asset_fetch"),
    list(fiba_resp(""), "hoopR_asset_fetch"),
    list(list(statusCode = 401L, message = "Access denied"), "hoopR_asset_fetch"),
    list(list(Error = "bad"), "hoopR_asset_fetch"),
    list(list(list(1L, list(2L))), "hoopR_asset_fetch")
  )
  for (case in cases) {
    fiba_net(list(getgdapgamesbycompetitionid = case[[1]]))
    expect_error(fiba_gdap_schedule(comp = 208182), class = case[[2]])
  }
  fiba_net(list(getgdapgamesbycompetitionid = fiba_resp("", 500L)))
  err <- expect_error(fiba_gdap_schedule(comp = 208182), class = "hoopR_asset_fetch")
  expect_true(err$transient)
})

test_that("rows of another competition are refused, type-strictly, never skipped", {
  rows <- function(cid, n = 2L) lapply(seq_len(n), function(i) list(gameId = 100720L + i, competition = list(competitionId = cid)))
  for (bad in list(rows(208722L), rows("208182"), rows(208182.5), c(rows(208182L), rows(1L, 1L)),
                   list(list(gameId = 1L)))) {
    fiba_net(list(getgdapgamesbycompetitionid = bad))
    expect_error(fiba_gdap_schedule(comp = 208182), "outside the request", class = "hoopR_asset_fetch")
  }
  fiba_net(list(getgdapgamesbycompetitionid = rows(208182L)))
  expect_equal(nrow(fiba_gdap_schedule(comp = 208182)), 2L)
})

test_that("every scoped route refuses a body for another entity", {
  cases <- list(
    list(function() fiba_gdap_game(game_id = 1), "getgdapgamebyid", fiba_json("game_wc2023_final.json")),
    list(function() fiba_gdap_competition(comp = 1), "getGdapCompetitionById", fiba_json("competition_wc2023.json")),
    list(function() fiba_gdap_teams(comp = 1), "getgdapcompetitionteamsbycompetitionid", fiba_json("teams_wc2023.json")),
    list(function() fiba_gdap_awards(comp = 1), "getgdapcompetitionawardsbyid", fiba_json("awards_wc2023.json")),
    list(function() fiba_gdap_nominations(comp = 1), "getgdapcompetitionnominationsbyid", fiba_json("nominations_wc2023.json")),
    list(function() fiba_gdap_roster(team_id = 1), "getgdapcompetitionteamrosterbyteamid", fiba_json("roster_wc2023_ger.json")),
    list(function() fiba_gdap_team_stats(team_id = 1), "getgdapcompetitionteamstatisticsbyteamid", fiba_json("team_stats_wc2023_ger.json")),
    list(function() fiba_gdap_team_games(team_id = 1), "getgdapgameswithleaderdetailsbyteamid", fiba_json("team_games_wc2023_ger.json")),
    list(function() fiba_gdap_player_info(player_id = 211501, comp = 1), "getgdapplayerinfobycompetitionid", fiba_json("player_info_bonga.json")),
    list(function() fiba_gdap_federation_games(federation_id = 1), "getgdapfederationgamesbyfederationid", fiba_json("federation_games_ger.json")),
    list(function() fiba_gdap_editions(family_id = 1), "getgdapcompetitionsbyseasonsandcompetitionmarketingname", fiba_json("editions_wc.json"))
  )
  for (case in cases) {
    answers <- list()
    answers[[case[[2]]]] <- case[[3]]
    fiba_net(answers)
    expect_error(case[[1]](), class = "hoopR_asset_fetch", label = case[[2]])
  }
})

test_that("a federation game where either side is the asked federation is accepted", {
  fiba_net(list(getgdapfederationgamesbyfederationid = list(
    list(gameId = 1L, teamA = list(organisationId = 64L), teamB = list(organisationId = 9L)),
    list(gameId = 2L, teamA = list(organisationId = 9L), teamB = list(organisationId = 64L))
  )))
  expect_equal(nrow(fiba_gdap_federation_games(federation_id = 64)), 2L)
})

test_that("the date window is checked on the venue-local time and dateTo is exclusive", {
  game <- function(at) list(list(gameId = 1L, gameDateTime = at))
  log <- fiba_net(list(getgdapgamesbetweentwodates = game("2023-09-10T20:00:00")))
  expect_equal(nrow(fiba_gdap_games_between(date_from = "2023-09-08", date_to = as.Date("2023-09-11"))), 1L)
  expect_identical(gdap_calls(log)[[1]]$query, list(dateFrom = "2023-09-08T00:00:00Z", dateTo = "2023-09-11T00:00:00Z"))
  for (at in list("2023-09-11T00:00:00", "2023-09-07T23:59:59", NULL)) {
    fiba_net(list(getgdapgamesbetweentwodates = game(at)))
    expect_error(fiba_gdap_games_between("2023-09-08", "2023-09-11"), "outside", class = "hoopR_asset_fetch")
  }
  expect_error(fiba_gdap_games_between("2023/09/08", "2023-09-11"), class = "hoopR_bad_request")
})

test_that("season maps unchanged (END year for clubs, event year for national events) and one season means only it", {
  ed <- function(season) list(list(competitionId = 1L, season = season,
                                   competitionMarketingName = list(competitionMarketingNameId = 112L)))
  log <- fiba_net(list(getgdapcompetitionsbyseasonsandcompetitionmarketingname = ed(2025L)))
  fiba_gdap_editions(family_id = 112, season = 2025)
  expect_identical(gdap_calls(log)[[1]]$query,
                   list(competitionMarketingNameId = 112L, fromSeason = 2025L, toSeason = 2025L))
  fiba_net(list(getgdapcompetitionsbyseasonsandcompetitionmarketingname = ed(2024L)))
  expect_error(fiba_gdap_editions(family_id = 112, season = 2025), "outside", class = "hoopR_asset_fetch")
  fiba_net(list(getgdapcompetitionsbyseasonsandcompetitionmarketingname = ed("2025")))
  expect_error(fiba_gdap_editions(family_id = 112, season = 2025), class = "hoopR_asset_fetch")
  expect_identical(.fiba_season(2023), 2023L)
  expect_identical(.fiba_season("2025"), 2025L)
  for (bad in list(1949, 2101, 2023.5, "20x3", TRUE)) expect_error(.fiba_season(bad), class = "hoopR_bad_request")
})

test_that("ids: integers, whole numbers and digit strings pass; fractions, logicals and text are refused", {
  expect_identical(.fiba_int_id(208182), 208182L)
  expect_identical(.fiba_int_id("208182"), 208182L)
  expect_null(.fiba_int_id(NULL))
  for (bad in list(208182.5, TRUE, "abc", c(1, 2), NA)) expect_error(.fiba_int_id(bad), class = "hoopR_bad_request")
  expect_error(fiba_gdap_schedule(comp = 1.5), class = "hoopR_bad_request")
})

test_that("contact details and coaches' / officials' dates of birth are dropped; players' are kept", {
  body <- list(teamId = 279569L, players = list(list(personId = 1L, dateOfBirth = "1999-01-01", email = "x@y")),
               coaches = list(list(personId = 2L, dateOfBirth = "1970-01-01", phone = "1")))
  clean <- .fiba_scrub(body)
  expect_identical(clean$players[[1]]$dateOfBirth, "1999-01-01")
  expect_null(clean$players[[1]]$email)
  expect_null(clean$coaches[[1]]$dateOfBirth)
  expect_null(clean$coaches[[1]]$phone)
  nom <- .fiba_scrub(list(list(personId = 3L, dateOfBirth = "1980-01-01")), root_staff = TRUE)
  expect_null(nom[[1]]$dateOfBirth)
  fiba_net(list(getgdapgamebyid = function(q) {
    g <- fiba_json("game_wc2023_final.json")
    g$nominations[[1]]$dateOfBirth <- "1975-05-05"
    g
  }))
  raw <- fiba_gdap_game(game_id = 100720, return_parsed = FALSE)
  expect_null(raw$nominations[[1]]$dateOfBirth)
})

# --- per-competition aliases ------------------------------------------------------------------

fiba_suffixes <- c("editions", "schedule", "standings", "teams", "player_box", "team_box", "pbp", "shots")

test_that("the aliases are sdv-py's minted names, from the registry, with sdv-py's arguments", {
  prefixes <- vapply(.intl_basketball_competitions$fiba, `[[`, "", "prefix")
  expect_identical(.fiba_alias_names(), as.vector(t(outer(prefixes, fiba_suffixes, paste, sep = "_"))))
  ns <- asNamespace("hoopR")
  exported <- getNamespaceExports(ns)
  for (n in .fiba_alias_names()) {
    expect_true(n %in% exported, label = n)
    want <- if (endsWith(n, "_editions")) c("season", "to_season", "return_parsed")
            else if (grepl("_(player_box|team_box|pbp|shots)$", n)) c("game_id", "season", "comp", "return_parsed")
            else c("season", "comp", "return_parsed")
    expect_identical(names(formals(get(n, envir = ns))), want, label = n)
  }
})

fiba_comp_wc <- function() fiba_json("competition_wc2023.json")

test_that("an alias checks comp is an edition of its family (the wrong-edition refusal)", {
  log <- fiba_net(list(getGdapCompetitionById = fiba_comp_wc(),
                       getgdapgamesbycompetitionid = fiba_json("schedule_wc2023.json")))
  expect_equal(nrow(fiba_wc_schedule(comp = 208182)), 3L)
  expect_error(fiba_bcl_schedule(comp = 208182), "edition of family 201", class = "hoopR_asset_fetch")
  fiba_bcl_schedule_calls <- vapply(gdap_calls(log), function(c) sub(".*/", "", c$url), "")
  expect_equal(sum(fiba_bcl_schedule_calls == "getGdapCompetitionById"), 1L) # cached per session
  nofam <- fiba_comp_wc()
  nofam$competitionMarketingName <- NULL
  fiba_net(list(getGdapCompetitionById = nofam))
  expect_error(fiba_wc_teams(comp = 208182), "no competition family", class = "hoopR_asset_fetch")
})

test_that("an alias season picks the family's one edition of that season", {
  ed <- function(...) lapply(list(...), function(x) list(competitionId = x[[1]], season = x[[2]], start = x[[3]],
    competitionMarketingName = list(competitionMarketingNameId = 201L)))
  log <- fiba_net(list(
    getgdapcompetitionsbyseasonsandcompetitionmarketingname = ed(list(208182L, 2023L, "2023-08-25")),
    getgdapgamesbycompetitionid = fiba_json("schedule_wc2023.json")
  ))
  expect_equal(nrow(fiba_wc_schedule(season = 2023)), 3L)
  q <- gdap_calls(log)[[1]]$query
  expect_identical(q, list(competitionMarketingNameId = 201L, fromSeason = 2023L, toSeason = 2023L))
  fiba_net(list(getgdapcompetitionsbyseasonsandcompetitionmarketingname =
                  ed(list(1L, 2027L, "2025-11-27"), list(2L, 2027L, "2026-02-26"))))
  expect_error(fiba_wc_schedule(season = 2027), "several editions", class = "hoopR_bad_request")
  # omitted: the newest edition that has started
  log <- fiba_net(list(
    getgdapcompetitionsbyseasonsandcompetitionmarketingname = ed(list(208182L, 2023L, "2023-08-25"),
                                                                 list(9L, 2099L, "2099-08-25")),
    getgdapcompetitionfinalstandingbycompetitionid = fiba_json("final_standings_wc2023.json")
  ))
  expect_equal(nrow(fiba_wc_standings()), 3L)
  expect_identical(gdap_calls(log)[[2]]$query$gdapCompetitionId, 208182L)
  expect_error(fiba_wc_pbp(game_id = 100720), "pass", class = "hoopR_bad_request")
})

test_that("live: the World Cup 2023 schedule", {
  skip_intl_live()
  .fiba_cache_reset()
  df <- fiba_gdap_schedule(comp = 208182)
  expect_gt(nrow(df), 0L)
  expect_in(names(.FIBA_DTYPES$fiba_gdap_schedule), names(df))
  expect_type(df$game_id, "integer")
})
