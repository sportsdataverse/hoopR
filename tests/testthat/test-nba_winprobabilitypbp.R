test_that("NBA Win Probability PBP", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_winprobabilitypbp(game_id = '0021700807', run_type = 'each second')


  cols_x1 <- c(
    "GAME_ID",
    "EVENT_NUM",
    "HOME_PCT",
    "VISITOR_PCT",
    "HOME_PTS",
    "VISITOR_PTS",
    "HOME_SCORE_MARGIN",
    "PERIOD",
    "SECONDS_REMAINING",
    "HOME_POSS_IND",
    "HOME_G",
    "DESCRIPTION",
    "LOCATION",
    "PCTIMESTRING",
    "ISVISIBLE"
  )

  cols_x2 <- c(
    "GAME_ID",
    "GAME_DATE",
    "HOME_TEAM_ID",
    "HOME_TEAM_ABR",
    "HOME_TEAM_PTS",
    "VISITOR_TEAM_ID",
    "VISITOR_TEAM_ABR",
    "VISITOR_TEAM_PTS"
  )
  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')

})
