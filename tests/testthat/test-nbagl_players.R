test_that("NBA G-League Players", {
  skip_on_cran()
  skip_on_ci()
  skip_nbagl_stats_test()

  x <- nbagl_players()

  expect_true("PlayerIndex" %in% names(x))
  expect_s3_class(x[[1]], "data.frame")

  if (nrow(x[[1]]) == 0) {
    skip("No PlayerIndex rows returned for current NBA G-League player index query.")
  }

  cols_x1 <- c(
    "PERSON_ID",
    "PLAYER_LAST_NAME",
    "PLAYER_FIRST_NAME",
    "PLAYER_SLUG",
    "TEAM_ID",
    "TEAM_SLUG",
    "TEAM_CITY",
    "TEAM_NAME",
    "TEAM_ABBREVIATION",
    "JERSEY_NUMBER",
    "POSITION",
    "HEIGHT",
    "WEIGHT",
    "COLLEGE",
    "COUNTRY",
    "DRAFT_YEAR",
    "DRAFT_ROUND",
    "DRAFT_NUMBER",
    "ROSTER_STATUS"
  )

  expect_in(sort(cols_x1), sort(colnames(x[[1]])))

  Sys.sleep(3)
})
