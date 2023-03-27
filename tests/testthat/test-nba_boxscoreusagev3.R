test_that("NBA Boxscore Usage V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscoreusagev3(game_id = "0022200021")

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
    "usage_percentage",
    "percentage_field_goals_made",
    "percentage_field_goals_attempted",
    "percentage_three_pointers_made",
    "percentage_three_pointers_attempted",
    "percentage_free_throws_made",
    "percentage_free_throws_attempted",
    "percentage_rebounds_offensive",
    "percentage_rebounds_defensive",
    "percentage_rebounds_total",
    "percentage_assists",
    "percentage_turnovers",
    "percentage_steals",
    "percentage_blocks",
    "percentage_blocks_allowed",
    "percentage_personal_fouls",
    "percentage_personal_fouls_drawn",
    "percentage_points"
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
    "usage_percentage",
    "percentage_field_goals_made",
    "percentage_field_goals_attempted",
    "percentage_three_pointers_made",
    "percentage_three_pointers_attempted",
    "percentage_free_throws_made",
    "percentage_free_throws_attempted",
    "percentage_rebounds_offensive",
    "percentage_rebounds_defensive",
    "percentage_rebounds_total",
    "percentage_assists",
    "percentage_turnovers",
    "percentage_steals",
    "percentage_blocks",
    "percentage_blocks_allowed",
    "percentage_personal_fouls",
    "percentage_personal_fouls_drawn",
    "percentage_points"
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
    "usage_percentage",
    "percentage_field_goals_made",
    "percentage_field_goals_attempted",
    "percentage_three_pointers_made",
    "percentage_three_pointers_attempted",
    "percentage_free_throws_made",
    "percentage_free_throws_attempted",
    "percentage_rebounds_offensive",
    "percentage_rebounds_defensive",
    "percentage_rebounds_total",
    "percentage_assists",
    "percentage_turnovers",
    "percentage_steals",
    "percentage_blocks",
    "percentage_blocks_allowed",
    "percentage_personal_fouls",
    "percentage_personal_fouls_drawn",
    "percentage_points"
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
    "usage_percentage",
    "percentage_field_goals_made",
    "percentage_field_goals_attempted",
    "percentage_three_pointers_made",
    "percentage_three_pointers_attempted",
    "percentage_free_throws_made",
    "percentage_free_throws_attempted",
    "percentage_rebounds_offensive",
    "percentage_rebounds_defensive",
    "percentage_rebounds_total",
    "percentage_assists",
    "percentage_turnovers",
    "percentage_steals",
    "percentage_blocks",
    "percentage_blocks_allowed",
    "percentage_personal_fouls",
    "percentage_personal_fouls_drawn",
    "percentage_points"
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
