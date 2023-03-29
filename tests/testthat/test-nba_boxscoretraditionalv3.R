test_that("NBA Boxscore Traditional V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscoretraditionalv3(game_id = "0022200021")

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
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points",
    "plus_minus_points"
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
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points",
    "plus_minus_points"
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
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points",
    "plus_minus_points"
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
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points",
    "plus_minus_points"
  )

  cols_x5 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points"
  )

  cols_x6 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points"
  )

  cols_x7 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points"
  )

  cols_x8 <- c(
    "game_id",
    "away_team_id",
    "home_team_id",
    "team_id",
    "team_name",
    "team_city",
    "team_tricode",
    "team_slug",
    "minutes",
    "field_goals_made",
    "field_goals_attempted",
    "field_goals_percentage",
    "three_pointers_made",
    "three_pointers_attempted",
    "three_pointers_percentage",
    "free_throws_made",
    "free_throws_attempted",
    "free_throws_percentage",
    "rebounds_offensive",
    "rebounds_defensive",
    "rebounds_total",
    "assists",
    "steals",
    "blocks",
    "turnovers",
    "fouls_personal",
    "points"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], "data.frame")
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], "data.frame")
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], "data.frame")
  expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], "data.frame")
  expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
  expect_s3_class(x[[8]], "data.frame")

  Sys.sleep(3)

})
