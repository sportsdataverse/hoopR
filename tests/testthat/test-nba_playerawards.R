test_that("NBA Player Awards", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playerawards(player_id = "2544")

  cols_x1 <- c(
    "PERSON_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "TEAM",
    "DESCRIPTION",
    "ALL_NBA_TEAM_NUMBER",
    "SEASON",
    "MONTH",
    "WEEK",
    "CONFERENCE",
    "TYPE",
    "SUBTYPE1",
    "SUBTYPE2",
    "SUBTYPE3"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
