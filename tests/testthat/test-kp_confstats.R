test_that("KP - Get conference statistics", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_confstats(year='2020')

  cols <- c(
    "conf", "eff", "eff_rk", "tempo", "tempo_rk", "e_fg_pct",
    "e_fg_pct_rk", "to_pct", "to_pct_rk", "or_pct", "or_pct_rk",
    "ft_rate", "ft_rate_rk", "blk_pct", "blk_pct_rk", "stl_pct",
    "stl_pct_rk", "fg_2_pct", "fg_2_pct_rk", "fg_3_pct", "fg_3_pct_rk",
    "ft_pct", "ft_pct_rk", "fg_3a_pct", "fg_3a_pct_rk", "a_pct", "a_pct_rk",
    "home_w_l", "home_w_l_pct", "home_w_l_rk",
    "close", "close_rk", "blowouts", "blowouts_rk", "year")

  expect_equal(colnames(x), cols)
  expect_s3_class(x,'data.frame')
})
