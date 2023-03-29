test_that("KP - Get conference (leaderboard)", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_conf(year="2020",conf="ACC")

  x1 <- x[[1]]
  x2 <- x[[2]]
  x3 <- x[[3]]
  x4 <- x[[4]]
  x5 <- x[[5]]
  x6 <- x[[6]]
  x7 <- x[[7]]

  cols_x1 <- c(
    "team",
    "overall",
    "conf",
    "adj_em",
    "adj_em_rk",
    "adj_o",
    "adj_o_rk",
    "adj_d",
    "adj_d_rk",
    "adj_t",
    "adj_t_rk",
    "conf_sos",
    "conf_sos_rk",
    "next_game",
    "year"
  )
  cols_x2 <- c(
    "team",
    "oe",
    "oe_rk",
    "e_fg_pct",
    "e_fg_pct_rk",
    "to_pct",
    "to_pct_rk",
    "or_pct",
    "or_pct_rk",
    "ft_rate",
    "ft_rate_rk",
    "fg_2_pct",
    "fg_2_pct_rk",
    "fg_3_pct",
    "fg_3_pct_rk",
    "ft_pct",
    "ft_pct_rk",
    "tempo",
    "tempo_rk",
    "year"
  )
  cols_x3 <- c(
    "team",
    "de",
    "de_rk",
    "e_fg_pct",
    "e_fg_pct_rk",
    "to_pct",
    "to_pct_rk",
    "or_pct",
    "or_pct_rk",
    "ft_rate",
    "ft_rate_rk",
    "fg_2_pct",
    "fg_2_pct_rk",
    "fg_3_pct",
    "fg_3_pct_rk",
    "blk_pct",
    "blk_pct_rk",
    "stl_pct",
    "stl_pct_rk",
    "year"
  )
  cols_x4 <- c(
    "rk",
    "player",
    "year"
  )
  cols_x5 <- c(
    "stat",
    "value",
    "rk",
    "year"
  )
  cols_x6 <- c(
    "stat",
    "count",
    "value",
    "rk",
    "year"
  )
  cols_x7 <- c(
    "rk",
    "conference",
    "rating",
    "year"
  )

  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)
  expect_equal(colnames(x3), cols_x3)
  expect_equal(colnames(x4), cols_x4)
  expect_equal(colnames(x5), cols_x5)
  expect_equal(colnames(x6), cols_x6)
  expect_equal(colnames(x7), cols_x7)
  Sys.sleep(2)
})
