test_that("NBA Player Index", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_playerindex()

  cols_x1 <- c(
    "PERSON_ID",
    "PLAYER_LAST_NAME",
    "PLAYER_FIRST_NAME",
    "PLAYER_SLUG",
    "TEAM_ID",
    "TEAM_SLUG",
    "IS_DEFUNCT",
    "TEAM_CITY",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "JERSEY_NUMBER",
    "POSITION",
    "HEIGHT",
    "WEIGHT",
    "COLLEGE",
    "COUNTRY",
    "DRAFT_YEAR",
    "DRAFT_ROUND",
    "DRAFT_NUMBER",
    "ROSTER_STATUS",
    "PTS",
    "REB",
    "AST",
    "STATS_TIMEFRAME",
    "FROM_YEAR",
    "TO_YEAR"
  )


  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
