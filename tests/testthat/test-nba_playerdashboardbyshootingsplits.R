test_that("NBA Player Dashboard by Shooting Splits", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_playerdashboardbyshootingsplits(player_id = '2544', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x2 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x3 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x4 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x5 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x6 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM"
  )

  cols_x7 <- c(
    "GROUP_SET",
    "GROUP_VALUE",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
  )

  cols_x8 <- c(
    "GROUP_SET",
    "PLAYER_ID",
    "PLAYER_NAME",
    "FGM",
    "FGA",
    "FG_PCT",
    "FG3M",
    "FG3A",
    "FG3_PCT",
    "EFG_PCT",
    "BLKA",
    "PCT_AST_2PM",
    "PCT_UAST_2PM",
    "PCT_AST_3PM",
    "PCT_UAST_3PM",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "FGM_RANK",
    "FGA_RANK",
    "FG_PCT_RANK",
    "FG3M_RANK",
    "FG3A_RANK",
    "FG3_PCT_RANK",
    "EFG_PCT_RANK",
    "BLKA_RANK",
    "PCT_AST_2PM_RANK",
    "PCT_UAST_2PM_RANK",
    "PCT_AST_3PM_RANK",
    "PCT_UAST_3PM_RANK",
    "PCT_AST_FGM_RANK",
    "PCT_UAST_FGM_RANK"
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

  Sys.sleep(3)

})
