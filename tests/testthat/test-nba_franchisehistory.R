test_that("NBA Franchise History", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_franchisehistory(league_id = '00')

  cols_x1 <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "START_YEAR",
    "END_YEAR",
    "YEARS",
    "GAMES",
    "WINS",
    "LOSSES",
    "WIN_PCT",
    "PO_APPEARANCES",
    "DIV_TITLES",
    "CONF_TITLES",
    "LEAGUE_TITLES"
  )

  cols_x2 <- c(
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "START_YEAR",
    "END_YEAR",
    "YEARS",
    "GAMES",
    "WINS",
    "LOSSES",
    "WIN_PCT",
    "PO_APPEARANCES",
    "DIV_TITLES",
    "CONF_TITLES",
    "LEAGUE_TITLES"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
