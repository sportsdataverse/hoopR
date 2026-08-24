# Pure, deterministic math -- no network, safe to run everywhere.

test_that("NBA metrics - shooting efficiency", {
  skip_on_cran()
  expect_equal(nba_true_shooting_pct(30, 20, 8), 30 / (2 * (20 + 0.44 * 8)))
  expect_equal(nba_effective_fg_pct(10, 4, 20), 0.6)
  expect_equal(nba_ft_rate(8, 20), 0.4)
  # vectorized
  expect_equal(nba_effective_fg_pct(c(10, 5), c(4, 0), c(20, 10)), c(0.6, 0.5))
})

test_that("NBA metrics - game score & ratios", {
  skip_on_cran()
  expect_equal(
    nba_game_score(30, 10, 20, 8, 7, 1, 6, 2, 8, 1, 2, 3),
    30 + 0.4 * 10 - 0.7 * 20 - 0.4 * (8 - 7) + 0.7 * 1 + 0.3 * 6 + 2 + 0.7 * 8 + 0.7 * 1 - 0.4 * 2 - 3
  )
  expect_equal(nba_assist_to_turnover(8, 3), 8 / 3)
})

test_that("NBA metrics - possessions, pace, ratings", {
  skip_on_cran()
  expect_equal(nba_possessions(88, 25, 10, 13), 88 + 0.44 * 25 - 10 + 13)
  expect_equal(nba_pace(100, 240), 100)              # 48 * 100 / (240/5)
  expect_equal(nba_offensive_rating(115, 100), 115)
  expect_equal(nba_defensive_rating(108, 100), 108)
  expect_equal(nba_net_rating(115, 108), 7)
})

test_that("NBA metrics - usage, assist %, four factors", {
  skip_on_cran()
  expect_equal(round(nba_usage_rate(20, 8, 3, 36, 88, 25, 13, 240), 2), 31.57)
  expect_equal(nba_assist_pct(8, 10, 36, 40, 240), 40)
  ff <- nba_four_factors(40, 12, 88, 25, 20, 10, 13, 33)
  expect_s3_class(ff, "tbl_df")
  expect_setequal(colnames(ff), c("efg_pct", "tov_pct", "oreb_pct", "ft_rate"))
  expect_equal(ff$efg_pct, (40 + 0.5 * 12) / 88)
})

test_that("NBA metrics - zero denominators return NA, not Inf", {
  skip_on_cran()
  expect_true(is.na(nba_true_shooting_pct(0, 0, 0)))
  expect_true(is.na(nba_effective_fg_pct(0, 0, 0)))
  expect_true(is.na(nba_assist_to_turnover(8, 0)))
})

test_that("NBA scaling - per-minute and enrichment", {
  skip_on_cran()
  box <- data.frame(player = c("A", "B"), min = c(36, 24),
                    pts = c(18, 8), reb = c(9, 6), ast = c(7, 2))
  pm <- nba_per_minutes(box, c("pts", "reb", "ast"))
  expect_true(all(c("pts_per_36", "reb_per_36", "ast_per_36") %in% names(pm)))
  expect_equal(pm$pts_per_36, c(18, 12))

  pp <- nba_per_possessions(
    data.frame(team = "A", poss = 100, pts = 110), cols = "pts")
  expect_equal(pp$pts_per_100, 110)

  enriched <- suppressMessages(nba_add_advanced_metrics(
    data.frame(player = "A", pts = 30, fgm = 10, fga = 20, fg3m = 4, ftm = 7,
               fta = 8, oreb = 1, dreb = 6, ast = 8, stl = 2, blk = 1, pf = 2, tov = 3)))
  expect_true(all(c("ts_pct", "efg_pct", "ft_rate", "tov_pct", "ast_to", "game_score")
                  %in% names(enriched)))
  expect_equal(enriched$efg_pct, 0.6)
})
