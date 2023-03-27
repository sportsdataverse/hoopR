test_that("NBA Common Player Info", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_commonplayerinfo(league_id = '00', player_id = '2544')

  cols_x1 <- c(
    "PERSON_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "DISPLAY_FIRST_LAST",
    "DISPLAY_LAST_COMMA_FIRST",
    "DISPLAY_FI_LAST",
    "PLAYER_SLUG",
    "BIRTHDATE",
    "SCHOOL",
    "COUNTRY",
    "LAST_AFFILIATION",
    "HEIGHT",
    "WEIGHT",
    "SEASON_EXP",
    "JERSEY",
    "POSITION",
    "ROSTERSTATUS",
    "GAMES_PLAYED_CURRENT_SEASON_FLAG",
    "TEAM_ID",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "TEAM_CODE",
    "TEAM_CITY",
    "PLAYERCODE",
    "FROM_YEAR",
    "TO_YEAR",
    "DLEAGUE_FLAG",
    "NBA_FLAG",
    "GAMES_PLAYED_FLAG",
    "DRAFT_YEAR",
    "DRAFT_ROUND",
    "DRAFT_NUMBER",
    "GREATEST_75_FLAG"
  )
  cols_x2 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TimeFrame",
    "PTS",
    "AST",
    "REB",
    "PIE"
  )
  cols_x3 <- c(
    "SEASON_ID"
  )
  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')

})
