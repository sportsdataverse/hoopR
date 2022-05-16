test_that("KP - Get team history", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_team_history(
    team = 'Florida St.'
  )

  y <- kp_team_history(
    team = 'Duke'
  )

  cols <- c(
    "year", "team_rk", "team", "coach", "conf", "adj_t",
    "adj_o", "adj_d", "off_e_fg_pct", "off_to_pct", "off_or_pct",
    "off_ft_rate", "off_fg_2_pct", "off_fg_3_pct", "off_ft_pct",
    "off_fg_3a_pct", "off_a_pct", "off_apl", "def_e_fg_pct",
    "def_to_pct", "def_or_pct", "def_ft_rate", "def_fg_2_pct",
    "def_fg_3_pct", "def_blk_pct", "def_fg_3a_pct", "def_a_pct",
    "def_apl", "foul2partic_pct", "wl", "wl_conf", "adj_t_rk", "adj_o_rk",
    "adj_d_rk", "off_e_fg_pct_rk", "off_to_pct_rk", "off_or_pct_rk",
    "off_ft_rate_rk", "off_fg_2_pct_rk", "off_fg_3_pct_rk", "off_ft_pct_rk",
    "off_fg_3a_pct_rk", "off_a_pct_rk", "off_apl_rk", "def_e_fg_pct_rk",
    "def_to_pct_rk", "def_or_pct_rk", "def_ft_rate_rk", "def_fg_2_pct_rk",
    "def_fg_3_pct_rk", "def_blk_pct_rk", "def_fg_3a_pct_rk", "def_a_pct_rk",
    "def_apl_rk", "foul2partic_pct_rk", "team_finish", "ncaa_seed"
  )

  expect_equal(colnames(x), cols)
  expect_equal(colnames(y), cols)
  expect_s3_class(x, "data.frame")
  expect_s3_class(y, "data.frame")
})
