test_that("NBA Team Info Common", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teaminfocommon(team_id = "1610612749",
                          season = year_to_season(most_recent_nba_season() - 1))


  cols_x1 <- c(
    "TEAM_ID",
    "SEASON_YEAR",
    "TEAM_CITY",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CONFERENCE",
    "TEAM_DIVISION",
    "TEAM_CODE",
    "TEAM_SLUG",
    "W",
    "L",
    "PCT",
    "CONF_RANK",
    "DIV_RANK",
    "MIN_YEAR",
    "MAX_YEAR"
  )

  cols_x2 <- c(
    "LEAGUE_ID",
    "SEASON_ID",
    "TEAM_ID",
    "PTS_RANK",
    "PTS_PG",
    "REB_RANK",
    "REB_PG",
    "AST_RANK",
    "AST_PG",
    "OPP_PTS_RANK",
    "OPP_PTS_PG"
  )

  cols_x3 <- c(
    "SEASON_ID"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")

  Sys.sleep(3)

})
