test_that("Spotrac - Team Cap", {
  skip_on_cran()
  skip_on_ci()

  x <- spotrac_team_cap(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No Spotrac cap data returned at test time")

  cols <- c("rank", "team", "total_cap_allocations", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(2)
})

test_that("NBADraft.net - Mock Draft", {
  skip_on_cran()
  skip_on_ci()

  x <- nbadraft_mock_draft()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No mock draft returned at test time")

  cols <- c("round", "pick", "team", "player", "position", "school")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(2)
})

test_that("HoopsHype - Salaries", {
  skip_on_cran()
  skip_on_ci()

  x <- hoopshype_salaries()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No HoopsHype salaries returned at test time")

  cols <- c("player_id", "player", "team", "season", "salary")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_gt(length(unique(x$player_id)), 100)  # full league, not just top earners

  Sys.sleep(2)
})
