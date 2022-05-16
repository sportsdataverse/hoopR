test_that("KP - Get trends", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_trends()

  cols <- c(
    "season", "efficiency", "tempo", "e_fg_pct", "to_pct",
    "or_pct", "ft_rate", "fg_2_pct", "fg_3_pct", "fg_3a_pct",
    "ft_pct", "a_pct", "blk_pct", "stl_pct",
    "non_stl_pct", "avg_hgt", "continuity", "home_win_pct", "ppg"
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
