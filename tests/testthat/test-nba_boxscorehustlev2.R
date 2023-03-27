test_that("NBA Boxscore Hustle V2", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscorehustlev2(game_id = "0022200021")

  cols_x1 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "person_id",
    "first_name",
    "family_name",
    "name_i",
    "player_slug",
    "position",
    "comment",
    "jersey_num",
    "minutes",
    "points",
    "contested_shots",
    "contested_shots2pt",
    "contested_shots3pt",
    "deflections",
    "charges_drawn",
    "screen_assists",
    "screen_assist_points",
    "loose_balls_recovered_offensive",
    "loose_balls_recovered_defensive",
    "loose_balls_recovered_total",
    "offensive_box_outs",
    "defensive_box_outs",
    "box_out_player_team_rebounds",
    "box_out_player_rebounds",
    "box_outs"
  )

  cols_x2 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "person_id",
    "first_name",
    "family_name",
    "name_i",
    "player_slug",
    "position",
    "comment",
    "jersey_num",
    "minutes",
    "points",
    "contested_shots",
    "contested_shots2pt",
    "contested_shots3pt",
    "deflections",
    "charges_drawn",
    "screen_assists",
    "screen_assist_points",
    "loose_balls_recovered_offensive",
    "loose_balls_recovered_defensive",
    "loose_balls_recovered_total",
    "offensive_box_outs",
    "defensive_box_outs",
    "box_out_player_team_rebounds",
    "box_out_player_rebounds",
    "box_outs"
  )

  cols_x3 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "points",
    "contested_shots",
    "contested_shots2pt",
    "contested_shots3pt",
    "deflections",
    "charges_drawn",
    "screen_assists",
    "screen_assist_points",
    "loose_balls_recovered_offensive",
    "loose_balls_recovered_defensive",
    "loose_balls_recovered_total",
    "offensive_box_outs",
    "defensive_box_outs",
    "box_out_player_team_rebounds",
    "box_out_player_rebounds",
    "box_outs"
  )

  cols_x4 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "points",
    "contested_shots",
    "contested_shots2pt",
    "contested_shots3pt",
    "deflections",
    "charges_drawn",
    "screen_assists",
    "screen_assist_points",
    "loose_balls_recovered_offensive",
    "loose_balls_recovered_defensive",
    "loose_balls_recovered_total",
    "offensive_box_outs",
    "defensive_box_outs",
    "box_out_player_team_rebounds",
    "box_out_player_rebounds",
    "box_outs"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], 'data.frame')

})
