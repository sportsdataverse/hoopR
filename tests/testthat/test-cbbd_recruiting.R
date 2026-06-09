test_that("CBD - Recruiting Players", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_recruiting_players(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No recruiting players returned at test time")

  cols <- c("id", "position", "school", "year", "name", "stars", "rating")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Recruiting Team Rankings", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_recruiting_teams(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team recruiting rankings returned at test time")

  cols <- c("team_id", "team", "conference", "year", "ranking", "rating")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Transfer Portal", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_recruiting_portal(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No transfer portal data returned at test time")

  cols <- c("id", "year", "first_name", "last_name", "position")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
