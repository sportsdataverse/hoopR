test_that("CBD - SRS Ratings", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_ratings_srs(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No SRS ratings returned at test time")

  cols <- c("season", "team_id", "team", "conference", "rating")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Adjusted Efficiency Ratings", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_ratings_adjusted(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No adjusted ratings returned at test time")

  cols <- c("season", "team_id", "team", "offensive_rating", "defensive_rating", "net_rating")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Elo Ratings", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_ratings_elo(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No Elo ratings returned at test time")

  cols <- c("season", "team_id", "team", "conference", "elo")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Rankings", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_rankings(season = 2024, poll_type = "ap")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No rankings returned at test time")

  cols <- c("season", "week", "poll_type", "team_id", "team", "ranking")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Rating History", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_ratings_history(season = 2025, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No rating history returned at test time")

  cols <- c("season", "date", "team_id", "team", "series", "net_rating", "srs", "rankings_net")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("cbbd_ratings_history() parses the recorded response into its documented columns", {
  skip_on_cran()
  local_http_fixtures()

  x <- cbbd_ratings_history(season = 2025, team = "Duke")
  expect_s3_class(x, "hoopR_data")
  expect_identical(colnames(x), return_columns$col_name[return_columns$fn == "cbbd_ratings_history"])
  expect_true(all(x$team == "Duke"))
  expect_type(x$net_rating, "double")
  expect_type(x$rankings_net, "integer")
})

test_that("cbbd_ratings_history() returns an empty frame for a date with no snapshots", {
  skip_on_cran()
  # an off-season date answers HTTP 200 with []
  withr::local_envvar(CBBD_API_KEY = "offline")
  httr2::local_mocked_responses(function(req) {
    httr2::response(status_code = 200L, url = req$url,
                    headers = list(`Content-Type` = "application/json"), body = charToRaw("[]"))
  })
  x <- cbbd_ratings_history(season = 2026, date = "2025-07-01")
  expect_s3_class(x, "hoopR_data")
  expect_equal(nrow(x), 0L)
})
