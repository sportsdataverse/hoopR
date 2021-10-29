context("KP - Get FanMatch")



test_that("KP - Get FanMatch", {
  skip_on_cran()
  
  x <- kp_fanmatch(date="2020-03-10")

  cols <- c(
    "prediction", "time_et", "location",
    "thrill_score", "comeback", "excitement", "win_rk",
    "win_team", "win_score", "loss_rk", "loss_team",
    "loss_score", "poss", "mvp", "event", "date"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
