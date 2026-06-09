test_that("RotoWire - NBA Injuries", {
  skip_on_cran()
  skip_on_ci()

  x <- rotowire_injuries()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RotoWire injuries returned at test time")

  cols <- c("player_id", "player", "team", "position", "injury", "status", "url")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_true(all(grepl("^https://www.rotowire.com", stats::na.omit(x$url))))

  Sys.sleep(2)
})
