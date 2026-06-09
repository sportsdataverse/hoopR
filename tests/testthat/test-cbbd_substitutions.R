cbbd_sub_cols <- c(
  "game_id", "team_id", "team", "conference", "athlete_id", "athlete", "opponent"
)

test_that("CBD - Substitutions by Team", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_substitutions_team(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No substitutions returned at test time")

  expect_in(sort(cbbd_sub_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Substitutions by Game", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  games <- cbbd_games(season = 2024, team = "Duke")
  if (!is.data.frame(games) || nrow(games) == 0) skip("No games to seed game_id")

  x <- cbbd_substitutions_game(game_id = games$id[1])
  if (!is.data.frame(x) || nrow(x) == 0) skip("No substitutions returned at test time")

  expect_in(sort(cbbd_sub_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
