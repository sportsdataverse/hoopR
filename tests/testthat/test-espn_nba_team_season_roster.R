test_that("ESPN - NBA Team Season Roster", {
  skip_on_cran()
  skip_on_ci()
  skip_espn_test()

  x <- espn_nba_team_season_roster(team_id = 29, season = 2024)

  if (is.null(x) || !is.data.frame(x) || nrow(x) == 0) {
    skip("No rows returned from espn_nba_team_season_roster at test time")
  }

  required_cols <- c(
    "team_id",
    "season",
    "league"
  )
  expect_in(sort(required_cols), sort(colnames(x)))
  expect_s3_class(x, "data.frame")

  Sys.sleep(1)
})

