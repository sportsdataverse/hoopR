context("KP - Get four factors")



test_that("KP - Get four factors", {
  skip_on_cran()
  skip_on_ci()
  x <- kp_fourfactors(min_year = 2020, max_year = 2020)

  cols <- c(
    "team", "conf", "adj_t", "adj_t_rk", "adj_o",
    "adj_o_rk", "off_e_fg_pct", "off_e_fg_pct_rk", "off_to_pct",
    "off_to_pct_rk", "off_or_pct", "off_or_pct_rk", "off_ft_rate",
    "off_ft_rate_rk", "adj_d", "adj_d_rk",
    "def_e_fg_pct", "def_e_fg_pct_rk",
    "def_to_pct", "def_to_pct_rk",
    "def_or_pct", "def_or_pct_rk", "def_ft_rate",
    "def_ft_rate_rk", "ncaa_seed", "year"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')


})
