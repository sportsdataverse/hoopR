test_that("KP - Get FanMatch", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_fanmatch(date = "2020-03-10")

  cols <- c(
    "prediction",
    "time_et",
    "location",
    "thrill_score",
    "comeback",
    "excitement",
    "road_rk",
    "road_team",
    "home_rk",
    "home_team",
    "win_rk",
    "win_team",
    "win_score",
    "loss_rk",
    "loss_team",
    "loss_score",
    "poss",
    "mvp",
    "event",
    "date"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
