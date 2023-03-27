test_that("KP - Get efficiency", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_efficiency(min_year = 2020, max_year = 2020)
  cols <- c(
    "team",
    "conf",
    "adj_t",
    "adj_t_rk",
    "raw_t",
    "raw_t_rk",
    "avg_poss_length_off",
    "avg_poss_length_off_rk",
    "avg_poss_length_def",
    "avg_poss_length_def_rk",
    "adj_o",
    "adj_o_rk",
    "raw_o",
    "raw_o_rk",
    "adj_d",
    "adj_d_rk",
    "raw_d",
    "raw_d_rk",
    "ncaa_seed",
    "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

  Sys.sleep(2)

})
