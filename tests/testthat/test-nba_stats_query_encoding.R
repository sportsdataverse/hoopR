# httr2::req_url_query() percent-encodes every query value, so a wrapper that
# swaps spaces for "+" first sends a literal plus ("Regular%2BSeason"), which
# stats.nba.com answers with HTTP 400. Values go to the request as they are.

test_that("spaces in stats.nba.com query values are sent as %20, never as an encoded '+'", {
  skip_on_cran()
  urls <- character()
  httr2::local_mocked_responses(function(req) {
    urls <<- c(urls, req$url)
    httr2::response(status_code = 400L, url = req$url)
  })
  suppressMessages({
    nba_leaguedashplayerstats(season = "2024-25", season_type = "Regular Season")
    nba_leaguedashteamstats(season = "2024-25", season_type = "Pre Season")
  })
  expect_length(urls, 2)
  expect_false(any(grepl("%2B", urls, fixed = TRUE)))
  expect_match(urls[[1]], "SeasonType=Regular%20Season", fixed = TRUE)
  expect_match(urls[[2]], "SeasonType=Pre%20Season", fixed = TRUE)
})

# stats.nba.com answered these with HTTP 500 (defensehub,
# glalumboxscoresimilarityscore) and 400 (boxscoresimilarityscore) for every
# parameter set tried on 2026-11-24 and 2026-11-25, so they are defunct and
# stop before any request.
test_that("nba_defensehub() and the similarity-score wrappers are defunct", {
  skip_on_cran()
  urls <- character()
  httr2::local_mocked_responses(function(req) {
    urls <<- c(urls, req$url)
    httr2::response(status_code = 500L, url = req$url)
  })
  expect_error(nba_defensehub(season = "2024-25"), class = "defunctError")
  expect_error(nba_boxscoresimilarityscore(), class = "defunctError")
  expect_error(nba_glalumboxscoresimilarityscore(
    person_1_id = "202681", person_1_league_id = "00", person_1_season = 2019,
    person_1_season_type = "Regular Season", person_2_id = "203078",
    person_2_league_id = "00", person_2_season = 2019, person_2_season_type = "Regular Season"
  ), class = "defunctError")
  expect_length(urls, 0)
})
