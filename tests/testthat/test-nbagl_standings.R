test_that("NBA G-League Standings", {
  skip_on_cran()
  skip_on_ci()

  x <- nbagl_standings(season = most_recent_nba_season() - 1)

  cols_x1 <- c(
    "val",
    "di_val",
    "tid",
    "see",
    "cli",
    "clid",
    "clic",
    "elim",
    "str",
    "l10",
    "dr",
    "cr",
    "l",
    "w",
    "hr",
    "ar",
    "gb",
    "gbd",
    "ta",
    "tn",
    "tc"
  )


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

})
