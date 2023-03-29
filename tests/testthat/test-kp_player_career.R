test_that("KP - Get player career", {
  skip_on_cran()
  skip_on_ci()

  x <- kp_player_career(player_id = "41180")
  x1 <- x[[1]]
  x2 <- x[[2]]

  cols_x1 <- c(
    "year",
    "team_rk",
    "team",
    "number",
    "name",
    "position",
    "hgt",
    "wgt",
    "yr",
    "g",
    "min_pct",
    "o_rtg",
    "poss_pct",
    "shots_pct",
    "e_fg_pct",
    "ts_pct",
    "or_pct",
    "dr_pct",
    "a_rate",
    "to_rate",
    "blk_pct",
    "stl_pct",
    "f_cper40",
    "f_dper40",
    "ft_rate",
    "ftm",
    "fta",
    "ft_pct",
    "fgm_2",
    "fga_2",
    "fg_2_pct",
    "fgm_3",
    "fga_3",
    "fg_3_pct",
    "group_rank",
    "team_finish",
    "ncaa_seed",
    "hometown",
    "date_of_birth",
    "age",
    "comparisons"
  )
  cols_x2 <- c(
    "year",
    "team",
    "name",
    "position",
    "opponent_tier",
    "date",
    "opponent_rk",
    "opponent",
    "result",
    "ot",
    "location",
    "game_type",
    "mvp",
    "start",
    "minutes_played",
    "o_rtg",
    "poss_pct",
    "pts",
    "fgm_2",
    "fga_2",
    "fgm_3",
    "fga_3",
    "ftm",
    "fta",
    "or",
    "dr",
    "a",
    "to",
    "blk",
    "stl",
    "pf"
  )
  expect_equal(colnames(x1), cols_x1)
  expect_equal(colnames(x2), cols_x2)


})
