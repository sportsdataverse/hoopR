test_that("NBA Common All Players", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_commonallplayers(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "PERSON_ID",
    "DISPLAY_LAST_COMMA_FIRST",
    "DISPLAY_FIRST_LAST",
    "ROSTERSTATUS",
    "FROM_YEAR",
    "TO_YEAR",
    "PLAYERCODE",
    "PLAYER_SLUG",
    "TEAM_ID",
    "TEAM_CITY",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CODE",
    "TEAM_SLUG",
    "GAMES_PLAYED_FLAG",
    "OTHERLEAGUE_EXPERIENCE_CH"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
