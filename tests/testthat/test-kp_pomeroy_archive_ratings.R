test_that("KP - Get pomeroy archive ratings", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_pomeroy_archive_ratings(date = "2018-11-22")


  cols <- c(
    "adj_em_rk",
    "team",
    "conf",
    "adj_em",
    "adj_o",
    "adj_o_rk",
    "adj_d",
    "adj_d_rk",
    "adj_t",
    "adj_t_rk",
    "final_rk",
    "final_adj_em",
    "final_adj_o",
    "final_adj_o_rk",
    "final_adj_d",
    "final_adj_d_rk",
    "final_adj_t",
    "final_adj_t_rk",
    "rk_chg",
    "em_chg",
    "adj_t_chg",
    "ncaa_seed"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
