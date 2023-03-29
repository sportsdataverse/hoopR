# test_that("NBA G-League Alum Boxscore Similarity Score", {
#   skip_on_cran()
#   skip_on_ci()
#   z <- nba_commonallplayers()$CommonAllPlayers
#   klay <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == "Klay Thompson")
#   book <- z %>% dplyr::filter(DISPLAY_FIRST_LAST == "Devin Booker")
#   x <- nba_glalumboxscoresimilarityscore(person_1_id = klay$PERSON_ID,
#                                    person_1_league_id = "00",
#                                    person_1_season = year_to_season(most_recent_nba_season() - 1),
#                                    person_1_season_type = "Regular Season",
#                                    person_2_id = book$PERSON_ID,
#                                    person_2_league_id = "00",
#                                    person_2_season = year_to_season(most_recent_nba_season() - 1),
#                                    person_2_season_type = "Regular Season")
#
#   cols_x1 <- c(
#     "GAME_ID",
#     "TEAM_ID",
#     "TEAM_CITY",
#     "TEAM_NAME",
#     "PERSON_ID",
#     "PLAYER_FIRST",
#     "PLAYER_LAST",
#     "IN_TIME_REAL",
#     "OUT_TIME_REAL",
#     "PLAYER_PTS",
#     "PT_DIFF",
#     "USG_PCT"
#   )
#
#   cols_x2 <- c(
#     "GAME_ID",
#     "TEAM_ID",
#     "TEAM_CITY",
#     "TEAM_NAME",
#     "PERSON_ID",
#     "PLAYER_FIRST",
#     "PLAYER_LAST",
#     "IN_TIME_REAL",
#     "OUT_TIME_REAL",
#     "PLAYER_PTS",
#     "PT_DIFF",
#     "USG_PCT"
#   )
#
#   expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
#   expect_s3_class(x[[1]], "data.frame")
#   expect_equal(sort(colnames(x[[2]])), sort(cols_x2))
#   expect_s3_class(x[[2]], "data.frame")
#
# })
