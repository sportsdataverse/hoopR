test_that("CBD - Draft Teams", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_draft_teams()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No draft teams returned at test time")

  cols <- c("id", "location", "name", "abbreviation")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Draft Positions", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_draft_positions()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No draft positions returned at test time")

  cols <- c("name", "abbreviation")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Draft Picks", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_draft_picks(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No draft picks returned at test time")

  cols <- c("athlete_id", "draft_team", "year", "overall", "round", "pick", "name")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
