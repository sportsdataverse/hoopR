# Atrium runtime: season mapping, every refusal and the error vocabulary (mocked
# getter). Port of sdv-py tests/basketball/test_atrium_runtime.py.

atrium_fx <- function(name) {
  paste(readLines(testthat::test_path("fixtures", "atrium", name), warn = FALSE, encoding = "UTF-8"), collapse = "\n")
}
atrium_body <- function(name) jsonlite::parse_json(atrium_fx(name))
atrium_json <- function(x) as.character(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null", digits = NA))
atrium_clear_cache <- function() rm(list = ls(.atrium_seasons_cache), envir = .atrium_seasons_cache)

# messages are matched whole: no cli line wrapping
withr::local_options(cli.width = 10000, .local_envir = testthat::teardown_env())

BASE <- "https://embed-api.eui.connect.sportradar.com/v1/embed"
F14 <- "0dc631bd-c34c-11f1-8d16-4d5a21afb79d"
F12 <- "5423072b-6715-11f0-bd8b-9ffadebc148f"
PERSON <- "4458f165-f865-11f0-8ebf-539c931c1654"
TEAM <- "f43b1b0f-55bc-11f0-84d9-01499d2f0a07"
NIL <- "00000000-0000-1000-8000-000000000000"

# Install a scripted getter: answer(url, query) returns a body (list -> JSON, or text).
wire <- function(answer, env = parent.frame()) {
  calls <- new.env()
  calls$log <- list()
  local_mocked_bindings(.intl_get = function(url, query = list(), ...) {
    calls$log[[length(calls$log) + 1L]] <- list(url = url, query = query)
    out <- answer(url, query)
    if (is.character(out)) out else atrium_json(out)
  }, .env = env)
  atrium_clear_cache()
  calls
}
serve <- function(b) function(url, query) b

# --- seasons -------------------------------------------------------------------------

test_that("the END year maps to the seasonId on a start-year site (LNB)", {
  lnb <- atrium_body("12__fixtures.json")
  calls <- wire(serve(lnb))
  s <- .atrium_parse_seasons(lnb)
  row <- s[s$competition_id == "3f4064bb-51ad-11f0-aaaf-2923c944b404", ]
  expect_identical(row$year, 2025L)
  expect_identical(atrium_season_id(12, 2026, row$competition_id), row$season_id)
  expect_identical(calls$log, list(list(url = paste0(BASE, "/12/fixtures"), query = list())))
  expect_error(atrium_season_id(12, 2025, row$competition_id), class = "hoopR_no_data") # 2025 is the START year
})

test_that("the END year is the calendar year on LNBP", {
  b <- atrium_body("14__fixtures__default.json")
  wire(serve(b))
  row <- .atrium_parse_seasons(b)[1, ]
  expect_identical(atrium_season_id(14, row$year, row$competition_id), row$season_id)
})

test_that("a shared END year needs a competition; an unlisted one is no_data", {
  wire(serve(atrium_body("12__fixtures.json")))
  expect_error(atrium_season_id(12, 2026), "ambiguous", class = "hoopR_bad_request")
  expect_error(atrium_season_id(12, 1999), "no season with END year 1999", class = "hoopR_no_data")
  expect_error(atrium_season_id(12, 2026, "nope"), "for competition nope", class = "hoopR_no_data")
})

test_that("unmappable sites and bad years are refused before any request", {
  calls <- wire(function(url, query) stop("no request expected"))
  for (site in c(999, 236)) expect_error(atrium_season_id(site, 2026), "season_id", class = "hoopR_bad_request")
  for (bad in list("2026", 2026.5, TRUE, NULL, NA)) {
    expect_error(atrium_season_id(12, bad), "END year", class = "hoopR_bad_request")
  }
  expect_error(atrium_fixtures("12"), class = "hoopR_bad_request")
  expect_length(calls$log, 0L)
})

test_that("the season list is fetched once per site, and again after its hour", {
  lnb <- atrium_body("12__fixtures.json")
  calls <- wire(serve(lnb))
  clock <- 1000
  local_mocked_bindings(.intl_now = function() clock)
  row <- .atrium_parse_seasons(lnb)[1, ]
  for (i in 1:3) atrium_season_id(12, row$season_end_year, row$competition_id)
  expect_length(calls$log, 1L)
  clock <- clock + .ATRIUM_SEASONS_TTL + 1
  atrium_season_id(12, row$season_end_year, row$competition_id)
  expect_length(calls$log, 2L)
})

test_that("season becomes seasonId and the competition that picked it is not sent", {
  lnb <- atrium_body("12__fixtures.json")
  row <- .atrium_parse_seasons(lnb)
  row <- row[row$is_default_season, ]
  calls <- wire(function(url, query) {
    if (is.null(query$seasonId)) return(lnb)
    b <- lnb
    b$data$seasonId <- query$seasonId
    b
  })
  atrium_fixtures(12, season = row$season_end_year, competition_id = row$competition_id)
  expect_identical(calls$log[[2]], list(url = paste0(BASE, "/12/fixtures"), query = list(seasonId = row$season_id)))
})

test_that("the competition routes keep their competitionId", {
  b <- list(data = list(statistics = list(list(statistics = list(list(x = 1L))))),
            links = list(self = paste0(BASE, "/12/statistics_competition_persons")), meta = list(code = 200L))
  calls <- wire(serve(b))
  atrium_competition_player_stats(12, "c")
  expect_identical(calls$log[[1]]$query, list(competitionId = "c"))
})

test_that("season and season_id together are refused", {
  calls <- wire(function(url, query) stop("no request expected"))
  expect_error(atrium_standings(12, season = 2026, season_id = "x"), "not both", class = "hoopR_bad_request")
  expect_length(calls$log, 0L)
})

# --- refusals ------------------------------------------------------------------------

test_that("a real answer passes every check", {
  wire(serve(atrium_fx("14__fixture_detail__pbp.json")))
  expect_identical(nrow(atrium_pbp(14, F14)), 9L)
})

test_that("error, stub and wrong-scope bodies are asset_fetch errors", {
  real <- atrium_body("14__fixture_detail__pbp.json")
  edit <- function(f) {
    b <- real
    f(b)
  }
  cases <- list(
    "error object" = list(error = list(code = 400L, message = "boom"), links = real$links),
    "no data object" = list(links = real$links),
    "no data object" = edit(function(b) { b$data <- list(); b }),
    "meta.code 500" = edit(function(b) { b$meta <- list(code = 500L); b }),
    "meta.code" = edit(function(b) { b$meta <- list(code = "200"); b }),
    "links.self" = edit(function(b) { b$links <- structure(list(), names = character()); b }),
    "asked for /14/fixture_detail" = edit(function(b) { b$links$self <- paste0(BASE, "/12/fixture_detail"); b }),
    "asked for /14/fixture_detail" = edit(function(b) { b$links$self <- paste0(BASE, "/14/fixtures"); b }),
    "sub=pbp" = edit(function(b) { b$data$sub <- "preview"; b }),
    "fixtureId" = edit(function(b) { b$data$fixture$fixtureId <- F12; b }),
    "not a JSON object" = "[]",
    "non-JSON" = "<html>"
  )
  for (i in seq_along(cases)) {
    wire(serve(cases[[i]]))
    expect_error(atrium_pbp(14, F14), names(cases)[[i]], class = "hoopR_asset_fetch")
  }
})

test_that("a game of the asked site passes with no season-list request", {
  for (name in c("14__fixture_detail__pbp.json", "full/14__fixture_detail__statistics.json",
                 "full/12__fixture_detail__statistics.json", "12__fixture_detail__pbp.json", "3__fixture_detail__pbp.json")) {
    b <- atrium_body(name)
    site <- as.integer(sub("__.*", "", basename(name)))
    calls <- wire(serve(b))
    out <- if (b$data$sub == "pbp") atrium_pbp(site, b$data$fixture$fixtureId) else atrium_box_score(site, b$data$fixture$fixtureId)
    expect_gt(nrow(out), 0)
    expect_identical(vapply(calls$log, `[[`, "", "url"), paste0(BASE, "/", site, "/fixture_detail"))
  }
})

test_that("an older game whose season the site no longer lists passes", {
  old <- "00000000-0000-1000-8000-0000000000aa" # LNB lists only 2023-2025: not proof of anything
  b <- atrium_body("12__fixture_detail__pbp.json")
  b$data$seasonId <- old
  b$data$fixture$seasonId <- old
  calls <- wire(function(url, query) if (endsWith(url, "/fixtures")) atrium_body("12__fixtures.json") else b)
  expect_false(old %in% .atrium_parse_seasons(atrium_body("12__fixtures.json"))$season_id)
  out <- atrium_pbp(12, F12)
  expect_identical(unique(out$season_id), old)
  expect_identical(vapply(calls$log, `[[`, "", "url"), paste0(BASE, "/12/fixture_detail"))
})

shell_body <- function(site) {
  b <- atrium_body("refusals/14__fixture_detail__pbp__other_site.json")
  b$links$self <- sub("/embed/14/", paste0("/embed/", site, "/"), b$links$self, fixed = TRUE)
  b
}

test_that("another site's game is the empty answer: no_data, not a proven wrong scope", {
  wire(serve(shell_body(14)))
  expect_error(atrium_pbp(14, F12), "site 14 has no fixture .*another site", class = "hoopR_no_data")
})

test_that("an unknown fixture id is the same empty answer: no_data", {
  wire(serve(shell_body(12)))
  expect_error(atrium_pbp(12, NIL), "an unknown id", class = "hoopR_no_data")
})

test_that("a body that proves another site is a wrong-scope asset_fetch error", {
  for (name in c("12__fixture_detail__pbp.json", "full/12__fixture_detail__statistics.json")) {
    wire(serve(atrium_body(name)))
    f <- if (grepl("pbp", name)) atrium_pbp else atrium_box_score
    expect_error(f(14, F12), "asked for /14/fixture_detail, the body is /12/fixture_detail", class = "hoopR_asset_fetch")
  }
})

test_that("a body that proves another game is a wrong-scope asset_fetch error", {
  wire(serve(atrium_body("14__fixture_detail__pbp.json")))
  expect_error(atrium_pbp(14, F12), "fixtureId", class = "hoopR_asset_fetch")
})

test_that("a site 236 game is served unchanged", {
  b <- atrium_body("14__fixture_detail__pbp.json")
  b$links$self <- sub("/embed/14/", "/embed/236/", b$links$self, fixed = TRUE)
  calls <- wire(serve(b))
  expect_identical(nrow(atrium_pbp(236, F14)), 9L)
  expect_length(calls$log, 1L)
})

test_that("a summary body for an unknown sub is not mistaken for a box score", {
  b <- atrium_body("full/14__fixture_detail__statistics.json")
  b$data$sub <- "preview"
  wire(serve(b))
  expect_error(atrium_box_score(14, F14), "sub", class = "hoopR_asset_fetch")
})

test_that("bodies of another season, player or team are refused", {
  st <- atrium_body("12__standings.json")
  wire(serve(st))
  expect_error(atrium_standings(12, season_id = NIL), "seasonId", class = "hoopR_asset_fetch")
  expect_gt(nrow(atrium_standings(12, season_id = st$data$seasonId)), 0)
  wire(serve(atrium_body("12__person_detail.json")))
  expect_error(atrium_player(12, NIL), "personId", class = "hoopR_asset_fetch")
  expect_identical(atrium_player(12, PERSON)$person_id, PERSON)
  wire(serve(atrium_body("12__entity_detail.json")))
  expect_error(atrium_team(12, NIL), "entityId", class = "hoopR_asset_fetch")
  expect_identical(atrium_team(12, TEAM)$entity_id, TEAM)
})

test_that("a default season outside the site's own list is refused", {
  b <- atrium_body("14__fixtures__default.json")
  b$data$seasonId <- NIL
  wire(serve(b))
  expect_error(atrium_fixtures(14), "not in the site's own season list", class = "hoopR_asset_fetch")
})

test_that("a well-formed body without rows is no_data, not a failure", {
  cases <- list(
    list("12__fixtures.json", function(d) { d$fixtures <- list(); d }, function() atrium_fixtures(12)),
    list("14__fixtures_ribbon.json", function(d) { d$fixtures <- list(); d }, function() atrium_fixtures_ribbon(14)),
    list("14__fixture_detail__pbp.json", function(d) {
      d$periodData <- lapply(d$periodData, function(p) { p$events <- list(); p }); d
    }, function() atrium_pbp(14, F14)),
    list("14__fixture_detail__shot_chart.json", function(d) {
      d$periodData <- lapply(d$periodData, function(p) { p$shots <- list(); p }); d
    }, function() atrium_shots(14, F14)),
    list("full/14__fixture_detail__statistics.json", function(d) {
      for (s in c("home", "away")) d$statistics$data$base[[s]]$persons <- list()
      d
    }, function() atrium_box_score(14, F14)),
    list("12__standings.json", function(d) { d$standings <- list(list(rows = list())); d }, function() atrium_standings(12)),
    list("12__entities.json", function(d) { d$teams <- list(); d }, function() atrium_teams(12)),
    list("12__persons.json", function(d) { d$persons$rows <- list(); d }, function() atrium_players(12)),
    list("12__person_detail__log.json", function(d) { d$log$rows <- list(); d }, function() atrium_player_game_log(12, PERSON)),
    list("12__statistics_leaders.json", function(d) { d$statistics <- list(); d }, function() atrium_leaders(12)),
    list("12__statistics_persons.json", function(d) { d$statistics <- list(); d }, function() atrium_player_stats(12))
  )
  for (cs in cases) {
    b <- atrium_body(cs[[1]])
    b$data <- cs[[2]](b$data)
    wire(serve(b))
    expect_error(cs[[3]](), "no rows", class = "hoopR_no_data")
  }
})

test_that("the season lookup tolerates a default page without fixtures", {
  b <- atrium_body("12__fixtures.json")
  b$data$fixtures <- list()
  wire(serve(b))
  row <- .atrium_parse_seasons(b)[1, ]
  expect_identical(atrium_season_id(12, row$season_end_year, row$competition_id), row$season_id)
})

test_that("the getter is called with the per-family HTTP 500 retry policy", {
  seen <- NULL
  local_mocked_bindings(.intl_get = function(url, query = list(), ..., retry_500 = FALSE) {
    seen <<- retry_500
    atrium_fx("14__fixture_detail__pbp.json")
  })
  atrium_pbp(14, F14)
  expect_true(seen)
})

test_that("HTTP statuses follow the package vocabulary (404 no_data, 400 bad_request, 5xx transient)", {
  local_mocked_bindings(.intl_sleep = function(seconds) invisible())
  for (st in list(c(404, "hoopR_no_data"), c(400, "hoopR_bad_request"), c(503, "hoopR_asset_fetch"))) {
    httr2::local_mocked_responses(function(req) httr2::response(status_code = as.integer(st[[1]])))
    err <- tryCatch(atrium_pbp(14, F14), error = function(e) e)
    expect_s3_class(err, st[[2]])
    if (st[[1]] == "503") expect_true(err$transient)
  }
})
