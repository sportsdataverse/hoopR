context("KP - Get FanMatch")



test_that("KP - Get FanMatch", {
  skip_on_cran()
  x <- kp_fanmatch(date="2020-03-10")

  cols <- c(
    'Prediction', 'Time(ET)', 'Location',
    'ThrillScore', 'Comeback', 'Excitement',
    'WinRk', 'WinTeam', 'WinScore',
    'LossRk', 'LossTeam',
    'LossScore', 'Poss', 'MVP', 'Event', 'Date'
  )


  expect_equal(colnames(x), cols)
  expect_s3_class(x, 'data.frame')
})
