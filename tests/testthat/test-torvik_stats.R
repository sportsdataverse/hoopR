test_that("Torvik - Player Season Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_player_stats(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player stats returned at test time")

  cols <- c("player_name", "team", "conf", "games", "o_rtg", "usage", "e_fg",
            "ts_pct", "pts", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("Torvik - Game Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- torvik_game_stats(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No game stats returned at test time")

  cols <- c("date", "team", "conf", "opp", "venue", "result", "adj_oe", "oe",
            "tempo", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})
