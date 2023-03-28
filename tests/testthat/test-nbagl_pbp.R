test_that("NBA G-League PBP", {
  skip_on_cran()
  skip_on_ci()

  x <- nbagl_pbp(game_id = "2012200001")

  cols_x1 <- c(
    "period",
    "evt",
    "wallclk",
    "cl",
    "de",
    "locX",
    "locY",
    "opt1",
    "opt2",
    "opt3",
    "opt4",
    "mtype",
    "etype",
    "opid",
    "tid",
    "pid",
    "hs",
    "vs",
    "epid",
    "oftid",
    "ord",
    "pts"
  )


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

  Sys.sleep(3)

})
