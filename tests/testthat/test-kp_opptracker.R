test_that("KP - Get opponent tracker", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_opptracker(team = 'Florida St.', year = 2020)

  cols <- c(
    "date",
    "game_date",
    "day_date",
    "wl",
    "team",
    "team_score",
    "opponent",
    "opponent_score",
    "result",
    "adj_oe",
    "adj_oe_rk",
    "off_e_fg_pct",
    "off_e_fg_pct_rk",
    "off_to_pct",
    "off_to_pct_rk",
    "off_or_pct",
    "off_or_pct_rk",
    "off_ft_rate",
    "off_ft_rate_rk",
    "off_fg_2_pct",
    "off_fg_2_pct_rk",
    "off_fg_3_pct",
    "off_fg_3_pct_rk",
    "off_blk_pct",
    "off_blk_pct_rk",
    "off_fg_3a_pct",
    "off_fg_3a_pct_rk",
    "off_apl",
    "off_apl_rk",
    "adj_de",
    "adj_de_rk",
    "def_e_fg_pct",
    "def_e_fg_pct_rk",
    "def_to_pct",
    "def_to_pct_rk",
    "def_or_pct",
    "def_or_pct_rk",
    "def_ft_rate",
    "def_ft_rate_rk",
    "def_fg_2_pct",
    "def_fg_2_pct_rk",
    "def_fg_3_pct",
    "def_fg_3_pct_rk",
    "def_blk_pct",
    "def_blk_pct_rk",
    "def_fg_3a_pct",
    "def_fg_3a_pct_rk",
    "def_apl",
    "def_apl_rk"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
