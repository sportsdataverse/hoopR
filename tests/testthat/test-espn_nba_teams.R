context("ESPN - Get NBA teams")



test_that("ESPN - Get NBA teams", {
  skip_on_cran()
  x <- espn_nba_teams()

  cols <- c(
    'id', 'uid', 'slug', 'location',
    'name', 'abbreviation',
    'displayName', 'shortDisplayName', 'color',
    'alternateColor', 'isActive', 'isAllStar',
    'logos_href_1', 'logos_href_2','logos_href_3',
    'logos_href_4',  'summary',
    'playoffSeed', 'wins', 'losses', 'winPercent',
    'gamesBehind', 'ties', 'OTWins', 'OTLosses',
    'gamesPlayed', 'pointsFor', 'pointsAgainst',
    'avgPointsFor', 'avgPointsAgainst', 'points',
    'differential', 'streak',
    'divisionWinPercent', 'leagueWinPercent', 'clincher'
  )
  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')

})
