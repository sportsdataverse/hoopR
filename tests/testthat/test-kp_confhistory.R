context("KP - Get conference history")



test_that("KP - Get conference history", {
  skip_on_cran()
  x <- kp_confhistory(conf='ACC')


  cols <- c(
    'Year', 'Rank', 'Tempo',
    'Efficiency', 'eFG.Pct', 'TO.Pct',
    'OR.Pct', 'FTRate', 'FG_2.Pct',
    'FG_3.Pct', 'FT.Pct', 'FG_3A.Pct',
    'A.Pct', 'Blk.Pct', 'Stl.Pct',
    'HomeRecord', 'Bids', 'S16', 'F4',
    'CH', 'RegSeasonChamp', 'TourneyChamp',
    'BestTeam')

  expect_equal(colnames(x), cols)
  expect_s3_class(x,'data.frame')
})
