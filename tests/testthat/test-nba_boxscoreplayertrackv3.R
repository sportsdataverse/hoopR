test_that("NBA Boxscore Player Track V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscoreplayertrackv3(game_id = "0022200021")

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
    "speed",
    "distance",
    "rebound_chances_offensive",
    "rebound_chances_defensive",
    "rebound_chances_total",
    "touches",
    "secondary_assists",
    "free_throw_assists",
    "passes",
    "assists",
    "contested_field_goals_made",
    "contested_field_goals_attempted",
    "contested_field_goal_percentage",
    "uncontested_field_goals_made",
    "uncontested_field_goals_attempted",
    "uncontested_field_goals_percentage",
    "field_goal_percentage",
    "defended_at_rim_field_goals_made",
    "defended_at_rim_field_goals_attempted",
    "defended_at_rim_field_goal_percentage"
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
    "speed",
    "distance",
    "rebound_chances_offensive",
    "rebound_chances_defensive",
    "rebound_chances_total",
    "touches",
    "secondary_assists",
    "free_throw_assists",
    "passes",
    "assists",
    "contested_field_goals_made",
    "contested_field_goals_attempted",
    "contested_field_goal_percentage",
    "uncontested_field_goals_made",
    "uncontested_field_goals_attempted",
    "uncontested_field_goals_percentage",
    "field_goal_percentage",
    "defended_at_rim_field_goals_made",
    "defended_at_rim_field_goals_attempted",
    "defended_at_rim_field_goal_percentage"
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
    "distance",
    "rebound_chances_offensive",
    "rebound_chances_defensive",
    "rebound_chances_total",
    "touches",
    "secondary_assists",
    "free_throw_assists",
    "passes",
    "assists",
    "contested_field_goals_made",
    "contested_field_goals_attempted",
    "contested_field_goal_percentage",
    "uncontested_field_goals_made",
    "uncontested_field_goals_attempted",
    "uncontested_field_goals_percentage",
    "field_goal_percentage",
    "defended_at_rim_field_goals_made",
    "defended_at_rim_field_goals_attempted",
    "defended_at_rim_field_goal_percentage"
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
    "distance",
    "rebound_chances_offensive",
    "rebound_chances_defensive",
    "rebound_chances_total",
    "touches",
    "secondary_assists",
    "free_throw_assists",
    "passes",
    "assists",
    "contested_field_goals_made",
    "contested_field_goals_attempted",
    "contested_field_goal_percentage",
    "uncontested_field_goals_made",
    "uncontested_field_goals_attempted",
    "uncontested_field_goals_percentage",
    "field_goal_percentage",
    "defended_at_rim_field_goals_made",
    "defended_at_rim_field_goals_attempted",
    "defended_at_rim_field_goal_percentage"
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
