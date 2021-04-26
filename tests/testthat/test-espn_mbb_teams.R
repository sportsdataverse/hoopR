context("ESPN - Get teams")



test_that("ESPN - Get teams", {
  skip_on_cran()
  x <- espn_mbb_teams()

  cols <- c(
    'id', 'uid', 'slug', 'location',
    'name', 'nickname', 'abbreviation',
    'displayName', 'shortDisplayName', 'color',
    'alternateColor', 'isActive', 'isAllStar',
    'logos_href_1', 'logos_href_2', 'summary',
    'playoffSeed', 'wins', 'losses', 'winPercent',
    'gamesBehind', 'ties', 'OTWins', 'OTLosses',
    'gamesPlayed', 'pointsFor', 'pointsAgainst',
    'avgPointsFor', 'avgPointsAgainst', 'points',
    'differential', 'streak',
    'divisionWinPercent', 'leagueWinPercent'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
