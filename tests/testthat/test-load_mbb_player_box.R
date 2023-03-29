test_that("hoopR Loader MBB Player Box", {
  skip_on_cran()
  x <- load_mbb_player_box(seasons = most_recent_mbb_season())


  cols <- c(
    "athlete_display_name",
    "team_short_display_name",
    "min",
    "fg",
    "fg3",
    "ft",
    "oreb",
    "dreb",
    "reb",
    "ast",
    "stl",
    "blk",
    "to",
    "pf",
    "pts",
    "starter",
    "ejected",
    "did_not_play",
    "active",
    "athlete_jersey",
    "athlete_id",
    "athlete_short_name",
    "athlete_headshot_href",
    "athlete_position_name",
    "athlete_position_abbreviation",
    "team_name",
    "team_logo",
    "team_id",
    "team_abbreviation",
    "team_color",
    "game_id",
    "season",
    "season_type",
    "game_date"
  )

  expect_equal(sort(colnames(x)), sort(cols))
  expect_s3_class(x, "data.frame")

})
