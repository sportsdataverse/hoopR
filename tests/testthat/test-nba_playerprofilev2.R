test_that("NBA Player Profile V2", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playerprofilev2(player_id = '2544')

  cols_x1 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x2 <- c(
    "PLAYER_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x3 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x4 <- c(
    "PLAYER_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x5 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x6 <- c(
    "PLAYER_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x7 <- c(
  )

  cols_x8 <- c(
  )

  cols_x9 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x10 <- c(
    "PLAYER_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "GP",
    "GS",
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
    "STL",
    "BLK",
    "TOV",
    "PF",
    "PTS"
  )

  cols_x11 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
    "RANK_MIN",
    "RANK_FGM",
    "RANK_FGA",
    "RANK_FG_PCT",
    "RANK_FG3M",
    "RANK_FG3A",
    "RANK_FG3_PCT",
    "RANK_FTM",
    "RANK_FTA",
    "RANK_FT_PCT",
    "RANK_OREB",
    "RANK_DREB",
    "RANK_REB",
    "RANK_AST",
    "RANK_STL",
    "RANK_BLK",
    "RANK_TOV",
    "RANK_PTS",
    "RANK_EFF"
  )

  cols_x12 <- c(
    "PLAYER_ID",
    "SEASON_ID",
    "LEAGUE_ID",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "PLAYER_AGE",
    "GP",
    "GS",
    "RANK_MIN",
    "RANK_FGM",
    "RANK_FGA",
    "RANK_FG_PCT",
    "RANK_FG3M",
    "RANK_FG3A",
    "RANK_FG3_PCT",
    "RANK_FTM",
    "RANK_FTA",
    "RANK_FT_PCT",
    "RANK_OREB",
    "RANK_DREB",
    "RANK_REB",
    "RANK_AST",
    "RANK_STL",
    "RANK_BLK",
    "RANK_TOV",
    "RANK_PTS",
    "RANK_EFF"
  )

  cols_x13 <- c(
    "PLAYER_ID",
    "GAME_ID",
    "GAME_DATE",
    "VS_TEAM_ID",
    "VS_TEAM_CITY",
    "VS_TEAM_NAME",
    "VS_TEAM_ABBREVIATION",
    "STAT",
    "STAT_VALUE",
    "STAT_ORDER",
    "DATE_EST"
  )

  cols_x14 <- c(
    "PLAYER_ID",
    "GAME_ID",
    "GAME_DATE",
    "VS_TEAM_ID",
    "VS_TEAM_CITY",
    "VS_TEAM_NAME",
    "VS_TEAM_ABBREVIATION",
    "STAT",
    "STAT_VALUE",
    "STAT_ORDER",
    "DATE_EST"
  )

  cols_x15 <- c(
    "GAME_ID",
    "GAME_DATE",
    "GAME_TIME",
    "LOCATION",
    "PLAYER_TEAM_ID",
    "PLAYER_TEAM_CITY",
    "PLAYER_TEAM_NICKNAME",
    "PLAYER_TEAM_ABBREVIATION",
    "VS_TEAM_ID",
    "VS_TEAM_CITY",
    "VS_TEAM_NICKNAME",
    "VS_TEAM_ABBREVIATION"
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
  # expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
  expect_s3_class(x[[7]], 'data.frame')
  # expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
  expect_s3_class(x[[8]], 'data.frame')
  expect_equal(sort(colnames(x[[9]])), sort(cols_x9))
  expect_s3_class(x[[9]], 'data.frame')
  expect_equal(sort(colnames(x[[10]])), sort(cols_x10))
  expect_s3_class(x[[10]], 'data.frame')
  expect_equal(sort(colnames(x[[11]])), sort(cols_x11))
  expect_s3_class(x[[11]], 'data.frame')
  expect_equal(sort(colnames(x[[12]])), sort(cols_x12))
  expect_s3_class(x[[12]], 'data.frame')
  expect_equal(sort(colnames(x[[13]])), sort(cols_x13))
  expect_s3_class(x[[13]], 'data.frame')
  expect_equal(sort(colnames(x[[14]])), sort(cols_x14))
  expect_s3_class(x[[14]], 'data.frame')
  expect_equal(sort(colnames(x[[15]])), sort(cols_x15))
  expect_s3_class(x[[15]], 'data.frame')

})
