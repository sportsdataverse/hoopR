test_that("NBA Common Team Roster", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_commonteamroster(season = year_to_season(most_recent_nba_season() - 1),
                            team_id = "1610612739")

  cols_x1 <- c(
    "TeamID",
    "SEASON",
    "LeagueID",
    "PLAYER",
    "NICKNAME",
    "PLAYER_SLUG",
    "NUM",
    "POSITION",
    "HEIGHT",
    "WEIGHT",
    "BIRTH_DATE",
    "AGE",
    "EXP",
    "SCHOOL",
    "PLAYER_ID",
    "HOW_ACQUIRED"
  )

  cols_x2 <- c(
    "TEAM_ID",
    "SEASON",
    "COACH_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "COACH_NAME",
    "IS_ASSISTANT",
    "COACH_TYPE",
    "SORT_SEQUENCE",
    "SUB_SORT_SEQUENCE"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")

  Sys.sleep(3)

})
