test_that("RealGM - NBA Player Index", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()  # Requires REALGM_TESTS=1 + chromote + Google Chrome

  x <- realgm_players()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM player data returned at test time")

  cols <- c("player", "pos", "ht", "wt", "current_team", "pre_draft_team")
  expect_in(sort(cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")
  expect_gt(nrow(x), 100)  # full active player index, not a single team

  Sys.sleep(2)
})

test_that("RealGM - Standings", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_standings()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM standings returned at test time")

  cols <- c("team", "w", "l", "pct", "conference")
  expect_in(sort(cols), sort(colnames(x)))
  expect_setequal(unique(x$conference), c("Eastern", "Western"))

  Sys.sleep(2)
})

test_that("RealGM - Player Stats (echoes params)", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_player_stats(season = 2025, stat_type = "Averages")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM player stats returned at test time")

  cols <- c("player", "team", "ppg", "season", "stat_type", "season_type")
  expect_in(sort(cols), sort(colnames(x)))
  expect_equal(unique(x$season), 2025)            # self-describing return
  expect_equal(unique(x$stat_type), "Averages")

  Sys.sleep(2)
})

test_that("RealGM - Team Stats (advanced sort)", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_team_stats(season = 2025, stat_type = "Advanced_Stats")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM team stats returned at test time")

  cols <- c("team", "o_rtg", "d_rtg", "season", "stat_type")
  expect_in(sort(cols), sort(colnames(x)))

  Sys.sleep(2)
})

test_that("RealGM - Draft (rounds + draft_year)", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_draft(year = 2020)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM draft returned at test time")

  cols <- c("pick", "player", "team", "pre_draft_team", "round", "draft_year")
  expect_in(sort(cols), sort(colnames(x)))
  expect_equal(unique(x$draft_year), 2020)
  expect_true(all(c(1, 2) %in% x$round))

  Sys.sleep(2)
})

test_that("RealGM - Players Abroad", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_players_abroad()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM players-abroad returned at test time")

  cols <- c("player", "pos", "nba_status", "ppg")
  expect_in(sort(cols), sort(colnames(x)))

  Sys.sleep(2)
})

test_that("RealGM - Future Free Agents", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_future_free_agents()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM future-FA returned at test time")

  cols <- c("player", "team", "season", "veteran_fa_status", "agent")
  expect_in(sort(cols), sort(colnames(x)))

  Sys.sleep(2)
})

test_that("RealGM - Salary Cap History", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_salary_cap()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM salary-cap returned at test time")

  cols <- c("season", "salary_cap", "luxury_tax")
  expect_in(sort(cols), sort(colnames(x)))

  Sys.sleep(2)
})

test_that("RealGM - Transactions Log", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_transactions()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM transactions returned at test time")

  expect_in(c("date", "transaction"), colnames(x))
  expect_s3_class(x$date, "Date")
  expect_gt(nrow(x), 50)

  Sys.sleep(2)
})

test_that("RealGM - Coaches & GMs", {
  skip_on_cran()
  skip_on_ci()
  skip_realgm_test()

  x <- realgm_coaches()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No RealGM coaches returned at test time")
  expect_in(c("staff", "team", "start_season"), colnames(x))

  Sys.sleep(2)

  y <- realgm_gms()
  if (!is.data.frame(y) || nrow(y) == 0) skip("No RealGM GMs returned at test time")
  expect_in(c("staff", "team"), colnames(y))

  Sys.sleep(2)
})
