test_that("NBA Gravity Leaders", {
  skip_on_cran()
  skip_on_ci()
  skip_nba_stats_test()

  x <- nba_gravityleaders(season = "2025-26")

  cols_gravity <- c(
    "playerid",
    "firstname",
    "lastname",
    "teamid",
    "teamabbreviation",
    "teamname",
    "teamcity",
    "frames",
    "gravityscore",
    "avggravityscore",
    "onballperimeterframes",
    "onballperimetergravityscore",
    "avgonballperimetergravityscore",
    "offballperimeterframes",
    "offballperimetergravityscore",
    "avgoffballperimetergravityscore",
    "onballinteriorframes",
    "onballinteriorgravityscore",
    "avgonballinteriorgravityscore",
    "offballinteriorframes",
    "offballinteriorgravityscore",
    "avgoffballinteriorgravityscore",
    "gamesplayed",
    "minutes",
    "pts",
    "reb",
    "ast"
  )
  expect_in(sort(cols_gravity), sort(colnames(x$GravityLeaders)))
  expect_s3_class(x$GravityLeaders, "data.frame")
  expect_gt(nrow(x$GravityLeaders), 0)

  Sys.sleep(3)
})
