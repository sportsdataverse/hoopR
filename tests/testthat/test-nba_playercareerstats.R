test_that("NBA Player Career Stats", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()


  x <- nba_playercareerstats(player_id = "2544")

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

  )

  cols_x10 <- c(

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

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))
  expect_s3_class(x[[1]], "data.frame")
  expect_in(sort(cols_x2), sort(colnames(x[[2]])))
  expect_s3_class(x[[2]], "data.frame")
  expect_in(sort(cols_x3), sort(colnames(x[[3]])))
  expect_s3_class(x[[3]], "data.frame")
  expect_in(sort(cols_x4), sort(colnames(x[[4]])))
  expect_s3_class(x[[4]], "data.frame")
  expect_in(sort(cols_x5), sort(colnames(x[[5]])))
  expect_s3_class(x[[5]], "data.frame")
  expect_in(sort(cols_x6), sort(colnames(x[[6]])))
  expect_s3_class(x[[6]], "data.frame")
  # expect_in(sort(cols_x7), sort(colnames(x[[7]])))
  expect_s3_class(x[[7]], "data.frame")
  # expect_in(sort(cols_x8), sort(colnames(x[[8]])))
  expect_s3_class(x[[8]], "data.frame")
  # expect_in(sort(cols_x9), sort(colnames(x[[9]])))
  expect_s3_class(x[[9]], "data.frame")
  # expect_in(sort(cols_x10), sort(colnames(x[[10]])))
  expect_s3_class(x[[10]], "data.frame")
  expect_in(sort(cols_x11), sort(colnames(x[[11]])))
  expect_s3_class(x[[11]], "data.frame")
  expect_in(sort(cols_x12), sort(colnames(x[[12]])))
  expect_s3_class(x[[12]], "data.frame")

  Sys.sleep(3)

})
