test_that("NBA Data PBP", {
  skip_on_cran()
  skip_on_ci()
  x <- nba_data_pbp(game_id = "0021900001")

  cols <- c(
    "period",
    "evt",
    "cl",
    "de",
    "locX",
    "locY",
    "opt1",
    "opt2",
    "mtype",
    "etype",
    "opid",
    "tid",
    "pid",
    "hs",
    "vs",
    "epid",
    "oftid",
    "ord"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, 'data.frame')

})
