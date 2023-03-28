test_that("NBA Team Year by Year Stats", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamyearbyyearstats(team_id = '1610612749')


  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "YEAR",
    "GP",
    "WINS",
    "LOSSES",
    "WIN_PCT",
    "CONF_RANK",
    "DIV_RANK",
    "PO_WINS",
    "PO_LOSSES",
    "CONF_COUNT",
    "DIV_COUNT",
    "NBA_FINALS_APPEARANCE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "FTM",
    "FTA",
    "FT_PCT",
    "OREB",
    "DREB",
    "REB",
    "AST",
    "PF",
    "STL",
    "TOV",
    "BLK",
    "PTS",
    "PTS_RANK"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

  Sys.sleep(3)

})
