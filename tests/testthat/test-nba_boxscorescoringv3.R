test_that("NBA Boxscore Scoring V3", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_boxscorescoringv3(game_id = "0022200021")

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
    "percentage_field_goals_attempted2pt",
    "percentage_field_goals_attempted3pt",
    "percentage_points2pt",
    "percentage_points_midrange2pt",
    "percentage_points3pt",
    "percentage_points_fast_break",
    "percentage_points_free_throw",
    "percentage_points_off_turnovers",
    "percentage_points_paint",
    "percentage_assisted2pt",
    "percentage_unassisted2pt",
    "percentage_assisted3pt",
    "percentage_unassisted3pt",
    "percentage_assisted_fgm",
    "percentage_unassisted_fgm"
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
    "percentage_field_goals_attempted2pt",
    "percentage_field_goals_attempted3pt",
    "percentage_points2pt",
    "percentage_points_midrange2pt",
    "percentage_points3pt",
    "percentage_points_fast_break",
    "percentage_points_free_throw",
    "percentage_points_off_turnovers",
    "percentage_points_paint",
    "percentage_assisted2pt",
    "percentage_unassisted2pt",
    "percentage_assisted3pt",
    "percentage_unassisted3pt",
    "percentage_assisted_fgm",
    "percentage_unassisted_fgm"
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
    "percentage_field_goals_attempted2pt",
    "percentage_field_goals_attempted3pt",
    "percentage_points2pt",
    "percentage_points_midrange2pt",
    "percentage_points3pt",
    "percentage_points_fast_break",
    "percentage_points_free_throw",
    "percentage_points_off_turnovers",
    "percentage_points_paint",
    "percentage_assisted2pt",
    "percentage_unassisted2pt",
    "percentage_assisted3pt",
    "percentage_unassisted3pt",
    "percentage_assisted_fgm",
    "percentage_unassisted_fgm"
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
    "percentage_field_goals_attempted2pt",
    "percentage_field_goals_attempted3pt",
    "percentage_points2pt",
    "percentage_points_midrange2pt",
    "percentage_points3pt",
    "percentage_points_fast_break",
    "percentage_points_free_throw",
    "percentage_points_off_turnovers",
    "percentage_points_paint",
    "percentage_assisted2pt",
    "percentage_unassisted2pt",
    "percentage_assisted3pt",
    "percentage_unassisted3pt",
    "percentage_assisted_fgm",
    "percentage_unassisted_fgm"
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
