test_that("KP - Get team depth chart", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_team_depth_chart(team = "Florida St.", year = 2020)
  cols <- c(
    "team",
    "year",
    "player_id",
    "player_name",
    "class_year",
    "height",
    "weight",
    "pct_pg",
    "pct_sg",
    "pct_sf",
    "pct_pf",
    "pct_c",
    "pct_poss",
    "fta",
    "fg2a",
    "fg3a"
  )

  expect_gt(nrow(x), 0)
  expect_in(cols, colnames(x))
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
