test_that("NBA League Lineup Viz", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguelineupviz(league_id = '00', season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "GROUP_ID",
    "GROUP_NAME",
    "TEAM_ID",
    "TEAM_ABBREVIATION",
    "MIN",
    "OFF_RATING",
    "DEF_RATING",
    "NET_RATING",
    "PACE",
    "TS_PCT",
    "FTA_RATE",
    "TM_AST_PCT",
    "PCT_FGA_2PT",
    "PCT_FGA_3PT",
    "PCT_PTS_2PT_MR",
    "PCT_PTS_FB",
    "PCT_PTS_FT",
    "PCT_PTS_PAINT",
    "PCT_AST_FGM",
    "PCT_UAST_FGM",
    "OPP_FG3_PCT",
    "OPP_EFG_PCT",
    "OPP_FTA_RATE",
    "OPP_TOV_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], 'data.frame')

})
