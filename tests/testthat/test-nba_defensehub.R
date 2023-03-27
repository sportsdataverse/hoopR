# test_that("NBA Defense Hub", {
#   skip_on_cran()
#   skip_on_ci()
#
#   x <- nba_defensehub(league_id = '00')
#
#   cols_x1 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "PTS"
#   )
#
#   cols_x2 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "REB"
#   )
#
#   cols_x3 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "AST"
#   )
#
#   cols_x4 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "STL"
#   )
#
#   cols_x5 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "FG_PCT"
#   )
#
#   cols_x6 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "FT_PCT"
#   )
#
#   cols_x7 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "FG3_PCT"
#   )
#
#   cols_x8 <- c(
#     "RANK",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_NAME",
#     "BLK"
#   )
#
#   expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
#   expect_s3_class(x[[1]], 'data.frame')
#   expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
#   expect_s3_class(x[[2]], 'data.frame')
#   expect_equal(sort(colnames(x[[3]])), sort(cols_x3))
#   expect_s3_class(x[[3]], 'data.frame')
#   expect_equal(sort(colnames(x[[4]])), sort(cols_x4))
#   expect_s3_class(x[[4]], 'data.frame')
#   expect_equal(sort(colnames(x[[5]])), sort(cols_x5))
#   expect_s3_class(x[[5]], 'data.frame')
#   expect_equal(sort(colnames(x[[6]])), sort(cols_x6))
#   expect_s3_class(x[[6]], 'data.frame')
#   expect_equal(sort(colnames(x[[7]])), sort(cols_x7))
#   expect_s3_class(x[[7]], 'data.frame')
#   expect_equal(sort(colnames(x[[8]])), sort(cols_x8))
#   expect_s3_class(x[[8]], 'data.frame')
#
# })
