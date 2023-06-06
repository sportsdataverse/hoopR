test_that("ESPN - Get NBA Standings", {
  skip_on_cran()
  x <- espn_nba_standings(year = 2021)

  cols <- c(
    "team_id",
    "team",
    "avgpointsagainst",
    "avgpointsfor",
    "clincher",
    "differential",
    "divisionwinpercent",
    "gamesbehind",
    "leaguewinpercent",
    "losses",
    "playoffseed",
    "pointdifferential",
    "streak",
    "winpercent",
    "wins",
    "leaguestandings",
    "home",
    "road",
    "vsdiv",
    "vsconf",
    "lasttengames"
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, "data.frame")

})
