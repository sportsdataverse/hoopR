context("ESPN - Get NBA player box score only")



test_that("ESPN - Get NBA player box score only", {
  skip_on_cran()
  x <- espn_nba_player_box(game_id = 401283399)

  cols <- c(
    "athlete_display_name", "team_short_display_name",
    "min", "fg", "fg3", "ft", "oreb", "dreb", "reb", "ast", "stl", "blk",
    "to", "pf", "+/-", "pts", "starter", "ejected", "did_not_play", "active",
    "athlete_jersey", "athlete_id", "athlete_short_name",
    'athlete_headshot_href',"athlete_position_name",
    "athlete_position_abbreviation", "team_name", "team_logo",
    "team_id", "team_abbreviation", "team_color", "team_alternate_color"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
