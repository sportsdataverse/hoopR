test_that("Torvik - Player Season Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_torvik_test()

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
  skip_torvik_test()

  x <- torvik_game_stats(year = 2024)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No game stats returned at test time")

  cols <- c("date", "team", "conf", "opp", "venue", "result", "adj_oe", "oe",
            "tempo", "year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

test_that("Torvik - player stats keep their names when barttorvik appends fields", {
  row <- function(n) paste(c('"A Player"', "Team", "ACC", rep("1", n - 3)), collapse = ",")
  local_mocked_bindings(.torvik_text = function(path) row(78))
  x <- torvik_player_stats(year = 2024)
  expect_equal(ncol(x), 78L)
  expect_equal(names(x)[c(1, 6, 64, 67)], c("player_name", "o_rtg", "pts", "recruit_date"))
  expect_equal(names(x)[68:78], paste0("v", 68:78))

  local_mocked_bindings(.torvik_text = function(path) row(50))
  expect_equal(names(torvik_player_stats(year = 2009))[1:2], c("v1", "v2"))
})
