test_that("KP - Get Pomeroy ratings", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_pomeroy_ratings(min_year = 2020, max_year = 2020)

  cols <- c(
    "year", "rk", "team", "conf", "w_l", "adj_em", "adj_o",
    "adj_o_rk", "adj_d", "adj_d_rk", "adj_t", "adj_t_rk",
    "luck", "luck_rk", "sos_adj_em", "sos_adj_em_rk",
    "sos_opp_o", "sos_opp_o_rk", "sos_opp_d",
    "sos_opp_d_rk", "ncsos_adj_em", "ncsos_adj_em_rk", "ncaa_seed"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
