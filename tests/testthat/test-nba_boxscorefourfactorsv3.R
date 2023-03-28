test_that("NBA Boxscore Four Factors V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscorefourfactorsv3(game_id = "0022200021")

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
    "effective_field_goal_percentage",
    "free_throw_attempt_rate",
    "team_turnover_percentage",
    "offensive_rebound_percentage",
    "opp_effective_field_goal_percentage",
    "opp_free_throw_attempt_rate",
    "opp_team_turnover_percentage",
    "opp_offensive_rebound_percentage"
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
    "effective_field_goal_percentage",
    "free_throw_attempt_rate",
    "team_turnover_percentage",
    "offensive_rebound_percentage",
    "opp_effective_field_goal_percentage",
    "opp_free_throw_attempt_rate",
    "opp_team_turnover_percentage",
    "opp_offensive_rebound_percentage"
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
    "effective_field_goal_percentage",
    "free_throw_attempt_rate",
    "team_turnover_percentage",
    "offensive_rebound_percentage",
    "opp_effective_field_goal_percentage",
    "opp_free_throw_attempt_rate",
    "opp_team_turnover_percentage",
    "opp_offensive_rebound_percentage"
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
    "effective_field_goal_percentage",
    "free_throw_attempt_rate",
    "team_turnover_percentage",
    "offensive_rebound_percentage",
    "opp_effective_field_goal_percentage",
    "opp_free_throw_attempt_rate",
    "opp_team_turnover_percentage",
    "opp_offensive_rebound_percentage"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], 'data.frame')

  Sys.sleep(3)

})
