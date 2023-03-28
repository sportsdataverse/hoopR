test_that("NBA Player vs Player", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playervsplayer(player_id = '2544', vs_player_id = '203076')

  cols_x1 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "PLAYER_ID",
    "PLAYER_NAME",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
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
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "NBA_FANTASY_PTS"
  )

  cols_x2 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GP",
    "W",
    "L",
    "W_PCT",
    "MIN",
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
    "TOV",
    "STL",
    "BLK",
    "BLKA",
    "PF",
    "PFD",
    "PTS",
    "PLUS_MINUS",
    "NBA_FANTASY_PTS"
  )

  cols_x3 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "PLAYER_ID",
    "PLAYER_NAME",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x4 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x5 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x6 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "PLAYER_ID",
    "PLAYER_NAME",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x7 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x8 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x9 <- c(
    "PERSON_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "DISPLAY_FIRST_LAST",
    "DISPLAY_LAST_COMMA_FIRST",
    "DISPLAY_FI_LAST",
    "BIRTHDATE",
    "SCHOOL",
    "COUNTRY",
    "LAST_AFFILIATION"
  )

  cols_x10 <- c(
    "PERSON_ID",
    "FIRST_NAME",
    "LAST_NAME",
    "DISPLAY_FIRST_LAST",
    "DISPLAY_LAST_COMMA_FIRST",
    "DISPLAY_FI_LAST",
    "BIRTHDATE",
    "SCHOOL",
    "COUNTRY",
    "LAST_AFFILIATION"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], 'data.frame')
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], 'data.frame')
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], 'data.frame')
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], 'data.frame')
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], 'data.frame')
  expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], 'data.frame')
  expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
  expect_s3_class(x[[8]], 'data.frame')
  expect_equal(sort(colnames(x[[9]])), sort(cols_x9))
  expect_s3_class(x[[9]], 'data.frame')
  expect_equal(sort(colnames(x[[10]])), sort(cols_x10))
  expect_s3_class(x[[10]], 'data.frame')

  Sys.sleep(3)

})
