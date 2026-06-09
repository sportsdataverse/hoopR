cbbd_play_cols <- c(
  "game_id", "id", "play_type", "period", "clock",
  "home_score", "away_score", "scoring_play", "shooting_play", "play_text"
)

test_that("CBD - Plays by Team", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_plays_team(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No plays returned at test time")

  expect_in(sort(cbbd_play_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Plays by Game", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  games <- cbbd_games(season = 2024, team = "Duke")
  if (!is.data.frame(games) || nrow(games) == 0) skip("No games to seed game_id")

  x <- cbbd_plays_game(game_id = games$id[1])
  if (!is.data.frame(x) || nrow(x) == 0) skip("No plays returned at test time")

  expect_in(sort(cbbd_play_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Play Types", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_play_types()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No play types returned at test time")

  cols <- c("id", "name")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
