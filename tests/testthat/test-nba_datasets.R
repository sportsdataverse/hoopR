test_that("nba_tidy_franchise_history binds active + defunct (B)", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_tidy_franchise_history()
  if (!is.data.frame(x) || nrow(x) == 0) skip("No franchise history at test time")

  expect_true(all(c("franchise_status", "TEAM_ID", "TEAM_NAME") %in% names(x)))
  expect_equal(names(x)[1], "franchise_status")
  expect_setequal(unique(x$franchise_status), c("active", "defunct"))

  Sys.sleep(3)
})

test_that("nba_tidy_boxscore joins player + team context (C)", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_tidy_boxscore(game_id = "0022300061")
  if (!is.data.frame(x) || nrow(x) == 0) skip("No box score at test time")

  expect_true(all(c("GAME_ID", "PLAYER_ID", "PTS") %in% names(x)))
  expect_true(any(grepl("_team$", names(x))))       # team context joined on
  expect_s3_class(x, "data.frame")

  Sys.sleep(3)
})

test_that("nba_tidy_player_profile nests by table (D)", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_tidy_player_profile(player_id = 201939)
  if (!is.data.frame(x) || nrow(x) == 0) skip("No player profile at test time")

  expect_true(all(c("set_name", "PLAYER_ID", ".data") %in% names(x)))
  expect_type(x$.data, "list")
  expect_s3_class(x$.data[[1]], "tbl_df")

  Sys.sleep(3)
})
