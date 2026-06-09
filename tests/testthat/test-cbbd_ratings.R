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
