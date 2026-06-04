test_that("ESPN - MBB Event Player Box (Long Format)", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_mbb_game_player_box(event_id = 401256760, team_id = 52, athlete_id = "4432809")

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_mbb_game_player_box at test time")
  }

  required_cols <- c(
    "league",
    "event_id",
    "team_id",
    "athlete_id",
    "stat_name"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

