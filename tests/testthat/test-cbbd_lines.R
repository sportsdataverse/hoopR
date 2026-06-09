test_that("CBD - Betting Lines", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_lines(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No betting lines returned at test time")

  cols <- c("game_id", "season", "home_team", "away_team", "lines")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Line Providers", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_lines_providers()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No line providers returned at test time")

  cols <- c("id", "name")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
