test_that("NBA Boxscore Player Track V2", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()



  x <- nba_boxscoreplayertrackv2(game_id = "0022200021")

  cols_x1 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "PLAYER_ID",
    "PLAYER_NAME",
    "START_POSITION",
    "COMMENT",
    "MIN",
    "SPD",
    "DIST",
    "ORBC",
    "DRBC",
    "RBC",
    "TCHS",
    "SAST",
    "FTAST",
    "PASS",
    "AST",
    "CFGM",
    "CFGA",
    "CFG_PCT",
    "UFGM",
    "UFGA",
    "UFG_PCT",
    "FG_PCT",
    "DFGM",
    "DFGA",
    "DFG_PCT"
  )

  cols_x2 <- c(
    "GAME_ID",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CITY",
    "MIN",
    "DIST",
    "ORBC",
    "DRBC",
    "RBC",
    "TCHS",
    "SAST",
    "FTAST",
    "PASS",
    "AST",
    "CFGM",
    "CFGA",
    "CFG_PCT",
    "UFGM",
    "UFGA",
    "UFG_PCT",
    "FG_PCT",
    "DFGM",
    "DFGA",
    "DFG_PCT"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
