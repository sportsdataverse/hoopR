test_that("NBA Team vs Player", {
  skip()
  skip_on_cran()
  skip_on_ci()

  x <- nba_teamvsplayer(team_id = "1610612749", vs_player_id = "2544")


  cols_x1 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
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
    "GP_RANK",
    "W_RANK",
    "L_RANK",
    "W_PCT_RANK",
    "MIN_RANK",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "FTM_RANK",
    "FTA_RANK",
    "FT_PCT_RANK",
    "OREB_RANK",
    "DREB_RANK",
    "REB_RANK",
    "AST_RANK",
    "TOV_RANK",
    "STL_RANK",
    "BLK_RANK",
    "BLKA_RANK",
    "PF_RANK",
    "PFD_RANK",
    "PTS_RANK",
    "PLUS_MINUS_RANK"
  )

  cols_x2 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "PLAYER_ID",
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
    "NBA_FANTASY_PTS",
    "DD2",
    "TD3",
    "WNBA_FANTASY_PTS",
    "GP_RANK",
    "W_RANK",
    "L_RANK",
    "W_PCT_RANK",
    "MIN_RANK",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "FTM_RANK",
    "FTA_RANK",
    "FT_PCT_RANK",
    "OREB_RANK",
    "DREB_RANK",
    "REB_RANK",
    "AST_RANK",
    "TOV_RANK",
    "STL_RANK",
    "BLK_RANK",
    "BLKA_RANK",
    "PF_RANK",
    "PFD_RANK",
    "PTS_RANK",
    "PLUS_MINUS_RANK",
    "NBA_FANTASY_PTS_RANK",
    "DD2_RANK",
    "TD3_RANK",
    "WNBA_FANTASY_PTS_RANK"
  )

  cols_x3 <- c(
    "GROUP_SET",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
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
    "GP_RANK",
    "W_RANK",
    "L_RANK",
    "W_PCT_RANK",
    "MIN_RANK",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "FTM_RANK",
    "FTA_RANK",
    "FT_PCT_RANK",
    "OREB_RANK",
    "DREB_RANK",
    "REB_RANK",
    "AST_RANK",
    "TOV_RANK",
    "STL_RANK",
    "BLK_RANK",
    "BLKA_RANK",
    "PF_RANK",
    "PFD_RANK",
    "PTS_RANK",
    "PLUS_MINUS_RANK"
  )

  cols_x4 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x5 <- c(
    "GROUP_SET",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
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
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x7 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x8 <- c(
    "GROUP_SET",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  cols_x9 <- c(
    "GROUP_SET",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "TEAM_NAME",
    "VS_PLAYER_ID",
    "VS_PLAYER_NAME",
    "COURT_STATUS",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT"
  )

  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")
  expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
  expect_s3_class(x[[2]], "data.frame")
  expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
  expect_s3_class(x[[3]], "data.frame")
  expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
  expect_s3_class(x[[4]], "data.frame")
  expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
  expect_s3_class(x[[5]], "data.frame")
  expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
  expect_s3_class(x[[6]], "data.frame")
  expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], "data.frame")
  expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
  expect_s3_class(x[[8]], "data.frame")
  expect_equal(sort(colnames(x[[9]])), sort(cols_x9))
  expect_s3_class(x[[9]], "data.frame")

  Sys.sleep(3)

})
