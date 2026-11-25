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

# A set with headers and no rows keeps its columns (it used to map to a 0x0
# tibble). `resultSet` (one set object: vector headers, matrix rowSet) maps
# the same way as `resultSets`.
test_that("a headers-only result set maps to a 0-row tibble with its columns", {
  plural <- jsonlite::fromJSON(
    '{"resultSets":[{"name":"A","headers":["X","Y"],"rowSet":[]}]}'
  )
  single <- jsonlite::fromJSON(
    '{"resultSet":{"name":"A","headers":["X","Y"],"rowSet":[]}}'
  )
  want <- list(A = dplyr::tibble(X = character(), Y = character()))
  expect_identical(nba_stats_map_result_sets(plural), want)
  expect_identical(nba_stats_map_result_sets(single), want)
})

test_that("a filled `resultSet` object maps every row and column", {
  x <- nba_stats_map_result_sets(jsonlite::fromJSON(
    '{"resultSet":{"name":"A","headers":["X","Y"],"rowSet":[[1,"a"],[2,"b"]]}}'
  ))
  expect_identical(x, list(A = dplyr::tibble(X = c("1", "2"), Y = c("a", "b"))))
})

test_that("wrappers keep the columns of a headers-only result set", {
  skip_on_cran()
  body <- NULL
  httr2::local_mocked_responses(function(req) {
    httr2::response(status_code = 200L, url = req$url,
                    headers = list(`Content-Type` = "application/json"),
                    body = charToRaw(body))
  })
  want <- list(A = dplyr::tibble(X = character(), Y = character()))
  body <- '{"resultSet":{"name":"A","headers":["X","Y"],"rowSet":[]}}'
  expect_identical(nba_leagueleaders(season = "2024-25"), want)
  expect_identical(nba_teamestimatedmetrics(season = "2024-25"), want)
  expect_identical(nba_playerestimatedmetrics(season = "2024-25"), want)
  expect_identical(nba_boxscoresimilarityscore(), want)
  body <- '{"resultSets":[{"name":"A","headers":["X","Y"],"rowSet":[]}]}'
  expect_identical(nba_gamerotation(game_id = "0022200021"), want)
  expect_identical(nba_leaguedashplayerptshot(season = "2024-25"), want)
})
