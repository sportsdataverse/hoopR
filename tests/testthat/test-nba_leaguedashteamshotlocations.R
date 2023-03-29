test_that("NBA League Dash Team Shot Locations", {
  skip_on_cran()
  skip_on_ci()

  x <- nba_leaguedashteamshotlocations(league_id = "00", season = year_to_season(most_recent_nba_season() - 1))

  cols_x1 <- c(
    "TEAM_ID",
    "TEAM_NAME",
    "Restricted_Area_FGM",
    "Restricted_Area_FGA",
    "Restricted_Area_FG_PCT",
    "In_The_Paint_Non_RA_FGM",
    "In_The_Paint_Non_RA_FGA",
    "In_The_Paint_Non_RA_FG_PCT",
    "Mid_Range_FGM",
    "Mid_Range_FGA",
    "Mid_Range_FG_PCT",
    "Left_Corner_3_FGM",
    "Left_Corner_3_FGA",
    "Left_Corner_3_FG_PCT",
    "Right_Corner_3_FGM",
    "Right_Corner_3_FGA",
    "Right_Corner_3_FG_PCT",
    "Above_the_Break_3_FGM",
    "Above_the_Break_3_FGA",
    "Above_the_Break_3_FG_PCT",
    "Backcourt_FGM",
    "Backcourt_FGA",
    "Backcourt_FG_PCT",
    "Corner_3_FGM",
    "Corner_3_FGA",
    "Corner_3_FG_PCT"
  )


  expect_equal(sort(colnames(x[[1]])), sort(cols_x1))
  expect_s3_class(x[[1]], "data.frame")

  Sys.sleep(3)

})
