test_that("KP - Get team stats", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_teamstats(min_year = 2020, max_year = 2020)

  cols <- c(
    "team", "conf", "off_fg_3_pct", "off_fg_3_pct_rk", "off_fg_2_pct",
    "off_fg_2_pct_rk", "off_ft_pct", "off_ft_pct_rk", "off_blk_pct",
    "off_blk_pct_rk", "off_stl_pct", "off_stl_pct_rk", "off_non_stl_pct",
    "off_non_stl_pct_rk", "off_a_pct", "off_a_pct_rk", "off_fg_3a_pct",
    "off_fg_3a_pct_rk", "adj_o", "adj_o_rk", "ncaa_seed", "year",
    "def_fg_3_pct", "def_fg_3_pct_rk", "def_fg_2_pct", "def_fg_2_pct_rk",
    "def_ft_pct", "def_ft_pct_rk", "def_blk_pct", "def_blk_pct_rk",
    "def_stl_pct", "def_stl_pct_rk", "def_non_stl_pct", "def_non_stl_pct_rk",
    "def_a_pct", "def_a_pct_rk", "def_fg_3a_pct", "def_fg_3a_pct_rk", "adj_d", "adj_d_rk"
  )

  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
