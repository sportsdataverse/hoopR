test_that("KP - Get team players (roster)", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_team_players(team = "Florida St.", year= 2020)


  cols <- c(
    "role", "number", "player", "ht", "wt", "yr", "g", "s", "min_pct",
    "o_rtg", "poss_pct", "shots_pct", "e_fg_pct", "ts_pct", "or_pct",
    "dr_pct", "a_rate", "to_rate", "blk_pct", "stl_pct", "f_cper40",
    "f_dper40", "ft_rate", "ftm", "fta", "ft_pct", "fgm_2", "fga_2",
    "fg_2_pct", "fgm_3", "fga_3", "fg_3_pct", "min_pct_rk", "o_rtg_rk",
    "poss_pct_rk", "shots_pct_rk", "e_fg_pct_rk", "ts_pct_rk", "or_pct_rk",
    "dr_pct_rk", "a_rate_rk", "to_rate_rk", "blk_pct_rk", "stl_pct_rk", "f_cper40_rk",
    "f_dper40_rk", "ft_rate_rk", "ft_pct_rk",
    "fg_2_pct_rk", "fg_3_pct_rk", "national_rank", "team", "year", "player_id"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)

})
