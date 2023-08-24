test_that("KP - Get conference history", {
  skip_on_cran()
  skip_on_ci()
  skip_kenpom_test()

  x <- kp_confhistory(conf="ACC")


  cols <- c(
    "year", "rank", "tempo", "efficiency", "e_fg_pct", "to_pct",
    "or_pct", "ft_rate", "fg_2_pct", "fg_3_pct", "ft_pct",
    "fg_3a_pct", "a_pct", "blk_pct", "stl_pct",
    "home_record", "bids", "s16", "f4", "ch", "reg_season_champ",
    "tourney_champ", "best_team")

  expect_equal(colnames(x), cols)
  expect_s3_class(x,"data.frame")

  Sys.sleep(3)

})
