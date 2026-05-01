test_that("KP - Get conference (leaderboard)", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_conf(year="2020",conf="ACC")

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

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

  expect_in(cols_x1, colnames(x1))
  expect_in(cols_x2, colnames(x2))
  expect_in(cols_x3, colnames(x3))
  expect_in(cols_x4, colnames(x4))
  expect_in(cols_x5, colnames(x5))
  expect_in(cols_x6, colnames(x6))
  expect_in(cols_x7, colnames(x7))

  Sys.sleep(3)

})
