test_that("BREF - Player Season Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_players_stats(season = 2024, table = "per_game")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player stats returned at test time")

  cols <- c("ranker", "player", "age", "team", "pos", "g", "gs", "mp_per_g",
            "pts_per_g", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})

test_that("BREF - Team Season Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_bref_test()

  x <- bref_teams_stats(season = 2024, table = "per_game")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No team stats returned at test time")

  cols <- c("team", "g", "mp", "pts", "season")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(5)
})
