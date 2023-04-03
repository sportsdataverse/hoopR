test_that("KP - Get point distribution", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_pointdist(min_year = 2020, max_year = 2020)

  cols <- c(
    "team",
    "conf",
    "off_ft_pct",
    "off_ft_pct_rk",
    "off_fg_2_pct",
    "off_fg_2_pct_rk",
    "off_fg_3_pct",
    "off_fg_3_pct_rk",
    "def_ft_pct",
    "def_ft_pct_rk",
    "def_fg_2_pct",
    "def_fg_2_pct_rk",
    "def_fg_3_pct",
    "def_fg_3_pct_rk",
    "ncaa_seed",
    "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
