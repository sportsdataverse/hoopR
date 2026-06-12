# Live tests for the Fox Sports (Bifrost) basketball wrappers (NBA + MBB).
# Stable ids captured 2026-06-10: nba event 106422 / team 1; cbk event 262052 /
# team 27. Subset-direction column checks; skip-if-empty guards for transient
# API errors + the ephemeral odds market.

test_that("Fox NBA play-by-play", {
  skip_on_cran()
  skip_on_ci()
  x <- fox_nba_pbp("106422")
  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) skip("No Fox NBA pbp at test time")
  expect_in(c("game_id", "period", "play_id", "clock", "play_text", "team"), colnames(x))
  expect_s3_class(x, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA boxscore", {
  skip_on_cran()
  skip_on_ci()
  x <- fox_nba_boxscore("106422")
  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) skip("No Fox NBA boxscore at test time")
  expect_in(c("game_id", "team", "stat_group", "player", "stat", "value"), colnames(x))
  expect_s3_class(x, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA team roster", {
  skip_on_cran()
  skip_on_ci()
  x <- fox_nba_team_roster("1")
  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) skip("No Fox NBA roster at test time")
  expect_in(c("team_id", "position_group", "player", "athlete_id"), colnames(x))
  expect_s3_class(x, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA standings", {
  skip_on_cran()
  skip_on_ci()
  st <- fox_nba_standings("1")
  if (is.null(st) || !is.data.frame(st) || nrow(st) == 0) skip("No Fox NBA standings at test time")
  expect_in(c("team_id", "section", "entity_id"), colnames(st))
  expect_s3_class(st, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA league leaders", {
  skip_on_cran()
  skip_on_ci()
  ll <- fox_nba_league_leaders("scoring")
  if (is.null(ll) || !is.data.frame(ll) || nrow(ll) == 0) skip("No Fox NBA leaders at test time")
  expect_in("entity_id", colnames(ll))
  expect_s3_class(ll, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA team game log", {
  skip_on_cran()
  skip_on_ci()
  gl <- fox_nba_team_gamelog("1")
  if (is.null(gl) || !is.data.frame(gl) || nrow(gl) == 0) skip("No Fox NBA gamelog at test time")
  expect_in(c("team_id", "category", "game_id", "stat", "value"), colnames(gl))
  expect_s3_class(gl, "data.frame")
  Sys.sleep(1)
})

test_that("Fox NBA odds (ephemeral market tolerated)", {
  skip_on_cran()
  skip_on_ci()
  x <- fox_nba_odds("106422")
  expect_s3_class(x, "data.frame")
  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) skip("No Fox NBA odds market at test time")
  expect_in(c("game_id", "team"), colnames(x))
  Sys.sleep(1)
})

test_that("Fox MBB play-by-play", {
  skip_on_cran()
  skip_on_ci()
  pb <- fox_mbb_pbp("262052")
  if (is.null(pb) || !is.data.frame(pb) || nrow(pb) == 0) skip("No Fox MBB pbp at test time")
  expect_in(c("game_id", "period", "play_id", "play_text"), colnames(pb))
  expect_s3_class(pb, "data.frame")
  Sys.sleep(1)
})

test_that("Fox MBB boxscore", {
  skip_on_cran()
  skip_on_ci()
  bo <- fox_mbb_boxscore("262052")
  if (is.null(bo) || !is.data.frame(bo) || nrow(bo) == 0) skip("No Fox MBB boxscore at test time")
  expect_in(c("game_id", "team", "player", "stat", "value"), colnames(bo))
  expect_s3_class(bo, "data.frame")
  Sys.sleep(1)
})

test_that("Fox MBB team roster", {
  skip_on_cran()
  skip_on_ci()
  ro <- fox_mbb_team_roster("27")
  if (is.null(ro) || !is.data.frame(ro) || nrow(ro) == 0) skip("No Fox MBB roster at test time")
  expect_in(c("team_id", "player", "athlete_id"), colnames(ro))
  expect_s3_class(ro, "data.frame")
  Sys.sleep(1)
})
