test_that("NBA Player Fantasy Profile Bar Graph", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_playerfantasyprofilebargraph(player_id = "2544")

  if (length(x) == 0 || is.null(x[[1]]) || !is.data.frame(x[[1]]) || nrow(x[[1]]) == 0) {
    skip("No rows returned from endpoint at test time")
  }

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "PTS",
    "REB",
    "AST",
    "FG3M",
    "FT_PCT",
    "STL",
    "BLK",
    "TOV",
    "FG_PCT"
  )

  cols_x2 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "FAN_DUEL_PTS",
    "NBA_FANTASY_PTS",
    "PTS",
    "REB",
    "AST",
    "FG3M",
    "FT_PCT",
    "STL",
    "BLK",
    "TOV",
    "FG_PCT"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
