test_that("NBA All-Time Leaders Grids", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()



  x <- nba_alltimeleadersgrids(league_id = "00")

  cols_x1 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "GP",
    "GP_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x2 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "PTS",
    "PTS_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x3 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "AST",
    "AST_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x4 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "STL",
    "STL_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x5 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "OREB",
    "OREB_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x6 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "DREB",
    "DREB_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x7 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "REB",
    "REB_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x8 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "BLK",
    "BLK_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x9 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FGM",
    "FGM_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x10 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FGA",
    "FGA_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x11 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FG_PCT",
    "FG_PCT_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x12 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "TOV",
    "TOV_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x13 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FG3M",
    "FG3M_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x14 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FG3A",
    "FG3A_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x15 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FG3_PCT",
    "FG3_PCT_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x16 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "PF",
    "PF_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x17 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FTM",
    "FTM_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x18 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FTA",
    "FTA_RANK",
    "IS_ACTIVE_FLAG"
  )

  cols_x19 <- c(
    "PLAYER_ID",
    "PLAYER_NAME",
    "FT_PCT",
    "FT_PCT_RANK",
    "IS_ACTIVE_FLAG"
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
  expect_in(sort(cols_x7), sort(colnames(x[[7]])))
  expect_s3_class(x[[7]], "data.frame")
  expect_in(sort(cols_x8), sort(colnames(x[[8]])))
  expect_s3_class(x[[8]], "data.frame")
  expect_in(sort(cols_x9), sort(colnames(x[[9]])))
  expect_s3_class(x[[9]], "data.frame")
  expect_in(sort(cols_x10), sort(colnames(x[[10]])))
  expect_s3_class(x[[10]], "data.frame")
  expect_in(sort(cols_x11), sort(colnames(x[[11]])))
  expect_s3_class(x[[11]], "data.frame")
  expect_in(sort(cols_x12), sort(colnames(x[[12]])))
  expect_s3_class(x[[12]], "data.frame")
  expect_in(sort(cols_x13), sort(colnames(x[[13]])))
  expect_s3_class(x[[13]], "data.frame")
  expect_in(sort(cols_x14), sort(colnames(x[[14]])))
  expect_s3_class(x[[14]], "data.frame")
  expect_in(sort(cols_x15), sort(colnames(x[[15]])))
  expect_s3_class(x[[15]], "data.frame")
  expect_in(sort(cols_x16), sort(colnames(x[[16]])))
  expect_s3_class(x[[16]], "data.frame")
  expect_in(sort(cols_x17), sort(colnames(x[[17]])))
  expect_s3_class(x[[17]], "data.frame")
  expect_in(sort(cols_x18), sort(colnames(x[[18]])))
  expect_s3_class(x[[18]], "data.frame")
  expect_in(sort(cols_x19), sort(colnames(x[[19]])))
  expect_s3_class(x[[19]], "data.frame")

  Sys.sleep(3)
})
