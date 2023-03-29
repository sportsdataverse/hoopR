# test_that("NBA Boxscore Matchups", {
#   skip_on_cran()
#   skip_on_ci()
#   x <- nba_boxscorematchups(game_id = "0022200021")
#
#   cols_x1 <- c(
#     "GAME_DATE_EST",
#     "GAME_SEQUENCE",
#     "GAME_ID",
#     "GAME_STATUS_ID",
#     "GAME_STATUS_TEXT",
#     "GAMECODE",
#     "HOME_TEAM_ID",
#     "VISITOR_TEAM_ID",
#     "SEASON",
#     "LIVE_PERIOD",
#     "LIVE_PC_TIME",
#     "NATL_TV_BROADCASTER_ABBREVIATION",
#     "LIVE_PERIOD_TIME_BCAST",
#     "WH_STATUS"
#   )
#
#   cols_x2 <- c(
#     "LEAGUE_ID",
#     "TEAM_ID",
#     "TEAM_ABBREVIATION",
#     "TEAM_CITY",
#     "PTS_PAINT",
#     "PTS_2ND_CHANCE",
#     "PTS_FB",
#     "LARGEST_LEAD",
#     "LEAD_CHANGES",
#     "TIMES_TIED",
#     "TEAM_TURNOVERS",
#     "TOTAL_TURNOVERS",
#     "TEAM_REBOUNDS",
#     "PTS_OFF_TO"
#   )
#
#
#   expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
#   expect_s3_class(x[[1]], "data.frame")
#   expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
#   expect_s3_class(x[[2]], "data.frame")
#
# })
