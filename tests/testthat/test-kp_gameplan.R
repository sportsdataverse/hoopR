test_that("KP - Get gameplan", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_gameplan(team = 'Florida St.', year= 2020)
  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]

  cols_x1 <- c(
    "date", "opponent_rk", "opponent", "result", "location",
    "pace", "off_eff", "off_eff_rk", "off_e_fg_pct",
    "off_to_pct", "off_or_pct", "off_ftr", "off_fgm_2",
    "off_fga_2", "off_fg_2_pct", "off_fgm_3", "off_fga_3",
    "off_fg_3_pct", "off_fg_3a_pct", "def_eff", "def_eff_rk",
    "def_e_fg_pct", "def_to_pct", "def_or_pct", "def_ftr",
    "def_fgm_2", "def_fga_2", "def_fg_2_pct", "def_fgm_3",
    "def_fga_3", "def_fg_3_pct", "def_fg_3a_pct", "wl",
    "team_score", "opponent_score", "day_date", "game_date"
  )
  cols_x2 <- c(
    "correlations_r_x_100", "pace", "off_e_fg_pct",
    "off_to_pct", "off_or_pct", "off_ftr",
    "def_e_fg_pct", "def_to_pct", "def_or_pct", "def_ftr"
  )
  cols_x3 <- c(
    "team", "category", "c_pct", "pf_pct", "sf_pct",
    "sg_pct", "pg_pct", "c_pct_rk", "pf_pct_rk",
    "sf_pct_rk", "sg_pct_rk", "pg_pct_rk",
    "c_pct_d1_avg", "pf_pct_d1_avg", "sf_pct_d1_avg",
    "sg_pct_d1_avg", "pg_pct_d1_avg"
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
  expect_equal(colnames(x3), cols_x3)
})
