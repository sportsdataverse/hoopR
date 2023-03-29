test_that("NBA Boxscore Misc V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscoremiscv3(game_id = "0022200021")

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
    "points_off_turnovers",
    "points_second_chance",
    "points_fast_break",
    "points_paint",
    "opp_points_off_turnovers",
    "opp_points_second_chance",
    "opp_points_fast_break",
    "opp_points_paint",
    "blocks",
    "blocks_against",
    "fouls_personal",
    "fouls_drawn"
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
    "points_off_turnovers",
    "points_second_chance",
    "points_fast_break",
    "points_paint",
    "opp_points_off_turnovers",
    "opp_points_second_chance",
    "opp_points_fast_break",
    "opp_points_paint",
    "blocks",
    "blocks_against",
    "fouls_personal",
    "fouls_drawn"
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
    "points_off_turnovers",
    "points_second_chance",
    "points_fast_break",
    "points_paint",
    "opp_points_off_turnovers",
    "opp_points_second_chance",
    "opp_points_fast_break",
    "opp_points_paint",
    "blocks",
    "blocks_against",
    "fouls_personal",
    "fouls_drawn"
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
    "points_off_turnovers",
    "points_second_chance",
    "points_fast_break",
    "points_paint",
    "opp_points_off_turnovers",
    "opp_points_second_chance",
    "opp_points_fast_break",
    "opp_points_paint",
    "blocks",
    "blocks_against",
    "fouls_personal",
    "fouls_drawn"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], "data.frame")

  Sys.sleep(3)

})
