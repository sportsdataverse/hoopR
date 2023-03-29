test_that("NBA Boxscore Defensive V2", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscoredefensivev2(game_id = "0022200021")

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
    "matchup_minutes",
    "partial_possessions",
    "switches_on",
    "player_points",
    "defensive_rebounds",
    "matchup_assists",
    "matchup_turnovers",
    "steals",
    "blocks",
    "matchup_field_goals_made",
    "matchup_field_goals_attempted",
    "matchup_field_goal_percentage",
    "matchup_three_pointers_made",
    "matchup_three_pointers_attempted",
    "matchup_three_pointer_percentage"
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
    "matchup_minutes",
    "partial_possessions",
    "switches_on",
    "player_points",
    "defensive_rebounds",
    "matchup_assists",
    "matchup_turnovers",
    "steals",
    "blocks",
    "matchup_field_goals_made",
    "matchup_field_goals_attempted",
    "matchup_field_goal_percentage",
    "matchup_three_pointers_made",
    "matchup_three_pointers_attempted",
    "matchup_three_pointer_percentage"
  )

  cols_x3 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug"
  )

  cols_x4 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug"
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
