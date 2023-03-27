test_that("NBA G-League Players", {
  skip_on_cran()
  skip_on_ci()

  x <- nbagl_players()

  cols_x1 <- c(
    "nba-affiliation",
    "season",
    "permalink",
    "tid",
    "fn",
    "ln",
    "pid",
    "num",
    "pos",
    "dob",
    "ht",
    "wt",
    "y",
    "sn",
    "ty",
    "co",
    "la",
    "dy",
    "pc",
    "fa",
    "s",
    "twc",
    "ta",
    "tn",
    "tc"
  )


  expect_equal(sort(colnames(x)), sort(cols_x1))
  expect_s3_class(x, 'data.frame')

})
