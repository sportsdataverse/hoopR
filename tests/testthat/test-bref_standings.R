test_that("BREF - Standings", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_standings(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No standings returned at test time")

  cols <- c("conference", "team", "wins", "losses", "win_loss_pct", "srs",
            "playoffs", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})

test_that("BREF - Draft", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_draft(season = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No draft data returned at test time")

  cols <- c("pick_overall", "team", "player", "college_name", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})
