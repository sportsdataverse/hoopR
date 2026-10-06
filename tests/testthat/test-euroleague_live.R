# Live tests for the euroleague_*() family: EUROLEAGUE_TESTS=1, four requests,
# one per host family (v2, v3 standings, v3 stats, live API).

test_that("EuroLeague live: v2 competitions", {
  skip_on_cran()
  skip_on_ci()
  skip_euroleague_test()
  x <- euroleague_competitions()
  expect_s3_class(x, "hoopR_data")
  expect_in(c("name", "code"), colnames(x))
  expect_in(c("E", "U"), x$code)
  Sys.sleep(1)
})

test_that("EuroLeague live: v3 standings as of round 1", {
  skip_on_cran()
  skip_on_ci()
  skip_euroleague_test()
  x <- euroleague_standings(competition_code = "E", season_code = "E2025", round = 1)
  if (nrow(x) == 0) skip("No rows returned from endpoint at test time")
  expect_in(c("position", "games_played", "games_won", "club_code", "club_name"), colnames(x))
  expect_gte(nrow(x), 18L)
  expect_type(x$club_code, "character")
  Sys.sleep(1)
})

test_that("EuroLeague live: v3 player stats, three rows", {
  skip_on_cran()
  skip_on_ci()
  skip_euroleague_test()
  x <- euroleague_player_stats(competition_code = "E", season_code = "E2025", limit = 3)
  if (nrow(x) == 0) skip("No rows returned from endpoint at test time")
  expect_equal(nrow(x), 3L)
  expect_in(c("player_code", "player_name", "games_played", "points_scored"), colnames(x))
  Sys.sleep(1)
})

test_that("EuroLeague live: shot chart of E2025 game 1 in cm from the hoop", {
  skip_on_cran()
  skip_on_ci()
  skip_euroleague_test()
  x <- euroleague_game_points(game_code = 1, season_code = "E2025")
  if (nrow(x) == 0) skip("No rows returned from endpoint at test time")
  expect_gte(nrow(x), 150L)
  expect_in(c("team", "id_player", "id_action", "coord_x", "coord_y", "zone"), colnames(x))
  fg <- x[x$id_action != "FTM", ]
  expect_true(all(fg$coord_y >= -100 & fg$coord_y <= 1100))
  expect_true(all(x$coord_x[x$id_action == "FTM"] == -1L))
  expect_identical(x$team[1], trimws(x$team[1]))
})
