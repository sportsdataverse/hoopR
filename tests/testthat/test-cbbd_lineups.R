cbbd_lineup_cols <- c(
  "team_id", "team", "conference", "id_hash", "athletes",
  "total_seconds", "pace", "offense_rating", "defense_rating", "net_rating"
)

test_that("CBD - Team Lineups", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  x <- cbbd_lineups_team(season = 2024, team = "Duke")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team lineups returned at test time")

  expect_in(sort(cbbd_lineup_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("CBD - Game Lineups", {
  skip_on_cran()
  skip_on_ci()
  skip_cbbd_test()

  games <- cbbd_games(season = 2024, team = "Duke")
  if (!is.data.frame(games) || nrow(games) == 0) skip("No games to seed game_id")

  x <- cbbd_lineups_game(game_id = games$id[1])
  if (!is.data.frame(x) || nrow(x) == 0) skip("No game lineups returned at test time")

  expect_in(sort(cbbd_lineup_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
