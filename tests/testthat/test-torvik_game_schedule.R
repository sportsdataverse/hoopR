test_that("Torvik - Season Schedule", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_game_schedule(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No Torvik schedule returned at test time")

  cols <- c("muid", "date", "team1", "team2", "t1oe", "t2oe", "tempo",
            "result", "winner", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
