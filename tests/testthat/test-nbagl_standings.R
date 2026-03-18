test_that("NBA G-League Standings", {
  skip_on_cran()
  skip_on_ci()
  skip_nbagl_stats_test()

  x <- nbagl_standings(season = most_recent_nba_season() - 1)

  expect_true("Standings" %in% names(x))
  expect_s3_class(x[[1]], "data.frame")

  if (nrow(x[[1]]) == 0) {
    skip("No standings rows returned for current NBA G-League standings query.")
  }

  cols_x1 <- c(
    "LeagueID",
    "SeasonID",
    "TeamID",
    "TeamCity",
    "TeamName",
    "Conference",
    "PlayoffRank",
    "Division",
    "WINS",
    "LOSSES",
    "WinPCT",
    "LeagueRank",
    "Record",
    "HOME",
    "ROAD",
    "L10",
    "CurrentStreak",
    "strCurrentStreak",
    "ConferenceGamesBack",
    "DivisionGamesBack",
    "LeagueGamesBack",
    "ClinchedPostSeason",
    "NEUTRAL"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))

  Sys.sleep(3)
})
