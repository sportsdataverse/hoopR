# stats.nba.com answers some retired V2 endpoints with `{}`. That is no result
# sets, not two empty ones (1:length(NULL) used to iterate over c(1, 0)).

test_that("nba_stats_map_result_sets() maps `{}` to an empty list", {
  expect_identical(nba_stats_map_result_sets(jsonlite::fromJSON("{}")), list())
  expect_identical(nba_stats_map_result_sets(jsonlite::fromJSON('{"resultSets":[]}')), list())
})

test_that("nba_stats_map_result_sets() still names and fills each result set", {
  resp <- jsonlite::fromJSON(paste0(
    '{"resultSets":[{"name":"A","headers":["X","Y"],"rowSet":[[1,"a"],[2,"b"]]},',
    '{"name":"B","headers":["Z"],"rowSet":[]}]}'
  ))
  x <- nba_stats_map_result_sets(resp)
  expect_named(x, c("A", "B"))
  expect_equal(nrow(x$A), 2L)
  expect_named(x$A, c("X", "Y"))
  expect_equal(nrow(x$B), 0L)
})

test_that("a wrapper given `{}` returns an empty list without an error", {
  skip_on_cran()
  requested <- character()
  httr2::local_mocked_responses(function(req) {
    requested <<- c(requested, req$url)
    httr2::response(status_code = 200L, url = req$url,
                    headers = list(`Content-Type` = "application/json"), body = charToRaw("{}"))
  })
  msgs <- character()
  x <- withCallingHandlers(nba_defensehub(season = "2024-25"), message = function(m) {
    msgs <<- c(msgs, conditionMessage(m))
    invokeRestart("muffleMessage")
  })
  expect_length(requested, 1)
  expect_match(requested, "https://stats.nba.com/stats/defensehub?", fixed = TRUE)
  expect_identical(x, list())
  expect_length(msgs, 0)
  expect_identical(nba_bind_sets(x), dplyr::tibble())
})
